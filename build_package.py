from pathlib import Path
import json
import re

ROOT = Path(__file__).resolve().parents[1]
if (ROOT/'ORIJINAL_DOSYALAR').is_dir():
    SRC, OUT, WORK = ROOT/'ORIJINAL_DOSYALAR', ROOT/'GUNCEL', ROOT/'BAKIM'
else:
    SRC, OUT, WORK = ROOT/'upload', ROOT/'output/GTD/GUNCEL', ROOT/'work'

# Order and immediate parents are taken from TPL_GTD_Publisher.docx.
SECTIONS = [
    ('ROOT_GENEL', 'GENEL', -1),
    ('AMAC', 'Amaç', 0),
    ('KAPSAM', 'Kapsam', 0),
    ('PROJE_TANITIMI', 'Proje Tanıtımı', 0),
    ('SISTEM_GENEL', 'Sisteme Genel Bakış', 3),
    ('URUN_GENEL', 'Ürüne Genel Bakış', 3),
    ('GROUP_KISALTMALAR_TANIMLAR', 'Kısaltmalar/Tanımlar', 0),
    ('KISALTMALAR', 'Kısaltmalar', 6),
    ('TANIMLAR', 'Tanımlar', 6),
    ('UYGULANABILIR_DOKUMANLAR', 'Uygulanabilir Dokümanlar', 0),
    ('STANDARTLAR', 'Standartlar', 9),
    ('DIGER_DOKUMANLAR', 'Diğer Dokümanlar', 9),
    ('ROOT_SISTEM_TANIMLAMASI', 'SİSTEMİN TANIMLAMASI', -1),
    ('DURUM_MODLAR', 'Durum ve Modlar', 12),
    ('OMUR_DONGUSU', 'Ömür Döngüsü', 12),
    ('SINIRLAMALAR', 'Sınırlamalar', 12),
    ('ROOT_GEREKSINIMLER', 'GEREKSİNİMLER', -1),
    ('REQ_ISLEVSEL', 'İşlevsel Gereksinimler', 16),
    ('REQ_PERFORMANS', 'Performans Gereksinimleri', 16),
    ('REQ_FIZIKSEL', 'Fiziksel Gereksinimler', 16),
    ('REQ_ARAYUZ', 'Arayüz Gereksinimleri', 16),
    ('REQ_CEVRESEL', 'Çevresel Gereksinimler', 16),
    ('REQ_EMNIYET', 'Emniyet Gereksinimleri', 16),
    ('REQ_ELD', 'Entegre Lojistik Destek Gereksinimleri', 16),
    ('REQ_GUV_GIZ', 'Güvenlik ve Gizlilik Gereksinimleri', 16),
    ('REQ_ERGONOMI', 'Ergonomi Gereksinimleri', 16),
    ('REQ_MARKALAMA', 'Markalama ve Etiketleme Gereksinimleri', 16),
    ('REQ_BILGISAYAR', 'Bilgisayar Kaynak Gereksinimleri', 16),
]


def dxl_string(value):
    """ASCII source, UTF-8 runtime string, independent of the editor encoding."""
    parts = []
    plain = ''
    for c in value:
        if ord(c) < 128:
            plain += c
        else:
            if plain:
                parts.append(json.dumps(plain)); plain = ''
            bs = list(c.encode('utf-8'))
            parts.append('headingBytes(' + ', '.join(map(str, bs + [-1]*(3-len(bs)))) + ')')
    if plain or not parts:
        parts.append(json.dumps(plain))
    return ' '.join(parts)


publisher = (SRC/'GTD_Publish.dxl').read_text()
normalizer = publisher[publisher.index('string headingBytes('):publisher.index('string sectionKeyForHeading(')]
legacy_map = publisher[publisher.index('string sectionKeyForHeading('):publisher.index('bool isContentSection(')]
# Preserve all of the previously accepted spelling aliases.
containers = '''    if (headingEndsWith(h, "genel")) return "ROOT_GENEL"
    if (headingEndsWith(h, "kisaltmalar/tanimlar")) return "GROUP_KISALTMALAR_TANIMLAR"
    if (headingEndsWith(h, "kisaltmalarvetanimlar")) return "GROUP_KISALTMALAR_TANIMLAR"
    if (headingEndsWith(h, "sistemintanimlamasi")) return "ROOT_SISTEM_TANIMLAMASI"
    if (headingEndsWith(h, "sistemintanimi")) return "ROOT_SISTEM_TANIMLAMASI"
    if (headingEndsWith(h, "gereksinimler")) return "ROOT_GEREKSINIMLER"
'''
legacy_map = legacy_map.replace('    return ""\n}', containers + '    return ""\n}')
content_funcs = publisher[publisher.index('bool isContentSection('):publisher.index('// IMPORTANT: this starts at parent(x), not x.')]
arrays = 'const int GTD_SECTION_COUNT = 28\n'
arrays += 'string gtdSectionKeys[] = {\n' + ',\n'.join('    '+json.dumps(k) for k,_,_ in SECTIONS) + '\n}\n'
arrays += 'string gtdSectionHeadings[] = {\n' + ',\n'.join('    '+dxl_string(h) for _,h,_ in SECTIONS) + '\n}\n'
arrays += 'int gtdSectionParents[] = {' + ', '.join(str(p) for _,_,p in SECTIONS) + '}\n'
common = '// BEGIN GTD SECTION MODEL - keep identical in setup, publisher and Control.\n'
common += normalizer + arrays + legacy_map + content_funcs + '''
int gtdSectionIndex(string key)
{
    int i
    for (i = 0; i < GTD_SECTION_COUNT; i++)
        if (gtdSectionKeys[i] == key) return i
    return -1
}

bool gtdBlank(string s)
{
    int i
    for (i = 0; i < length(s); i++) {
        string c = s[i:i]
        if (c != " " && c != "\\t" && c != "\\r" && c != "\\n") return false
    }
    return true
}

string gtdStoredSectionKey(Object o)
{
    if (null o) return ""
    Module om = module(o)
    AttrDef ad = find(om, "GTD Section Key")
    if (null ad || !ad.object) return ""
    return o."GTD Section Key" ""
}

string sectionKeyForObject(Object o)
{
    if (null o || isDeleted(o)) return ""
    if (table(o) || row(o) || cell(o)) return ""
    if (!gtdBlank(getPictName(o))) return ""
    string h = o."Object Heading" ""
    if (gtdBlank(h)) return ""
    string key = gtdStoredSectionKey(o)
    // A nonempty unknown key must not fall back to the visible title.
    if (!gtdBlank(key)) {
        if (gtdSectionIndex(key) >= 0) return key
        return ""
    }
    return sectionKeyForHeading(h)
}

string gtdSectionIdentityIssue(Object o)
{
    string stored = gtdStoredSectionKey(o)
    if (gtdBlank(stored)) return ""
    if (table(o) || row(o) || cell(o)) return "SECTION_KEY_ON_TABLE"
    if (gtdSectionIndex(stored) < 0) return "UNKNOWN_SECTION_KEY"
    string h = o."Object Heading" ""
    if (gtdBlank(h)) return "SECTION_KEY_WITHOUT_HEADING"
    string pict = getPictName(o)
    if (!gtdBlank(pict)) return "SECTION_KEY_ON_PICTURE"
    string titleKey = sectionKeyForHeading(h)
    if (titleKey != "" && titleKey != stored) return "SECTION_KEY_TITLE_CONFLICT"
    return ""
}

// Start at the parent: a section heading is not its own requirement.
// A recognized container closes the search; do not inherit a stale section.
string sectionKeyFromParents(Object x)
{
    Object p = parent(x)
    while (!null p) {
        string key = sectionKeyForObject(p)
        if (key != "") {
            if (isContentSection(key)) return key
            return ""
        }
        p = parent(p)
    }
    return ""
}
// END GTD SECTION MODEL
'''
(WORK/'section_model.dxl').write_text(common, encoding='ascii')
(WORK/'section_manifest.json').write_text(json.dumps(SECTIONS,ensure_ascii=False,indent=2))

# Publisher keeps the established text protocol and Word builder unchanged.
start = publisher.index('string headingBytes(')
end = publisher.index('// Self-check both source encodings')
publisher = publisher[:start] + common + '\n' + publisher[end:]
publisher = publisher.replace('Run GTD_Setup_Requirement_Source_Attributes.dxl once', 'Run GTD_Setup_Module.dxl once')
publisher = publisher.replace('ownSection = sectionKeyForHeading(ownHeading)', 'ownSection = sectionKeyForObject(so)')
publisher = publisher.replace('sectionKeyForHeading(ownHeading)', 'sectionKeyForObject(so)')
publisher = publisher.replace('if (ownSection != "") {\n                activeSection', 'if (isContentSection(ownSection)) {\n                activeSection')
for variable in ['narrativeSection','orderedSection','pictureSection','tableSection']:
    publisher = publisher.replace(f'if ({variable} == "")\n', f'if ({variable} == "" && !gtdManagedStructure)\n')
publisher = publisher.replace('if (isRequirementSection(narrativeSection) && sectionReqType != "")', 'if (isRequirementSection(narrativeSection) && sectionReqType != "" && gtdBlank(ownHeading) && gtdBlank(getPictName(so)))')
publisher = publisher.replace('if (orderedReqType != "" && orderedReqText != "")', 'if (orderedReqType != "" && orderedReqText != "" && gtdBlank(ownHeading) && gtdBlank(getPictName(so)))')
publisher = publisher.replace('if (reqType != "" && objText != "")', 'if (reqType != "" && objText != "" && gtdBlank(o."Object Heading" "") && gtdBlank(getPictName(o)))')
gate = '''
// Managed modules use hierarchy, never the legacy sibling fallback.
AttrDef gtdKeyAttr = find(m, "GTD Section Key")
bool gtdManagedStructure = !null gtdKeyAttr
if (gtdManagedStructure) {
    Buffer structureIssues = create
    if (gtdBlank(systemName) || gtdBlank(documentNumber) || gtdBlank(documentRevision) ||
        gtdBlank(documentDate) || gtdBlank(projectName) || gtdBlank(projectNumber) ||
        gtdBlank(department) || gtdBlank(classification) || gtdBlank(m."Prefix" ""))
        structureIssues += "Required document metadata is missing; run GTD_Module_Info.dxl.\\n"
    AttrDef setupStateAttr = find(m, "GTD Setup State")
    if (null setupStateAttr || !setupStateAttr.module)
        structureIssues += "GTD Setup State missing; run GTD_Setup_Module.dxl.\\n"
    else {
        string setupState = m."GTD Setup State" ""
        if (setupState != "READY")
            structureIssues += "Setup is incomplete; resolve the setup log and run it again.\\n"
    }
    int sectionCount[GTD_SECTION_COUNT]
    int si
    for (si = 0; si < GTD_SECTION_COUNT; si++) sectionCount[si] = 0
    Object checkObject
    for checkObject in entire m do {
        if (isDeleted(checkObject)) continue
        string issue = gtdSectionIdentityIssue(checkObject)
        if (issue != "") structureIssues += identifier(checkObject) " : " issue "\\n"
        if (table(checkObject) || row(checkObject) || cell(checkObject)) continue
        string key = sectionKeyForObject(checkObject)
        int idx = gtdSectionIndex(key)
        if (idx >= 0) {
            sectionCount[idx]++
            Object p = parent(checkObject)
            int pi = gtdSectionParents[idx]
            string expectedParent = ""
            if (pi >= 0) expectedParent = gtdSectionKeys[pi]
            string actualParent = sectionKeyForObject(p)
            bool wrongParent = false
            if (pi < 0 && !null p) wrongParent = true
            if (pi >= 0 && (null p || actualParent != expectedParent)) wrongParent = true
            if (wrongParent) structureIssues += identifier(checkObject) " : WRONG_PARENT " key "\\n"
        }
        string rt = checkObject."Requirement Type" ""
        string txt = checkObject."Object Text" ""
        string head = checkObject."Object Heading" ""
        if (!gtdBlank(rt) && !gtdBlank(txt) && gtdBlank(head) && gtdBlank(getPictName(checkObject))) {
            string containing = sectionKeyFromParents(checkObject)
            if (!isRequirementSection(containing))
                structureIssues += identifier(checkObject) " : REQUIREMENT_OUTSIDE_SECTION\\n"
        }
    }
    for (si = 0; si < GTD_SECTION_COUNT; si++)
        if (sectionCount[si] != 1)
            structureIssues += gtdSectionKeys[si] " : expected one heading; found " sectionCount[si] "\\n"
    if (length(stringOf(structureIssues)) > 0) {
        string structureLog = tempFileName() "_GTD_Structure_Check.txt"
        Stream structureOut = write(structureLog)
        if (!null structureOut) {
            structureOut << stringOf(structureIssues)
            close(structureOut)
        }
        print stringOf(structureIssues)
        close(out)
        ack "GTD bolum yapisi tamamlanmamis. Yayin durduruldu.\\nSetup'i tekrar calistirin.\\n\\nKontrol raporu:\\n" structureLog
        delete(structureIssues)
        halt
    }
    delete(structureIssues)
}

'''
publisher = publisher.replace('bool oldTableContents = tableContents(m)', gate+'bool oldTableContents = tableContents(m)')
publisher = publisher.replace('// A recognized heading ALWAYS wins and immediately becomes active.', '// A content heading becomes active; a container closes sibling context.')
publisher = publisher.replace('            else {\n            }\n', '')
(OUT/'GTD_Publish.dxl').write_text(publisher, encoding='ascii')

control = (SRC/'GTD_Requirement_Review_Control.dxl').read_text()
start = control.index('string headingBytes(')
end = control.index('string expectedTypeNormalized(')
control = control[:start] + common + '\n' + control[end:]
control = control.replace('requirementSectionFromParents(o)', 'sectionKeyFromParents(o)')
control = control.replace('else if (table(o) || row(o) || cell(o)) {', 'else if (isDeleted(o) || table(o) || row(o) || cell(o)) {')
control = control.replace('if (!null pictureName && pictureName != "") {', 'if ((!null pictureName && pictureName != "") || !isBlank(o."Object Heading" "")) {')
# The new setup creates all these definitions; also fail readably if run on a raw module.
control = control.replace('''        if (isBlank(objectText) || sectionKey == "") {
            display ""
        }
        else {''', '''        Module controlModule = module(o)
        AttrDef typeDefinition = find(controlModule, "Requirement Type")
        AttrDef methodDefinition = find(controlModule, "Verification Method")
        if (isBlank(objectText)) {
            display ""
        }
        else if (null typeDefinition || null methodDefinition) {
            display "HATA: Setup eksik"
        }
        else if (!isRequirementSection(sectionKey)) {
            string existingType = o."Requirement Type" ""
            if (!isBlank(existingType)) display "HATA: Gereksinim standart baslik disinda"
            else display ""
        }
        else {''')
control = control.replace('Module m = current', 'Module m = module(o)')
control = control.replace('//   - objects outside requirement sections', '//   - untyped narrative outside requirement sections')
control = control.replace('// Headings, narrative objects and anything outside requirement\n        // sections are intentionally not checked.', '// Untyped narrative outside requirement sections is ignored.\n        // Typed objects outside those sections need manual placement.')
control = control.replace('else if (null typeDefinition || null methodDefinition)', 'else if (null typeDefinition || null methodDefinition || !typeDefinition.object || !methodDefinition.object)')
(OUT/'GTD_Requirement_Review_Control.dxl').write_text(control,encoding='ascii')

setup = (WORK/'setup_body.dxl').read_text(encoding='ascii')
setup = setup.replace('// INSERT SECTION MODEL HERE', common)
setup = setup.replace('// INSERT ENUM LABELS HERE', '''string gtdRequirementTypes[] = {
''' + ',\n'.join('    '+dxl_string(x) for x in ['İşlevsel','Performans','Fiziksel','Arayüz','Çevresel','Emniyet','Entegre Lojistik Destek','Güvenlik ve Gizlilik','Ergonomi','Markalama ve Etiketleme','Bilgisayar Kaynak']) + '''
}
string gtdVerificationMethods[] = {
''' + ',\n'.join('    '+dxl_string(x) for x in ['Analiz','Gösterim','Muayene','Test','Uygunluk Belgesi']) + '\n}\n')
(OUT/'GTD_Setup_Module.dxl').write_text(setup,encoding='ascii')

# Keep the embedded trigger body byte-for-byte in step with its readable file.
open_check = (SRC/'GTD_Open_Check(1).dxl').read_text().replace(
    '// Master/template marker is not configured: silently ignore.',
    '// GTD setup marker is not configured: silently ignore.')
(OUT/'GTD_Open_Check.dxl').write_text(open_check, encoding='ascii')
installer = (SRC/'GTD_Install_Open_Trigger(1).dxl').read_text()
a = installer.index('    gtdTriggerCode += ')
b = installer.index('\nTrigger gtdInstalledTrigger')
embedded = ''.join('    gtdTriggerCode += '+json.dumps(line)+'\n' for line in open_check.splitlines(keepends=True))
installer = installer[:a] + embedded + installer[b:]
(OUT/'GTD_Install_Open_Trigger.dxl').write_text(installer,encoding='ascii')
info = (SRC/'GTD_Module_Info(1).dxl').read_text().replace(
    '// Assumes the GTD master/setup has already created the module attributes.',
    '// Run GTD_Setup_Module.dxl first to create the module attributes.')
(OUT/'GTD_Module_Info.dxl').write_text(info, encoding='utf-8')

print('Built setup, publisher and Control from one section model.')
