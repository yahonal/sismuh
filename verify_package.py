"""Static cross-file contracts. This is not a DOORS/DXL execution test."""
from pathlib import Path
from zipfile import ZipFile
import hashlib
import json
import re
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[1]
if (ROOT/'ORIJINAL_DOSYALAR').is_dir():
    SRC, OUT = ROOT/'ORIJINAL_DOSYALAR', ROOT/'GUNCEL'
else:
    SRC, OUT = ROOT/'upload', ROOT/'output/GTD/GUNCEL'

results = []
def check(label, condition):
    results.append((label, bool(condition)))
    if not condition:
        raise AssertionError(label)

def array(code, name):
    return re.search(r'\b'+re.escape(name)+r'\[\]\s*=\s*\{(.*?)\}', code, re.S).group(1)

def strings(body):
    # Constant string concatenation plus the established headingBytes helper.
    pattern = r'"(?:[^"\\]|\\.)*"|headingBytes\(\d+,\s*-?\d+,\s*-?\d+\)|,'
    items, current = [], bytearray()
    for token in re.findall(pattern, body):
        if token == ',':
            items.append(current.decode('utf-8')); current = bytearray()
        elif token.startswith('"'):
            current.extend(json.loads(token).encode('utf-8'))
        else:
            current.extend(x for x in map(int,re.findall(r'-?\d+',token)) if x >= 0)
    if current: items.append(current.decode('utf-8'))
    return items

def scrub(code):
    # Preserve line breaks while removing comments and quoted strings.
    return re.sub(r'//[^\n]*|/\*.*?\*/|"(?:[^"\\]|\\.)*"', lambda m:'\n'*m.group().count('\n'), code, flags=re.S)

def balanced(code):
    stack = []
    close = {')':'(',']':'[','}':'{'}
    for c in scrub(code):
        if c in '([{': stack.append(c)
        elif c in close:
            if not stack or stack.pop() != close[c]: return False
    return not stack

codes = {p.name:p.read_text() for p in OUT.glob('*.dxl')}
setup = codes['GTD_Setup_Module.dxl']
publisher = codes['GTD_Publish.dxl']
control = codes['GTD_Requirement_Review_Control.dxl']
for name,code in codes.items():
    check('Balanced DXL delimiters: '+name, balanced(code))
    check('No generation placeholders: '+name, 'INSERT SECTION MODEL HERE' not in code and 'INSERT ENUM LABELS HERE' not in code)

blocks = [re.search(r'// BEGIN GTD SECTION MODEL.*?// END GTD SECTION MODEL',code,re.S).group() for code in (setup,publisher,control)]
check('The three section models are identical', len(set(blocks)) == 1)
keys = strings(array(setup,'gtdSectionKeys'))
headings = strings(array(setup,'gtdSectionHeadings'))
parents = [int(x) for x in re.findall(r'-?\d+',array(setup,'gtdSectionParents'))]
check('28 unique headings with valid parents', len(keys) == len(headings) == len(parents) == 28 and len(set(keys)) == 28 and all(-1 <= p < i for i,p in enumerate(parents)))

ns = {'w':'http://schemas.openxmlformats.org/wordprocessingml/2006/main'}
w = '{'+ns['w']+'}'
with ZipFile(SRC/'TPL_GTD_Publisher.docx') as z:
    root = ET.fromstring(z.read('word/document.xml'))
    template_heads, template_parents, stack, markers = [], [], [], []
    in_scope = False
    verification = []
    in_verification = False
    for para in root.findall('./w:body/w:p',ns):
        text = ''.join(t.text or '' for t in para.findall('.//w:t',ns)).strip()
        st = para.find('./w:pPr/w:pStyle',ns)
        style = st.get(w+'val','') if st is not None else ''
        if text == 'GENEL' and style == 'Heading1': in_scope = True
        if text == 'GEREKSİNİM DOĞRULAMA YÖNTEMİ': in_scope = False; in_verification = True
        if text == 'İZLENEBİLİRLİK MATRİSİ': in_verification = False
        if in_verification and style == 'Heading2': verification.append(text)
        if not in_scope: continue
        if re.fullmatch(r'Heading[123]',style):
            level = int(style[-1])
            stack = stack[:level-1]
            template_parents.append(stack[-1] if stack else -1)
            template_heads.append(text)
            stack.append(len(template_heads)-1)
        markers.extend(re.findall(r'\{\{((?:SEC_|REQ_)[A-Z_]+)\}\}',text))
check('Setup heading text and hierarchy equal the Word template sections 1–3', headings == template_heads and parents == template_parents)
content_keys = [k for k in keys if not k.startswith(('ROOT_','GROUP_'))]
marker_keys = [x[4:] if x.startswith('SEC_') else x for x in markers]
check('24 content keys cover every Word placeholder exactly once', len(marker_keys) == 24 and set(marker_keys) == set(content_keys) and len(set(marker_keys)) == 24)
builder = (OUT/'GTD_Build_Document.ps1').read_text(encoding='utf-8-sig')
ordered_block = re.search(r'\$orderedMarkers\s*=\s*@\{(.*?)\n\s*\}',builder,re.S).group(1)
ps_keys = re.findall(r'"([A-Z_]+)"\s*=',ordered_block)
check('PowerShell consumes all 24 mapped sections', set(ps_keys) == set(content_keys))
check('New verification choices match Word section 4', strings(array(setup,'gtdVerificationMethods')) == verification)
original_sources = strings(re.search(r'enumNames\[6\]\s*=\s*\{(.*?)\}',(SRC/'GTD_Setup_Requirement_Source_Attributes.dxl').read_text(),re.S).group(1))
check('All six requirement source choices are preserved', strings(array(setup,'gtdSourceTypes')) == original_sources)

defined = set(strings(array(setup,'gtdModuleStrings')) + strings(array(setup,'gtdObjectTexts')))
defined.update(re.findall(r'gtdEnsureAttribute\("([^"]+)"',setup))
defined.update(re.findall(r'gtdEnsureEnumeration\("([^"]+)"',setup))
used = set(re.findall(r'\b\w+\."([^"\n]+)"','\n'.join(codes.values())))
check('Every literal custom attribute read is created by setup', used <= defined | {'Object Heading','Object Text','Prefix'})
check('Setup has no object move, delete, link or enum modify operation', re.search(r'\b(move|hardDelete|softDelete|modify|createLink|createBaseline)\s*\(',scrub(setup)) is None)
object_writes = set(re.findall(r'\b(?:created|existing)\."([^"]+)"\s*=',setup))
check('Setup writes only heading text and section key on objects', object_writes == {'Object Heading','GTD Section Key'})
check('Setup never assigns Prefix, Document Date or Document Revision', not re.search(r'gtdSetModuleString\("(?:Prefix|Document Date|Document Revision)"',setup) and not re.search(r'\."(?:Prefix|Document Date|Document Revision)"\s*=',setup))
check('Section key creation explicitly disables inheritance', '(inherit false)' in setup)
check('Managed publishing has no sibling fallback', publisher.count('&& !gtdManagedStructure)') == 4)
check('Headings and pictures excluded from requirement and matrix records', 'gtdBlank(ownHeading) && gtdBlank(getPictName(so))' in publisher and 'gtdBlank(o."Object Heading" "") && gtdBlank(getPictName(o))' in publisher)

installer = codes['GTD_Install_Open_Trigger.dxl']
embedded = ''.join(json.loads(x) for x in re.findall(r'gtdTriggerCode \+= ("(?:[^"\\]|\\.)*")',installer))
check('Installed trigger body equals the readable open-check file', embedded == codes['GTD_Open_Check.dxl'])
for name in ['TPL_GTD_Publisher.docx','GTD_Build_Document.ps1']:
    check('Original bytes preserved: '+name,(SRC/name).read_bytes() == (OUT/name).read_bytes())
for name in ['GTD_Setup_Module.dxl','GTD_Publish.dxl','GTD_Requirement_Review_Control.dxl']:
    check('Encoding-independent ASCII DXL source: '+name, codes[name].isascii())
for label, ok in results: print(('PASS | ' if ok else 'FAIL | ')+label)
print(f'\n{len(results)} static contract checks passed. DOORS compilation and execution were not performed.')
