# Gemini — Researcher görevi

Devir kimliği: **GTD-HANDOFF-2026-09-13-a3cc85b1e006**

Bu projede Researcher / Research & Standards Analyst rolündesin. Ekli bağlamı ve kod kanıtı alıntılarını okuyup aşağıdaki soruları **kaynak araştırması yaparak** yanıtla. Türkçe rapor ver. Bu görev kod incelemesini tekrar etmekten çok sürüm/API ve mühendislik iddialarını doğrulamak içindir; önemli kod çelişkisi görürsen kanıtıyla bildir.

## Çalışma kuralları

- Hedef **IBM DOORS Classic 9.6.1.3 64-bit**. DOORS Next belgelerini eşdeğer kabul etme. 9.1, 9.6 veya 9.7 belgesindeki bilgi için hedef sürüm uygulanabilirliğini ayrı yaz. Tam patch sürümü kanıtlanamıyorsa bunu belirt.
- IBM DXL Reference Manual, IBM Docs/support/release note/APAR gibi birincil kaynaklara öncelik ver. Windows PowerShell için Microsoft, DOCX/Open XML için ECMA/Microsoft gibi asıl yayımlayıcı belgelerini kullan. Sistem mühendisliği için resmî standart yayımlayıcısı, INCOSE veya NASA gibi kurumsal kaynakları değerlendir.
- Kaynağı gerçekten aç ve ilgili bölümü oku. Arama özeti veya bir AI cevabını doğrulama kanıtı olarak kullanma. Forum/mirror bulgularını birincil yayımlayıcı belgesiyle karıştırma; bir mirror'daki özgün IBM dokümanını kullanırsan sürümünü ve barındırma durumunu yaz.
- Her teknik iddiada kaynak başlığı, kurum, belge/sürüm tarihi, ilgili bölüm/sayfa, doğrudan URL ve erişim tarihini ver. Destekleyen kısa alıntıyı yalnız gerekli ve izin verilen ölçüde kullan; paragraf/kitap kopyalama.
- Bağlayıcı standart hükmü, kurum iyi uygulaması, proje kararı ve kendi çıkarımını ayır. Kullanıcının sözleşmesi veya uygulanacak standart listesi verilmedi; zorunluluk uydurma.
- D-ID'ler mevcut kararlardır; değiştirilmesi gerekiyorsa kanıt + etkiler + mevcut kararı koruyan seçenek + karar değişikliği önerisi sun. I-ID'leri kullanıcı tarafından ayrıca onaylanmış varsayma.
- 'Belgelendi' ile 'bu kod gerçek istemcide derlendi/çalıştı' farklı sonuçlardır. DXL/Windows testleri burada henüz yapılmış değildir.

## Araştırma soruları

| ID | Doğrulanacak konu | Beklenen sonuç |
|---|---|---|
| RQ01 | Yeni/mevcut formal module için DXL create/attribute/view API'lerinin 9.6.1.3 desteği; 64-bit etkisi | Hedefe uygulanabilir kaynak ve hâlâ compile/runtime gerektiren noktalar |
| RQ02 | `create(Module)`, `create before/after`, `create last below` nesne konumu; `entire`/parent ve filtre/silinmiş/table nesneleri | Kodda varsayılan ekleme ve tarama davranışlarının dayanağı |
| RQ03 | AttrDef.type/module/object/inherit/multi/dxl; AttrType.strings/size; enum create overload ve mevcut tanımı koruma | Gerçek imza/özellik desteği; noninherited String key yaklaşımına etki |
| RQ04 | views/load/save, ViewDef/create/useWindows, Column insert/delete/main/attribute/dxl; Standard view adı ve locale | Mevcut görünüm/erişim korunumu ve tekrar kurulum etkisi |
| RQ05 | Persistent trigger kapsamı/current project; open/post/priority; `eval_`; read-only/baseline açılışı | Kurulum/yenileme/kaldırma ve form çağrısına ilişkin belgelenmiş sınırlar |
| RQ06 | Aynı modülde nesne taşımanın Absolute Number/identifier/Prefix, history ve linklere etkisi | Ne korunur, ne değişebilir, hangi gerçek test kanıtı gerekir? |
| RQ07 | Outgoing link → kaynak yönü, tam link modülü filtresi, yüklenmemiş/silinmiş/erişilemeyen hedef ve ModuleVersion | Raw link sayısı / geçerli izlenebilirlik ayrımı ve kaynak sürümü anlamı |
| RQ08 | DXL string/file encoding ve PowerShell `Get-Content -Encoding Default`; Windows locale ve Unicode | Türkçe/özel karakter aktarımı için doğrulanmış koşullar ve minimum test örnekleri |
| RQ09 | Native picture/table ve Object Text aktarımı; pipe sanitization; DOCX marker/XML escaping/alan güncelleme | Destek sınırları, belgelendirilebilir riskler ve resmi API davranışı |
| RQ10 | PLM release sonrasında manuel DOORS baseline; Word çıktısı ile baseline içeriğini eşleme | D09'u koruyan uygulanabilir kayıt/iş akışı seçenekleri; hangi şartlarda uyumsuzluk oluşabileceği |
| RQ11 | Altı Requirement Source Type sınıfı; özellikle Derived için yapılandırılmış üst kaynak linki olmaması | Proje sınıflandırmasının genel gereksinim türetme/izlenebilirlik uygulamalarıyla ilişkisinin kaynaklı değerlendirmesi |
| RQ12 | Verification Method tek/çoklu seçim; yöntem ile gerçek doğrulama kanıtı; Control hataları ve yayın kapısı | Standart/iyi uygulama/proje tercihinin ayrımı; minimum gerekçeli öneri |
| RQ13 | Gelecek baseline diff aracının içerik/link/hiyerarşi/görsel kapsamı | Kaynaklı kapsam soruları; mevcut pakette araç varmış gibi anlatılmamalı |

Önce RQ01–RQ08'in somut teknik iddialarını, ardından süreç konularını tamamla. Sadece genel best-practice yazısı verme. Her soruya ulaşabildiğin kanıtla yanıt ver; erişilemeyen veya hedef sürüm için doğrulanamayanları açık bırak.

## Beklenen rapor

`GEMINI_RESEARCH_REPORT.md` adlı rapor ver; dosya üretemiyorsan aynı yapıyı yanıtında kullan.

1. Devir kimliği, araştırma tarihi, gerçekten kullanılan kaynaklar/araçlar ve erişim sınırı.
2. RQ01–RQ13 için sonuç tablosu: iddia, **SUPPORTED / PARTIAL / CONTRADICTED / UNVERIFIED**, kaynak ID, hedef sürüm uygulanabilirliği, kod/süreç etkisi, kalan test veya karar ihtiyacı.
3. Önemli bulgulara `RS-001` biçiminde ID: önem, ilgili D/I/O-ID, somut dosya/işlev/satır veya süreç adımı, kaynak kanıtı, çıkarım, öneri, doğrulama adımı.
4. Kaynak listesi: `SRC-001`, başlık/yayımlayıcı/sürüm/tarih/bölüm veya sayfa/doğrudan URL/erişim tarihi. Her kaynak hangi RQ/RS'yi desteklediğini göstermeli.
5. Mevcut kararı koruyan öneriler ve karar değişikliği gerektiren öneriler ayrı belirtilmeli. Araştırmayla çözülemeyen hedef ortam testleriyle bitir.

Belgeye erişilemediyse onu okudum deme; yalnız metadata/abstract görüldüyse bunu yaz. Tarama erişimin yoksa araştırmayı yapılmış gibi göstermeden doğrulanamayanları ve kullanılabilir birincil kaynak arama planını belirt.
