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



---

# Girdi kapsamı


Bu tek dosya ortak proje durumunu, kararları, araştırma görevini ve güncel koddan seçilmiş kanıt kesitlerini içerir. Tam kod incelemesi yapılmış olduğunu varsayma. Gerektiğinde tam kaynaklar GTD_AI_Team_Handoff.zip içindedir; erişmediğin dosyalar için okunmuş iddiasında bulunma.



---

# Included document: 00_MASTER_CONTEXT.md

# GTD — ortak proje hafızası

Devir kimliği: **GTD-HANDOFF-2026-09-13-a3cc85b1e006**  
Hazırlanma tarihi: 2026-09-13  
Durum: **İncelemeye hazır uygulama adayı; gerçek DOORS/Windows doğrulaması bekleniyor.**

## Amaç ve kapsam

IBM DOORS Classic **9.6.1.3 64-bit** içindeki yeni veya mevcut formal module'leri ortak GTD yapısına hazırlamak; gereksinimleri, bölüm metinlerini, görselleri ve yerel tabloları şirket Word şablonuna aktarmak. Resmî doküman onay/release sistemi PLM'dir.

Bu devir, mevcut dosyalar ve konuşmada netleştirilmiş proje kararlarından oluşturuldu. GTD kısaltmasının açılımı, PLM ürünü, istemci Windows/PowerShell sürümü ve kurum standardı verilmedi; bunları tahmin etmeyin. Capella/MBSE entegrasyonu bu paketin kapsamına eklenmiş değildir.

## Takım ve yetki

| Üye | Rol | Teslimat |
|---|---|---|
| Kullanıcı | Product Owner / karar verici | Bulguların önceliği, süreç değişiklikleri ve kabul kararı |
| ChatGPT | Lead / birleştirme | Ortak durum, görevler, bulguların değerlendirilmesi ve onaylanan düzeltmeler |
| Claude | Bağımsız Reviewer | Kod ve tasarım bulguları; dosya/işlev/satır kanıtı; düzeltme ve test önerileri |
| Gemini | Researcher | Sürüm uyumluluğu ve mühendislik iddiaları için kaynaklı doğrulama |

Bu dosyalar görev devridir. Claude/Gemini tarafından henüz inceleme veya araştırma yapılmış olduğunu göstermez. Raporlar kullanıcı üzerinden ChatGPT'ye döner. Bir rapordaki öneri kendiliğinden kabul edilmiş karar haline gelmez.

## Esas alınacak içerik

1. `01_DECISIONS.md`: kullanıcı tarafından netleştirilmiş kararlar ve bunlardan ayrı uygulama tercihleri.
2. `PROJECT_FILES/GTD/GUNCEL/`: bu devir kimliğine ait yürütülebilir aday dosyalar.
3. `PROJECT_FILES/GTD/ORIJINAL_DOSYALAR/`: yüklenen dokuz dosyanın değiştirilmemiş kopyaları; tarihlerinden olgunluk veya test durumu çıkarılmamalı.
4. `PROJECT_FILES/GTD/BAKIM/`: üretim kaynakları ve statik kontrol aracı. DOORS içinde çalıştırılmaz.
5. `06_FILE_INVENTORY.md`, `EVIDENCE/FILE_MANIFEST.json` ve `DIFFS/`: dosya eşlemesi, hash'ler, gerçek farklar.

Karar ve kod çelişirse bunu bulgu olarak kaydedin. Kararı koda uydurmayın veya dokümantasyonu doğruluk kanıtı saymayın. Tüm raporlar devir kimliğini tekrar yazmalı.

## Şu anda bulunan uygulama

- Yeni `GTD_Setup_Module.dxl`, ayrı DOORS şablon modülü kopyalama ihtiyacını kaldırmayı amaçlar. Açık formal module'de eksik şema, 28 başlık ve Entry/Review view'larını hazırlar.
- Tek ve doğru ebeveyn altında bulunan başlığı aynı nesne üzerinden kullanır. Eksikleri oluşturur; çakışmaları raporlar. Gereksinimleri otomatik taşımaz.
- Publisher ve Control, setup ile aynı bölüm anahtarı modelini içerir. Setup uygulanmış modüllerde gerçek başlık hiyerarşisi esastır.
- Gereksinim kaynağı ve outgoing link kuralları önceki dosyalardan korunmuştur.
- Word şablonu ve PowerShell dosyası yüklenenlerle bayt düzeyinde aynıdır; bu, hatasız veya hedef ortamda test edilmiş oldukları anlamına gelmez.
- Module Info ve açılış trigger ailesinin temel işlevi korunmuştur. Yalnız ilgili açıklamalar ve gömülü gövde eşlemesi güncellenmiştir.

## Doğrulama ve açık iş

Mevcut rapor **34 statik sözleşme kontrolünün geçtiğini** bildiriyor. Kontroller çoğunlukla dosya içeriği, eşleşme ve belirli kod kalıplarını denetliyor; bir DXL derleyicisi, çalışma zamanı testi veya tam veri-kaybı ispatı değil.

Bu ortamda DOORS 9.6.1.3 derlemesi/çalıştırması ve Windows PowerShell ile uçtan uca yayın yapılmadı. Bu nedenle 'üretime hazır', 'tüm testler geçti' veya 'migration kesin korunur' sonucu çıkarılamaz. Word şablonunun önceki yerel render incelemesi, DOORS'tan üretilmiş gerçek çıktı testi değildir.

Son release baseline'ı ile güncel modülü karşılaştırıp Word Değişiklik Kaydı'nı dolduracak araç bu dosyalarda **yoktur**. Bu özellik planlanan açık iş olarak kalır. Ayrıntılar `05_OPEN_ITEMS.md` ve `07_VALIDATION_AND_ACCEPTANCE.md` içindedir.




---

# Included document: 01_DECISIONS.md

# Kararlar ve uygulama tercihleri

## Kullanıcı tarafından netleştirilmiş proje kararları

| ID | Karar | İncelemede korunacak anlam |
|---|---|---|
| D01 | Hedef IBM DOORS Classic 9.6.1.3 64-bit. | DXL doğrulaması DOORS Next veya farklı sürümle eşdeğer sayılamaz. |
| D02 | DOORS'ta ayrı şablon modülü tutmak gerekmeyecek. | Tasarımcı yeni veya eski formal module açtıktan sonra ana setup DXL'yi çalıştıracak. Word şablonu kullanılmaya devam eder. |
| D03 | Önceden oluşturulmuş başlık yeniden oluşturulmayacak. | Uygun mevcut nesne kullanılmalı; mevcut veriler, attribute/enum tanımları, view'lar ve linkler korunmalı. |
| D04 | Eski gereksinimleri sistem mühendisi başlıkların altına taşıyacak. | Aynı modülde mevcut nesneler kullanılır; metinden gereksinim yeniden oluşturma veya otomatik sınıflandırma yapılmaz. |
| D05 | DOORS → DXL kayıtları → PowerShell → şirket Word şablonu → DOCX. | Mevcut yayın mimarisi ve PLM onay süreci esas alınır. |
| D06 | Control sütunu tür/bölüm, doğrulama ve kaynak/link kurallarını denetler. | Başlıklar, görseller ve native table/row/cell nesneleri gereksinim kontrolüne sokulmaz. |
| D07 | Requirement Source Type/Reference ve trace link yaklaşımı devam eder. | Mevcut altı seçenek ve kaynak kuralları korunur; bunların evrensel bir standardın hükmü olduğu iddia edilmez. |
| D08 | DOORS'ta 4. Gereksinim Doğrulama Yöntemi ve 5. İzlenebilirlik Matrisi bölümleri oluşturulmaz. | Bilgi attribute/link olarak yaşar; Word'daki bu bölümler korunur. Var olan nesneler otomatik silinmez. |
| D09 | Taslak Word üretiminde veya görüş sürecinde otomatik baseline yok. | PLM'de resmî release sonrasında sistem mühendisi DOORS'ta manuel baseline alır. |
| D10 | Sonraki revizyon aracı son release baseline'ı ile güncel modül farkına bakacak. | Bu gelecek işlev mevcut pakette tamamlanmış sayılmaz. |
| D11 | Document Revision ve Document Date otomatik artırılmayacak. | Bilgi formunda kullanıcının kaydetmesi ile otomatik sürüm artışı birbirine karıştırılmaz. |
| D12 | Final dosya adlarında v17/debug gibi geliştirme ekleri temizlenecek. | Yüklemedeki `(1)` adları yalnız orijinal kopyalarda korunur; eski dosyalar delil olarak tutulur. |

Kararlar incelemeye kapalı dogmalar değildir. Kanıtlanmış bir çelişki veya veri bütünlüğü sorunu bulunursa ilgili D-ID ile gerekçeli değişiklik önerisi verin. Mimariyi kendiliğinden yeniden tasarlamayın; kabul yetkisi kullanıcıdadır.

## Bu uygulama adayının teknik tercihleri

Aşağıdakiler kodda mevcut tercihlerdir; her birinin kullanıcı tarafından ayrıca onaylandığı varsayılmamalı.

| ID | Tercih | Reviewer / Researcher değerlendirmesi |
|---|---|---|
| I01 | Word 1–3. bölümlerinden 28 başlık, 24 içerik hedefi, 11 gereksinim türü. | Şablonla eşleme ve hiyerarşi doğruluğu. |
| I02 | Non-inherited String `GTD Section Key`, başlık nesnesi kimliği için öncelikli anahtar. | Görünen ad değişikliği, çakışma, bilinmeyen anahtar, miras ve kapsam davranışı. |
| I03 | Yinelenen/yanlış ebeveynli başlıkta seçim/taşıma yapılmaz; bağımlı alt dal bekler. | Çözümlenmemiş dalın davranışı ve tekrar çalıştırma. |
| I04 | `GTD Setup State`: INCOMPLETE / NEEDS_REVIEW / READY. | READY yalnız kurulum sonucudur; içerik veya release onayı değildir. |
| I05 | Yeni Verification Method, beş seçenekli tek seçimli enum. | Analiz, Gösterim, Muayene, Test, Uygunluk Belgesi; bir gereksinimin birden fazla yönteme ihtiyacı olup olmadığı açık konudur. Mevcut çoklu seçim ayarı korunur. |
| I06 | Mevcut Entry view korunur; Review'da yalnız Control eklenir/güncellenir. | Özel görünüm, erişim, sütun çakışması ve refresh sırasında Layout DXL etkileri. |
| I07 | Setup uygulanmış modülde yayın için yapı kontrolü ve gerçek parent ilişkisi. | Yapısı kurulmamış eski modülde eski ardışık nesne eşleme davranışı korunmuştur. |
| I08 | Kaynak uyarıları yayın kayıtlarına/log'a yazılır; mevcut kodda hepsi Word üretimini durdurmaz. | Control hataları ile yayın engeli aynı kabul edilmemeli; kapı politikası için öneri ayrı sunulmalı. |
| I09 | Setup sonunda modül kaydedilir; çalışma zamanı hatasında otomatik rollback yok. | Kısmi işlem, kayıt başarısızlığı, yeniden çalıştırma ve kullanıcıya kalan iş. |
| I10 | DXL kaynakları ASCII; Türkçe başlık metinleri byte helper ile kurulur. | Çalışma zamanı encoding'i, Windows kod sayfası, Unicode aktarımı. |

## Değişiklik kaydı kuralı

Her öneri `bulgu → etkilenen D/I-ID → kanıt → önerilen değişiklik → etki → gerekli doğrulama → kullanıcı kararı` sırasıyla değerlendirilir. Reddedilen ve ertelenen öneriler de gerekçesiyle kaydedilir. İki modelin aynı şeyi söylemesi tek başına doğrulama sayılmaz.




---

# Included document: 02_ARCHITECTURE_AND_WORKFLOW.md

# Mimari ve iş akışı

## Çalışma akışı

1. Tasarımcı yeni veya mevcut formal module'ü görünür pencerede Exclusive Edit açar; `GTD_Setup_Module.dxl` çalıştırır.
2. Setup mevcut şemayı ve klasör/yol ayarlarını kontrol eder. Uyuşmazlık varsa uygun aşamada durur; eksik tanımlar, başlıklar ve view'lar hazırlanır.
3. Tek ve doğru yerdeki başlık tekrar kullanılır. Mükerrer veya yanlış yerdeki başlık log'a girer. Sistem mühendisi çakışmaları düzeltip setup'ı yeniden çalıştırır.
4. Sistem mühendisi mevcut gereksinim nesnelerini aynı modül içinde ilgili başlıkların altına taşır; eksik tür, doğrulama ve kaynak bilgilerini tamamlar. Setup bu bilgileri gereksinim bazında uydurmaz.
5. Modül bilgi formunda doküman bilgileri kaydedilir. Control bulguları değerlendirilir.
6. `GTD_Publish.dxl` yapı ve gerekli tanımları kontrol eder; geçici metin kayıtlarını ve varsa görselleri üretir. PowerShell ve DOCX şablonu geçici yerel konuma kopyalanarak Windows PowerShell çağrılır.
7. `GTD_Build_Document.ps1` DOCX paketinin XML parçalarını, bölüm içeriğini ve trace matrisini doldurur; XML geçerliliğini kontrol edip çıktıyı oluşturur.
8. Sistem mühendisi Word'da alanları/İçindekiler'i günceller, sonucu gözden geçirir ve PLM onayına sunar. Release sonrası baseline manuel alınır.

## Bileşenler

| Dosya | Sorumluluk |
|---|---|
| GTD_Setup_Module.dxl | Şema ön kontrolü, eksikleri oluşturma, başlık kimliği/hiyerarşisi, view, log ve kurulum durumu |
| GTD_Requirement_Review_Control.dxl | Requirement Review içindeki nesne bazlı Layout DXL; normal bağımsız script giriş noktası değildir |
| GTD_Module_Info.dxl | Doküman metadata formu; Kaydet ile kullanıcı değerlerini kaydeder |
| GTD_Open_Check.dxl | Proje açılış trigger'ının okunabilir gövdesi |
| GTD_Install_Open_Trigger.dxl | Current projede GTD_Module_Open_Check isimli kalıcı trigger kurar/yeniler |
| GTD_Remove_Open_Trigger.dxl | Aynı trigger'ı kaldırır |
| GTD_Publish.dxl | Bölüm/requirement/image/table ve trace kayıtlarını üretir, PS1'i başlatır |
| GTD_Build_Document.ps1 | Kayıtlardan şirket şablonu ile DOCX oluşturur |
| TPL_GTD_Publisher.docx | Kapak, metadata, bölüm yapısı, doğrulama bölümü ve trace matrisi şablonu |

## Nesne ve bölüm sözleşmesi

Başlık kimliği `GTD Section Key` ile tanımlanır. İlk eşleştirmede tanımlı yazım seçenekleri, Türkçe karakter/boşluk/büyük-küçük harf ve sayısal önek normalizasyonu kullanılır. Key varsa tanınan key önceliklidir. Başlığın metni farklı bir serbest ada çevrilebilir; başka bilinen bölüm adıyla çelişirse raporlanır. Bilinmeyen fakat dolu key sessizce başlıktan yeniden tahmin edilmez.

Setup, başlıkların hemen üstündeki parent'ı esas alır. Gereksinim/narrative içeriğinin bölümü parent zincirindeki uygun bölümden bulunur. Yeni yapıda başlığın ekranda ardından gelmek yeterli değildir; içerik hiyerarşide altında olmalıdır. Bilinen kapsayıcı başlık, uzaktaki eski bir içerik bölümünden yanlış miras alınmasını durdurur.

`entire module` taramalarıyla filtre dışında kalan nesneler de değerlendirilir. Silinmiş nesneler aktif başlık sayılmaz. Setup gereksinim nesnelerini silmez/taşımaz; mevcut başlıklara boş key atayabilir ve yeni başlıklarda Heading/Key yazar. Yeni başlık eklenmesi görünür bölüm numaralarını etkileyebilir. Yapısal hareketin geçmiş kaydı yaratması, önceki geçmişin kaybolmasıyla aynı şey değildir; gerçek istemcide doğrulanmalıdır.

## Kayıt protokolü

| Kayıt | İçerik |
|---|---|
| M | Doküman metadata anahtar/değer |
| O | Sıralı bölüm içeriği: TEXT, REQ, IMAGE, TABLE_START, CELL, TABLE_END |
| R | Gereksinim kimliği, tür, metin, doğrulama yöntemi ve referansı |
| Q | Gereksinim için sistem/not/kaynak sınıfı/kaynak referansı |
| X | Outgoing kaynak linki, modül ve çözümleme durumu |
| D | Tanı, kaynak uyarıları ve özet kayıtları |

Alan ayracı `|` karakteridir. `safeField`, `|`, tab, CR ve LF karakterlerini boşluğa dönüştürür. Bu metin dönüşümü biçim koruma garantisi değildir; satır sonları/rich text ve özel karakterlerin beklenen çıktısı Reviewer kapsamındadır. PowerShell `Get-Content -Encoding Default` kullanır; DXL dosya çıktısı ve Windows kod sayfası ile uyumu hedef ortamda doğrulanmalıdır.

Şablonda 24 içerik placeholder'ı vardır. Word'daki 4 ve 5. bölümler DOORS başlık listesine eklenmez. Şablon/marker'lar için `EVIDENCE/TEMPLATE_STRUCTURE.md`, bölüm/ebeveyn listesi için `EVIDENCE/SECTION_MAP.md` kullanılır.

## Yayın kontrolünün sınırı

`GTD Section Key` attribute'ünün varlığı managed yapı yolunu seçtirir. Bu yolda READY durumu, zorunlu metadata, her bölümden tek başlık, anahtar/ad uyumu, doğru ebeveyn ve standart gereksinim bölümü dışında kalan tür atanmış metinler kontrol edilir. Yapı engeli Word üretimini başlatmaz. Bu kontrol, bütün Control kurallarının publisher'da engelleyici biçimde yeniden çalıştırıldığı anlamına gelmez.

Eski unmanaged modüllerde önceki ardışık bölüm fallback'i korunur. Tam DOORS yolu biçiminde `GTD Trace Link Module` publisher için gerekir; setup sırasında henüz bilinmiyorsa boş kalabilir. Hiç Higher-Level gereksinimi bulunmayan modüllerde de bu genel kapının etkisi değerlendirilmelidir.

## Bakım

`PROJECT_FILES/GTD/BAKIM/build_package.py`, orijinal kaynaklar ve `setup_body.dxl` üzerinden güncel dosyaları üretir. `section_model.dxl` üç DXL'de aynı ortak modeli temsil eder. `verify_package.py` statik sözleşmeleri denetler.

Bir düzeltme önerisi, üretilmiş DXL'deki değişikliğin üretici kaynağına da nasıl taşınacağını belirtmelidir; aksi halde yeniden üretim düzeltmeyi kaybettirebilir. Bu devir sırasında yürütülebilir dosyalar değiştirilmemiştir.




---

# Included document: 03_REQUIREMENT_RULES.md

# Gereksinim ve kaynak kuralları

Bu kurallar projenin mevcut uygulamasını tarif eder. Standart zorunluluğu oldukları varsayılmamalı.

## Nesnelerin ele alınması

| Nesne | Control davranışı / beklenti |
|---|---|
| Başlık, native picture, native table/row/cell, silinmiş nesne | Gereksinim doğrulaması uygulanmaz. |
| Object Text boş metin nesnesi | Control boş sonuç üretir; boş gereksinimlerin ayrıca yakalanması mevcut kapsamda açık değerlendirme konusudur. |
| Standart gereksinim bölümü dışındaki türsüz narrative | Gereksinim olarak kontrol edilmez. |
| Standart gereksinim bölümü dışındaki tür atanmış metin | Yanlış yerleştirme hatası gösterilir; managed yayın yapı kapısı da bunu denetler. |
| Gereksinim bölümü altındaki dolu metin | Requirement Type ve Verification Method doluluğu, tür/bölüm uyumu, kaynak kuralları denetlenir. |

Bir metnin gereksinim bölümünde bulunması, type boş olsa bile Control kontrolüne girebilir. Türü boş metnin publisher'da narrative olarak aktarılması ile bu kontrolün ilişkisini Reviewer incelemelidir; yeni bir zorunlu Object Kind alanı kabul edilmiş karar değildir.

## Tür/bölüm eşlemesi

11 alan: İşlevsel; Performans; Fiziksel; Arayüz; Çevresel; Emniyet; Entegre Lojistik Destek; Güvenlik ve Gizlilik; Ergonomi; Markalama ve Etiketleme; Bilgisayar Kaynak. Eşleme kodda normalizasyonla kontrol edilir; tam bölüm başlıkları ve anahtarlar `EVIDENCE/SECTION_MAP.md` içindedir.

Yeni Verification Method alanının tek seçimli seçenekleri Analiz, Gösterim, Muayene, Test, Uygunluk Belgesi'dir. Mevcut enum/string/text tanımı ve mevcut çoklu seçim ayarı yeniden kurulmaz. Control mevcut yöntem metninin doluluğunu kontrol eder; yöntem sözlüğü doğruluğu, birden çok yöntem, Verification Reference zorunluluğu veya doğrulama kanıtının yeterliliği kapsamının daha geniş olduğu varsayılmamalı.

## Kaynak kuralları

| Requirement Source Type | Mevcut kural |
|---|---|
| Higher-Level Requirement | `GTD Trace Link Module` tanımlı olmalı ve o modülden en az bir outgoing kaynak linki bulunmalı. |
| Derived | Yapılandırılmış kaynak link modülünden üst seviye kaynak linki bulunmamalı. Bu, diğer tüm link türlerinin yasaklandığı anlamına gelmez. |
| Standard / Regulation | Requirement Source Reference boş olmamalı. |
| Interface | Requirement Source Reference boş olmamalı. |
| Safety Analysis | Requirement Source Reference boş olmamalı. |
| Other | Requirement Source Reference boş olmamalı. |

Boş veya bilinmeyen source type hata/uyarıdır. Link yönü **mevcut gereksinim → üst/kaynak gereksinim** olarak seçilmiştir. Eşleme tam link modülü yoluna göre yapılır.

Control'un link sayması, hedef gereksinimin açılabildiğini/geçerli olduğunu tek başına kanıtlamaz. Publisher link hedefini çözümlemeyi dener; eksik, silinmiş veya erişilemeyen hedefler için durumlar üretir. Raw link sayısı ile çözümlenmiş geçerli hedef sayısının anlamı Reviewer ve Researcher tarafından ayrıca değerlendirilmelidir.

Publisher kaynak sorunlarını `D|SOURCE_WARNING|...` kayıtlarıyla bildirir; mevcut uygulamada bu uyarılar tümüyle yayın engeline çevrilmemiştir. PLM'ye geçiş için kurumun kabul kapısı henüz kodla otomatikleştirilmiş kabul edilmez.

## Eski gereksinimlerin taşınması

Taşıma aynı modüldeki mevcut nesnelerle yapılır. Başlangıçtaki Absolute Number, görünür Identifier/Prefix, metin, attribute değerleri, link uçları ve geçmiş kaydı karşılaştırılabilir kanıt olarak alınmalıdır. Nesne tekrar yaratılmaması gereklidir; görünür başlık numarası ile nesne kimliği farklı kavramlardır. Formda Prefix'i kullanıcının değiştirebilmesi ayrıca değerlendirilmeli; setup kendisi Prefix atamaz.




---

# Included document: 04_RELEASE_BASELINE_CHANGE_WORKFLOW.md

# Release, baseline ve değişiklik kaydı

## Kabul edilmiş akış

Sistem mühendisi DOORS'taki çalışma modülünden Word çıktısı üretir. Doküman PLM'de görüş/onay sürecine girer. Görüşlerle içerik revize edilebilir ve yeni Word çıktısı alınabilir. Bu taslak/görüş aşamasında araç otomatik DOORS baseline oluşturmaz.

PLM'de doküman resmî olarak release olduğunda sistem mühendisi DOORS'a girip **manuel baseline** alır. Sonraki doküman revizyonu için tasarlanan değişiklik aracı, **son release baseline'ı ile güncel çalışma modülünü** karşılaştıracaktır.

Document Revision ve Document Date araç tarafından otomatik artırılmaz. Module Info formu boş tarih için bugünü kullanıcıya önerir; kaydetme kullanıcının Kaydet işlemiyle olur. Bu davranış otomatik release tarihi/sürüm tayini değildir.

## Mevcut kodun durumu

Setup/publisher'da otomatik baseline oluşturma işlevi yoktur. Bu pakette baseline karşılaştırması yapan veya Word Değişiklik Kaydı'nı otomatik dolduran ayrı revizyon aracı da yoktur. Sadece şablonda Değişiklik Kaydı bulunması bu özelliğin uygulanmış olduğunu kanıtlamaz.

## Araştırılması ve süreçte netleştirilmesi gereken nokta

**İncelenecek senaryo; gerçekleşmiş hata olarak raporlanmamalı:** PLM'ye gönderilen Word çıktıktan sonra çalışma modülü değişirse, release anında alınan baseline yayımlanmış Word ile aynı içerik kümesini temsil etmeyebilir. Bu olasılık, baseline'ı otomatik erkene çekme kararı değildir.

Researcher, mevcut manuel baseline zamanını koruyarak yayımlanan DOCX ile DOORS içeriğinin hangi kayıtlarla eşlenebileceğini araştırmalıdır. Öneriler; yayın anı modül/nesne kapsamı, doküman revizyonu, çıktı hash'i, review değişikliklerinin izlenmesi ve release-baseline eşleme kaydı gibi seçenekleri gerekçe ve operasyon yüküyle değerlendirebilir. Bu kayıtlar mevcut kodda uygulanmış değildir.

Gelecek diff aracı için olası kapsam soruları: eklenen/silinen gereksinimler, Object Text ve seçili attribute değişiklikleri, başlık/konum değişikliği, link değişikliği, görsel/tablolar, silinmiş nesnelerin takibi ve baseline dışındaki kaynak modüllerin sürümleri. Bunlar açık tasarım sorularıdır; tamamlanmış gereksinim veya onaylanmış standart kapsamı olarak yazılmamalı.




---

# Included document: 05_OPEN_ITEMS.md

# Açık işler ve inceleme soruları

Bu tablo bilinen sınırlarla araştırma sorularını ayırır. Şüphe tek başına hata kaydı değildir.

| ID | Durum | Konu | Beklenen sorumlu / çıktı |
|---|---|---|---|
| O01 | Çalıştırılmadı | DOORS 9.6.1.3 64-bit derleme ve API davranışı | Claude somut kod incelemesi; Gemini sürüm kaynakları; kullanıcı gerçek istemci test kanıtı |
| O02 | Çalıştırılmadı | Yeni/eski modülde tekrar setup, kısmi hata, view ve kimlik korunumu | Claude test edilebilir hata senaryoları; kullanıcı test modülü |
| O03 | Çalıştırılmadı | Windows DXL → PowerShell → Word uçtan uca yayın | Encoding, tablo/görsel/sıra, trace, özel karakter, uzun içerik ve hata geri bildirimi |
| O04 | Uygulanmadı | Son release baseline karşılaştırması ve otomatik Change Record | Gereksinim/kapsam önerisi; tamamlanmış özellik diye raporlanmamalı |
| O05 | Bilinen manuel adım | Word TOC/tablo/şekil/page alanları yeniden hesaplanmıyor | Kullanıcı Word'da günceller; otomasyon önerisi ayrı değişiklik olarak değerlendirilir |
| O06 | Karar netleştirme | Yeni Verification Method alanında tek/çoklu seçim | Mevcut I05 tercihini incele; kullanıcı kabulü/etkisi |
| O07 | Karar netleştirme | Control hata/uyarısının yayını veya PLM geçişini engellemesi | Mevcut yapı kapısı ile kaynak uyarıları ayrımı; önerilen minimum kontrol |
| O08 | Kaynaklı değerlendirme | PLM release içeriği ile sonradan alınan baseline'ın eşliği | Mevcut D09 zamanını koruyan uygulanabilir kayıt/iş akışı önerisi |
| O09 | Ortam bilgisi eksik | Windows/PowerShell/Word sürümü, locale, yetkiler, ağ yolu | Bilinmeyen ortam bilgileri varsayım olarak etiketlenir |
| O10 | Araştırma sorusu | Ham link sayısı, çözülmeyen/silinmiş hedefler ve kaynak modül sürümleri | DOORS davranışı, kod etkisi ve hedefli test |
| O11 | İnceleme sorusu | Görsel, native table ve rich text kayıpları/sınırları | Desteklenen ve desteklenmeyen içerik, gerçek çıktı delili |
| O12 | İnceleme sorusu | Gereksinim/narrative ayrımı, boş metin, multi-valued eski enum | Control/publisher tutarlılığı, sessiz atlanan içerik senaryoları |
| O13 | İnceleme sorusu | Trigger kurulum/yineleme/kaldırma kapsamı ve hata yönetimi | Doğru proje, baseline/read-only açma, eski trigger silme hatası ve eval_ davranışı |
| O14 | Kurumsal dayanak verilmedi | Uygulanacak sözleşme/standart ve zorunlu kontroller | Genel iyi uygulama ile bağlayıcı zorunluluk açıkça ayrılır |

İncelemenin temel önceliği O01–O03'tür. Diğer konuların önemi kanıtlanan etkiyle belirlenir. Tüm O-ID'leri otomatik olarak kritik kusur saymayın; yeni kapsamı mevcut kabul koşullarına gizlice eklemeyin.




---

# Included document: 06_FILE_INVENTORY.md

# Dosya envanteri ve değişiklik kapsamı

Devir kimliği: **GTD-HANDOFF-2026-09-13-a3cc85b1e006**

Güncel aday dosyaların yolu `PROJECT_FILES/GTD/GUNCEL/`; eski eşleri `PROJECT_FILES/GTD/ORIJINAL_DOSYALAR/` altındadır.

| Güncel dosya | Yüklenen eş | Durum | Kapsam |
|---|---|---|---|
| GTD_Setup_Module.dxl | Ana dosya yüklenmemişti | NEW | Yeni ana setup; kaynak helper görevi ana kurulumda birleşti. |
| GTD_Publish.dxl | GTD_Publish.dxl | MODIFIED | Ortak bölüm modeli, managed yapı kontrolü ve nesne türü filtreleri. |
| GTD_Requirement_Review_Control.dxl | GTD_Requirement_Review_Control.dxl | MODIFIED | Bölüm kimliği, owning module ve nesne kapsamı kontrolleri. |
| GTD_Module_Info.dxl | GTD_Module_Info(1).dxl | COMMENT_AND_NAME | Setup açıklaması ve dağıtım adı; temel form işlevi korundu. |
| GTD_Open_Check.dxl | GTD_Open_Check(1).dxl | COMMENT_AND_NAME | Setup açıklaması ve dağıtım adı; temel kontrol işlevi korundu. |
| GTD_Install_Open_Trigger.dxl | GTD_Install_Open_Trigger(1).dxl | EMBEDDED_BODY_AND_NAME | Gömülü gövde Open Check dosyası ile eşlendi; temel trigger işlevi korundu. |
| GTD_Remove_Open_Trigger.dxl | GTD_Remove_Open_Trigger(1).dxl | RENAME_ONLY | İçerik aynı; indirme eki dağıtım adından çıkarıldı. |
| GTD_Build_Document.ps1 | GTD_Build_Document.ps1 | UNCHANGED | Bayt düzeyinde aynı. |
| TPL_GTD_Publisher.docx | TPL_GTD_Publisher.docx | UNCHANGED | Bayt düzeyinde aynı. |

Yüklenen `GTD_Setup_Requirement_Source_Attributes.dxl` güncel bağımsız giriş noktası olarak dağıtılmıyor; orijinali saklı ve görevleri ana setup kapsamına alındı.

## Bayt kanıtı

| Güncel dosya | SHA256 |
|---|---|
| GTD_Build_Document.ps1 | `271ac27d3057aa00941496b14014204491b3cc0b67c26958ad682c7f8a613372` |
| GTD_Install_Open_Trigger.dxl | `bcd18eba4113efbfcc10f0af2366c6883b8c813b073141ca4e5724df1bc58f61` |
| GTD_Module_Info.dxl | `10437d6ec52bcb11e7d9ed5cd6f2929052e6d47037554f4fcf61bfe8febd8d1b` |
| GTD_Open_Check.dxl | `7e14ae469db219e069b4137457c9fe90937065226caf6f1db076d79f4d4d5cf4` |
| GTD_Publish.dxl | `ae9ede7a815a42475ae0856e4c4039d62e07ccf312d04ddbb2516c895f2e01c8` |
| GTD_Remove_Open_Trigger.dxl | `65bd19a1ee873ac50898515a1f1e75f88e3930fb4c5ad2a3d34d22aa2d0b4f26` |
| GTD_Requirement_Review_Control.dxl | `016bd67910b1398ecebe1b091f292e6c4325785c3441fbb060c7640642d44a11` |
| GTD_Setup_Module.dxl | `8db1c858798ccbd26f61f5937e41ef5ee5976eb8609a84bc1158b55ed927165d` |
| TPL_GTD_Publisher.docx | `1e2857f51b35ca0a84c4ccde6cfe2be3152cf0fae07638666b2506dfb7665d2c` |

Bakım araçları ve orijinal dosyaların ayrıntılı hash bilgisi `EVIDENCE/FILE_MANIFEST.json` içindedir. Salt içerik inceleme metinleri okunabilirlik için satır numarası ekler; bayt otoritesi arşivdeki gerçek dosyalardır.

## Önceki uygulama adayının korunması

Bu tur yalnız devir dokümanları ve okuma paketlerini oluşturur. `PROJECT_FILES/GTD` ağacı önceki GTD paketinden birebir kopyalanır; çalıştırılabilir dosyaların hiçbiri bu devir için yeniden üretilmemiş veya düzeltilmemiştir.




---

# Included document: 07_VALIDATION_AND_ACCEPTANCE.md

# Doğrulama kanıtı ve hedef ortam kabul planı

## Mevcut kanıt

| Kanıt | Sonuç | Sınır |
|---|---|---|
| `PROJECT_FILES/GTD/BAKIM/STATIK_KONTROL_SONUCU.txt` | 34 statik sözleşme kontrolü PASS | DXL parser/derleyici veya gerçek modül yürütmesi yok. Kontroller belirli örüntülere dayanır. |
| Orijinal/güncel SHA256 karşılaştırması | DOCX, PS1 ve Remove Trigger içeriği aynıdır; diğer değişiklikler fark dosyalarında | Önceki dosyaların doğru çalıştığı bu eşitlikten çıkmaz. |
| Word şablonunun önceki yerel render'ı | Önceki paket notunda 8 sayfa görsel inceleme; alan önbelleklerinde eski sayfa numaraları | DOORS'tan üretilmiş ve Word istemcisinde doğrulanmış çıktı değildir. Render PNG'leri bu devirde yeniden oluşturulmamıştır. |
| `EVIDENCE/HANDOFF_CHECKS.txt` | Devir kopyaları, kaynak metin kapsamı ve arşiv bütünlüğü | Ürün davranış testi değildir. |

DOORS/Windows test sonuçları mevcut değildir. Test matrisindeki bütün senaryoların ilk durumu `NOT_RUN`'dır. İlgili ortamda test edilmeden PASS olarak işaretlenmemelidir.

## Kabul planının kullanımı

`EVIDENCE/ACCEPTANCE_TEST_MATRIX.csv` her senaryo için başlangıç koşulu, işlem, beklenen sonuç ve toplanacak kanıtı içerir. Reviewer bu planın somut eksiklerini belirtebilir. İlk test modülü için ekrandaki nesne ID'leri, başlık anahtarları, parent ilişkileri ve kurulum log'u birlikte saklanmalıdır.

Eski gereksinimlerin taşınmasında önce/sonra Absolute Number, görünür Identifier/Prefix, içerik, attribute değerleri, link uçları ve geçmiş kayıtları karşılaştırılır. Yeni hareket kayıtları oluşması ile eski geçmişin kaybolması ayrı değerlendirilir.

Bir hata kısmi değişiklikten sonra oluşursa otomatik rollback varsayılmamalı. Log, modülün kayıt durumu ve yeniden açıldığındaki gerçek içerik test kanıtına yazılır. Düzeltmeden sonra yeniden çalıştırmanın eksikleri tamamlayıp tamamlamadığı ayrıca gözlenir.

## İnceleme sonucu için karar sınırı

Reviewer 'inceleme kapsamı içinde engelleyici bulgu yok' diyebilir; hedef ortam kanıtı yokken bu sonuç üretim kabulü anlamına gelmez. Researcher bir API'nin belgede bulunmasını, kodun derlendiği/çalıştığı şeklinde raporlamamalı. Kaynak araştırmasıyla kapatılamayan O-ID'ler açık bırakılır.




---

# Included document: EVIDENCE/SECTION_MAP.md

# Bölüm eşlemesi

Başlık ve parent verisi mevcut üretim manifestinden aynen alınmıştır. Parent anahtarı `MODULE_ROOT` ise üst nesne yoktur.

| Sıra | Key | Object Heading | Parent key | Word içerik marker |
|---|---|---|---|---|
| 1 | ROOT_GENEL | GENEL | MODULE_ROOT | — (kapsayıcı) |
| 2 | AMAC | Amaç | ROOT_GENEL | {{SEC_AMAC}} |
| 3 | KAPSAM | Kapsam | ROOT_GENEL | {{SEC_KAPSAM}} |
| 4 | PROJE_TANITIMI | Proje Tanıtımı | ROOT_GENEL | {{SEC_PROJE_TANITIMI}} |
| 5 | SISTEM_GENEL | Sisteme Genel Bakış | PROJE_TANITIMI | {{SEC_SISTEM_GENEL}} |
| 6 | URUN_GENEL | Ürüne Genel Bakış | PROJE_TANITIMI | {{SEC_URUN_GENEL}} |
| 7 | GROUP_KISALTMALAR_TANIMLAR | Kısaltmalar/Tanımlar | ROOT_GENEL | — (kapsayıcı) |
| 8 | KISALTMALAR | Kısaltmalar | GROUP_KISALTMALAR_TANIMLAR | {{SEC_KISALTMALAR}} |
| 9 | TANIMLAR | Tanımlar | GROUP_KISALTMALAR_TANIMLAR | {{SEC_TANIMLAR}} |
| 10 | UYGULANABILIR_DOKUMANLAR | Uygulanabilir Dokümanlar | ROOT_GENEL | {{SEC_UYGULANABILIR_DOKUMANLAR}} |
| 11 | STANDARTLAR | Standartlar | UYGULANABILIR_DOKUMANLAR | {{SEC_STANDARTLAR}} |
| 12 | DIGER_DOKUMANLAR | Diğer Dokümanlar | UYGULANABILIR_DOKUMANLAR | {{SEC_DIGER_DOKUMANLAR}} |
| 13 | ROOT_SISTEM_TANIMLAMASI | SİSTEMİN TANIMLAMASI | MODULE_ROOT | — (kapsayıcı) |
| 14 | DURUM_MODLAR | Durum ve Modlar | ROOT_SISTEM_TANIMLAMASI | {{SEC_DURUM_MODLAR}} |
| 15 | OMUR_DONGUSU | Ömür Döngüsü | ROOT_SISTEM_TANIMLAMASI | {{SEC_OMUR_DONGUSU}} |
| 16 | SINIRLAMALAR | Sınırlamalar | ROOT_SISTEM_TANIMLAMASI | {{SEC_SINIRLAMALAR}} |
| 17 | ROOT_GEREKSINIMLER | GEREKSİNİMLER | MODULE_ROOT | — (kapsayıcı) |
| 18 | REQ_ISLEVSEL | İşlevsel Gereksinimler | ROOT_GEREKSINIMLER | {{REQ_ISLEVSEL}} |
| 19 | REQ_PERFORMANS | Performans Gereksinimleri | ROOT_GEREKSINIMLER | {{REQ_PERFORMANS}} |
| 20 | REQ_FIZIKSEL | Fiziksel Gereksinimler | ROOT_GEREKSINIMLER | {{REQ_FIZIKSEL}} |
| 21 | REQ_ARAYUZ | Arayüz Gereksinimleri | ROOT_GEREKSINIMLER | {{REQ_ARAYUZ}} |
| 22 | REQ_CEVRESEL | Çevresel Gereksinimler | ROOT_GEREKSINIMLER | {{REQ_CEVRESEL}} |
| 23 | REQ_EMNIYET | Emniyet Gereksinimleri | ROOT_GEREKSINIMLER | {{REQ_EMNIYET}} |
| 24 | REQ_ELD | Entegre Lojistik Destek Gereksinimleri | ROOT_GEREKSINIMLER | {{REQ_ELD}} |
| 25 | REQ_GUV_GIZ | Güvenlik ve Gizlilik Gereksinimleri | ROOT_GEREKSINIMLER | {{REQ_GUV_GIZ}} |
| 26 | REQ_ERGONOMI | Ergonomi Gereksinimleri | ROOT_GEREKSINIMLER | {{REQ_ERGONOMI}} |
| 27 | REQ_MARKALAMA | Markalama ve Etiketleme Gereksinimleri | ROOT_GEREKSINIMLER | {{REQ_MARKALAMA}} |
| 28 | REQ_BILGISAYAR | Bilgisayar Kaynak Gereksinimleri | ROOT_GEREKSINIMLER | {{REQ_BILGISAYAR}} |




---

# Included document: EVIDENCE/SOURCE_LEADS.md

# Researcher için kaynak başlangıcı

Bu devir turunda yeni bir web araştırması yürütülmedi. Aşağıdaki bilgi önceki paket notundan aktarılan başlangıç kaydıdır; Gemini'nin açıp sürüm ve ilgili sayfaları yeniden değerlendirmesi gerekir.

| Alan | Kayıt |
|---|---|
| Önceki çalışmada başvurulan belge | Telelogic DOORS DXL Reference Manual, Release 9.1 |
| Özgün yayımlayıcı | Önceki paket notuna göre IBM; barındıran site aşağıda görüldüğü gibi üçüncü taraftır |
| Başlangıç adresi | https://manuals.plus/m/a29c37c1bb2c5611140c6daddb57693d46e762afed91e38d52bbeb0efb7862a6 |
| Önceki kullanım | Nesne create konumu, attribute tanımları, view/column işlevleri |
| Hedefe uygulanabilirlik | 9.6.1.3 derleme/çalıştırma kanıtı değildir. Bu sürüme uygun IBM kaynakları ayrıca bulunmalı. |

RQ01–RQ07 için IBM DOORS Classic DXL Reference Manual 9.6, IBM Docs 9.6, ilgili release note/support/APAR kayıtları araştırılmalı. RQ08 için Microsoft'un Windows PowerShell dosya encoding belgeleri; RQ09 için ECMA Open XML ve Microsoft Open XML belgeleri araştırılmalı. RQ10–RQ13 için ilgili resmî standart/kurumsal gereksinim ve configuration management kaynakları kullanılmalı.

Bu başlıklar kaynak arama yönüdür; okunmuş veya doğrulanmış yayın listesi değildir. Resmî sayfaya erişilemiyorsa benzer sürüm bilgisini tam hedef sürüm doğrulaması olarak sunmayın. Bir belgeye veya standardın tam metnine erişim yoksa ilgili maddeyi uydurmayın.




---

# Included document: EVIDENCE/RESEARCH_CODE_EXCERPTS.md

# Researcher için gerçek kod kesitleri

Bunlar güncel adaydan mekanik alınmış satır numaralı kesitlerdir. Tam işlev gövdesi her kesitte yer almayabilir. Kod değişmedi; arşivdeki gerçek dosyalar tamdır. `0001 |` önekleri kaynak dosyanın parçası değildir.

## GTD_Setup_Module.dxl — Module gtdSetupModule = current

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Setup_Module.dxl`; ilk satır 9; SHA256 `8db1c858798ccbd26f61f5937e41ef5ee5976eb8609a84bc1158b55ed927165d`.

````text
0009 | Module gtdSetupModule = current
0010 | if (null gtdSetupModule) {
0011 |     ack "Acik bir formal module bulunamadi."
0012 |     halt
0013 | }
0014 | if (baseline(gtdSetupModule) || !isEdit(gtdSetupModule)) {
0015 |     ack "Setup icin guncel modulu Exclusive Edit modunda acin."
0016 |     halt
0017 | }
0018 | 
0019 | // BEGIN GTD SECTION MODEL - keep identical in setup, publisher and Control.
0020 | string headingBytes(int first, int second, int third)
0021 | {
0022 |     Buffer b = create
0023 |     char c1 = charOf(first)
0024 |     b += c1
0025 |     if (second >= 0) {
0026 |         char c2 = charOf(second)
0027 |         b += c2
0028 |     }
0029 |     if (third >= 0) {
0030 |         char c3 = charOf(third)
````


## GTD_Setup_Module.dxl — string gtdStoredSectionKey(Object o)

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Setup_Module.dxl`; ilk satır 335; SHA256 `8db1c858798ccbd26f61f5937e41ef5ee5976eb8609a84bc1158b55ed927165d`.

````text
0335 | string gtdStoredSectionKey(Object o)
0336 | {
0337 |     if (null o) return ""
0338 |     Module om = module(o)
0339 |     AttrDef ad = find(om, "GTD Section Key")
0340 |     if (null ad || !ad.object) return ""
0341 |     return o."GTD Section Key" ""
0342 | }
0343 | 
0344 | string sectionKeyForObject(Object o)
0345 | {
0346 |     if (null o || isDeleted(o)) return ""
0347 |     if (table(o) || row(o) || cell(o)) return ""
0348 |     if (!gtdBlank(getPictName(o))) return ""
0349 |     string h = o."Object Heading" ""
0350 |     if (gtdBlank(h)) return ""
0351 |     string key = gtdStoredSectionKey(o)
0352 |     // A nonempty unknown key must not fall back to the visible title.
0353 |     if (!gtdBlank(key)) {
0354 |         if (gtdSectionIndex(key) >= 0) return key
0355 |         return ""
0356 |     }
0357 |     return sectionKeyForHeading(h)
0358 | }
0359 | 
0360 | string gtdSectionIdentityIssue(Object o)
0361 | {
0362 |     string stored = gtdStoredSectionKey(o)
0363 |     if (gtdBlank(stored)) return ""
0364 |     if (table(o) || row(o) || cell(o)) return "SECTION_KEY_ON_TABLE"
0365 |     if (gtdSectionIndex(stored) < 0) return "UNKNOWN_SECTION_KEY"
0366 |     string h = o."Object Heading" ""
0367 |     if (gtdBlank(h)) return "SECTION_KEY_WITHOUT_HEADING"
0368 |     string pict = getPictName(o)
0369 |     if (!gtdBlank(pict)) return "SECTION_KEY_ON_PICTURE"
0370 |     string titleKey = sectionKeyForHeading(h)
0371 |     if (titleKey != "" && titleKey != stored) return "SECTION_KEY_TITLE_CONFLICT"
0372 |     return ""
0373 | }
0374 | 
0375 | // Start at the parent: a section heading is not its own requirement.
0376 | // A recognized container closes the search; do not inherit a stale section.
0377 | string sectionKeyFromParents(Object x)
0378 | {
0379 |     Object p = parent(x)
0380 |     while (!null p) {
0381 |         string key = sectionKeyForObject(p)
0382 |         if (key != "") {
0383 |             if (isContentSection(key)) return key
0384 |             return ""
0385 |         }
0386 |         p = parent(p)
0387 |     }
0388 |     return ""
0389 | }
0390 | // END GTD SECTION MODEL
0391 | 
0392 | 
````


## GTD_Setup_Module.dxl — void gtdCheckAttribute(

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Setup_Module.dxl`; ilk satır 503; SHA256 `8db1c858798ccbd26f61f5937e41ef5ee5976eb8609a84bc1158b55ed927165d`.

````text
0503 | void gtdCheckAttribute(string name, bool moduleScope, string kind)
0504 | {
0505 |     AttrDef ad = find(gtdSetupModule, name)
0506 |     if (null ad) return
0507 |     bool valid = true
0508 |     if (moduleScope && !ad.module) valid = false
0509 |     if (!moduleScope && !ad.object) valid = false
0510 |     AttrType at = ad.type
0511 |     if (null at) valid = false
0512 |     else {
0513 |         if (kind == "Date" && at.type != attrDate) valid = false
0514 |         if (kind == "Text" && !gtdTextType(at)) valid = false
0515 |         if (kind == "Choice" && !gtdTextType(at) && at.type != attrEnumeration) valid = false
0516 |         if (kind == "Key") {
0517 |             if (at.type != attrString || ad.inherit || ad.dxl || ad.multi) valid = false
0518 |         }
0519 |     }
0520 |     if (!valid) {
0521 |         gtdSchemaErrors++
0522 |         gtdLog("SCHEMA_CONFLICT | " name " | existing definition preserved")
0523 |     }
0524 | }
0525 | 
0526 | bool gtdHasEnumLabel(AttrType at, string label, bool normalize)
0527 | {
0528 |     int i
0529 |     for (i = 0; i < at.size; i++) {
0530 |         string value = at.strings[i]
0531 |         if (normalize) {
0532 |             if (compactHeading(value) == compactHeading(label)) return true
0533 |         }
0534 |         else if (value == label) return true
0535 |     }
0536 |     return false
0537 | }
0538 | 
0539 | void gtdCheckEnumeration(string attrName, string typeName, string labels[], int count, bool normalize)
0540 | {
0541 |     AttrDef ad = find(gtdSetupModule, attrName)
0542 |     AttrType at = null
0543 |     if (!null ad) at = ad.type
0544 |     else at = find(gtdSetupModule, typeName)
0545 |     if (null at) return
0546 |     // Existing String/Text definitions remain editable and retain their values.
0547 |     if (!null ad && gtdTextType(at)) return
0548 |     if (at.type != attrEnumeration) {
0549 |         gtdSchemaErrors++
0550 |         gtdLog("TYPE_CONFLICT | " typeName)
0551 |         return
0552 |     }
0553 |     int i
0554 |     for (i = 0; i < count; i++) {
0555 |         if (!gtdHasEnumLabel(at, labels[i], normalize)) {
0556 |             gtdSchemaErrors++
0557 |             gtdLog("ENUM_VALUE_MISSING | " attrName " | " labels[i] " | enum preserved; extend/map explicitly")
0558 |         }
0559 |     }
0560 | }
0561 | 
0562 | void gtdEnsureAttribute(string name, bool moduleScope, string typeName)
0563 | {
0564 |     AttrDef ad = find(gtdSetupModule, name)
0565 |     if (!null ad) {
0566 |         gtdLog("KEEP_ATTRIBUTE | " name)
0567 |         return
0568 |     }
0569 |     noError()
0570 |     if (moduleScope) ad = create module type typeName attribute name
0571 |     else ad = create object type typeName (inherit false) attribute name
0572 |     string err = lastError()
0573 |     if (null ad || !gtdBlank(err)) gtdFail("ATTRIBUTE_CREATE_FAILED | " name " | " err)
0574 |     gtdCreatedAttrs++
0575 |     gtdLog("CREATE_ATTRIBUTE | " name)
0576 | }
0577 | 
0578 | void gtdEnsureEnumeration(string attrName, string typeName, string labels[], int count)
0579 | {
0580 |     AttrDef ad = find(gtdSetupModule, attrName)
0581 |     if (!null ad) {
0582 |         gtdLog("KEEP_ATTRIBUTE | " attrName)
0583 |         return
0584 |     }
0585 |     AttrType at = find(gtdSetupModule, typeName)
0586 |     if (null at) {
0587 |         int values[count]
0588 |         int i
0589 |         for (i = 0; i < count; i++) values[i] = i+1
0590 |         string err = ""
0591 |         noError()
0592 |         at = create(typeName, labels, values, err)
0593 |         string runtimeErr = lastError()
0594 |         if (null at || !gtdBlank(err) || !gtdBlank(runtimeErr))
0595 |             gtdFail("ENUM_CREATE_FAILED | " typeName " | " err " " runtimeErr)
0596 |         gtdLog("CREATE_TYPE | " typeName)
0597 |     }
0598 |     gtdEnsureAttribute(attrName, false, typeName)
0599 | }
0600 | 
0601 | void gtdSetModuleString(string name, string value, bool onlyIfBlank)
0602 | {
0603 |     string old = gtdReadModuleString(name)
0604 |     if (old == value || (onlyIfBlank && !gtdBlank(old))) return
0605 |     noError()
0606 |     gtdSetupModule.(name) = value
0607 |     string err = lastError()
0608 |     if (!gtdBlank(err)) gtdFail("MODULE_VALUE_FAILED | " name " | " err)
0609 |     gtdLog("SET_MODULE_ATTRIBUTE | " name)
0610 | }
0611 | 
0612 | gtdLog("GTD SETUP | " fullName(gtdSetupModule))
0613 | gtdLog("Existing object identities, links, enum definitions and requirement values are preserved.")
0614 | int gtdI
0615 | for (gtdI = 0; gtdI < 16; gtdI++) {
0616 |     string kind = "Text"
0617 |     if (gtdModuleStrings[gtdI] == "Classification") kind = "Choice"
0618 |     gtdCheckAttribute(gtdModuleStrings[gtdI], true, kind)
0619 | }
0620 | gtdCheckAttribute("Document Date", true, "Date")
0621 | for (gtdI = 0; gtdI < 4; gtdI++) gtdCheckAttribute(gtdObjectTexts[gtdI], false, "Text")
0622 | gtdCheckAttribute("Requirement Source Reference", false, "Text")
0623 | gtdCheckAttribute("Requirement Type", false, "Choice")
0624 | gtdCheckAttribute("Verification Method", false, "Choice")
0625 | gtdCheckAttribute("Requirement Source Type", false, "Choice")
0626 | gtdCheckAttribute("GTD Section Key", false, "Key")
0627 | gtdCheckEnumeration("Requirement Type", "GTD Requirement Type", gtdRequirementTypes, 11, true)
0628 | gtdCheckEnumeration("Requirement Source Type", "GTD Requirement Source Type", gtdSourceTypes, 6, false)
0629 | // Existing verification vocabularies are retained; only a missing attribute/type is initialized.
0630 | AttrDef gtdExistingMethod = find(gtdSetupModule, "Verification Method")
0631 | if (null gtdExistingMethod)
0632 |     gtdCheckEnumeration("Verification Method", "GTD Verification Method", gtdVerificationMethods, 5, true)
0633 | if (gtdSchemaErrors > 0) gtdFail("Schema conflicts found. No module changes were made.")
0634 | 
````


## GTD_Setup_Module.dxl — Object gtdCreateHeading(

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Setup_Module.dxl`; ilk satır 756; SHA256 `8db1c858798ccbd26f61f5937e41ef5ee5976eb8609a84bc1158b55ed927165d`.

````text
0756 | Object gtdCreateHeading(int idx, Object requiredParent)
0757 | {
0758 |     Object nextKnown = null
0759 |     int j
0760 |     for (j = idx+1; j < GTD_SECTION_COUNT; j++) {
0761 |         if (gtdSectionParents[j] != gtdSectionParents[idx]) continue
0762 |         if (gtdCandidateCount[j] != 1 || gtdIdentityConflict[j]) continue
0763 |         Object candidate = gtdCandidates[j]
0764 |         if (parent(candidate) == requiredParent) {
0765 |             nextKnown = candidate
0766 |             break
0767 |         }
0768 |     }
0769 |     Object created = null
0770 |     noError()
0771 |     if (!null nextKnown) created = create before nextKnown
0772 |     else if (!null requiredParent) created = create last below requiredParent
0773 |     else {
0774 |         // create(Module) PREPENDS, so use it only when there is no live root.
0775 |         Object lastRoot = null
0776 |         Object rootObject
0777 |         for rootObject in entire gtdSetupModule do {
0778 |             if (isDeleted(rootObject)) continue
0779 |             if (null parent(rootObject)) lastRoot = rootObject
0780 |         }
0781 |         if (null lastRoot) created = create(gtdSetupModule)
0782 |         else created = create after lastRoot
0783 |     }
0784 |     string err = lastError()
0785 |     if (null created || !gtdBlank(err)) gtdFail("HEADING_CREATE_FAILED | " gtdSectionKeys[idx] " | " err)
0786 |     noError()
0787 |     created."Object Heading" = gtdSectionHeadings[idx]
0788 |     created."GTD Section Key" = gtdSectionKeys[idx]
0789 |     err = lastError()
0790 |     if (!gtdBlank(err)) gtdFail("HEADING_VALUE_FAILED | " gtdSectionKeys[idx] " | " err)
0791 |     gtdCreatedHeadings++
0792 |     gtdLog("CREATE_HEADING | " gtdSectionKeys[idx] " | " identifier(created))
0793 |     return created
0794 | }
0795 | 
0796 | for (gtdI = 0; gtdI < GTD_SECTION_COUNT; gtdI++) {
0797 |     string sectionKey = gtdSectionKeys[gtdI]
0798 |     int parentIdx = gtdSectionParents[gtdI]
0799 |     Object expectedParent = null
0800 |     if (parentIdx >= 0) expectedParent = gtdResolved[parentIdx]
0801 |     if (gtdIdentityConflict[gtdI] || gtdCandidateCount[gtdI] > 1) {
0802 |         gtdBlockedHeadings++
0803 |         gtdLog("BLOCK_HEADING | " sectionKey " | duplicate or conflicting identity; no new heading")
0804 |         continue
0805 |     }
0806 |     if (parentIdx >= 0 && null expectedParent) {
0807 |         gtdBlockedHeadings++
0808 |         gtdLog("BLOCK_HEADING | " sectionKey " | parent unresolved; no new heading")
0809 |         continue
0810 |     }
0811 |     if (gtdCandidateCount[gtdI] == 1) {
0812 |         Object existing = gtdCandidates[gtdI]
0813 |         if (parent(existing) != expectedParent) {
0814 |             gtdBlockedHeadings++
0815 |             string parentLabel = "MODULE_ROOT"
0816 |             if (!null expectedParent) parentLabel = identifier(expectedParent)
0817 |             gtdLog("WRONG_PARENT | " sectionKey " | " identifier(existing) " | expected parent " parentLabel " | move manually, then rerun")
0818 |             continue
0819 |         }
0820 |         if (gtdBlank(gtdStoredSectionKey(existing))) {
0821 |             noError()
0822 |             existing."GTD Section Key" = sectionKey
0823 |             string err = lastError()
0824 |             if (!gtdBlank(err)) gtdFail("HEADING_TAG_FAILED | " identifier(existing) " | " err)
0825 |         }
0826 |         gtdResolved[gtdI] = existing
0827 |         gtdReusedHeadings++
0828 |         gtdLog("REUSE_HEADING | " sectionKey " | " identifier(existing))
0829 |     }
0830 |     else gtdResolved[gtdI] = gtdCreateHeading(gtdI, expectedParent)
0831 | }
````


## GTD_Setup_Module.dxl — bool gtdViewExists(

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Setup_Module.dxl`; ilk satır 833; SHA256 `8db1c858798ccbd26f61f5937e41ef5ee5976eb8609a84bc1158b55ed927165d`.

````text
0833 | bool gtdViewExists(string viewName)
0834 | {
0835 |     string candidate
0836 |     for candidate in views(gtdSetupModule) do
0837 |         if (candidate == viewName) return true
0838 |     return false
0839 | }
0840 | 
0841 | void gtdAppendColumn(string attrName, int colWidth)
0842 | {
0843 |     int n = 0
0844 |     Column c
0845 |     for c in gtdSetupModule do n++
0846 |     c = insert column n
0847 |     attribute(c, attrName)
0848 |     title(c, attrName)
0849 |     width(c, colWidth)
0850 | }
0851 | 
0852 | void gtdEnsureView(string viewName, bool review)
0853 | {
0854 |     bool viewAlreadyExists = gtdViewExists(viewName)
0855 |     View v = view(viewName)
0856 |     noError()
0857 |     if (viewAlreadyExists) {
0858 |         bool loaded = load(v)
0859 |         string loadErr = lastError()
0860 |         if (!loaded || !gtdBlank(loadErr)) gtdFail("VIEW_LOAD_FAILED | " viewName " | " loadErr)
0861 |         if (!review) {
0862 |             gtdLog("KEEP_VIEW | " viewName)
0863 |             return
0864 |         }
0865 |     }
0866 |     else {
0867 |         bool standardLoaded = load(view("Standard view"))
0868 |         string loadErr = lastError()
0869 |         if (!standardLoaded || !gtdBlank(loadErr)) gtdFail("Standard view could not be loaded.")
0870 |         // Only the unsaved display is rebuilt; no existing saved view is replaced.
0871 |         Column c
0872 |         int oldColumnCount = 0
0873 |         for c in gtdSetupModule do oldColumnCount++
0874 |         int ci
0875 |         for (ci = 0; ci < oldColumnCount; ci++) delete(column 0)
0876 |         c = insert column 0
0877 |         attribute(c, "Object Identifier")
0878 |         title(c, "ID")
0879 |         width(c, 100)
0880 |         c = insert column 1
0881 |         main(c)
0882 |         title(c, "Baslik / Metin")
0883 |         width(c, 450)
0884 |         gtdAppendColumn("Requirement Type", 140)
0885 |         gtdAppendColumn("Verification Method", 130)
0886 |         gtdAppendColumn("Verification Reference", 160)
0887 |         gtdAppendColumn("Requirement Source Type", 175)
0888 |         gtdAppendColumn("Requirement Source Reference", 210)
0889 |         if (!review) {
0890 |             gtdAppendColumn("Rationale", 200)
0891 |             gtdAppendColumn("Remarks", 180)
0892 |             gtdAppendColumn("Traceability Note", 200)
0893 |         }
0894 |     }
0895 |     bool changed = !viewAlreadyExists
0896 |     if (review) {
0897 |         Column controlColumn = null
0898 |         Column col
0899 |         int n = 0
0900 |         int controlCount = 0
0901 |         for col in gtdSetupModule do {
0902 |             if (title(col) == "Control") {
0903 |                 controlColumn = col
0904 |                 controlCount++
0905 |             }
0906 |             n++
0907 |         }
0908 |         if (controlCount > 1) {
0909 |             gtdReviewNeeded++
0910 |             gtdLog("VIEW_CONFLICT | Requirement Review has multiple Control columns; kept unchanged")
0911 |             return
0912 |         }
0913 |         bool controlWasMissing = null controlColumn
0914 |         if (controlWasMissing) {
0915 |             controlColumn = insert column n
0916 |             title(controlColumn, "Control")
0917 |             width(controlColumn, 300)
0918 |             changed = true
0919 |         }
0920 |         string oldCode = ""
0921 |         if (!controlWasMissing && gtdBlank(attrName(controlColumn)) && !main(controlColumn)) oldCode = dxl(controlColumn)
0922 |         else if (!controlWasMissing && viewAlreadyExists) {
0923 |             gtdReviewNeeded++
0924 |             gtdLog("VIEW_CONFLICT | Control title belongs to a non-DXL column; kept unchanged")
0925 |             return
0926 |         }
0927 |         if (oldCode != gtdControlCode) {
0928 |             dxl(controlColumn, gtdControlCode)
0929 |             changed = true
0930 |         }
0931 |     }
0932 |     if (changed) {
0933 |         noError()
0934 |         refresh(gtdSetupModule)
0935 |         string refreshErr = lastError()
0936 |         if (!gtdBlank(refreshErr)) gtdFail("VIEW_REFRESH_FAILED | " viewName " | " refreshErr)
0937 |         noError()
0938 |         if (viewAlreadyExists) save(v)
0939 |         else {
0940 |             // Default view access inheritance is retained; no module ACL is changed.
0941 |             ViewDef def = create(gtdSetupModule, true)
0942 |             useWindows(def, false)
0943 |             save(gtdSetupModule, v, def)
0944 |         }
0945 |         string err = lastError()
0946 |         if (!gtdBlank(err)) gtdFail("VIEW_SAVE_FAILED | " viewName " | " err)
0947 |         if (viewAlreadyExists) {
0948 |             gtdUpdatedViews++
0949 |             gtdLog("UPDATE_CONTROL_ONLY | " viewName)
0950 |         }
0951 |         else {
0952 |             gtdCreatedViews++
0953 |             gtdLog("CREATE_VIEW | " viewName)
0954 |         }
0955 |     }
0956 |     else gtdLog("KEEP_VIEW | " viewName)
0957 | }
0958 | 
0959 | gtdEnsureView("Requirement Entry", false)
0960 | gtdEnsureView("Requirement Review", true)
````


## GTD_Requirement_Review_Control.dxl — int sourceLinkCount(

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Requirement_Review_Control.dxl`; ilk satır 441; SHA256 `016bd67910b1398ecebe1b091f292e6c4325785c3441fbb060c7640642d44a11`.

````text
0441 | int sourceLinkCount(Object o, string traceLinkModulePath)
0442 | {
0443 |     if (traceLinkModulePath == "") return 0
0444 | 
0445 |     int count = 0
0446 |     Link traceLink
0447 | 
0448 |     for traceLink in all(o->"*") do {
0449 |         Module traceLinkModule = module(traceLink)
0450 |         if (!null traceLinkModule) {
0451 |             string actualLinkPath = fullName(traceLinkModule)
0452 |             if (actualLinkPath == traceLinkModulePath)
0453 |                 count++
0454 |         }
0455 |     }
0456 | 
0457 |     return count
0458 | }
0459 | 
0460 | // ------------------------------------------------------------
0461 | // Layout DXL execution for the current row/object.
````


## GTD_Requirement_Review_Control.dxl — // ---------------- Source validation

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Requirement_Review_Control.dxl`; ilk satır 526; SHA256 `016bd67910b1398ecebe1b091f292e6c4325785c3441fbb060c7640642d44a11`.

````text
0526 |             // ---------------- Source validation ----------------
0527 |             Module m = module(o)
0528 | 
0529 |             if (null m) {
0530 |                 addIssue(issues, "HATA: Module bulunamadi")
0531 |             }
0532 |             else {
0533 |                 AttrDef adSourceType = find(m, "Requirement Source Type")
0534 |                 AttrDef adSourceReference = find(m, "Requirement Source Reference")
0535 |                 AttrDef adTraceLinkModule = find(m, "GTD Trace Link Module")
0536 | 
0537 |                 if (null adSourceType || null adSourceReference) {
0538 |                     addIssue(issues, "HATA: Kaynak attribute tanimsiz")
0539 |                 }
0540 |                 else {
0541 |                     string sourceType = o."Requirement Source Type" ""
0542 |                     string sourceReference = o."Requirement Source Reference" ""
0543 |                     string traceLinkModulePath = ""
0544 | 
0545 |                     if (!null adTraceLinkModule)
0546 |                         traceLinkModulePath = m."GTD Trace Link Module" ""
0547 | 
0548 |                     int matchedSourceLinks = sourceLinkCount(o, traceLinkModulePath)
0549 | 
0550 |                     if (isBlank(sourceType)) {
0551 |                         addIssue(issues, "EKSIK: Requirement Source Type")
0552 |                     }
0553 |                     else if (sourceType == "Higher-Level Requirement") {
0554 |                         if (isBlank(traceLinkModulePath))
0555 |                             addIssue(issues, "HATA: GTD Trace Link Module tanimsiz")
0556 |                         else if (matchedSourceLinks == 0)
0557 |                             addIssue(issues, "HATA: Ust seviye kaynak linki yok")
0558 |                     }
0559 |                     else if (sourceType == "Derived") {
0560 |                         if (!isBlank(traceLinkModulePath) && matchedSourceLinks > 0)
0561 |                             addIssue(issues, "HATA: Derived ama kaynak linki var")
0562 |                     }
0563 |                     else if (sourceType == "Standard / Regulation" ||
0564 |                              sourceType == "Interface" ||
0565 |                              sourceType == "Safety Analysis" ||
0566 |                              sourceType == "Other") {
0567 |                         if (isBlank(sourceReference))
0568 |                             addIssue(issues, "EKSIK: Requirement Source Reference")
0569 |                     }
0570 |                     else {
0571 |                         addIssue(issues, "HATA: Bilinmeyen Requirement Source Type")
0572 |                     }
0573 |                 }
0574 |             }
0575 | 
0576 |             string result = stringOf(issues)
0577 |             if (result == "")
0578 |                 display "OK"
0579 |             else
0580 |                 display result
0581 | 
0582 |             delete(issues)
0583 |         }
0584 |     }
0585 | }
````


## GTD_Publish.dxl — string safeField(

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Publish.dxl`; ilk satır 50; SHA256 `ae9ede7a815a42475ae0856e4c4039d62e07ccf312d04ddbb2516c895f2e01c8`.

````text
0050 | string safeField(string s)
0051 | {
0052 |     Buffer b = create
0053 |     int i
0054 |     int n = length(s)
0055 | 
0056 |     for (i = 0; i < n; i++) {
0057 |         string ch = s[i:i]
0058 | 
0059 |         if (ch == "|" || ch == "\n" || ch == "\r" || ch == "\t")
0060 |             b += " "
0061 |         else
0062 |             b += ch
0063 |     }
0064 | 
0065 |     string r = stringOf(b)
0066 |     delete(b)
0067 |     return r
0068 | }
0069 | 
0070 | // Required: full path of the link module used for derived-from traceability.
0071 | // Link direction is current requirement -> upper/source requirement.
0072 | AttrDef adTraceLinkModule = find(m, "GTD Trace Link Module")
0073 | string traceLinkModulePath = ""
0074 | if (!null adTraceLinkModule) traceLinkModulePath = m."GTD Trace Link Module" ""
0075 | if (traceLinkModulePath == "" || traceLinkModulePath == "*") {
0076 |     ack "GTD Trace Link Module: set this module String attribute to the full path of your upper-requirement link module."
0077 |     halt
0078 | }
0079 | if (traceLinkModulePath[0:0] != "/") {
0080 |     ack "GTD Trace Link Module must be a full DOORS path beginning with /."
0081 |     halt
0082 | }
0083 | AttrDef adTraceNote = find(m, "Traceability Note")
````


## GTD_Publish.dxl — AttrDef gtdKeyAttr = find(

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Publish.dxl`; ilk satır 554; SHA256 `ae9ede7a815a42475ae0856e4c4039d62e07ccf312d04ddbb2516c895f2e01c8`.

````text
0554 | AttrDef gtdKeyAttr = find(m, "GTD Section Key")
0555 | bool gtdManagedStructure = !null gtdKeyAttr
0556 | if (gtdManagedStructure) {
0557 |     Buffer structureIssues = create
0558 |     if (gtdBlank(systemName) || gtdBlank(documentNumber) || gtdBlank(documentRevision) ||
0559 |         gtdBlank(documentDate) || gtdBlank(projectName) || gtdBlank(projectNumber) ||
0560 |         gtdBlank(department) || gtdBlank(classification) || gtdBlank(m."Prefix" ""))
0561 |         structureIssues += "Required document metadata is missing; run GTD_Module_Info.dxl.\n"
0562 |     AttrDef setupStateAttr = find(m, "GTD Setup State")
0563 |     if (null setupStateAttr || !setupStateAttr.module)
0564 |         structureIssues += "GTD Setup State missing; run GTD_Setup_Module.dxl.\n"
0565 |     else {
0566 |         string setupState = m."GTD Setup State" ""
0567 |         if (setupState != "READY")
0568 |             structureIssues += "Setup is incomplete; resolve the setup log and run it again.\n"
0569 |     }
0570 |     int sectionCount[GTD_SECTION_COUNT]
0571 |     int si
0572 |     for (si = 0; si < GTD_SECTION_COUNT; si++) sectionCount[si] = 0
0573 |     Object checkObject
0574 |     for checkObject in entire m do {
0575 |         if (isDeleted(checkObject)) continue
0576 |         string issue = gtdSectionIdentityIssue(checkObject)
0577 |         if (issue != "") structureIssues += identifier(checkObject) " : " issue "\n"
0578 |         if (table(checkObject) || row(checkObject) || cell(checkObject)) continue
0579 |         string key = sectionKeyForObject(checkObject)
0580 |         int idx = gtdSectionIndex(key)
0581 |         if (idx >= 0) {
0582 |             sectionCount[idx]++
0583 |             Object p = parent(checkObject)
0584 |             int pi = gtdSectionParents[idx]
0585 |             string expectedParent = ""
0586 |             if (pi >= 0) expectedParent = gtdSectionKeys[pi]
0587 |             string actualParent = sectionKeyForObject(p)
0588 |             bool wrongParent = false
0589 |             if (pi < 0 && !null p) wrongParent = true
0590 |             if (pi >= 0 && (null p || actualParent != expectedParent)) wrongParent = true
0591 |             if (wrongParent) structureIssues += identifier(checkObject) " : WRONG_PARENT " key "\n"
0592 |         }
0593 |         string rt = checkObject."Requirement Type" ""
0594 |         string txt = checkObject."Object Text" ""
0595 |         string head = checkObject."Object Heading" ""
0596 |         if (!gtdBlank(rt) && !gtdBlank(txt) && gtdBlank(head) && gtdBlank(getPictName(checkObject))) {
0597 |             string containing = sectionKeyFromParents(checkObject)
0598 |             if (!isRequirementSection(containing))
0599 |                 structureIssues += identifier(checkObject) " : REQUIREMENT_OUTSIDE_SECTION\n"
0600 |         }
0601 |     }
0602 |     for (si = 0; si < GTD_SECTION_COUNT; si++)
0603 |         if (sectionCount[si] != 1)
0604 |             structureIssues += gtdSectionKeys[si] " : expected one heading; found " sectionCount[si] "\n"
0605 |     if (length(stringOf(structureIssues)) > 0) {
0606 |         string structureLog = tempFileName() "_GTD_Structure_Check.txt"
0607 |         Stream structureOut = write(structureLog)
0608 |         if (!null structureOut) {
0609 |             structureOut << stringOf(structureIssues)
0610 |             close(structureOut)
0611 |         }
0612 |         print stringOf(structureIssues)
0613 |         close(out)
0614 |         ack "GTD bolum yapisi tamamlanmamis. Yayin durduruldu.\nSetup'i tekrar calistirin.\n\nKontrol raporu:\n" structureLog
0615 |         delete(structureIssues)
0616 |         halt
0617 |     }
0618 |     delete(structureIssues)
0619 | }
0620 | 
````


## GTD_Publish.dxl — // Q = supplemental matrix fields.

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Publish.dxl`; ilk satır 906; SHA256 `ae9ede7a815a42475ae0856e4c4039d62e07ccf312d04ddbb2516c895f2e01c8`.

````text
0906 |         // Q = supplemental matrix fields. X = one outgoing source link per row.
0907 |         // Q|ReqId|RelatedSystem|TraceNote|SourceType|SourceReference
0908 |         string traceNote = ""
0909 |         if (!null adTraceNote) traceNote = o."Traceability Note" ""
0910 |         string sourceType = o."Requirement Source Type" ""
0911 |         string sourceReference = o."Requirement Source Reference" ""
0912 |         string sfTraceNote = safeField(traceNote)
0913 |         string sfSourceType = safeField(sourceType)
0914 |         string sfSourceReference = safeField(sourceReference)
0915 |         out << "Q|" << sfReqId << "|" << sfSystemName << "|" << sfTraceNote << "|" << sfSourceType << "|" << sfSourceReference << "\n"
0916 | 
0917 |         int matchedTraceLinks = 0
0918 |         Link traceLink
0919 |         for traceLink in all(o->"*") do {
0920 |             Module traceLinkModule = module(traceLink)
0921 |             string actualLinkPath = fullName(traceLinkModule)
0922 |             string sfActualLinkPath = safeField(actualLinkPath)
0923 |             if (actualLinkPath == traceLinkModulePath) {
0924 |                 matchedTraceLinks++
0925 |                 string traceSourceId = ""
0926 |                 string traceSourceModule = ""
0927 |                 string traceStatus = "UNREADABLE"
0928 |                 ModuleVersion traceTargetVersion = targetVersion(traceLink)
0929 |                 if (!null traceTargetVersion) {
0930 |                     ModName_ sourceModuleName = module(traceTargetVersion)
0931 |                     if (!null sourceModuleName) {
0932 |                         traceSourceModule = fullName(sourceModuleName)
0933 |                         if (!isDeleted(sourceModuleName)) {
0934 |                             Object sourceObject = target(traceLink)
0935 |                             if (null sourceObject) {
0936 |                                 noError()
0937 |                                 load(traceTargetVersion, false)
0938 |                                 string loadError = lastError()
0939 |                                 if (!null loadError && loadError != "") {
0940 |                                     string sfLoadError = safeField(loadError)
0941 |                                     out << "D|TRACE_LOAD_ERROR|" << sfReqId << "|" << sfLoadError << "\n"
0942 |                                 }
0943 |                                 sourceObject = target(traceLink)
0944 |                             }
0945 |                             if (!null sourceObject) {
0946 |                                 if (!isDeleted(sourceObject)) {
0947 |                                     traceSourceId = identifier(sourceObject)
0948 |                                     traceStatus = "RESOLVED"
0949 |                                 }
0950 |                                 else traceStatus = "DELETED"
0951 |                             }
0952 |                         }
0953 |                         else traceStatus = "DELETED"
0954 |                     }
0955 |                 }
0956 |                 string sfTraceSourceId = safeField(traceSourceId)
0957 |                 string sfTraceSourceModule = safeField(traceSourceModule)
0958 |                 out << "X|" << sfReqId << "|" << sfTraceSourceId << "|" << sfTraceSourceModule << "|" << sfActualLinkPath << "|" << traceStatus << "\n"
0959 |             }
0960 |         }
0961 |         if (matchedTraceLinks == 0) {
0962 |             out << "X|" << sfReqId << "||||NONE\n"
0963 |         }
0964 | 
0965 |         // Source-definition validation. Warnings do not block publishing yet.
0966 |         if (sourceType == "") {
0967 |             sourceValidationWarnings++
0968 |             out << "D|SOURCE_WARNING|" << sfReqId << "|SOURCE_TYPE_EMPTY\n"
0969 |         }
0970 |         else if (sourceType == "Higher-Level Requirement") {
0971 |             if (matchedTraceLinks == 0) {
0972 |                 sourceValidationWarnings++
0973 |                 out << "D|SOURCE_WARNING|" << sfReqId << "|HIGHER_LEVEL_WITHOUT_LINK\n"
0974 |             }
0975 |         }
0976 |         else if (sourceType == "Derived") {
0977 |             if (matchedTraceLinks > 0) {
0978 |                 sourceValidationWarnings++
0979 |                 out << "D|SOURCE_WARNING|" << sfReqId << "|DERIVED_HAS_UPPER_SOURCE_LINK\n"
0980 |             }
0981 |         }
0982 |         else if (sourceType == "Standard / Regulation" ||
0983 |                  sourceType == "Interface" ||
0984 |                  sourceType == "Safety Analysis" ||
0985 |                  sourceType == "Other") {
0986 |             if (sourceReference == "") {
0987 |                 sourceValidationWarnings++
0988 |                 out << "D|SOURCE_WARNING|" << sfReqId << "|SOURCE_REFERENCE_EMPTY|" << sfSourceType << "\n"
0989 |             }
0990 |         }
0991 |         else {
0992 |             sourceValidationWarnings++
0993 |             out << "D|SOURCE_WARNING|" << sfReqId << "|UNKNOWN_SOURCE_TYPE|" << sfSourceType << "\n"
0994 |         }
0995 | 
0996 |     }
0997 |     }
0998 | }
0999 | 
1000 | string sourceWarningCountText = sourceValidationWarnings ""
1001 | out << "D|SOURCE_VALIDATION_SUMMARY|WARNINGS|" << sourceWarningCountText << "\n"
1002 | 
1003 | close(out)
1004 | 
1005 | // ------------------------------------------------------------
````


## GTD_Publish.dxl — // Copy network files to local TEMP, then run locally.

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Publish.dxl`; ilk satır 1006; SHA256 `ae9ede7a815a42475ae0856e4c4039d62e07ccf312d04ddbb2516c895f2e01c8`.

````text
1006 | // Copy network files to local TEMP, then run locally.
1007 | // ------------------------------------------------------------
1008 | string batPath = tmpBase ".bat"
1009 | string localScript = tmpBase "_GTD_Build_Document.ps1"
1010 | string localTemplate = tmpBase "_TPL_GTD_Publisher.docx"
1011 | 
1012 | Stream bat = write(batPath)
1013 | 
1014 | if (null bat) {
1015 |     ack "Gecici BAT dosyasi olusturulamadi."
1016 |     halt
1017 | }
1018 | 
1019 | bat << "@echo off\r\n"
1020 | bat << "setlocal\r\n"
1021 | bat << "cd /d \"%TEMP%\"\r\n"
1022 | 
1023 | bat << "copy /Y \"" scriptPath "\" \"" localScript "\" >nul\r\n"
1024 | bat << "if errorlevel 1 (\r\n"
1025 | bat << "  echo PowerShell dosyasi TEMP'e kopyalanamadi.\r\n"
1026 | bat << "  pause\r\n"
1027 | bat << "  exit /b 1\r\n"
1028 | bat << ")\r\n"
1029 | 
1030 | bat << "copy /Y \"" templatePath "\" \"" localTemplate "\" >nul\r\n"
1031 | bat << "if errorlevel 1 (\r\n"
1032 | bat << "  echo Word template TEMP'e kopyalanamadi.\r\n"
1033 | bat << "  pause\r\n"
1034 | bat << "  exit /b 1\r\n"
1035 | bat << ")\r\n"
1036 | 
1037 | bat << "powershell.exe -NoProfile -ExecutionPolicy Bypass -File \"" localScript "\" -DataPath \"" dataPath "\" -TemplatePath \"" localTemplate "\" -OutputName \"" outputName "\"\r\n"
1038 | bat << "set ERR=%ERRORLEVEL%\r\n"
1039 | bat << "del /Q \"" localScript "\" >nul 2>nul\r\n"
1040 | bat << "del /Q \"" localTemplate "\" >nul 2>nul\r\n"
1041 | bat << "exit /b %ERR%\r\n"
1042 | 
1043 | close(bat)
1044 | 
1045 | system("cmd.exe /c \"" batPath "\"")
1046 | 
1047 | infoBox "GTD yayin komutu tamamlandi.\n\nBasariliysa cikti Masaustunde secili gosterilecek.\nBasarisizsa Masaustundeki GTD_Publish_Log.txt otomatik acilacak."
````


## GTD_Build_Document.ps1 — function Replace-ScalarMarkersRaw(

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Build_Document.ps1`; ilk satır 74; SHA256 `271ac27d3057aa00941496b14014204491b3cc0b67c26958ad682c7f8a613372`.

````text
0074 | function Replace-ScalarMarkersRaw([string]$PartPath, [hashtable]$Map) {
0075 |     if (-not (Test-Path -LiteralPath $PartPath)) { return }
0076 | 
0077 |     $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
0078 |     $content = [System.IO.File]::ReadAllText($PartPath, [System.Text.Encoding]::UTF8)
0079 | 
0080 |     foreach ($key in $Map.Keys) {
0081 |         $content = $content.Replace($key, (Xml-Escape ([string]$Map[$key])))
0082 |     }
0083 | 
0084 |     [System.IO.File]::WriteAllText($PartPath, $content, $utf8NoBom)
0085 | }
0086 | 
0087 | function Build-OrderedTableXml($Cells) {
0088 |     $fragment = New-Object System.Text.StringBuilder
````


## GTD_Build_Document.ps1 — function Replace-OrderedContentMarkerRaw(

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Build_Document.ps1`; ilk satır 269; SHA256 `271ac27d3057aa00941496b14014204491b3cc0b67c26958ad682c7f8a613372`.

````text
0269 | function Replace-OrderedContentMarkerRaw(
0270 |     [string]$DocumentPath,
0271 |     [string]$Marker,
0272 |     $Events,
0273 |     [string]$WordDir
0274 | ) {
0275 |     $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
0276 |     $content = [System.IO.File]::ReadAllText($DocumentPath, [System.Text.Encoding]::UTF8)
0277 | 
0278 |     $markerEsc = [regex]::Escape($Marker)
0279 |     $pattern = '<w:p\b[^>]*>(?:(?!</w:p>).)*' + $markerEsc + '(?:(?!</w:p>).)*</w:p>'
0280 |     $match = [regex]::Match(
0281 |         $content,
0282 |         $pattern,
0283 |         [System.Text.RegularExpressions.RegexOptions]::Singleline
0284 |     )
0285 | 
0286 |     # Word can split a marker across several runs. Accept known legacy names
0287 |     # and case differences, but only when the paragraph contains just a marker.
0288 |     if (-not $match.Success) {
0289 |         $paragraphMatches = [regex]::Matches(
0290 |             $content,
0291 |             '<w:p\b[^>]*>.*?</w:p>',
0292 |             [System.Text.RegularExpressions.RegexOptions]::Singleline
0293 |         )
0294 |         foreach ($candidate in $paragraphMatches) {
0295 |             $textParts = [regex]::Matches(
0296 |                 $candidate.Value,
0297 |                 '<w:t\b[^>]*>(.*?)</w:t>',
0298 |                 [System.Text.RegularExpressions.RegexOptions]::Singleline
0299 |             )
0300 |             $paragraphText = (($textParts | ForEach-Object {
0301 |                 [System.Net.WebUtility]::HtmlDecode($_.Groups[1].Value)
0302 |             }) -join '').Trim()
0303 |             $normalizedMarker = $paragraphText.ToUpperInvariant()
0304 |             if ($normalizedMarker -eq '{{SEC_DURUM_VE_MODLAR}}') {
0305 |                 $normalizedMarker = '{{SEC_DURUM_MODLAR}}'
0306 |             }
0307 |             if ($normalizedMarker -ceq $Marker.ToUpperInvariant()) {
0308 |                 $match = $candidate
0309 |                 Log ("Ordered marker resolved: " + $paragraphText + " -> " + $Marker)
0310 |                 break
0311 |             }
0312 |         }
0313 |     }
0314 | 
0315 |     if (-not $match.Success) {
0316 |         Log ("Ordered content marker not found: " + $Marker)
0317 |         return
0318 |     }
0319 | 
0320 |     $fragment = New-Object System.Text.StringBuilder
0321 |     $eventList = @($Events)
0322 |     $i = 0
0323 | 
0324 |     while ($i -lt $eventList.Count) {
0325 |         $ev = $eventList[$i]
0326 | 
0327 |         if ($ev.kind -eq "TEXT") {
0328 |             $txt = Xml-Escape ([string]$ev.text)
````


## GTD_Build_Document.ps1 — $lines = Get-Content -LiteralPath $DataPath -Encoding Default

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Build_Document.ps1`; ilk satır 848; SHA256 `271ac27d3057aa00941496b14014204491b3cc0b67c26958ad682c7f8a613372`.

````text
0848 |     $lines = Get-Content -LiteralPath $DataPath -Encoding Default
0849 | 
0850 |     foreach ($line in $lines) {
0851 |         if ([string]::IsNullOrWhiteSpace($line)) { continue }
0852 | 
0853 |         $parts = $line.Split('|')
0854 | 
0855 |         if ($parts[0] -eq "M" -and $parts.Count -ge 3) {
0856 |             $meta[$parts[1]] = $parts[2]
0857 |         }
0858 |         elseif ($parts[0] -eq "R" -and $parts.Count -ge 6) {
0859 |             [void]$reqs.Add([pscustomobject]@{
0860 |                 id = $parts[1]
0861 |                 type = $parts[2]
0862 |                 text = $parts[3]
0863 |                 verificationMethod = $parts[4]
````


## GTD_Build_Document.ps1 — Log "Validating all DOCX XML parts..."

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Build_Document.ps1`; ilk satır 1086; SHA256 `271ac27d3057aa00941496b14014204491b3cc0b67c26958ad682c7f8a613372`.

````text
1086 |         Log "Validating all DOCX XML parts..."
1087 |         Validate-XmlFiles $work
1088 |         Log "XML validation passed."
1089 | 
1090 |         Remove-Item -LiteralPath $outputPath -Force
1091 | 
1092 |         [System.IO.Compression.ZipFile]::CreateFromDirectory(
1093 |             $work,
1094 |             $outputPath,
1095 |             [System.IO.Compression.CompressionLevel]::Optimal,
1096 |             $false
1097 |         )
1098 |     }
1099 |     finally {
1100 |         if (Test-Path -LiteralPath $work) {
1101 |             Remove-Item -LiteralPath $work -Recurse -Force
1102 |         }
1103 |     }
1104 | 
1105 |     if (-not (Test-Path -LiteralPath $outputPath)) {
1106 |         throw "Output DOCX was not created."
1107 |     }
1108 | 
1109 |     Log "SUCCESS"
1110 |     Log "Created: $outputPath"
1111 | 
1112 |     Start-Process explorer.exe -ArgumentList "/select,`"$outputPath`""
1113 |     exit 0
1114 | }
1115 | catch {
1116 |     Log "FAILED"
1117 |     Log $_.Exception.Message
1118 |     Log $_.ScriptStackTrace
1119 | 
1120 |     try {
1121 |         Start-Process notepad.exe -ArgumentList "`"$logPath`""
1122 |     } catch {}
1123 | 
1124 |     exit 1
1125 | }
````


## GTD_Module_Info.dxl — string gtdSystemName       =

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Module_Info.dxl`; ilk satır 147; SHA256 `10437d6ec52bcb11e7d9ed5cd6f2929052e6d47037554f4fcf61bfe8febd8d1b`.

````text
0147 | string gtdSystemName       = gtdInfoModule."System Name" ""
0148 | string gtdPrefix           = gtdInfoModule."Prefix" ""
0149 | string gtdDocumentNumber   = gtdInfoModule."Document Number" ""
0150 | string gtdDocumentRevision = gtdInfoModule."Document Revision" ""
0151 | string gtdProjectName      = gtdInfoModule."Project Name" ""
0152 | string gtdProjectNumber    = gtdInfoModule."Project Number" ""
0153 | string gtdDepartment       = gtdInfoModule."Department" ""
0154 | string gtdWorkPackage      = gtdInfoModule."Work Package" ""
0155 | string gtdSDVILNumber      = gtdInfoModule."SDVIL Number" ""
0156 | string gtdClassification   = gtdInfoModule."Classification" ""
0157 | 
0158 | Date gtdDocumentDate = gtdInfoModule."Document Date"
0159 | 
0160 | if (null gtdDocumentDate)
0161 |     gtdDocumentDate = dateOnly(today)
0162 | 
0163 | // ------------------------------------------------------------
0164 | // Dialog globals
0165 | // ------------------------------------------------------------
0166 | DB gtdInfoDb = create("GTD Module Bilgileri", styleCentered | styleStandard)
````


## GTD_Module_Info.dxl — void gtdSaveInfo(

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Module_Info.dxl`; ilk satır 210; SHA256 `10437d6ec52bcb11e7d9ed5cd6f2929052e6d47037554f4fcf61bfe8febd8d1b`.

````text
0210 | void gtdSaveInfo(DB db)
0211 | {
0212 |     string systemName       = gtdTrim(get(gtdSystemNameField))
0213 |     string modulePrefix     = gtdTrim(get(gtdPrefixField))
0214 |     string documentNumber   = gtdTrim(get(gtdDocumentNumberField))
0215 |     string documentRevision = gtdTrim(get(gtdDocumentRevisionField))
0216 |     string projectName      = gtdTrim(get(gtdProjectNameField))
0217 |     string projectNumber    = gtdTrim(get(gtdProjectNumberField))
0218 |     string department       = gtdTrim(get(gtdDepartmentField))
0219 |     string workPackage      = gtdTrim(get(gtdWorkPackageField))
0220 |     string sdvilNumber      = gtdTrim(get(gtdSDVILNumberField))
0221 | 
0222 |     Date documentDate = dateOnly(getDate(gtdDocumentDateField))
0223 | 
0224 |     int classificationIndex = get(gtdClassificationChoice)
0225 |     string classification = ""
0226 | 
0227 |     if (classificationIndex >= 0 && classificationIndex < 4)
0228 |         classification = gtdClassificationChoices[classificationIndex]
0229 | 
0230 |     Buffer missing = create
0231 | 
0232 |     if (systemName == "")       missing += "System Name\n"
0233 |     if (modulePrefix == "")     missing += "DOORS Prefix\n"
0234 |     if (documentNumber == "")   missing += "Document Number\n"
0235 |     if (documentRevision == "") missing += "Document Revision\n"
0236 |     if (null documentDate)      missing += "Document Date\n"
0237 |     if (projectName == "")      missing += "Project Name\n"
0238 |     if (projectNumber == "")    missing += "Project Number\n"
0239 |     if (department == "")       missing += "Department\n"
0240 |     if (classification == "")   missing += "Classification\n"
0241 | 
0242 |     string missingText = stringOf(missing)
0243 | 
0244 |     if (missingText != "") {
0245 |         delete(missing)
0246 |         warningBox "Zorunlu alanlar eksik:\n\n" missingText
0247 |         return
0248 |     }
0249 | 
0250 |     delete(missing)
0251 | 
0252 |     if (!gtdValidPrefix(modulePrefix)) {
0253 |         warningBox "DOORS Prefix gecersiz.\n\nYalnizca A-Z, a-z, 0-9, _ ve - kullanin."
0254 |         return
0255 |     }
0256 | 
0257 |     gtdInfoModule."System Name"       = systemName
0258 |     gtdInfoModule."Prefix"            = modulePrefix
0259 |     gtdInfoModule."Document Number"   = documentNumber
0260 |     gtdInfoModule."Document Revision" = documentRevision
0261 |     gtdInfoModule."Document Date"     = documentDate
0262 |     gtdInfoModule."Project Name"      = projectName
0263 |     gtdInfoModule."Project Number"    = projectNumber
0264 |     gtdInfoModule."Department"        = department
0265 |     gtdInfoModule."Work Package"      = workPackage
0266 |     gtdInfoModule."SDVIL Number"      = sdvilNumber
0267 |     gtdInfoModule."Classification"    = classification
0268 | 
0269 |     noError()
0270 |     save(gtdInfoModule)
0271 |     string saveError = lastError()
0272 | 
0273 |     if (saveError != "") {
0274 |         warningBox "Module kaydedilemedi:\n\n" saveError
0275 |         return
0276 |     }
0277 | 
0278 |     release db
0279 | }
0280 | 
````


## GTD_Install_Open_Trigger.dxl — Project gtdProject =

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Install_Open_Trigger.dxl`; ilk satır 18; SHA256 `bcd18eba4113efbfcc10f0af2366c6883b8c813b073141ca4e5724df1bc58f61`.

````text
0018 | Project gtdProject = current Project
0019 | 
0020 | if (null gtdProject) {
0021 |     ack "Once trigger'in kurulacagi projeyi current project yapin."
0022 |     halt
0023 | }
0024 | 
0025 | // Replace the previous trigger with the same agreed identity.
0026 | // A delete error is ignored because it also occurs when no old trigger exists.
0027 | string gtdDeleteError = delete(
0028 |     "GTD_Module_Open_Check",
0029 |     module->all->formal,
0030 |     post,
0031 |     open,
0032 |     10
0033 | )
0034 | 
0035 | Buffer gtdTriggerCode = create
0036 | 
0037 |     gtdTriggerCode += "// ============================================================\n"
0038 |     gtdTriggerCode += "// GTD_Open_Check.dxl\n"
0039 |     gtdTriggerCode += "// Body used by persistent trigger: GTD_Module_Open_Check\n"
0040 |     gtdTriggerCode += "// Scope: current project -> all formal modules\n"
0041 |     gtdTriggerCode += "// Event: post open\n"
0042 |     gtdTriggerCode += "// Priority: 10\n"
````


## GTD_Install_Open_Trigger.dxl — Trigger

Kaynak: `PROJECT_FILES/GTD/GUNCEL/GTD_Install_Open_Trigger.dxl`; ilk satır 79; SHA256 `bcd18eba4113efbfcc10f0af2366c6883b8c813b073141ca4e5724df1bc58f61`.

````text
0079 |     gtdTriggerCode += "    Trigger gtdTrigger = current()\n"
0080 |     gtdTriggerCode += "\n"
0081 |     gtdTriggerCode += "    // For a post-open module trigger, this obtains the opened module.\n"
0082 |     gtdTriggerCode += "    // The 0 variant also allows correct baseline detection.\n"
0083 |     gtdTriggerCode += "    Module gtdModule = module(gtdTrigger, 0)\n"
0084 |     gtdTriggerCode += "\n"
0085 |     gtdTriggerCode += "    if (null gtdModule)\n"
0086 |     gtdTriggerCode += "        return\n"
0087 |     gtdTriggerCode += "\n"
0088 |     gtdTriggerCode += "    if (baseline(gtdModule))\n"
0089 |     gtdTriggerCode += "        return\n"
0090 |     gtdTriggerCode += "\n"
0091 |     gtdTriggerCode += "    AttrDef adVersion = find(gtdModule, \"GTD Template Version\")\n"
0092 |     gtdTriggerCode += "    AttrDef adFormPath = find(gtdModule, \"GTD Form Path\")\n"
0093 |     gtdTriggerCode += "\n"
0094 |     gtdTriggerCode += "    // Not a GTD module: silently ignore.\n"
0095 |     gtdTriggerCode += "    if (null adVersion || null adFormPath)\n"
0096 |     gtdTriggerCode += "        return\n"
0097 |     gtdTriggerCode += "\n"
0098 |     gtdTriggerCode += "    if (!adVersion.module || !adFormPath.module)\n"
0099 |     gtdTriggerCode += "        return\n"
0100 |     gtdTriggerCode += "\n"
````



---

# Existing static check report


````text
PASS | Balanced DXL delimiters: GTD_Publish.dxl
PASS | No generation placeholders: GTD_Publish.dxl
PASS | Balanced DXL delimiters: GTD_Requirement_Review_Control.dxl
PASS | No generation placeholders: GTD_Requirement_Review_Control.dxl
PASS | Balanced DXL delimiters: GTD_Remove_Open_Trigger.dxl
PASS | No generation placeholders: GTD_Remove_Open_Trigger.dxl
PASS | Balanced DXL delimiters: GTD_Install_Open_Trigger.dxl
PASS | No generation placeholders: GTD_Install_Open_Trigger.dxl
PASS | Balanced DXL delimiters: GTD_Setup_Module.dxl
PASS | No generation placeholders: GTD_Setup_Module.dxl
PASS | Balanced DXL delimiters: GTD_Module_Info.dxl
PASS | No generation placeholders: GTD_Module_Info.dxl
PASS | Balanced DXL delimiters: GTD_Open_Check.dxl
PASS | No generation placeholders: GTD_Open_Check.dxl
PASS | The three section models are identical
PASS | 28 unique headings with valid parents
PASS | Setup heading text and hierarchy equal the Word template sections 1–3
PASS | 24 content keys cover every Word placeholder exactly once
PASS | PowerShell consumes all 24 mapped sections
PASS | New verification choices match Word section 4
PASS | All six requirement source choices are preserved
PASS | Every literal custom attribute read is created by setup
PASS | Setup has no object move, delete, link or enum modify operation
PASS | Setup writes only heading text and section key on objects
PASS | Setup never assigns Prefix, Document Date or Document Revision
PASS | Section key creation explicitly disables inheritance
PASS | Managed publishing has no sibling fallback
PASS | Headings and pictures excluded from requirement and matrix records
PASS | Installed trigger body equals the readable open-check file
PASS | Original bytes preserved: TPL_GTD_Publisher.docx
PASS | Original bytes preserved: GTD_Build_Document.ps1
PASS | Encoding-independent ASCII DXL source: GTD_Setup_Module.dxl
PASS | Encoding-independent ASCII DXL source: GTD_Publish.dxl
PASS | Encoding-independent ASCII DXL source: GTD_Requirement_Review_Control.dxl

34 static contract checks passed. DOORS compilation and execution were not performed.
````



END OF RESEARCH INPUT — GTD-HANDOFF-2026-09-13-a3cc85b1e006


Şimdi kaynak araştırmasını yap ve GEMINI_RESEARCH_REPORT.md raporunu hazırla. Doğrulanamayan hedef sürüm iddialarını açık bırak.
