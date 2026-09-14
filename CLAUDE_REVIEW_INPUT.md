# Claude — bağımsız Reviewer görevi

Devir kimliği: **GTD-HANDOFF-2026-09-13-a3cc85b1e006**

Bu projede bağımsız kıdemli DOORS/DXL ve doküman yayın kodu Reviewer'ısın. Ekli dosyayı önce ortak bağlam, sonra kaynaklar ve farklar sırasıyla incele. Görevi doğrudan uygula; yalnız inceleme planı veya görevi anladığını belirten yanıt verme. Türkçe, teknik isimleri koruyarak raporla.

## Amaç

Mevcut uygulama adayının yeni/eski modülde güvenilir biçimde kurulum ve yayın yapmasını engelleyen somut kusurları, kararla kod arasındaki çelişkileri ve kanıt eksiklerini bul. Eski dosya da hatalı olabilir; 'önceden vardı' gerekçesiyle göz ardı etme. Her bulguda kökeni **yeni / önceden var / yeni-eski etkileşimi / belirsiz** olarak belirt.

`01_DECISIONS.md` içindeki D-ID'leri mevcut proje kararları olarak esas al. Geçerli bir teknik sorun varsa kararın değişmesini gerekçeli öneri olarak sun; mimariyi kendiliğinden değişmiş kabul etme. I-ID'ler uygulama tercihleridir ve inceleme konusudur. Bu turda teslim edilen kodun yerini alacak yeniden yazılmış bir paket üretme; gerekli en küçük düzeltmeyi bulguya ekle. Yalnız 'iyi görünüyor' değerlendirmesi yeterli değildir.

## Öncelikli inceleme alanları

1. **Derlenebilirlik ve DXL bağlamı:** DOORS 9.6.1.3 64-bit; overload/macro söz dizimi, array/AttrDef/AttrType/ViewDef/Column kullanımı, `current` bağlamı, error handling, Layout DXL `obj`, `eval_` ve persistent trigger. Gerçek derleme olmadan derlendiğini söyleme. Sürüm bilgisi belirsizse araştırılması gereken iddiayı belirt.
2. **Mevcut modülü koruma:** Şema ön kontrolü değişiklikten önce yeterli mi? Attribute scope/type/inheritance/DXL/multi ve erişim izinleri, dolu yolların korunması, enum numaraları/etiketleri, kısmi hata ve kayıt başarısızlığı. Idempotence, tekrar çalıştırmada nesne kopyası üretmemektir; hiçbir geçmiş kaydı oluşmaması olarak yorumlama.
3. **Başlık kimliği ve hiyerarşi:** 28 başlık, parent ilişkileri, tanımlı alias'lar, Türkçe/numaralı başlık, filtrelenmiş/silinmiş nesne, bilinmeyen key, key/ad çelişkisi, mükerrer ve yanlış parent, çözümlenmemiş dallar, mevcut sıra ve yeni ekleme konumları. Düz metinlerin veya tanınmayan eski başlıkların sessiz kaybını da kontrol et.
4. **View/Control:** Entry korunumu; Review'da sadece Control güncelleme; Standard view adı/erişimi, sütun çakışmaları, Layout DXL refresh hataları, kullanıcı özelleştirmeleri. Başlık/görsel/native table dışlanması, boş metin, türsüz narrative, yanlış tür ve kaynak kontrolleri.
5. **Yayın ve trace:** Managed yapı kapısı, eski fallback ile etkileşim, Control ile engelleyici publisher kontrollerinin farkı, outgoing link modülü filtresi, raw link sayısı ve çözümlenmiş hedef ayrımı; silinmiş/erişilemeyen/hedef sürümü açılmamış linkler.
6. **DXL → PowerShell → DOCX:** Pipe alanları, satır sonu/rich text kayıpları, UTF-8/Windows kod sayfası, boşluk ve kabuk özel karakterli yollar, temp dosyaları, çıktı dosyası çakışması, hata kodları; XML escaping/marker run bölünmesi, native tablo/görsel yerleşimi, trace matrisi, DOCX paket bütünlüğü, metadata/TOC alanları. Şablon ve PS1'in bayt düzeyinde aynı kalması test yerine geçmez.
7. **Bakım ve test delili:** Ortak modelin üç kopyasının üretim kaynağı, yeniden üretimin düzeltmeleri silme riski, statik kontrol aracının kanıt sınırı. Testleri yalnız uygulamadaki aynı kalıpları aradığı için davranış garantisi sayma.

Bu başlıklar kapsam yönlendirmesidir; bildirilmiş doğrulanmış hatalar değildir. Bağımsız değerlendir, aynı kök nedeni tekrar sayma, yalnız biçimsel tercihleri yüksek önem derecesine çıkarma.

## Beklenen rapor

Raporu `CLAUDE_REVIEW_REPORT.md` adıyla ver; dosya üretemiyorsan aynı yapıyı yanıtında kullan.

- Başta devir kimliği, inceleme tarihi, kullandığın model/ortam, gerçekten okunan dosyalar ve çalıştırılan/çalıştırılmayan kontroller.
- Önce somut önemli bulgular; sonra bilinmeyenler ve kapsanmayan alanlar. Engelleyici bulgu yoksa bunu inceleme kapsamı ve runtime sınırıyla söyle.
- Her bulgu `RV-001` biçiminde benzersiz ID almalı ve şu alanları içermeli:

| Alan | Gereken içerik |
|---|---|
| Önem / durum | BLOCKER, HIGH, MEDIUM, LOW / CONFIRMED, POTENTIAL veya QUESTION |
| Köken | Yeni / önceden var / etkileşim / belirsiz |
| Kanıt | Tam göreli dosya yolu, işlev veya kod bloğu ve birinci satır numarası; kısa ilgili kod. Gerekirse sürüme uygun birincil kaynak. |
| Etki | Hangi nesne/veri/işlem etkilenir; kullanıcı hangi sonucu görür? |
| Tetikleyici | En küçük yeniden üretme senaryosu ve ön koşullar |
| Beklenen / gözlenen | Karar veya sözleşme ile kodun davranışı; gözlem yerine çıkarımsa açıkça etiketle |
| Düzeltme | En küçük uygulanabilir öneri; üretilen DXL yanında `build_package.py` / `setup_body.dxl` etkisi |
| Doğrulama | Düzeltmeyi kanıtlayacak hedefli gerçek istemci testi veya uygun kontrol |
| Bağlantı | İlgili D/I/O-ID; karar değişikliği gerekiyorsa açık gerekçe |

- Son bölümde öncelikli düzeltme sırası ve hedef ortamda hâlâ gerekli kabul testleri.
- Gemini'ye aktarılması yararlı olan sürüm/standart sorularını ayrı listele; kendin bulduğun kaynağı sürümüyle birlikte ver.
- Gerçekte çalıştırmadığın hiçbir kod veya senaryoya PASS verme. Satır numaralı metindeki `0001 |` önekleri kaynak dosyanın parçası değildir.

Word şablonu ayrıca ekliyse doğrudan incele. Yalnız metin dökümü varsa XML/layout değerlendirmesinin sınırını belirt. Tam arşivde orijinal dosyalar ve üretim kaynakları bulunur; erişmediğin içerik için inceleme yapılmış gibi yazma.



---

# Girdi kapsamı


Bu tek dosya ortak proje hafızasını, görevini, sekiz güncel metin kaynak dosyasını, üç bakım kaynağını, eski kaynak helper dosyasını, değişiklik farklarını, statik raporu, bölüm/şablon dökümünü ve kabul planını içerir. Gerçek DOCX şablonu ayrıca eklenmelidir; metin dökümü görsel inceleme yerine geçmez. Tam orijinaller arşivde saklıdır. Kod hash ve satırları bu devir kimliğine aittir.



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

# Included document: EVIDENCE/TEMPLATE_STRUCTURE.md

# Word şablonu: mekanik yapı ve metin dökümü

Kaynak: `PROJECT_FILES/GTD/GUNCEL/TPL_GTD_Publisher.docx`  
SHA256: `1e2857f51b35ca0a84c4ccde6cfe2be3152cf0fae07638666b2506dfb7665d2c`

Bu döküm DOCX XML öğelerinden okunur; sayfa görünümü, çizimler, resimler ve alanların yeniden hesaplanmış sonuçları değildir. Reviewer mümkünse gerçek DOCX ekini de açmalıdır.

## Ana gövde: başlıklar

| Gövde öğesi | Stil | Metin |
|---|---|---|
| 49 | Heading1 | GENEL |
| 50 | Heading2 | Amaç |
| 53 | Heading2 | Kapsam |
| 55 | Heading2 | Proje Tanıtımı |
| 58 | Heading3 | Sisteme Genel Bakış |
| 60 | Heading3 | Ürüne Genel Bakış |
| 62 | Heading2 | Kısaltmalar/Tanımlar |
| 63 | Heading3 | Kısaltmalar |
| 66 | Heading3 | Tanımlar |
| 69 | Heading2 | Uygulanabilir Dokümanlar |
| 71 | Heading3 | Standartlar |
| 74 | Heading3 | Diğer Dokümanlar |
| 77 | Heading1 | SİSTEMİN TANIMLAMASI |
| 78 | Heading2 | Durum ve Modlar |
| 80 | Heading2 | Ömür Döngüsü |
| 82 | Heading2 | Sınırlamalar |
| 84 | Heading1 | GEREKSİNİMLER |
| 85 | Heading2 | İşlevsel Gereksinimler  |
| 87 | Heading2 | Performans Gereksinimleri  |
| 89 | Heading2 | Fiziksel Gereksinimler  |
| 91 | Heading2 | Arayüz Gereksinimleri  |
| 93 | Heading2 | Çevresel Gereksinimler  |
| 95 | Heading2 | Emniyet Gereksinimleri  |
| 97 | Heading2 | Entegre Lojistik Destek Gereksinimleri  |
| 99 | Heading2 | Güvenlik ve Gizlilik Gereksinimleri  |
| 101 | Heading2 | Ergonomi Gereksinimleri  |
| 103 | Heading2 | Markalama ve Etiketleme Gereksinimleri  |
| 105 | Heading2 | Bilgisayar Kaynak Gereksinimleri  |
| 107 | Heading1 | GEREKSİNİM DOĞRULAMA YÖNTEMİ |
| 108 | Heading2 | Analiz  |
| 109 | Heading2 | Gösterim  |
| 110 | Heading2 | Muayene  |
| 111 | Heading2 | Test  |
| 112 | Heading2 | Uygunluk Belgesi  |

## Marker envanteri

- `{{CLASS}}`
- `{{DATE}}`
- `{{DOCNO}}`
- `{{PROJNO}}`
- `{{PROJ_DEPT}}`
- `{{REQ_ARAYUZ}}`
- `{{REQ_BILGISAYAR}}`
- `{{REQ_CEVRESEL}}`
- `{{REQ_ELD}}`
- `{{REQ_EMNIYET}}`
- `{{REQ_ERGONOMI}}`
- `{{REQ_FIZIKSEL}}`
- `{{REQ_GUV_GIZ}}`
- `{{REQ_ISLEVSEL}}`
- `{{REQ_MARKALAMA}}`
- `{{REQ_PERFORMANS}}`
- `{{REV}}`
- `{{SDVIL}}`
- `{{SEC_AMAC}}`
- `{{SEC_DIGER_DOKUMANLAR}}`
- `{{SEC_DURUM_MODLAR}}`
- `{{SEC_KAPSAM}}`
- `{{SEC_KISALTMALAR}}`
- `{{SEC_OMUR_DONGUSU}}`
- `{{SEC_PROJE_TANITIMI}}`
- `{{SEC_SINIRLAMALAR}}`
- `{{SEC_SISTEM_GENEL}}`
- `{{SEC_STANDARTLAR}}`
- `{{SEC_TANIMLAR}}`
- `{{SEC_URUN_GENEL}}`
- `{{SEC_UYGULANABILIR_DOKUMANLAR}}`
- `{{SYS}}`
- `{{TRACE_MATRIX}}`
- `{{WORK}}`

## Ana gövde: metin ve tablolar

````text
[001] PARAGRAPH style=default: 
[002] TABLE
  row 1: Dok. No | : | {{DOCNO}}
  row 2: Rev. | : | {{REV}}
  row 3: Tarih | : | {{DATE}}
  row 4: Proje/Bölüm | : | {{PROJ_DEPT}}
  row 5: İş Paketi  | : | {{WORK}}
  row 6: SDVİL No  | : | {{SDVIL}}
[003] PARAGRAPH style=default: 
[004] TABLE
  row 1: {{SYS}} /  /  /  / GEREKSİNİM TANIMLAMA DOKÜMANI
[005] PARAGRAPH style=default: 
[006] TABLE
  row 1: DAĞITIM LİSTESİ*
  row 2: Adet | Adı ve Soyadı | Bölüm/Unvan | Kurum/Kuruluş
  row 3:  |  |  | 
  row 4:  |  |  | 
  row 5:  |  |  | 
[007] PARAGRAPH style=default: 
[008] PARAGRAPH style=default: 
[009] TABLE
  row 1: DEĞİŞİKLİK KAYDI
  row 2: Rev. | Tarih | Sayfa | Değişiklik Tanımı
  row 3:  |  |  | 
[010] PARAGRAPH style=default: 
[011] PARAGRAPH style=Caption: İÇİNDEKİLER
[012] PARAGRAPH style=TOC1: 1. GENEL7
[013] PARAGRAPH style=TOC2: 1.1. Amaç7
[014] PARAGRAPH style=TOC2: 1.2. Kapsam7
[015] PARAGRAPH style=TOC2: 1.3. Proje Tanıtımı7
[016] PARAGRAPH style=TOC2: 1.4. Kısaltmalar/Tanımlar8
[017] PARAGRAPH style=TOC2: 1.5. Uygulanabilir Dokümanlar8
[018] PARAGRAPH style=TOC1: 2. SİSTEMİN TANIMLAMASI8
[019] PARAGRAPH style=TOC2: 2.1. Durum ve Modlar8
[020] PARAGRAPH style=TOC2: 2.2. Ömür Döngüsü8
[021] PARAGRAPH style=TOC2: 2.3. Sınırlamalar9
[022] PARAGRAPH style=TOC1: 3. GEREKSİNİMLER9
[023] PARAGRAPH style=TOC2: 3.1. İşlevsel Gereksinimler9
[024] PARAGRAPH style=TOC2: 3.2. Performans Gereksinimleri9
[025] PARAGRAPH style=TOC2: 3.3. Fiziksel Gereksinimler9
[026] PARAGRAPH style=TOC2: 3.4. Arayüz Gereksinimleri9
[027] PARAGRAPH style=TOC2: 3.5. Çevresel Gereksinimler9
[028] PARAGRAPH style=TOC2: 3.6. Emniyet Gereksinimleri10
[029] PARAGRAPH style=TOC2: 3.7. Entegre Lojistik Destek Gereksinimleri10
[030] PARAGRAPH style=TOC2: 3.8. Güvenlik ve Gizlilik Gereksinimleri10
[031] PARAGRAPH style=TOC2: 3.9. Ergonomi Gereksinimleri10
[032] PARAGRAPH style=TOC2: 3.10. Markalama ve Etiketleme Gereksinimleri10
[033] PARAGRAPH style=TOC2: 3.11. Bilgisayar Kaynak Gereksinimleri11
[034] PARAGRAPH style=TOC1: 4. GEREKSİNİM DOĞRULAMA YÖNTEMİ11
[035] PARAGRAPH style=TOC2: 4.1. Analiz11
[036] PARAGRAPH style=TOC2: 4.2. Gösterim11
[037] PARAGRAPH style=TOC2: 4.3. Muayene11
[038] PARAGRAPH style=TOC2: 4.4. Test11
[039] PARAGRAPH style=TOC2: 4.5. Uygunluk Belgesi12
[040] PARAGRAPH style=TOC1: 5. İZLENEBİLİRLİK MATRİSİ12
[041] PARAGRAPH style=default: 
[042] PARAGRAPH style=Caption: ŞEKİL LİSTESİ
[043] PARAGRAPH style=default: 
[044] PARAGRAPH style=default: 
[045] PARAGRAPH style=Caption: TABLO LİSTESİ
[046] PARAGRAPH style=TableofFigures: Tablo 1 İzlenebilirlik Matrisi12
[047] PARAGRAPH style=TableofFigures: 
[048] PARAGRAPH style=default: 
[049] PARAGRAPH style=Heading1: GENEL
[050] PARAGRAPH style=Heading2: Amaç
[051] PARAGRAPH style=default: {{SEC_AMAC}}
[052] PARAGRAPH style=default: 
[053] PARAGRAPH style=Heading2: Kapsam
[054] PARAGRAPH style=default: {{SEC_KAPSAM}}
[055] PARAGRAPH style=Heading2: Proje Tanıtımı
[056] PARAGRAPH style=default: {{SEC_PROJE_TANITIMI}}
[057] PARAGRAPH style=default: 
[058] PARAGRAPH style=Heading3: Sisteme Genel Bakış
[059] PARAGRAPH style=default: {{SEC_SISTEM_GENEL}}
[060] PARAGRAPH style=Heading3: Ürüne Genel Bakış
[061] PARAGRAPH style=default: {{SEC_URUN_GENEL}}
[062] PARAGRAPH style=Heading2: Kısaltmalar/Tanımlar
[063] PARAGRAPH style=Heading3: Kısaltmalar
[064] PARAGRAPH style=default: {{SEC_KISALTMALAR}}
[065] PARAGRAPH style=default: 
[066] PARAGRAPH style=Heading3: Tanımlar
[067] PARAGRAPH style=default: {{SEC_TANIMLAR}}
[068] PARAGRAPH style=default: 
[069] PARAGRAPH style=Heading2: Uygulanabilir Dokümanlar
[070] PARAGRAPH style=default: {{SEC_UYGULANABILIR_DOKUMANLAR}}
[071] PARAGRAPH style=Heading3: Standartlar
[072] PARAGRAPH style=default: {{SEC_STANDARTLAR}}
[073] PARAGRAPH style=default: 
[074] PARAGRAPH style=Heading3: Diğer Dokümanlar
[075] PARAGRAPH style=default: {{SEC_DIGER_DOKUMANLAR}}
[076] PARAGRAPH style=default: 
[077] PARAGRAPH style=Heading1: SİSTEMİN TANIMLAMASI
[078] PARAGRAPH style=Heading2: Durum ve Modlar
[079] PARAGRAPH style=default: {{SEC_DURUM_MODLAR}}
[080] PARAGRAPH style=Heading2: Ömür Döngüsü
[081] PARAGRAPH style=default: {{SEC_OMUR_DONGUSU}}
[082] PARAGRAPH style=Heading2: Sınırlamalar
[083] PARAGRAPH style=default: {{SEC_SINIRLAMALAR}}
[084] PARAGRAPH style=Heading1: GEREKSİNİMLER
[085] PARAGRAPH style=Heading2: İşlevsel Gereksinimler 
[086] PARAGRAPH style=default: {{REQ_ISLEVSEL}}
[087] PARAGRAPH style=Heading2: Performans Gereksinimleri 
[088] PARAGRAPH style=default: {{REQ_PERFORMANS}}
[089] PARAGRAPH style=Heading2: Fiziksel Gereksinimler 
[090] PARAGRAPH style=default: {{REQ_FIZIKSEL}}
[091] PARAGRAPH style=Heading2: Arayüz Gereksinimleri 
[092] PARAGRAPH style=default: {{REQ_ARAYUZ}}
[093] PARAGRAPH style=Heading2: Çevresel Gereksinimler 
[094] PARAGRAPH style=default: {{REQ_CEVRESEL}}
[095] PARAGRAPH style=Heading2: Emniyet Gereksinimleri 
[096] PARAGRAPH style=default: {{REQ_EMNIYET}}
[097] PARAGRAPH style=Heading2: Entegre Lojistik Destek Gereksinimleri 
[098] PARAGRAPH style=default: {{REQ_ELD}}
[099] PARAGRAPH style=Heading2: Güvenlik ve Gizlilik Gereksinimleri 
[100] PARAGRAPH style=default: {{REQ_GUV_GIZ}}
[101] PARAGRAPH style=Heading2: Ergonomi Gereksinimleri 
[102] PARAGRAPH style=default: {{REQ_ERGONOMI}}
[103] PARAGRAPH style=Heading2: Markalama ve Etiketleme Gereksinimleri 
[104] PARAGRAPH style=default: {{REQ_MARKALAMA}}
[105] PARAGRAPH style=Heading2: Bilgisayar Kaynak Gereksinimleri 
[106] PARAGRAPH style=default: {{REQ_BILGISAYAR}}
[107] PARAGRAPH style=Heading1: GEREKSİNİM DOĞRULAMA YÖNTEMİ
[108] PARAGRAPH style=Heading2: Analiz 
[109] PARAGRAPH style=Heading2: Gösterim 
[110] PARAGRAPH style=Heading2: Muayene 
[111] PARAGRAPH style=Heading2: Test 
[112] PARAGRAPH style=Heading2: Uygunluk Belgesi 
[113] PARAGRAPH style=default: İZLENEBİLİRLİK MATRİSİ
[114] PARAGRAPH style=default: Tablo 1 İzlenebilirlik Matrisi
[115] TABLE
  row 1: GEREKSİNİMNO | İLGİLİ SİSTEM /  / ALT SİSTEM* | DOĞRULAMA YÖNTEMİ | AÇIKLAMA** | GEREKSİNİMİN KAYNAĞI
  row 2: {{TRACE_MATRIX}} |  |   |  |  
[116] PARAGRAPH style=default: 
[117] PARAGRAPH style=default: 
````

## Header / footer metinleri

### word/header1.xml

````text
{{CLASS}}
````

### word/footer2.xml

````text
{{CLASS}}
Gereksinim_Tanımlama_Dokümanı_Şablonu_Rev.0
````

### word/header3.xml

````text

{{SYS}}GEREKSİNİM TANIMLAMA DOKÜMANI



Dok. No 
{{DOCNO}}


Rev. No
{{REV}}


Tarih
{{DATE}}


Sayfa No
12 / 12
Gizlilik Derecesi
{{CLASS}}

Proje/Bölüm
{{PROJ_DEPT}}
````

### word/header2.xml

````text


BELGE NO 
: {{DOCNO}}


GÜNC. NO
: {{REV}}


SAYFA NO
: 2 / 7
PROJE / NO
: {{PROJNO}}
BELGE TİPİ
: GTD
KISIM
:
GİZLİLİK DERECESİ
: {{CLASS}}
````

### word/footer1.xml

````text

{{CLASS}}
Gereksinim_Tanımlama_Dokümanı_Şablonu_Rev.0
````




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



# Acceptance scenarios — NOT_RUN


````csv
test_id,scenario,preconditions,action,expected_result,evidence_required,related_ids,status,actual_result,evidence_location
AT01,Boş formal module,"Görünür, Exclusive Edit, standart izinler",Ana setup çalıştır; klasör ve bilinen trace yolunu ver,"28 tekil başlık, doğru parent, gerekli şema ve iki view; uydurulmuş gereksinim yok",Setup log; nesne/key/parent listesi; view ve attribute tanımları,D02 D03 I01 O01,NOT_RUN,,
AT02,Tekrar çalıştırma,AT01 tamamlandı,Setup iki kez daha çalıştır,Aynı başlık Absolute Number/ID; yeni heading/attribute/view kopyası yok; state history değişikliği ayrıca kaydedilir,Önce/sonra nesne sayısı ve kimlikler; log,D03 I04 O02,NOT_RUN,,
AT03,Filtreli mevcut başlık,Standart başlık filtre dışında,Setup çalıştır,Gizli başlık bulunur; kopyası yaratılmaz,Filtre ve entire nesne listesi; log,D03 O02,NOT_RUN,,
AT04,Tek eksik başlık,Bir standart alt bölüm yok; parent doğru,Setup çalıştır,Yalnız eksik başlık doğru parent/konumda oluşturulur,Başlangıç/sonuç key listesi ve nesne sırası,D03 I01,NOT_RUN,,
AT05,Mükerrer başlık,Aynı key/ad için iki aday,Setup çalıştır,Tahmini seçim/taşıma/yeni kopya yok; dal raporlanır; NEEDS_REVIEW beklenir,İki nesnenin kimliği ve log; final state,D03 I03,NOT_RUN,,
AT06,Yanlış parent,Tek standart başlık yanlış parent altında,Setup; sonra kullanıcı doğru yere taşır ve tekrar setup,İlk run nesneyi koruyup WRONG_PARENT bildirir; ikinci run aynı nesneyi kullanır,Her iki log; aynı Absolute Number; parent before/after,D03 D04 I03,NOT_RUN,,
AT07,Key/ad değişimi,Anahtar atanmış başlık,Serbest yeniden adlandır; başka bilinen bölüm adı; bilinmeyen key durumlarını ayrı dene,Serbest ad key ile aynı hedefe gider; çelişkiler sessizce yeniden eşlenmez,Key/Heading/parent; log; yayın yapı raporu,I02,NOT_RUN,,
AT08,Türkçe ve numaralı başlık,Tanımlı eski alias; Türkçe büyük/küçük harf; elle numara,Ayrı test modüllerinde setup çalıştır,Yalnız desteklenen eşlemeler tanınır; key/başlık tutarlı; bilinmeyen adlar tahmin edilmez,Encoding/locale; başlık ve key listesi,I02 I10 O01,NOT_RUN,,
AT09,Silinmiş başlık,Standart heading soft-delete; aktif eş yok,Setup çalıştır,Silinmiş nesne geri getirilmez; yeni aktif başlık oluşturma ve eski geçmiş korunumu gözlenir,Silinmiş/aktif nesne listesi; log,D03 O02,NOT_RUN,,
AT10,Şema uyuşmazlığı,Yanlış scope/type; gerekli etiketi eksik enum; inherited key,Her çelişki için ayrı setup çalıştır,Ön kontrol değişiklik başlamadan durur; eski tanım/değer korunur,Önce/sonra şema hash/dökümü; log; module history,D03 I02,NOT_RUN,,
AT11,Eski enum ve çoklu doğrulama,Özel Verification Method vocabulary/multi; geçerli Requirement Type/source enum,Setup ve Control görüntüleme,Mevcut enum/sıra/numara/çoklu seçim korunur; Control davranışı ayrıca raporlanır,Attribute/type tanımı before/after; Control çıktısı,D03 I05 O06,NOT_RUN,,
AT12,Yetki ve edit modu,Read-only/baseline; ayrıca attribute/view write yetkisi kısıtlı test kullanıcısı,Setup çalıştır,"Read-only/baseline durur; diğer izin hataları açıklanır, tamamlanmamış iş READY olarak sunulmaz",İzinler; log; kaydedilen modül durumu,O01 O02,NOT_RUN,,
AT13,Kısmi işlem ve retry,Başlık/view/kayıt aşamasında kontrollü hata üretebilen test ortamı,Hata oluştur; gerçek kayıt durumunu incele; neden giderilince tekrar çalıştır,Otomatik rollback varsayımı yok; kısmi durum/log açık; retry kopya üretmeden tamamlar,Öncesi/sonrası/kapat-aç sonucu; log; state,I04 I09 O02,NOT_RUN,,
AT14,Mevcut özel view,Özel Entry/Review; Review Control mevcut veya eksik,Setup çalıştır,Entry korunur; Review diğer sütun/ayarları korunur; Control eklenir/güncellenir,View tanımları before/after; erişim; ekran,D03 I06,NOT_RUN,,
AT15,Control başlığı çakışması,Review iki Control veya Control adlı non-DXL sütun içeriyor,Setup çalıştır,Mevcut içerik ezilmez; review gerekir; çakışma log'a girer,View sütun listesi; log; state,I06,NOT_RUN,,
AT16,Manuel eski gereksinim taşıma,"Kimlik, metin, attribute, incoming/outgoing link ve geçmiş delili alınmış modül",Setup; mevcut gereksinimi aynı modülde doğru bölüm altına taşı,Aynı nesne/Absolute Number/link uçları ve geçmiş kayıtları korunur; yeni hareket kaydı ayrı izlenir,Önce/sonra döküm; Prefix; Control; link listesi,D04 O02,NOT_RUN,,
AT17,Nesne türü ayrımı,Başlık/picture/table/row/cell nesnelerine yanlışlıkla type verilmiş; ayrıca narrative/boş metin,Control ve publisher çalıştır,İçerik nesneleri gereksinim/matris kaydı olmaz; boş/türsüz metin davranışı açıkça değerlendirilir,Control; O/R/Q/X kayıtları; Word çıktı,D06 O11 O12,NOT_RUN,,
AT18,Bölüm dışı gereksinim,Dolu Object Text ve Requirement Type; uygun başlığın kardeşi veya dışarıda,Control ve managed publisher çalıştır,Yerleştirme hatası; managed Word üretimi durur; gerçek parent altına taşıyınca düzelir,Control; structure raporu; çıktı dosyası oluşma durumu,I07,NOT_RUN,,
AT19,Managed yayın kapıları,READY olmayan state; eksik metadata; eksik/mükerrer/yanlış parent/key,Her durumu ayrı yayınla,Yapı kontrolü Word üretimini engeller; anlaşılır rapor; geçici dosya ve hata etkisi izlenir,Log; state; metadata; çıktı kontrolü,I04 I07,NOT_RUN,,
AT20,Altı kaynak tipi,Her source type için geçerli ve geçersiz referans/link örneği,Control ve publisher çalıştır,03_REQUIREMENT_RULES ile tutarlı hata/uyarı; kaynak uyarısı ile yayın engeli ayrımı görünür,Control ve SOURCE_WARNING/SUMMARY; trace matris,D07 I08,NOT_RUN,,
AT21,Trace uçları ve sürümleri,Çoklu outgoing; başka link modülü; yüklenmemiş/silinmiş/erişilemeyen hedef,Publisher; gerekirse hedef modülü farklı sürümde aç,Filtre/yön/status doğru; başarısız çözümleme geçerli trace gibi gizlenmez,X/Q/D kayıtları; hedef ModuleVersion; Word matris,O10 RQ07,NOT_RUN,,
AT22,Unicode ve pipe,"Türkçe tüm harfler, farklı Unicode, &, <, >, çift tırnak, pipe/tab/CRLF metni",DXL ve Windows PS1 ile yayınla,Öngörülen sanitization dışındaki kayıp açıkça saptanır; XML geçerli; locale/encoding kaydedilir,Ham veri dosyası baytları; Windows locale/PS sürümü; DOCX karşılaştırma,I10 O03,NOT_RUN,,
AT23,Görsel/native tablo/uzun içerik,Karışık sıralı metin/gereksinim/görsel/native tablo; uzun hücre/metin,DOCX üret ve gerçek Word ile aç,Beklenen bölüm/sıra/ID/görsel boyut/tablo metni; geçerli paket; görsel sayfa incelemesi,Veri kayıtları; resim dosyaları; Word ekran/PDF; XML kontrol,D05 O03 O11,NOT_RUN,,
AT24,Dosya yolu ve yayın hatası,Boşluk/Türkçe/&/% gibi karakterli izinli test yolu; eksik şablon; salt okunur hedef; mevcut çıktı adı,Publisher ayrı hata/başarı senaryoları,Dosya yolu doğru aktarılır; hata/çıktı durumu dürüst; mevcut dosya üzerine yazma davranışı açıkça kaydedilir,BAT/PS log; exit code; önceki çıktı hash; yeni çıktı,O03,NOT_RUN,,
AT25,Trigger yaşam döngüsü,Doğru current proje; GTD ve GTD olmayan modül; gerekli metadata eksik/tam,Kur/yenile/aç/kaldır; baseline/read-only ayrı dene,Beklenen tek trigger ve uygun form çağrısı; hedef olmayan modüller etkilenmez; hatalar görünür,Trigger listesi/kapsamı; açılış davranışı; log,O13,NOT_RUN,,
AT26,Alanlar ve release eşliği,"Taslak DOCX, sonraki modül değişikliği ve kontrollü release senaryosu",Word alanlarını güncelle; release kaydıyla manuel baseline'ı eşleştir,TOC/page alanları güncellenir; otomatik baseline/rev/tarih artışı yok; release-baseline eşliği için süreç kanıtı ihtiyacı belirlenir,DOCX hash/rev; release kaydı; baseline kimliği ve kapsanan içerik,D09 D10 D11 O04 O05 O08,NOT_RUN,,
````



---

# Current full text sources


### PROJECT_FILES/GTD/GUNCEL/GTD_Setup_Module.dxl

SHA256 (original bytes): `8db1c858798ccbd26f61f5937e41ef5ee5976eb8609a84bc1158b55ed927165d`  
Lines: 996. Line-number prefixes are for review only.

````text
0001 | // GTD_Setup_Module.dxl - DOORS Classic 9.6.1.x
0002 | // Run in the visible target formal module, in Exclusive Edit mode.
0003 | // Creates missing schema, headings and views. Reuses existing heading objects.
0004 | // Never moves/deletes an existing object, changes an enum, or creates a baseline.
0005 | // GTD Template Version is retained as a compatibility marker for the open trigger.
0006 | 
0007 | pragma runLim, 0
0008 | 
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
0031 |         b += c3
0032 |     }
0033 |     string result = stringOf(b)
0034 |     delete(b)
0035 |     return result
0036 | }
0037 | 
0038 | // Replace complete strings: works without assuming one byte per Turkish letter.
0039 | string replaceHeadingToken(string s, string token, string replacement)
0040 | {
0041 |     Buffer b = create
0042 |     int i = 0
0043 |     int n = length(s)
0044 |     int t = length(token)
0045 |     while (i < n) {
0046 |         bool matched = false
0047 |         if (i + t <= n) {
0048 |             string part = s[i:(i + t - 1)]
0049 |             if (part == token) matched = true
0050 |         }
0051 |         if (matched) {
0052 |             b += replacement
0053 |             i = i + t
0054 |         }
0055 |         else {
0056 |             b += s[i:i]
0057 |             i++
0058 |         }
0059 |     }
0060 |     string result = stringOf(b)
0061 |     delete(b)
0062 |     return result
0063 | }
0064 | 
0065 | string compactHeading(string s)
0066 | {
0067 |     string token = ""
0068 |     // Decode complete UTF-8 sequences before single-byte Windows-1254.
0069 |     token = headingBytes(195, 135, -1)
0070 |     s = replaceHeadingToken(s, token, "c")
0071 |     token = headingBytes(195, 167, -1)
0072 |     s = replaceHeadingToken(s, token, "c")
0073 |     token = headingBytes(196, 158, -1)
0074 |     s = replaceHeadingToken(s, token, "g")
0075 |     token = headingBytes(196, 159, -1)
0076 |     s = replaceHeadingToken(s, token, "g")
0077 |     token = headingBytes(196, 176, -1)
0078 |     s = replaceHeadingToken(s, token, "i")
0079 |     token = headingBytes(196, 177, -1)
0080 |     s = replaceHeadingToken(s, token, "i")
0081 |     token = headingBytes(195, 150, -1)
0082 |     s = replaceHeadingToken(s, token, "o")
0083 |     token = headingBytes(195, 182, -1)
0084 |     s = replaceHeadingToken(s, token, "o")
0085 |     token = headingBytes(197, 158, -1)
0086 |     s = replaceHeadingToken(s, token, "s")
0087 |     token = headingBytes(197, 159, -1)
0088 |     s = replaceHeadingToken(s, token, "s")
0089 |     token = headingBytes(195, 156, -1)
0090 |     s = replaceHeadingToken(s, token, "u")
0091 |     token = headingBytes(195, 188, -1)
0092 |     s = replaceHeadingToken(s, token, "u")
0093 |     // Windows Turkish bytes (also covers common Latin-1 letters).
0094 |     token = headingBytes(199, -1, -1)
0095 |     s = replaceHeadingToken(s, token, "c")
0096 |     token = headingBytes(231, -1, -1)
0097 |     s = replaceHeadingToken(s, token, "c")
0098 |     token = headingBytes(208, -1, -1)
0099 |     s = replaceHeadingToken(s, token, "g")
0100 |     token = headingBytes(240, -1, -1)
0101 |     s = replaceHeadingToken(s, token, "g")
0102 |     token = headingBytes(221, -1, -1)
0103 |     s = replaceHeadingToken(s, token, "i")
0104 |     token = headingBytes(253, -1, -1)
0105 |     s = replaceHeadingToken(s, token, "i")
0106 |     token = headingBytes(214, -1, -1)
0107 |     s = replaceHeadingToken(s, token, "o")
0108 |     token = headingBytes(246, -1, -1)
0109 |     s = replaceHeadingToken(s, token, "o")
0110 |     token = headingBytes(222, -1, -1)
0111 |     s = replaceHeadingToken(s, token, "s")
0112 |     token = headingBytes(254, -1, -1)
0113 |     s = replaceHeadingToken(s, token, "s")
0114 |     token = headingBytes(220, -1, -1)
0115 |     s = replaceHeadingToken(s, token, "u")
0116 |     token = headingBytes(252, -1, -1)
0117 |     s = replaceHeadingToken(s, token, "u")
0118 |     token = headingBytes(194, 160, -1)
0119 |     s = replaceHeadingToken(s, token, "")
0120 |     token = headingBytes(226, 128, 175)
0121 |     s = replaceHeadingToken(s, token, "")
0122 |     token = headingBytes(226, 128, 139)
0123 |     s = replaceHeadingToken(s, token, "")
0124 |     token = headingBytes(160, -1, -1)
0125 |     s = replaceHeadingToken(s, token, "")
0126 |     string upperChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
0127 |     string lowerChars = "abcdefghijklmnopqrstuvwxyz"
0128 |     Buffer b = create
0129 |     int i
0130 |     int j
0131 |     int n = length(s)
0132 |     for (i = 0; i < n; i++) {
0133 |         string ch = s[i:i]
0134 |         for (j = 0; j < 26; j++) {
0135 |             if (ch == upperChars[j:j]) {
0136 |                 ch = lowerChars[j:j]
0137 |                 break
0138 |             }
0139 |         }
0140 |         if (ch != " " && ch != "\t" && ch != "\r" && ch != "\n" && ch != ":")
0141 |             b += ch
0142 |     }
0143 |     string result = stringOf(b)
0144 |     delete(b)
0145 |     return result
0146 | }
0147 | 
0148 | bool headingEndsWith(string h, string suffix)
0149 | {
0150 |     string c = compactHeading(h)
0151 |     string s = compactHeading(suffix)
0152 |     int lc = length(c)
0153 |     int ls = length(s)
0154 |     if (ls == 0 || lc < ls) return false
0155 |     string tail = c[(lc - ls):(lc - 1)]
0156 |     if (tail != s) return false
0157 |     // Only a manual numeric prefix may precede a known heading.
0158 |     // An arbitrary heading ending in a known name must not steal its section.
0159 |     int i
0160 |     for (i = 0; i < lc - ls; i++) {
0161 |         string ch = c[i:i]
0162 |         if (ch != "0" && ch != "1" && ch != "2" && ch != "3" && ch != "4" && ch != "5" && ch != "6" && ch != "7" && ch != "8" && ch != "9" && ch != "." && ch != ")" && ch != "(" && ch != "-")
0163 |             return false
0164 |     }
0165 |     return true
0166 | }
0167 | 
0168 | const int GTD_SECTION_COUNT = 28
0169 | string gtdSectionKeys[] = {
0170 |     "ROOT_GENEL",
0171 |     "AMAC",
0172 |     "KAPSAM",
0173 |     "PROJE_TANITIMI",
0174 |     "SISTEM_GENEL",
0175 |     "URUN_GENEL",
0176 |     "GROUP_KISALTMALAR_TANIMLAR",
0177 |     "KISALTMALAR",
0178 |     "TANIMLAR",
0179 |     "UYGULANABILIR_DOKUMANLAR",
0180 |     "STANDARTLAR",
0181 |     "DIGER_DOKUMANLAR",
0182 |     "ROOT_SISTEM_TANIMLAMASI",
0183 |     "DURUM_MODLAR",
0184 |     "OMUR_DONGUSU",
0185 |     "SINIRLAMALAR",
0186 |     "ROOT_GEREKSINIMLER",
0187 |     "REQ_ISLEVSEL",
0188 |     "REQ_PERFORMANS",
0189 |     "REQ_FIZIKSEL",
0190 |     "REQ_ARAYUZ",
0191 |     "REQ_CEVRESEL",
0192 |     "REQ_EMNIYET",
0193 |     "REQ_ELD",
0194 |     "REQ_GUV_GIZ",
0195 |     "REQ_ERGONOMI",
0196 |     "REQ_MARKALAMA",
0197 |     "REQ_BILGISAYAR"
0198 | }
0199 | string gtdSectionHeadings[] = {
0200 |     "GENEL",
0201 |     "Ama" headingBytes(195, 167, -1),
0202 |     "Kapsam",
0203 |     "Proje Tan" headingBytes(196, 177, -1) "t" headingBytes(196, 177, -1) "m" headingBytes(196, 177, -1),
0204 |     "Sisteme Genel Bak" headingBytes(196, 177, -1) headingBytes(197, 159, -1),
0205 |     headingBytes(195, 156, -1) "r" headingBytes(195, 188, -1) "ne Genel Bak" headingBytes(196, 177, -1) headingBytes(197, 159, -1),
0206 |     "K" headingBytes(196, 177, -1) "saltmalar/Tan" headingBytes(196, 177, -1) "mlar",
0207 |     "K" headingBytes(196, 177, -1) "saltmalar",
0208 |     "Tan" headingBytes(196, 177, -1) "mlar",
0209 |     "Uygulanabilir Dok" headingBytes(195, 188, -1) "manlar",
0210 |     "Standartlar",
0211 |     "Di" headingBytes(196, 159, -1) "er Dok" headingBytes(195, 188, -1) "manlar",
0212 |     "S" headingBytes(196, 176, -1) "STEM" headingBytes(196, 176, -1) "N TANIMLAMASI",
0213 |     "Durum ve Modlar",
0214 |     headingBytes(195, 150, -1) "m" headingBytes(195, 188, -1) "r D" headingBytes(195, 182, -1) "ng" headingBytes(195, 188, -1) "s" headingBytes(195, 188, -1),
0215 |     "S" headingBytes(196, 177, -1) "n" headingBytes(196, 177, -1) "rlamalar",
0216 |     "GEREKS" headingBytes(196, 176, -1) "N" headingBytes(196, 176, -1) "MLER",
0217 |     headingBytes(196, 176, -1) headingBytes(197, 159, -1) "levsel Gereksinimler",
0218 |     "Performans Gereksinimleri",
0219 |     "Fiziksel Gereksinimler",
0220 |     "Aray" headingBytes(195, 188, -1) "z Gereksinimleri",
0221 |     headingBytes(195, 135, -1) "evresel Gereksinimler",
0222 |     "Emniyet Gereksinimleri",
0223 |     "Entegre Lojistik Destek Gereksinimleri",
0224 |     "G" headingBytes(195, 188, -1) "venlik ve Gizlilik Gereksinimleri",
0225 |     "Ergonomi Gereksinimleri",
0226 |     "Markalama ve Etiketleme Gereksinimleri",
0227 |     "Bilgisayar Kaynak Gereksinimleri"
0228 | }
0229 | int gtdSectionParents[] = {-1, 0, 0, 0, 3, 3, 0, 6, 6, 0, 9, 9, -1, 12, 12, 12, -1, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16}
0230 | string sectionKeyForHeading(string h)
0231 | {
0232 |     if (headingEndsWith(h, "amac")) return "AMAC"
0233 |     if (headingEndsWith(h, "kapsam")) return "KAPSAM"
0234 |     if (headingEndsWith(h, "projetanimi")) return "PROJE_TANITIMI"
0235 |     if (headingEndsWith(h, "projetanitimi")) return "PROJE_TANITIMI"
0236 |     if (headingEndsWith(h, "sistemegenelbakis")) return "SISTEM_GENEL"
0237 |     if (headingEndsWith(h, "urunegenelbakis")) return "URUN_GENEL"
0238 |     if (headingEndsWith(h, "kisaltmalar")) return "KISALTMALAR"
0239 |     if (headingEndsWith(h, "tanimlar")) return "TANIMLAR"
0240 |     if (headingEndsWith(h, "uygulanabilirdokumanlar")) return "UYGULANABILIR_DOKUMANLAR"
0241 |     if (headingEndsWith(h, "standartlar")) return "STANDARTLAR"
0242 |     if (headingEndsWith(h, "digerdokumanlar")) return "DIGER_DOKUMANLAR"
0243 |     if (headingEndsWith(h, "durumvemodlar")) return "DURUM_MODLAR"
0244 |     if (headingEndsWith(h, "omurdongusu")) return "OMUR_DONGUSU"
0245 |     if (headingEndsWith(h, "sinirlamalar")) return "SINIRLAMALAR"
0246 | 
0247 |     if (headingEndsWith(h, "islevselgereksinimleri")) return "REQ_ISLEVSEL"
0248 |     if (headingEndsWith(h, "islevselgereksinimler")) return "REQ_ISLEVSEL"
0249 |     if (headingEndsWith(h, "performansgereksinimleri")) return "REQ_PERFORMANS"
0250 |     if (headingEndsWith(h, "fizikselgereksinimler")) return "REQ_FIZIKSEL"
0251 |     if (headingEndsWith(h, "arayuzgereksinimleri")) return "REQ_ARAYUZ"
0252 |     if (headingEndsWith(h, "cevreselgereksinimler")) return "REQ_CEVRESEL"
0253 |     if (headingEndsWith(h, "emniyetgereksinimleri")) return "REQ_EMNIYET"
0254 |     if (headingEndsWith(h, "entegrelojistikdestekgereksinimleri")) return "REQ_ELD"
0255 |     if (headingEndsWith(h, "guvenlikvegizlilikgereksinimleri")) return "REQ_GUV_GIZ"
0256 |     if (headingEndsWith(h, "ergonomigereksinimleri")) return "REQ_ERGONOMI"
0257 |     if (headingEndsWith(h, "markalamaveetiketlemegereksinimleri")) return "REQ_MARKALAMA"
0258 |     if (headingEndsWith(h, "bilgisayarkaynakgereksinimleri")) return "REQ_BILGISAYAR"
0259 | 
0260 |     if (headingEndsWith(h, "genel")) return "ROOT_GENEL"
0261 |     if (headingEndsWith(h, "kisaltmalar/tanimlar")) return "GROUP_KISALTMALAR_TANIMLAR"
0262 |     if (headingEndsWith(h, "kisaltmalarvetanimlar")) return "GROUP_KISALTMALAR_TANIMLAR"
0263 |     if (headingEndsWith(h, "sistemintanimlamasi")) return "ROOT_SISTEM_TANIMLAMASI"
0264 |     if (headingEndsWith(h, "sistemintanimi")) return "ROOT_SISTEM_TANIMLAMASI"
0265 |     if (headingEndsWith(h, "gereksinimler")) return "ROOT_GEREKSINIMLER"
0266 |     return ""
0267 | }
0268 | 
0269 | bool isContentSection(string k)
0270 | {
0271 |     if (k == "AMAC") return true
0272 |     if (k == "KAPSAM") return true
0273 |     if (k == "PROJE_TANITIMI") return true
0274 |     if (k == "SISTEM_GENEL") return true
0275 |     if (k == "URUN_GENEL") return true
0276 |     if (k == "KISALTMALAR") return true
0277 |     if (k == "TANIMLAR") return true
0278 |     if (k == "UYGULANABILIR_DOKUMANLAR") return true
0279 |     if (k == "STANDARTLAR") return true
0280 |     if (k == "DIGER_DOKUMANLAR") return true
0281 |     if (k == "DURUM_MODLAR") return true
0282 |     if (k == "OMUR_DONGUSU") return true
0283 |     if (k == "SINIRLAMALAR") return true
0284 | 
0285 |     if (k == "REQ_ISLEVSEL") return true
0286 |     if (k == "REQ_PERFORMANS") return true
0287 |     if (k == "REQ_FIZIKSEL") return true
0288 |     if (k == "REQ_ARAYUZ") return true
0289 |     if (k == "REQ_CEVRESEL") return true
0290 |     if (k == "REQ_EMNIYET") return true
0291 |     if (k == "REQ_ELD") return true
0292 |     if (k == "REQ_GUV_GIZ") return true
0293 |     if (k == "REQ_ERGONOMI") return true
0294 |     if (k == "REQ_MARKALAMA") return true
0295 |     if (k == "REQ_BILGISAYAR") return true
0296 | 
0297 |     return false
0298 | }
0299 | 
0300 | bool isRequirementSection(string k)
0301 | {
0302 |     if (k == "REQ_ISLEVSEL") return true
0303 |     if (k == "REQ_PERFORMANS") return true
0304 |     if (k == "REQ_FIZIKSEL") return true
0305 |     if (k == "REQ_ARAYUZ") return true
0306 |     if (k == "REQ_CEVRESEL") return true
0307 |     if (k == "REQ_EMNIYET") return true
0308 |     if (k == "REQ_ELD") return true
0309 |     if (k == "REQ_GUV_GIZ") return true
0310 |     if (k == "REQ_ERGONOMI") return true
0311 |     if (k == "REQ_MARKALAMA") return true
0312 |     if (k == "REQ_BILGISAYAR") return true
0313 |     return false
0314 | }
0315 | 
0316 | 
0317 | int gtdSectionIndex(string key)
0318 | {
0319 |     int i
0320 |     for (i = 0; i < GTD_SECTION_COUNT; i++)
0321 |         if (gtdSectionKeys[i] == key) return i
0322 |     return -1
0323 | }
0324 | 
0325 | bool gtdBlank(string s)
0326 | {
0327 |     int i
0328 |     for (i = 0; i < length(s); i++) {
0329 |         string c = s[i:i]
0330 |         if (c != " " && c != "\t" && c != "\r" && c != "\n") return false
0331 |     }
0332 |     return true
0333 | }
0334 | 
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
0393 | string gtdRequirementTypes[] = {
0394 |     headingBytes(196, 176, -1) headingBytes(197, 159, -1) "levsel",
0395 |     "Performans",
0396 |     "Fiziksel",
0397 |     "Aray" headingBytes(195, 188, -1) "z",
0398 |     headingBytes(195, 135, -1) "evresel",
0399 |     "Emniyet",
0400 |     "Entegre Lojistik Destek",
0401 |     "G" headingBytes(195, 188, -1) "venlik ve Gizlilik",
0402 |     "Ergonomi",
0403 |     "Markalama ve Etiketleme",
0404 |     "Bilgisayar Kaynak"
0405 | }
0406 | string gtdVerificationMethods[] = {
0407 |     "Analiz",
0408 |     "G" headingBytes(195, 182, -1) "sterim",
0409 |     "Muayene",
0410 |     "Test",
0411 |     "Uygunluk Belgesi"
0412 | }
0413 | 
0414 | string gtdSourceTypes[] = {
0415 |     "Higher-Level Requirement", "Derived", "Standard / Regulation",
0416 |     "Interface", "Safety Analysis", "Other"
0417 | }
0418 | string gtdModuleStrings[] = {
0419 |     "System Name", "Document Number", "Document Revision", "Project Name",
0420 |     "Project Number", "Department", "Work Package", "SDVIL Number",
0421 |     "Classification", "GTD Template Version", "GTD Form Path",
0422 |     "GTD Word Template Path", "GTD Publisher Script Path", "GTD Trace Link Module",
0423 |     "GTD Tool Folder", "GTD Setup State"
0424 | }
0425 | string gtdObjectTexts[] = {
0426 |     "Verification Reference", "Rationale", "Remarks", "Traceability Note"
0427 | }
0428 | 
0429 | string gtdLogPath = tempFileName() "_GTD_Setup_Log.txt"
0430 | Stream gtdLogStream = write(gtdLogPath)
0431 | if (null gtdLogStream) {
0432 |     ack "Setup log dosyasi acilamadi. Degisiklik yapilmadi."
0433 |     halt
0434 | }
0435 | int gtdCreatedAttrs = 0
0436 | int gtdCreatedHeadings = 0
0437 | int gtdReusedHeadings = 0
0438 | int gtdBlockedHeadings = 0
0439 | int gtdCreatedViews = 0
0440 | int gtdUpdatedViews = 0
0441 | int gtdSchemaErrors = 0
0442 | int gtdReviewNeeded = 0
0443 | bool gtdMutationStarted = false
0444 | 
0445 | void gtdLog(string text)
0446 | {
0447 |     gtdLogStream << text << "\n"
0448 |     print text "\n"
0449 | }
0450 | 
0451 | void gtdFail(string message)
0452 | {
0453 |     if (gtdMutationStarted) {
0454 |         AttrDef stateDef = find(gtdSetupModule, "GTD Setup State")
0455 |         if (!null stateDef && stateDef.module) {
0456 |             noError()
0457 |             gtdSetupModule."GTD Setup State" = "INCOMPLETE"
0458 |             string stateErr = lastError()
0459 |             if (!gtdBlank(stateErr)) gtdLog("STATE_UPDATE_FAILED | " stateErr)
0460 |         }
0461 |     }
0462 |     gtdLog("STOP | " message)
0463 |     close(gtdLogStream)
0464 |     ack "GTD setup tamamlanamadi.\n" message "\n\nLog:\n" gtdLogPath
0465 |     halt
0466 | }
0467 | 
0468 | string gtdReadModuleString(string name)
0469 | {
0470 |     AttrDef ad = find(gtdSetupModule, name)
0471 |     if (null ad || !ad.module) return ""
0472 |     return gtdSetupModule.(name) ""
0473 | }
0474 | 
0475 | string gtdTrim(string s)
0476 | {
0477 |     int a = 0
0478 |     int z = length(s) - 1
0479 |     while (a <= z && gtdBlank(s[a:a])) a++
0480 |     while (z >= a && gtdBlank(s[z:z])) z--
0481 |     if (z < a) return ""
0482 |     return s[a:z]
0483 | }
0484 | 
0485 | string gtdFolderOf(string path)
0486 | {
0487 |     int i
0488 |     for (i = length(path)-1; i >= 0; i--)
0489 |         if (path[i:i] == "\\" || path[i:i] == "/") {
0490 |             if (i == 0) return path[0:0]
0491 |             return path[0:i-1]
0492 |         }
0493 |     return ""
0494 | }
0495 | 
0496 | bool gtdTextType(AttrType at)
0497 | {
0498 |     if (null at) return false
0499 |     return at.type == attrString || at.type == attrText
0500 | }
0501 | 
0502 | // Only validation here. All schema conflicts are collected before any mutation.
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
0635 | // Capture the folder of the current package. Existing configured paths are retained.
0636 | string gtdFolder = gtdReadModuleString("GTD Tool Folder")
0637 | if (gtdBlank(gtdFolder)) gtdFolder = gtdFolderOf(gtdReadModuleString("GTD Publisher Script Path"))
0638 | string gtdTracePath = gtdReadModuleString("GTD Trace Link Module")
0639 | bool gtdProceed = false
0640 | DB gtdSetupDb = create("GTD Modul Kurulumu", styleCentered | styleStandard)
0641 | label(gtdSetupDb, "GUNCEL klasorunun tam yolunu girin. Mevcut dosya yolu attribute'lari korunur.")
0642 | DBE gtdFolderField = field(gtdSetupDb, "GTD dosyalarinin klasoru:", gtdFolder, 65, false)
0643 | DBE gtdTraceField = field(gtdSetupDb, "Kaynak link modulu (tam DOORS yolu):", gtdTracePath, 65, false)
0644 | label(gtdSetupDb, "Link modulu henuz belirlenmediyse bos birakilabilir; yayin oncesinde doldurulur.")
0645 | 
0646 | void gtdAcceptSetup(DB db)
0647 | {
0648 |     gtdFolder = gtdTrim(get(gtdFolderField))
0649 |     if (gtdBlank(gtdFolder)) {
0650 |         warningBox "GTD dosyalarinin klasor yolunu girin."
0651 |         return
0652 |     }
0653 |     string enteredTrace = gtdTrim(get(gtdTraceField))
0654 |     if (!gtdBlank(enteredTrace) && enteredTrace[0:0] != "/") {
0655 |         warningBox "Kaynak link modulu / ile baslayan tam DOORS yolu olmali."
0656 |         return
0657 |     }
0658 |     if (gtdBlank(gtdTracePath)) gtdTracePath = enteredTrace
0659 |     else if (enteredTrace != gtdTracePath) {
0660 |         warningBox "Mevcut GTD Trace Link Module degeri korunur. Degistirmek icin module attribute'unu duzenleyin."
0661 |         return
0662 |     }
0663 |     gtdProceed = true
0664 |     release db
0665 | }
0666 | 
0667 | void gtdCancelSetup(DB db)
0668 | {
0669 |     release db
0670 | }
0671 | 
0672 | ok(gtdSetupDb, "Kurulumu calistir", gtdAcceptSetup)
0673 | close(gtdSetupDb, true, gtdCancelSetup)
0674 | realize gtdSetupDb
0675 | block gtdSetupDb
0676 | destroy gtdSetupDb
0677 | if (!gtdProceed) {
0678 |     gtdLog("CANCELLED | No module changes were made.")
0679 |     close(gtdLogStream)
0680 |     halt
0681 | }
0682 | current = gtdSetupModule
0683 | if (baseline(gtdSetupModule) || !isEdit(gtdSetupModule)) gtdFail("Module is no longer editable.")
0684 | 
0685 | int gtdLast = length(gtdFolder)-1
0686 | while (gtdLast >= 0 && (gtdFolder[gtdLast:gtdLast] == "\\" || gtdFolder[gtdLast:gtdLast] == "/")) gtdLast--
0687 | if (gtdLast < 0) gtdFail("Invalid tool folder.")
0688 | gtdFolder = gtdFolder[0:gtdLast]
0689 | string gtdFormPath = gtdReadModuleString("GTD Form Path")
0690 | string gtdTemplatePath = gtdReadModuleString("GTD Word Template Path")
0691 | string gtdBuilderPath = gtdReadModuleString("GTD Publisher Script Path")
0692 | if (gtdBlank(gtdFormPath)) gtdFormPath = gtdFolder "\\GTD_Module_Info.dxl"
0693 | if (gtdBlank(gtdTemplatePath)) gtdTemplatePath = gtdFolder "\\TPL_GTD_Publisher.docx"
0694 | if (gtdBlank(gtdBuilderPath)) gtdBuilderPath = gtdFolder "\\GTD_Build_Document.ps1"
0695 | string gtdControlPath = gtdFolder "\\GTD_Requirement_Review_Control.dxl"
0696 | if (!fileExists_(gtdFormPath)) gtdFail("FILE_MISSING | " gtdFormPath)
0697 | if (!fileExists_(gtdTemplatePath)) gtdFail("FILE_MISSING | " gtdTemplatePath)
0698 | if (!fileExists_(gtdBuilderPath)) gtdFail("FILE_MISSING | " gtdBuilderPath)
0699 | if (!fileExists_(gtdControlPath)) gtdFail("FILE_MISSING | " gtdControlPath)
0700 | string gtdControlCode = readFile(gtdControlPath)
0701 | if (gtdBlank(gtdControlCode)) gtdFail("Control DXL could not be read.")
0702 | 
0703 | // Create the internal state first. Any interrupted run remains visibly incomplete.
0704 | gtdEnsureAttribute("GTD Setup State", true, "String")
0705 | gtdMutationStarted = true
0706 | gtdSetModuleString("GTD Setup State", "INCOMPLETE", false)
0707 | for (gtdI = 0; gtdI < 16; gtdI++) gtdEnsureAttribute(gtdModuleStrings[gtdI], true, "String")
0708 | gtdEnsureAttribute("Document Date", true, "Date")
0709 | for (gtdI = 0; gtdI < 4; gtdI++) gtdEnsureAttribute(gtdObjectTexts[gtdI], false, "Text")
0710 | gtdEnsureAttribute("Requirement Source Reference", false, "String")
0711 | gtdEnsureAttribute("GTD Section Key", false, "String")
0712 | gtdEnsureEnumeration("Requirement Type", "GTD Requirement Type", gtdRequirementTypes, 11)
0713 | gtdEnsureEnumeration("Verification Method", "GTD Verification Method", gtdVerificationMethods, 5)
0714 | gtdEnsureEnumeration("Requirement Source Type", "GTD Requirement Source Type", gtdSourceTypes, 6)
0715 | gtdSetModuleString("GTD Template Version", "GTD_SETUP", true)
0716 | gtdSetModuleString("GTD Form Path", gtdFormPath, true)
0717 | gtdSetModuleString("GTD Word Template Path", gtdTemplatePath, true)
0718 | gtdSetModuleString("GTD Publisher Script Path", gtdBuilderPath, true)
0719 | gtdSetModuleString("GTD Trace Link Module", gtdTracePath, true)
0720 | gtdSetModuleString("GTD Tool Folder", gtdFolder, false)
0721 | 
0722 | // Scan the whole module, including objects hidden by a filter or outline.
0723 | Object gtdCandidates[GTD_SECTION_COUNT]
0724 | Object gtdResolved[GTD_SECTION_COUNT]
0725 | int gtdCandidateCount[GTD_SECTION_COUNT]
0726 | bool gtdIdentityConflict[GTD_SECTION_COUNT]
0727 | for (gtdI = 0; gtdI < GTD_SECTION_COUNT; gtdI++) {
0728 |     gtdCandidates[gtdI] = null
0729 |     gtdResolved[gtdI] = null
0730 |     gtdCandidateCount[gtdI] = 0
0731 |     gtdIdentityConflict[gtdI] = false
0732 | }
0733 | Object gtdScan
0734 | for gtdScan in entire gtdSetupModule do {
0735 |     if (isDeleted(gtdScan)) continue
0736 |     string issue = gtdSectionIdentityIssue(gtdScan)
0737 |     if (issue != "") {
0738 |         gtdReviewNeeded++
0739 |         gtdLog("IDENTITY_CONFLICT | " identifier(gtdScan) " | " issue)
0740 |         int storedIndex = gtdSectionIndex(gtdStoredSectionKey(gtdScan))
0741 |         if (storedIndex >= 0) gtdIdentityConflict[storedIndex] = true
0742 |         if (!table(gtdScan) && !row(gtdScan) && !cell(gtdScan)) {
0743 |             int titleIndex = gtdSectionIndex(sectionKeyForHeading(gtdScan."Object Heading" ""))
0744 |             if (titleIndex >= 0) gtdIdentityConflict[titleIndex] = true
0745 |         }
0746 |     }
0747 |     string key = sectionKeyForObject(gtdScan)
0748 |     int idx = gtdSectionIndex(key)
0749 |     if (idx >= 0) {
0750 |         gtdCandidateCount[idx]++
0751 |         gtdCandidates[idx] = gtdScan
0752 |         gtdLog("FOUND_HEADING | " key " | " identifier(gtdScan))
0753 |     }
0754 | }
0755 | 
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
0832 | 
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
0961 | noError()
0962 | bool gtdReviewLoaded = load(view("Requirement Review"))
0963 | string gtdReviewLoadError = lastError()
0964 | if (!gtdReviewLoaded || !gtdBlank(gtdReviewLoadError)) gtdFail("Requirement Review view could not be loaded.")
0965 | string gtdFinalState = "READY"
0966 | if (gtdBlockedHeadings > 0 || gtdReviewNeeded > 0) gtdFinalState = "NEEDS_REVIEW"
0967 | gtdSetModuleString("GTD Setup State", gtdFinalState, false)
0968 | noError()
0969 | save(gtdSetupModule)
0970 | string gtdSaveError = lastError()
0971 | if (!gtdBlank(gtdSaveError)) gtdFail("MODULE_SAVE_FAILED | " gtdSaveError)
0972 | gtdLog("SUMMARY | state=" gtdFinalState " | attributes created=" gtdCreatedAttrs " | headings created=" gtdCreatedHeadings " | headings reused=" gtdReusedHeadings " | headings blocked=" gtdBlockedHeadings " | views created=" gtdCreatedViews " | views updated=" gtdUpdatedViews)
0973 | gtdLog("Move existing requirements as existing objects under the proper headings; fill missing values manually.")
0974 | gtdLog("No baseline was created. Document Revision, Document Date and Prefix were not assigned by setup.")
0975 | close(gtdLogStream)
0976 | ack "GTD setup tamamlandi.\nDurum: " gtdFinalState "\n\nOlusturulan baslik: " gtdCreatedHeadings "\nKullanilan mevcut baslik: " gtdReusedHeadings "\nCozum bekleyen baslik: " gtdBlockedHeadings "\n\nLog:\n" gtdLogPath "\n\nGereksinimleri uygun basliklarin altina mevcut nesneleriyle tasiyin."
0977 | 
0978 | // The metadata dialog is part of the same entry-point run when data is missing.
0979 | // It saves only on the user's Kaydet action, using the existing project form.
0980 | bool gtdInfoMissing = gtdBlank(gtdReadModuleString("System Name")) ||
0981 |     gtdBlank(gtdReadModuleString("Document Number")) ||
0982 |     gtdBlank(gtdReadModuleString("Document Revision")) ||
0983 |     gtdBlank(gtdReadModuleString("Project Name")) ||
0984 |     gtdBlank(gtdReadModuleString("Project Number")) ||
0985 |     gtdBlank(gtdReadModuleString("Department")) ||
0986 |     gtdBlank(gtdReadModuleString("Classification")) ||
0987 |     gtdBlank(gtdSetupModule."Prefix" "")
0988 | Date gtdInfoDate = gtdSetupModule."Document Date"
0989 | if (null gtdInfoDate) gtdInfoMissing = true
0990 | if (gtdInfoMissing && gtdFinalState == "READY") {
0991 |     string formCode = readFile(gtdFormPath)
0992 |     if (!gtdBlank(formCode)) {
0993 |         string formError = eval_(formCode)
0994 |         if (!gtdBlank(formError)) ack "GTD_Module_Info formu calistirilamadi:\n" formError
0995 |     }
0996 | }
````


### PROJECT_FILES/GTD/GUNCEL/GTD_Requirement_Review_Control.dxl

SHA256 (original bytes): `016bd67910b1398ecebe1b091f292e6c4325785c3441fbb060c7640642d44a11`  
Lines: 585. Line-number prefixes are for review only.

````text
0001 | // ============================================================
0002 | // GTD Requirement Review - Control Layout DXL
0003 | //
0004 | // Checks:
0005 | //   1) Requirement Type exists and matches containing section
0006 | //   2) Verification Method exists
0007 | //   3) Requirement source definition is consistent
0008 | //
0009 | // Non-requirement objects are ignored:
0010 | //   - picture objects
0011 | //   - native tables / rows / cells
0012 | //   - headings / objects without Object Text
0013 | //   - untyped narrative outside requirement sections
0014 | //
0015 | // Source rules:
0016 | //   Higher-Level Requirement -> source trace link required
0017 | //   Derived                  -> source trace link must NOT exist
0018 | //   Standard / Regulation    -> Requirement Source Reference required
0019 | //   Interface                -> Requirement Source Reference required
0020 | //   Safety Analysis          -> Requirement Source Reference required
0021 | //   Other                    -> Requirement Source Reference required
0022 | // ============================================================
0023 | 
0024 | pragma runLim, 0
0025 | 
0026 | // ------------------------------------------------------------
0027 | // Encoding-safe Turkish heading normalization copied from the
0028 | // GTD publisher logic. Source code remains ASCII-only.
0029 | // ------------------------------------------------------------
0030 | // BEGIN GTD SECTION MODEL - keep identical in setup, publisher and Control.
0031 | string headingBytes(int first, int second, int third)
0032 | {
0033 |     Buffer b = create
0034 |     char c1 = charOf(first)
0035 |     b += c1
0036 |     if (second >= 0) {
0037 |         char c2 = charOf(second)
0038 |         b += c2
0039 |     }
0040 |     if (third >= 0) {
0041 |         char c3 = charOf(third)
0042 |         b += c3
0043 |     }
0044 |     string result = stringOf(b)
0045 |     delete(b)
0046 |     return result
0047 | }
0048 | 
0049 | // Replace complete strings: works without assuming one byte per Turkish letter.
0050 | string replaceHeadingToken(string s, string token, string replacement)
0051 | {
0052 |     Buffer b = create
0053 |     int i = 0
0054 |     int n = length(s)
0055 |     int t = length(token)
0056 |     while (i < n) {
0057 |         bool matched = false
0058 |         if (i + t <= n) {
0059 |             string part = s[i:(i + t - 1)]
0060 |             if (part == token) matched = true
0061 |         }
0062 |         if (matched) {
0063 |             b += replacement
0064 |             i = i + t
0065 |         }
0066 |         else {
0067 |             b += s[i:i]
0068 |             i++
0069 |         }
0070 |     }
0071 |     string result = stringOf(b)
0072 |     delete(b)
0073 |     return result
0074 | }
0075 | 
0076 | string compactHeading(string s)
0077 | {
0078 |     string token = ""
0079 |     // Decode complete UTF-8 sequences before single-byte Windows-1254.
0080 |     token = headingBytes(195, 135, -1)
0081 |     s = replaceHeadingToken(s, token, "c")
0082 |     token = headingBytes(195, 167, -1)
0083 |     s = replaceHeadingToken(s, token, "c")
0084 |     token = headingBytes(196, 158, -1)
0085 |     s = replaceHeadingToken(s, token, "g")
0086 |     token = headingBytes(196, 159, -1)
0087 |     s = replaceHeadingToken(s, token, "g")
0088 |     token = headingBytes(196, 176, -1)
0089 |     s = replaceHeadingToken(s, token, "i")
0090 |     token = headingBytes(196, 177, -1)
0091 |     s = replaceHeadingToken(s, token, "i")
0092 |     token = headingBytes(195, 150, -1)
0093 |     s = replaceHeadingToken(s, token, "o")
0094 |     token = headingBytes(195, 182, -1)
0095 |     s = replaceHeadingToken(s, token, "o")
0096 |     token = headingBytes(197, 158, -1)
0097 |     s = replaceHeadingToken(s, token, "s")
0098 |     token = headingBytes(197, 159, -1)
0099 |     s = replaceHeadingToken(s, token, "s")
0100 |     token = headingBytes(195, 156, -1)
0101 |     s = replaceHeadingToken(s, token, "u")
0102 |     token = headingBytes(195, 188, -1)
0103 |     s = replaceHeadingToken(s, token, "u")
0104 |     // Windows Turkish bytes (also covers common Latin-1 letters).
0105 |     token = headingBytes(199, -1, -1)
0106 |     s = replaceHeadingToken(s, token, "c")
0107 |     token = headingBytes(231, -1, -1)
0108 |     s = replaceHeadingToken(s, token, "c")
0109 |     token = headingBytes(208, -1, -1)
0110 |     s = replaceHeadingToken(s, token, "g")
0111 |     token = headingBytes(240, -1, -1)
0112 |     s = replaceHeadingToken(s, token, "g")
0113 |     token = headingBytes(221, -1, -1)
0114 |     s = replaceHeadingToken(s, token, "i")
0115 |     token = headingBytes(253, -1, -1)
0116 |     s = replaceHeadingToken(s, token, "i")
0117 |     token = headingBytes(214, -1, -1)
0118 |     s = replaceHeadingToken(s, token, "o")
0119 |     token = headingBytes(246, -1, -1)
0120 |     s = replaceHeadingToken(s, token, "o")
0121 |     token = headingBytes(222, -1, -1)
0122 |     s = replaceHeadingToken(s, token, "s")
0123 |     token = headingBytes(254, -1, -1)
0124 |     s = replaceHeadingToken(s, token, "s")
0125 |     token = headingBytes(220, -1, -1)
0126 |     s = replaceHeadingToken(s, token, "u")
0127 |     token = headingBytes(252, -1, -1)
0128 |     s = replaceHeadingToken(s, token, "u")
0129 |     token = headingBytes(194, 160, -1)
0130 |     s = replaceHeadingToken(s, token, "")
0131 |     token = headingBytes(226, 128, 175)
0132 |     s = replaceHeadingToken(s, token, "")
0133 |     token = headingBytes(226, 128, 139)
0134 |     s = replaceHeadingToken(s, token, "")
0135 |     token = headingBytes(160, -1, -1)
0136 |     s = replaceHeadingToken(s, token, "")
0137 |     string upperChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
0138 |     string lowerChars = "abcdefghijklmnopqrstuvwxyz"
0139 |     Buffer b = create
0140 |     int i
0141 |     int j
0142 |     int n = length(s)
0143 |     for (i = 0; i < n; i++) {
0144 |         string ch = s[i:i]
0145 |         for (j = 0; j < 26; j++) {
0146 |             if (ch == upperChars[j:j]) {
0147 |                 ch = lowerChars[j:j]
0148 |                 break
0149 |             }
0150 |         }
0151 |         if (ch != " " && ch != "\t" && ch != "\r" && ch != "\n" && ch != ":")
0152 |             b += ch
0153 |     }
0154 |     string result = stringOf(b)
0155 |     delete(b)
0156 |     return result
0157 | }
0158 | 
0159 | bool headingEndsWith(string h, string suffix)
0160 | {
0161 |     string c = compactHeading(h)
0162 |     string s = compactHeading(suffix)
0163 |     int lc = length(c)
0164 |     int ls = length(s)
0165 |     if (ls == 0 || lc < ls) return false
0166 |     string tail = c[(lc - ls):(lc - 1)]
0167 |     if (tail != s) return false
0168 |     // Only a manual numeric prefix may precede a known heading.
0169 |     // An arbitrary heading ending in a known name must not steal its section.
0170 |     int i
0171 |     for (i = 0; i < lc - ls; i++) {
0172 |         string ch = c[i:i]
0173 |         if (ch != "0" && ch != "1" && ch != "2" && ch != "3" && ch != "4" && ch != "5" && ch != "6" && ch != "7" && ch != "8" && ch != "9" && ch != "." && ch != ")" && ch != "(" && ch != "-")
0174 |             return false
0175 |     }
0176 |     return true
0177 | }
0178 | 
0179 | const int GTD_SECTION_COUNT = 28
0180 | string gtdSectionKeys[] = {
0181 |     "ROOT_GENEL",
0182 |     "AMAC",
0183 |     "KAPSAM",
0184 |     "PROJE_TANITIMI",
0185 |     "SISTEM_GENEL",
0186 |     "URUN_GENEL",
0187 |     "GROUP_KISALTMALAR_TANIMLAR",
0188 |     "KISALTMALAR",
0189 |     "TANIMLAR",
0190 |     "UYGULANABILIR_DOKUMANLAR",
0191 |     "STANDARTLAR",
0192 |     "DIGER_DOKUMANLAR",
0193 |     "ROOT_SISTEM_TANIMLAMASI",
0194 |     "DURUM_MODLAR",
0195 |     "OMUR_DONGUSU",
0196 |     "SINIRLAMALAR",
0197 |     "ROOT_GEREKSINIMLER",
0198 |     "REQ_ISLEVSEL",
0199 |     "REQ_PERFORMANS",
0200 |     "REQ_FIZIKSEL",
0201 |     "REQ_ARAYUZ",
0202 |     "REQ_CEVRESEL",
0203 |     "REQ_EMNIYET",
0204 |     "REQ_ELD",
0205 |     "REQ_GUV_GIZ",
0206 |     "REQ_ERGONOMI",
0207 |     "REQ_MARKALAMA",
0208 |     "REQ_BILGISAYAR"
0209 | }
0210 | string gtdSectionHeadings[] = {
0211 |     "GENEL",
0212 |     "Ama" headingBytes(195, 167, -1),
0213 |     "Kapsam",
0214 |     "Proje Tan" headingBytes(196, 177, -1) "t" headingBytes(196, 177, -1) "m" headingBytes(196, 177, -1),
0215 |     "Sisteme Genel Bak" headingBytes(196, 177, -1) headingBytes(197, 159, -1),
0216 |     headingBytes(195, 156, -1) "r" headingBytes(195, 188, -1) "ne Genel Bak" headingBytes(196, 177, -1) headingBytes(197, 159, -1),
0217 |     "K" headingBytes(196, 177, -1) "saltmalar/Tan" headingBytes(196, 177, -1) "mlar",
0218 |     "K" headingBytes(196, 177, -1) "saltmalar",
0219 |     "Tan" headingBytes(196, 177, -1) "mlar",
0220 |     "Uygulanabilir Dok" headingBytes(195, 188, -1) "manlar",
0221 |     "Standartlar",
0222 |     "Di" headingBytes(196, 159, -1) "er Dok" headingBytes(195, 188, -1) "manlar",
0223 |     "S" headingBytes(196, 176, -1) "STEM" headingBytes(196, 176, -1) "N TANIMLAMASI",
0224 |     "Durum ve Modlar",
0225 |     headingBytes(195, 150, -1) "m" headingBytes(195, 188, -1) "r D" headingBytes(195, 182, -1) "ng" headingBytes(195, 188, -1) "s" headingBytes(195, 188, -1),
0226 |     "S" headingBytes(196, 177, -1) "n" headingBytes(196, 177, -1) "rlamalar",
0227 |     "GEREKS" headingBytes(196, 176, -1) "N" headingBytes(196, 176, -1) "MLER",
0228 |     headingBytes(196, 176, -1) headingBytes(197, 159, -1) "levsel Gereksinimler",
0229 |     "Performans Gereksinimleri",
0230 |     "Fiziksel Gereksinimler",
0231 |     "Aray" headingBytes(195, 188, -1) "z Gereksinimleri",
0232 |     headingBytes(195, 135, -1) "evresel Gereksinimler",
0233 |     "Emniyet Gereksinimleri",
0234 |     "Entegre Lojistik Destek Gereksinimleri",
0235 |     "G" headingBytes(195, 188, -1) "venlik ve Gizlilik Gereksinimleri",
0236 |     "Ergonomi Gereksinimleri",
0237 |     "Markalama ve Etiketleme Gereksinimleri",
0238 |     "Bilgisayar Kaynak Gereksinimleri"
0239 | }
0240 | int gtdSectionParents[] = {-1, 0, 0, 0, 3, 3, 0, 6, 6, 0, 9, 9, -1, 12, 12, 12, -1, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16}
0241 | string sectionKeyForHeading(string h)
0242 | {
0243 |     if (headingEndsWith(h, "amac")) return "AMAC"
0244 |     if (headingEndsWith(h, "kapsam")) return "KAPSAM"
0245 |     if (headingEndsWith(h, "projetanimi")) return "PROJE_TANITIMI"
0246 |     if (headingEndsWith(h, "projetanitimi")) return "PROJE_TANITIMI"
0247 |     if (headingEndsWith(h, "sistemegenelbakis")) return "SISTEM_GENEL"
0248 |     if (headingEndsWith(h, "urunegenelbakis")) return "URUN_GENEL"
0249 |     if (headingEndsWith(h, "kisaltmalar")) return "KISALTMALAR"
0250 |     if (headingEndsWith(h, "tanimlar")) return "TANIMLAR"
0251 |     if (headingEndsWith(h, "uygulanabilirdokumanlar")) return "UYGULANABILIR_DOKUMANLAR"
0252 |     if (headingEndsWith(h, "standartlar")) return "STANDARTLAR"
0253 |     if (headingEndsWith(h, "digerdokumanlar")) return "DIGER_DOKUMANLAR"
0254 |     if (headingEndsWith(h, "durumvemodlar")) return "DURUM_MODLAR"
0255 |     if (headingEndsWith(h, "omurdongusu")) return "OMUR_DONGUSU"
0256 |     if (headingEndsWith(h, "sinirlamalar")) return "SINIRLAMALAR"
0257 | 
0258 |     if (headingEndsWith(h, "islevselgereksinimleri")) return "REQ_ISLEVSEL"
0259 |     if (headingEndsWith(h, "islevselgereksinimler")) return "REQ_ISLEVSEL"
0260 |     if (headingEndsWith(h, "performansgereksinimleri")) return "REQ_PERFORMANS"
0261 |     if (headingEndsWith(h, "fizikselgereksinimler")) return "REQ_FIZIKSEL"
0262 |     if (headingEndsWith(h, "arayuzgereksinimleri")) return "REQ_ARAYUZ"
0263 |     if (headingEndsWith(h, "cevreselgereksinimler")) return "REQ_CEVRESEL"
0264 |     if (headingEndsWith(h, "emniyetgereksinimleri")) return "REQ_EMNIYET"
0265 |     if (headingEndsWith(h, "entegrelojistikdestekgereksinimleri")) return "REQ_ELD"
0266 |     if (headingEndsWith(h, "guvenlikvegizlilikgereksinimleri")) return "REQ_GUV_GIZ"
0267 |     if (headingEndsWith(h, "ergonomigereksinimleri")) return "REQ_ERGONOMI"
0268 |     if (headingEndsWith(h, "markalamaveetiketlemegereksinimleri")) return "REQ_MARKALAMA"
0269 |     if (headingEndsWith(h, "bilgisayarkaynakgereksinimleri")) return "REQ_BILGISAYAR"
0270 | 
0271 |     if (headingEndsWith(h, "genel")) return "ROOT_GENEL"
0272 |     if (headingEndsWith(h, "kisaltmalar/tanimlar")) return "GROUP_KISALTMALAR_TANIMLAR"
0273 |     if (headingEndsWith(h, "kisaltmalarvetanimlar")) return "GROUP_KISALTMALAR_TANIMLAR"
0274 |     if (headingEndsWith(h, "sistemintanimlamasi")) return "ROOT_SISTEM_TANIMLAMASI"
0275 |     if (headingEndsWith(h, "sistemintanimi")) return "ROOT_SISTEM_TANIMLAMASI"
0276 |     if (headingEndsWith(h, "gereksinimler")) return "ROOT_GEREKSINIMLER"
0277 |     return ""
0278 | }
0279 | 
0280 | bool isContentSection(string k)
0281 | {
0282 |     if (k == "AMAC") return true
0283 |     if (k == "KAPSAM") return true
0284 |     if (k == "PROJE_TANITIMI") return true
0285 |     if (k == "SISTEM_GENEL") return true
0286 |     if (k == "URUN_GENEL") return true
0287 |     if (k == "KISALTMALAR") return true
0288 |     if (k == "TANIMLAR") return true
0289 |     if (k == "UYGULANABILIR_DOKUMANLAR") return true
0290 |     if (k == "STANDARTLAR") return true
0291 |     if (k == "DIGER_DOKUMANLAR") return true
0292 |     if (k == "DURUM_MODLAR") return true
0293 |     if (k == "OMUR_DONGUSU") return true
0294 |     if (k == "SINIRLAMALAR") return true
0295 | 
0296 |     if (k == "REQ_ISLEVSEL") return true
0297 |     if (k == "REQ_PERFORMANS") return true
0298 |     if (k == "REQ_FIZIKSEL") return true
0299 |     if (k == "REQ_ARAYUZ") return true
0300 |     if (k == "REQ_CEVRESEL") return true
0301 |     if (k == "REQ_EMNIYET") return true
0302 |     if (k == "REQ_ELD") return true
0303 |     if (k == "REQ_GUV_GIZ") return true
0304 |     if (k == "REQ_ERGONOMI") return true
0305 |     if (k == "REQ_MARKALAMA") return true
0306 |     if (k == "REQ_BILGISAYAR") return true
0307 | 
0308 |     return false
0309 | }
0310 | 
0311 | bool isRequirementSection(string k)
0312 | {
0313 |     if (k == "REQ_ISLEVSEL") return true
0314 |     if (k == "REQ_PERFORMANS") return true
0315 |     if (k == "REQ_FIZIKSEL") return true
0316 |     if (k == "REQ_ARAYUZ") return true
0317 |     if (k == "REQ_CEVRESEL") return true
0318 |     if (k == "REQ_EMNIYET") return true
0319 |     if (k == "REQ_ELD") return true
0320 |     if (k == "REQ_GUV_GIZ") return true
0321 |     if (k == "REQ_ERGONOMI") return true
0322 |     if (k == "REQ_MARKALAMA") return true
0323 |     if (k == "REQ_BILGISAYAR") return true
0324 |     return false
0325 | }
0326 | 
0327 | 
0328 | int gtdSectionIndex(string key)
0329 | {
0330 |     int i
0331 |     for (i = 0; i < GTD_SECTION_COUNT; i++)
0332 |         if (gtdSectionKeys[i] == key) return i
0333 |     return -1
0334 | }
0335 | 
0336 | bool gtdBlank(string s)
0337 | {
0338 |     int i
0339 |     for (i = 0; i < length(s); i++) {
0340 |         string c = s[i:i]
0341 |         if (c != " " && c != "\t" && c != "\r" && c != "\n") return false
0342 |     }
0343 |     return true
0344 | }
0345 | 
0346 | string gtdStoredSectionKey(Object o)
0347 | {
0348 |     if (null o) return ""
0349 |     Module om = module(o)
0350 |     AttrDef ad = find(om, "GTD Section Key")
0351 |     if (null ad || !ad.object) return ""
0352 |     return o."GTD Section Key" ""
0353 | }
0354 | 
0355 | string sectionKeyForObject(Object o)
0356 | {
0357 |     if (null o || isDeleted(o)) return ""
0358 |     if (table(o) || row(o) || cell(o)) return ""
0359 |     if (!gtdBlank(getPictName(o))) return ""
0360 |     string h = o."Object Heading" ""
0361 |     if (gtdBlank(h)) return ""
0362 |     string key = gtdStoredSectionKey(o)
0363 |     // A nonempty unknown key must not fall back to the visible title.
0364 |     if (!gtdBlank(key)) {
0365 |         if (gtdSectionIndex(key) >= 0) return key
0366 |         return ""
0367 |     }
0368 |     return sectionKeyForHeading(h)
0369 | }
0370 | 
0371 | string gtdSectionIdentityIssue(Object o)
0372 | {
0373 |     string stored = gtdStoredSectionKey(o)
0374 |     if (gtdBlank(stored)) return ""
0375 |     if (table(o) || row(o) || cell(o)) return "SECTION_KEY_ON_TABLE"
0376 |     if (gtdSectionIndex(stored) < 0) return "UNKNOWN_SECTION_KEY"
0377 |     string h = o."Object Heading" ""
0378 |     if (gtdBlank(h)) return "SECTION_KEY_WITHOUT_HEADING"
0379 |     string pict = getPictName(o)
0380 |     if (!gtdBlank(pict)) return "SECTION_KEY_ON_PICTURE"
0381 |     string titleKey = sectionKeyForHeading(h)
0382 |     if (titleKey != "" && titleKey != stored) return "SECTION_KEY_TITLE_CONFLICT"
0383 |     return ""
0384 | }
0385 | 
0386 | // Start at the parent: a section heading is not its own requirement.
0387 | // A recognized container closes the search; do not inherit a stale section.
0388 | string sectionKeyFromParents(Object x)
0389 | {
0390 |     Object p = parent(x)
0391 |     while (!null p) {
0392 |         string key = sectionKeyForObject(p)
0393 |         if (key != "") {
0394 |             if (isContentSection(key)) return key
0395 |             return ""
0396 |         }
0397 |         p = parent(p)
0398 |     }
0399 |     return ""
0400 | }
0401 | // END GTD SECTION MODEL
0402 | 
0403 | string expectedTypeNormalized(string sectionKey)
0404 | {
0405 |     if (sectionKey == "REQ_ISLEVSEL")   return "islevsel"
0406 |     if (sectionKey == "REQ_PERFORMANS") return "performans"
0407 |     if (sectionKey == "REQ_FIZIKSEL")   return "fiziksel"
0408 |     if (sectionKey == "REQ_ARAYUZ")     return "arayuz"
0409 |     if (sectionKey == "REQ_CEVRESEL")   return "cevresel"
0410 |     if (sectionKey == "REQ_EMNIYET")    return "emniyet"
0411 |     if (sectionKey == "REQ_ELD")        return "entegrelojistikdestek"
0412 |     if (sectionKey == "REQ_GUV_GIZ")    return "guvenlikvegizlilik"
0413 |     if (sectionKey == "REQ_ERGONOMI")   return "ergonomi"
0414 |     if (sectionKey == "REQ_MARKALAMA")  return "markalamaveetiketleme"
0415 |     if (sectionKey == "REQ_BILGISAYAR") return "bilgisayarkaynak"
0416 |     return ""
0417 | }
0418 | 
0419 | bool isBlank(string s)
0420 | {
0421 |     int i
0422 |     int n = length(s)
0423 |     if (n == 0) return true
0424 | 
0425 |     for (i = 0; i < n; i++) {
0426 |         string ch = s[i:i]
0427 |         if (ch != " " && ch != "\t" && ch != "\r" && ch != "\n")
0428 |             return false
0429 |     }
0430 | 
0431 |     return true
0432 | }
0433 | 
0434 | void addIssue(Buffer b, string issue)
0435 | {
0436 |     string currentText = stringOf(b)
0437 |     if (currentText != "") b += " | "
0438 |     b += issue
0439 | }
0440 | 
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
0462 | // ------------------------------------------------------------
0463 | Object o = obj
0464 | 
0465 | if (null o) {
0466 |     display ""
0467 | }
0468 | else if (isDeleted(o) || table(o) || row(o) || cell(o)) {
0469 |     display ""
0470 | }
0471 | else {
0472 |     string pictureName = getPictName(o)
0473 | 
0474 |     // Native picture objects are document content, not requirements.
0475 |     if ((!null pictureName && pictureName != "") || !isBlank(o."Object Heading" "")) {
0476 |         display ""
0477 |     }
0478 |     else {
0479 |         string objectText = o."Object Text" ""
0480 |         string sectionKey = sectionKeyFromParents(o)
0481 | 
0482 |         // Untyped narrative outside requirement sections is ignored.
0483 |         // Typed objects outside those sections need manual placement.
0484 |         Module controlModule = module(o)
0485 |         AttrDef typeDefinition = find(controlModule, "Requirement Type")
0486 |         AttrDef methodDefinition = find(controlModule, "Verification Method")
0487 |         if (isBlank(objectText)) {
0488 |             display ""
0489 |         }
0490 |         else if (null typeDefinition || null methodDefinition || !typeDefinition.object || !methodDefinition.object) {
0491 |             display "HATA: Setup eksik"
0492 |         }
0493 |         else if (!isRequirementSection(sectionKey)) {
0494 |             string existingType = o."Requirement Type" ""
0495 |             if (!isBlank(existingType)) display "HATA: Gereksinim standart baslik disinda"
0496 |             else display ""
0497 |         }
0498 |         else {
0499 |             Buffer issues = create
0500 | 
0501 |             string reqType = o."Requirement Type" ""
0502 |             string verificationMethod = o."Verification Method" ""
0503 | 
0504 |             bool typeMissing = isBlank(reqType)
0505 |             bool verificationMissing = isBlank(verificationMethod)
0506 | 
0507 |             if (typeMissing && verificationMissing) {
0508 |                 addIssue(issues, "EKSIK: Tip + Dogrulama")
0509 |             }
0510 |             else {
0511 |                 if (typeMissing)
0512 |                     addIssue(issues, "EKSIK: Requirement Type")
0513 | 
0514 |                 if (verificationMissing)
0515 |                     addIssue(issues, "EKSIK: Verification Method")
0516 |             }
0517 | 
0518 |             if (!typeMissing) {
0519 |                 string expectedType = expectedTypeNormalized(sectionKey)
0520 |                 string actualType = compactHeading(reqType)
0521 | 
0522 |                 if (expectedType != "" && actualType != expectedType)
0523 |                     addIssue(issues, "HATA: Yanlis Requirement Type")
0524 |             }
0525 | 
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


### PROJECT_FILES/GTD/GUNCEL/GTD_Publish.dxl

SHA256 (original bytes): `ae9ede7a815a42475ae0856e4c4039d62e07ccf312d04ddbb2516c895f2e01c8`  
Lines: 1047. Line-number prefixes are for review only.

````text
0001 | // ============================================================
0002 | // GTD Publisher - DOORS to Word
0003 | // DOORS -> simple text data -> PowerShell -> DOCX
0004 | // ============================================================
0005 | 
0006 | pragma runLim, 0
0007 | 
0008 | Module m = current
0009 | 
0010 | if (null m) {
0011 |     ack "Acik bir formal module bulunamadi."
0012 |     halt
0013 | }
0014 | 
0015 | AttrDef adTpl = find(m, "GTD Word Template Path")
0016 | if (null adTpl) {
0017 |     ack "GTD Word Template Path Module Attribute tanimli degil."
0018 |     halt
0019 | }
0020 | 
0021 | string templatePath = m."GTD Word Template Path" ""
0022 | 
0023 | AttrDef adScript = find(m, "GTD Publisher Script Path")
0024 | if (null adScript) {
0025 |     ack "GTD Publisher Script Path Module Attribute tanimli degil."
0026 |     halt
0027 | }
0028 | 
0029 | string scriptPath = m."GTD Publisher Script Path" ""
0030 | 
0031 | if (templatePath == "") {
0032 |     ack "GTD Word Template Path degeri bos."
0033 |     halt
0034 | }
0035 | 
0036 | if (scriptPath == "") {
0037 |     ack "GTD Publisher Script Path degeri bos."
0038 |     halt
0039 | }
0040 | 
0041 | if (!fileExists_(scriptPath)) {
0042 |     ack "PowerShell publisher bulunamadi:\n" scriptPath
0043 |     halt
0044 | }
0045 | 
0046 | // ------------------------------------------------------------
0047 | // Make one safe data field:
0048 | //   |, tab, CR and LF -> space
0049 | // ------------------------------------------------------------
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
0084 | 
0085 | // Requirement source classification. These are object attributes.
0086 | AttrDef adSourceType = find(m, "Requirement Source Type")
0087 | AttrDef adSourceReference = find(m, "Requirement Source Reference")
0088 | if (null adSourceType || null adSourceReference) {
0089 |     ack "Requirement source attributes are missing.\nRun GTD_Setup_Module.dxl once while the module is open in Exclusive Edit mode."
0090 |     halt
0091 | }
0092 | 
0093 | string systemName       = m."System Name" ""
0094 | string documentNumber   = m."Document Number" ""
0095 | string documentRevision = m."Document Revision" ""
0096 | string projectName      = m."Project Name" ""
0097 | string projectNumber    = m."Project Number" ""
0098 | string department       = m."Department" ""
0099 | string workPackage      = m."Work Package" ""
0100 | string sdvilNumber      = m."SDVIL Number" ""
0101 | string classification   = m."Classification" ""
0102 | 
0103 | Date dv = m."Document Date"
0104 | string documentDate = ""
0105 | 
0106 | if (!null dv)
0107 |     documentDate = dv ""
0108 | 
0109 | string tmpBase = tempFileName()
0110 | string dataPath = tmpBase ".txt"
0111 | 
0112 | string safeDoc = goodFileName(documentNumber "_Rev" documentRevision)
0113 | if (safeDoc == "")
0114 |     safeDoc = "GTD_Output"
0115 | 
0116 | string outputName = safeDoc ".docx"
0117 | 
0118 | // ------------------------------------------------------------
0119 | // Write simple text data
0120 | // ------------------------------------------------------------
0121 | Stream out = write(dataPath)
0122 | 
0123 | if (null out) {
0124 |     ack "Gecici GTD veri dosyasi olusturulamadi:\n" dataPath
0125 |     halt
0126 | }
0127 | 
0128 | string sfSystemName       = safeField(systemName)
0129 | string sfDocumentNumber   = safeField(documentNumber)
0130 | string sfDocumentRevision = safeField(documentRevision)
0131 | string sfDocumentDate     = safeField(documentDate)
0132 | string sfProjectName      = safeField(projectName)
0133 | string sfProjectNumber    = safeField(projectNumber)
0134 | string sfDepartment       = safeField(department)
0135 | string sfWorkPackage      = safeField(workPackage)
0136 | string sfSDVILNumber      = safeField(sdvilNumber)
0137 | string sfClassification   = safeField(classification)
0138 | 
0139 | out << "M|SystemName|"       << sfSystemName       << "\n"
0140 | out << "M|DocumentNumber|"   << sfDocumentNumber   << "\n"
0141 | out << "M|DocumentRevision|" << sfDocumentRevision << "\n"
0142 | out << "M|DocumentDate|"     << sfDocumentDate     << "\n"
0143 | out << "M|ProjectName|"      << sfProjectName      << "\n"
0144 | out << "M|ProjectNumber|"    << sfProjectNumber    << "\n"
0145 | out << "M|Department|"       << sfDepartment       << "\n"
0146 | out << "M|WorkPackage|"      << sfWorkPackage      << "\n"
0147 | out << "M|SDVILNumber|"      << sfSDVILNumber      << "\n"
0148 | out << "M|Classification|"   << sfClassification   << "\n"
0149 | 
0150 | 
0151 | // ------------------------------------------------------------
0152 | // Export narrative sections + native DOORS tables.
0153 | //
0154 | // O|SectionKey|TEXT/REQ/IMAGE/TABLE_START/CELL/TABLE_END|...
0155 | // D|...   diagnostic records for the publisher log
0156 | //
0157 | // ------------------------------------------------------------
0158 | // Robust heading resolution
0159 | //
0160 | // - Ignores spaces/tabs/CR/LF in heading text.
0161 | // - Accepts manually numbered headings such as "1.3 Proje Tanitimi"
0162 | //   by checking the END of the normalized heading.
0163 | // - Parent lookup starts at parent(x), never at x itself.
0164 | // ------------------------------------------------------------
0165 | // All source characters are ASCII. Construct runtime bytes explicitly.
0166 | // BEGIN GTD SECTION MODEL - keep identical in setup, publisher and Control.
0167 | string headingBytes(int first, int second, int third)
0168 | {
0169 |     Buffer b = create
0170 |     char c1 = charOf(first)
0171 |     b += c1
0172 |     if (second >= 0) {
0173 |         char c2 = charOf(second)
0174 |         b += c2
0175 |     }
0176 |     if (third >= 0) {
0177 |         char c3 = charOf(third)
0178 |         b += c3
0179 |     }
0180 |     string result = stringOf(b)
0181 |     delete(b)
0182 |     return result
0183 | }
0184 | 
0185 | // Replace complete strings: works without assuming one byte per Turkish letter.
0186 | string replaceHeadingToken(string s, string token, string replacement)
0187 | {
0188 |     Buffer b = create
0189 |     int i = 0
0190 |     int n = length(s)
0191 |     int t = length(token)
0192 |     while (i < n) {
0193 |         bool matched = false
0194 |         if (i + t <= n) {
0195 |             string part = s[i:(i + t - 1)]
0196 |             if (part == token) matched = true
0197 |         }
0198 |         if (matched) {
0199 |             b += replacement
0200 |             i = i + t
0201 |         }
0202 |         else {
0203 |             b += s[i:i]
0204 |             i++
0205 |         }
0206 |     }
0207 |     string result = stringOf(b)
0208 |     delete(b)
0209 |     return result
0210 | }
0211 | 
0212 | string compactHeading(string s)
0213 | {
0214 |     string token = ""
0215 |     // Decode complete UTF-8 sequences before single-byte Windows-1254.
0216 |     token = headingBytes(195, 135, -1)
0217 |     s = replaceHeadingToken(s, token, "c")
0218 |     token = headingBytes(195, 167, -1)
0219 |     s = replaceHeadingToken(s, token, "c")
0220 |     token = headingBytes(196, 158, -1)
0221 |     s = replaceHeadingToken(s, token, "g")
0222 |     token = headingBytes(196, 159, -1)
0223 |     s = replaceHeadingToken(s, token, "g")
0224 |     token = headingBytes(196, 176, -1)
0225 |     s = replaceHeadingToken(s, token, "i")
0226 |     token = headingBytes(196, 177, -1)
0227 |     s = replaceHeadingToken(s, token, "i")
0228 |     token = headingBytes(195, 150, -1)
0229 |     s = replaceHeadingToken(s, token, "o")
0230 |     token = headingBytes(195, 182, -1)
0231 |     s = replaceHeadingToken(s, token, "o")
0232 |     token = headingBytes(197, 158, -1)
0233 |     s = replaceHeadingToken(s, token, "s")
0234 |     token = headingBytes(197, 159, -1)
0235 |     s = replaceHeadingToken(s, token, "s")
0236 |     token = headingBytes(195, 156, -1)
0237 |     s = replaceHeadingToken(s, token, "u")
0238 |     token = headingBytes(195, 188, -1)
0239 |     s = replaceHeadingToken(s, token, "u")
0240 |     // Windows Turkish bytes (also covers common Latin-1 letters).
0241 |     token = headingBytes(199, -1, -1)
0242 |     s = replaceHeadingToken(s, token, "c")
0243 |     token = headingBytes(231, -1, -1)
0244 |     s = replaceHeadingToken(s, token, "c")
0245 |     token = headingBytes(208, -1, -1)
0246 |     s = replaceHeadingToken(s, token, "g")
0247 |     token = headingBytes(240, -1, -1)
0248 |     s = replaceHeadingToken(s, token, "g")
0249 |     token = headingBytes(221, -1, -1)
0250 |     s = replaceHeadingToken(s, token, "i")
0251 |     token = headingBytes(253, -1, -1)
0252 |     s = replaceHeadingToken(s, token, "i")
0253 |     token = headingBytes(214, -1, -1)
0254 |     s = replaceHeadingToken(s, token, "o")
0255 |     token = headingBytes(246, -1, -1)
0256 |     s = replaceHeadingToken(s, token, "o")
0257 |     token = headingBytes(222, -1, -1)
0258 |     s = replaceHeadingToken(s, token, "s")
0259 |     token = headingBytes(254, -1, -1)
0260 |     s = replaceHeadingToken(s, token, "s")
0261 |     token = headingBytes(220, -1, -1)
0262 |     s = replaceHeadingToken(s, token, "u")
0263 |     token = headingBytes(252, -1, -1)
0264 |     s = replaceHeadingToken(s, token, "u")
0265 |     token = headingBytes(194, 160, -1)
0266 |     s = replaceHeadingToken(s, token, "")
0267 |     token = headingBytes(226, 128, 175)
0268 |     s = replaceHeadingToken(s, token, "")
0269 |     token = headingBytes(226, 128, 139)
0270 |     s = replaceHeadingToken(s, token, "")
0271 |     token = headingBytes(160, -1, -1)
0272 |     s = replaceHeadingToken(s, token, "")
0273 |     string upperChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
0274 |     string lowerChars = "abcdefghijklmnopqrstuvwxyz"
0275 |     Buffer b = create
0276 |     int i
0277 |     int j
0278 |     int n = length(s)
0279 |     for (i = 0; i < n; i++) {
0280 |         string ch = s[i:i]
0281 |         for (j = 0; j < 26; j++) {
0282 |             if (ch == upperChars[j:j]) {
0283 |                 ch = lowerChars[j:j]
0284 |                 break
0285 |             }
0286 |         }
0287 |         if (ch != " " && ch != "\t" && ch != "\r" && ch != "\n" && ch != ":")
0288 |             b += ch
0289 |     }
0290 |     string result = stringOf(b)
0291 |     delete(b)
0292 |     return result
0293 | }
0294 | 
0295 | bool headingEndsWith(string h, string suffix)
0296 | {
0297 |     string c = compactHeading(h)
0298 |     string s = compactHeading(suffix)
0299 |     int lc = length(c)
0300 |     int ls = length(s)
0301 |     if (ls == 0 || lc < ls) return false
0302 |     string tail = c[(lc - ls):(lc - 1)]
0303 |     if (tail != s) return false
0304 |     // Only a manual numeric prefix may precede a known heading.
0305 |     // An arbitrary heading ending in a known name must not steal its section.
0306 |     int i
0307 |     for (i = 0; i < lc - ls; i++) {
0308 |         string ch = c[i:i]
0309 |         if (ch != "0" && ch != "1" && ch != "2" && ch != "3" && ch != "4" && ch != "5" && ch != "6" && ch != "7" && ch != "8" && ch != "9" && ch != "." && ch != ")" && ch != "(" && ch != "-")
0310 |             return false
0311 |     }
0312 |     return true
0313 | }
0314 | 
0315 | const int GTD_SECTION_COUNT = 28
0316 | string gtdSectionKeys[] = {
0317 |     "ROOT_GENEL",
0318 |     "AMAC",
0319 |     "KAPSAM",
0320 |     "PROJE_TANITIMI",
0321 |     "SISTEM_GENEL",
0322 |     "URUN_GENEL",
0323 |     "GROUP_KISALTMALAR_TANIMLAR",
0324 |     "KISALTMALAR",
0325 |     "TANIMLAR",
0326 |     "UYGULANABILIR_DOKUMANLAR",
0327 |     "STANDARTLAR",
0328 |     "DIGER_DOKUMANLAR",
0329 |     "ROOT_SISTEM_TANIMLAMASI",
0330 |     "DURUM_MODLAR",
0331 |     "OMUR_DONGUSU",
0332 |     "SINIRLAMALAR",
0333 |     "ROOT_GEREKSINIMLER",
0334 |     "REQ_ISLEVSEL",
0335 |     "REQ_PERFORMANS",
0336 |     "REQ_FIZIKSEL",
0337 |     "REQ_ARAYUZ",
0338 |     "REQ_CEVRESEL",
0339 |     "REQ_EMNIYET",
0340 |     "REQ_ELD",
0341 |     "REQ_GUV_GIZ",
0342 |     "REQ_ERGONOMI",
0343 |     "REQ_MARKALAMA",
0344 |     "REQ_BILGISAYAR"
0345 | }
0346 | string gtdSectionHeadings[] = {
0347 |     "GENEL",
0348 |     "Ama" headingBytes(195, 167, -1),
0349 |     "Kapsam",
0350 |     "Proje Tan" headingBytes(196, 177, -1) "t" headingBytes(196, 177, -1) "m" headingBytes(196, 177, -1),
0351 |     "Sisteme Genel Bak" headingBytes(196, 177, -1) headingBytes(197, 159, -1),
0352 |     headingBytes(195, 156, -1) "r" headingBytes(195, 188, -1) "ne Genel Bak" headingBytes(196, 177, -1) headingBytes(197, 159, -1),
0353 |     "K" headingBytes(196, 177, -1) "saltmalar/Tan" headingBytes(196, 177, -1) "mlar",
0354 |     "K" headingBytes(196, 177, -1) "saltmalar",
0355 |     "Tan" headingBytes(196, 177, -1) "mlar",
0356 |     "Uygulanabilir Dok" headingBytes(195, 188, -1) "manlar",
0357 |     "Standartlar",
0358 |     "Di" headingBytes(196, 159, -1) "er Dok" headingBytes(195, 188, -1) "manlar",
0359 |     "S" headingBytes(196, 176, -1) "STEM" headingBytes(196, 176, -1) "N TANIMLAMASI",
0360 |     "Durum ve Modlar",
0361 |     headingBytes(195, 150, -1) "m" headingBytes(195, 188, -1) "r D" headingBytes(195, 182, -1) "ng" headingBytes(195, 188, -1) "s" headingBytes(195, 188, -1),
0362 |     "S" headingBytes(196, 177, -1) "n" headingBytes(196, 177, -1) "rlamalar",
0363 |     "GEREKS" headingBytes(196, 176, -1) "N" headingBytes(196, 176, -1) "MLER",
0364 |     headingBytes(196, 176, -1) headingBytes(197, 159, -1) "levsel Gereksinimler",
0365 |     "Performans Gereksinimleri",
0366 |     "Fiziksel Gereksinimler",
0367 |     "Aray" headingBytes(195, 188, -1) "z Gereksinimleri",
0368 |     headingBytes(195, 135, -1) "evresel Gereksinimler",
0369 |     "Emniyet Gereksinimleri",
0370 |     "Entegre Lojistik Destek Gereksinimleri",
0371 |     "G" headingBytes(195, 188, -1) "venlik ve Gizlilik Gereksinimleri",
0372 |     "Ergonomi Gereksinimleri",
0373 |     "Markalama ve Etiketleme Gereksinimleri",
0374 |     "Bilgisayar Kaynak Gereksinimleri"
0375 | }
0376 | int gtdSectionParents[] = {-1, 0, 0, 0, 3, 3, 0, 6, 6, 0, 9, 9, -1, 12, 12, 12, -1, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16}
0377 | string sectionKeyForHeading(string h)
0378 | {
0379 |     if (headingEndsWith(h, "amac")) return "AMAC"
0380 |     if (headingEndsWith(h, "kapsam")) return "KAPSAM"
0381 |     if (headingEndsWith(h, "projetanimi")) return "PROJE_TANITIMI"
0382 |     if (headingEndsWith(h, "projetanitimi")) return "PROJE_TANITIMI"
0383 |     if (headingEndsWith(h, "sistemegenelbakis")) return "SISTEM_GENEL"
0384 |     if (headingEndsWith(h, "urunegenelbakis")) return "URUN_GENEL"
0385 |     if (headingEndsWith(h, "kisaltmalar")) return "KISALTMALAR"
0386 |     if (headingEndsWith(h, "tanimlar")) return "TANIMLAR"
0387 |     if (headingEndsWith(h, "uygulanabilirdokumanlar")) return "UYGULANABILIR_DOKUMANLAR"
0388 |     if (headingEndsWith(h, "standartlar")) return "STANDARTLAR"
0389 |     if (headingEndsWith(h, "digerdokumanlar")) return "DIGER_DOKUMANLAR"
0390 |     if (headingEndsWith(h, "durumvemodlar")) return "DURUM_MODLAR"
0391 |     if (headingEndsWith(h, "omurdongusu")) return "OMUR_DONGUSU"
0392 |     if (headingEndsWith(h, "sinirlamalar")) return "SINIRLAMALAR"
0393 | 
0394 |     if (headingEndsWith(h, "islevselgereksinimleri")) return "REQ_ISLEVSEL"
0395 |     if (headingEndsWith(h, "islevselgereksinimler")) return "REQ_ISLEVSEL"
0396 |     if (headingEndsWith(h, "performansgereksinimleri")) return "REQ_PERFORMANS"
0397 |     if (headingEndsWith(h, "fizikselgereksinimler")) return "REQ_FIZIKSEL"
0398 |     if (headingEndsWith(h, "arayuzgereksinimleri")) return "REQ_ARAYUZ"
0399 |     if (headingEndsWith(h, "cevreselgereksinimler")) return "REQ_CEVRESEL"
0400 |     if (headingEndsWith(h, "emniyetgereksinimleri")) return "REQ_EMNIYET"
0401 |     if (headingEndsWith(h, "entegrelojistikdestekgereksinimleri")) return "REQ_ELD"
0402 |     if (headingEndsWith(h, "guvenlikvegizlilikgereksinimleri")) return "REQ_GUV_GIZ"
0403 |     if (headingEndsWith(h, "ergonomigereksinimleri")) return "REQ_ERGONOMI"
0404 |     if (headingEndsWith(h, "markalamaveetiketlemegereksinimleri")) return "REQ_MARKALAMA"
0405 |     if (headingEndsWith(h, "bilgisayarkaynakgereksinimleri")) return "REQ_BILGISAYAR"
0406 | 
0407 |     if (headingEndsWith(h, "genel")) return "ROOT_GENEL"
0408 |     if (headingEndsWith(h, "kisaltmalar/tanimlar")) return "GROUP_KISALTMALAR_TANIMLAR"
0409 |     if (headingEndsWith(h, "kisaltmalarvetanimlar")) return "GROUP_KISALTMALAR_TANIMLAR"
0410 |     if (headingEndsWith(h, "sistemintanimlamasi")) return "ROOT_SISTEM_TANIMLAMASI"
0411 |     if (headingEndsWith(h, "sistemintanimi")) return "ROOT_SISTEM_TANIMLAMASI"
0412 |     if (headingEndsWith(h, "gereksinimler")) return "ROOT_GEREKSINIMLER"
0413 |     return ""
0414 | }
0415 | 
0416 | bool isContentSection(string k)
0417 | {
0418 |     if (k == "AMAC") return true
0419 |     if (k == "KAPSAM") return true
0420 |     if (k == "PROJE_TANITIMI") return true
0421 |     if (k == "SISTEM_GENEL") return true
0422 |     if (k == "URUN_GENEL") return true
0423 |     if (k == "KISALTMALAR") return true
0424 |     if (k == "TANIMLAR") return true
0425 |     if (k == "UYGULANABILIR_DOKUMANLAR") return true
0426 |     if (k == "STANDARTLAR") return true
0427 |     if (k == "DIGER_DOKUMANLAR") return true
0428 |     if (k == "DURUM_MODLAR") return true
0429 |     if (k == "OMUR_DONGUSU") return true
0430 |     if (k == "SINIRLAMALAR") return true
0431 | 
0432 |     if (k == "REQ_ISLEVSEL") return true
0433 |     if (k == "REQ_PERFORMANS") return true
0434 |     if (k == "REQ_FIZIKSEL") return true
0435 |     if (k == "REQ_ARAYUZ") return true
0436 |     if (k == "REQ_CEVRESEL") return true
0437 |     if (k == "REQ_EMNIYET") return true
0438 |     if (k == "REQ_ELD") return true
0439 |     if (k == "REQ_GUV_GIZ") return true
0440 |     if (k == "REQ_ERGONOMI") return true
0441 |     if (k == "REQ_MARKALAMA") return true
0442 |     if (k == "REQ_BILGISAYAR") return true
0443 | 
0444 |     return false
0445 | }
0446 | 
0447 | bool isRequirementSection(string k)
0448 | {
0449 |     if (k == "REQ_ISLEVSEL") return true
0450 |     if (k == "REQ_PERFORMANS") return true
0451 |     if (k == "REQ_FIZIKSEL") return true
0452 |     if (k == "REQ_ARAYUZ") return true
0453 |     if (k == "REQ_CEVRESEL") return true
0454 |     if (k == "REQ_EMNIYET") return true
0455 |     if (k == "REQ_ELD") return true
0456 |     if (k == "REQ_GUV_GIZ") return true
0457 |     if (k == "REQ_ERGONOMI") return true
0458 |     if (k == "REQ_MARKALAMA") return true
0459 |     if (k == "REQ_BILGISAYAR") return true
0460 |     return false
0461 | }
0462 | 
0463 | 
0464 | int gtdSectionIndex(string key)
0465 | {
0466 |     int i
0467 |     for (i = 0; i < GTD_SECTION_COUNT; i++)
0468 |         if (gtdSectionKeys[i] == key) return i
0469 |     return -1
0470 | }
0471 | 
0472 | bool gtdBlank(string s)
0473 | {
0474 |     int i
0475 |     for (i = 0; i < length(s); i++) {
0476 |         string c = s[i:i]
0477 |         if (c != " " && c != "\t" && c != "\r" && c != "\n") return false
0478 |     }
0479 |     return true
0480 | }
0481 | 
0482 | string gtdStoredSectionKey(Object o)
0483 | {
0484 |     if (null o) return ""
0485 |     Module om = module(o)
0486 |     AttrDef ad = find(om, "GTD Section Key")
0487 |     if (null ad || !ad.object) return ""
0488 |     return o."GTD Section Key" ""
0489 | }
0490 | 
0491 | string sectionKeyForObject(Object o)
0492 | {
0493 |     if (null o || isDeleted(o)) return ""
0494 |     if (table(o) || row(o) || cell(o)) return ""
0495 |     if (!gtdBlank(getPictName(o))) return ""
0496 |     string h = o."Object Heading" ""
0497 |     if (gtdBlank(h)) return ""
0498 |     string key = gtdStoredSectionKey(o)
0499 |     // A nonempty unknown key must not fall back to the visible title.
0500 |     if (!gtdBlank(key)) {
0501 |         if (gtdSectionIndex(key) >= 0) return key
0502 |         return ""
0503 |     }
0504 |     return sectionKeyForHeading(h)
0505 | }
0506 | 
0507 | string gtdSectionIdentityIssue(Object o)
0508 | {
0509 |     string stored = gtdStoredSectionKey(o)
0510 |     if (gtdBlank(stored)) return ""
0511 |     if (table(o) || row(o) || cell(o)) return "SECTION_KEY_ON_TABLE"
0512 |     if (gtdSectionIndex(stored) < 0) return "UNKNOWN_SECTION_KEY"
0513 |     string h = o."Object Heading" ""
0514 |     if (gtdBlank(h)) return "SECTION_KEY_WITHOUT_HEADING"
0515 |     string pict = getPictName(o)
0516 |     if (!gtdBlank(pict)) return "SECTION_KEY_ON_PICTURE"
0517 |     string titleKey = sectionKeyForHeading(h)
0518 |     if (titleKey != "" && titleKey != stored) return "SECTION_KEY_TITLE_CONFLICT"
0519 |     return ""
0520 | }
0521 | 
0522 | // Start at the parent: a section heading is not its own requirement.
0523 | // A recognized container closes the search; do not inherit a stale section.
0524 | string sectionKeyFromParents(Object x)
0525 | {
0526 |     Object p = parent(x)
0527 |     while (!null p) {
0528 |         string key = sectionKeyForObject(p)
0529 |         if (key != "") {
0530 |             if (isContentSection(key)) return key
0531 |             return ""
0532 |         }
0533 |         p = parent(p)
0534 |     }
0535 |     return ""
0536 | }
0537 | // END GTD SECTION MODEL
0538 | 
0539 | // Self-check both source encodings before processing module objects.
0540 | string checkAnsi = "Ama" headingBytes(231, -1, -1)
0541 | string checkUtf8 = "Ama" headingBytes(195, 167, -1)
0542 | string normAnsi = compactHeading(checkAnsi)
0543 | string normUtf8 = compactHeading(checkUtf8)
0544 | string keyAnsi = sectionKeyForHeading(checkAnsi)
0545 | string keyUtf8 = sectionKeyForHeading(checkUtf8)
0546 | if (normAnsi != "amac" || normUtf8 != "amac" || keyAnsi != "AMAC" || keyUtf8 != "AMAC") {
0547 |     close(out)
0548 |     ack "Heading normalization self-check failed. Export stopped."
0549 |     halt
0550 | }
0551 | 
0552 | 
0553 | // Managed modules use hierarchy, never the legacy sibling fallback.
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
0621 | bool oldTableContents = tableContents(m)
0622 | tableContents(true)
0623 | 
0624 | Object so
0625 | Object tr
0626 | Object tc
0627 | 
0628 | // Sequential fallback is used only when the object is a sibling rather than
0629 | // a child of the section heading.
0630 | //
0631 | // activeSectionLevel prevents stale sections from leaking into the next
0632 | // sibling heading. If a new heading appears at the same or higher level,
0633 | // the previous section context is closed immediately.
0634 | string activeSection = ""
0635 | int activeSectionLevel = 999
0636 | 
0637 | for so in entire m do {
0638 | 
0639 |     if (!isDeleted(so)) {
0640 | 
0641 |         string ownHeading = ""
0642 |         string ownSection = ""
0643 |         int ownLevel = 999
0644 | 
0645 |         if (!table(so) && !row(so) && !cell(so)) {
0646 | 
0647 |             ownHeading = so."Object Heading" ""
0648 |             ownLevel = level(so)
0649 | 
0650 |             if (ownHeading != "")
0651 |                 ownSection = sectionKeyForObject(so)
0652 | 
0653 |             // A content heading becomes active; a container closes sibling context.
0654 |             if (isContentSection(ownSection)) {
0655 |                 activeSection = ownSection
0656 |                 activeSectionLevel = ownLevel
0657 |             }
0658 |             else if (ownHeading != "") {
0659 |                 // An unrelated heading at the same/higher hierarchy level closes
0660 |                 // the previous sibling-section context.
0661 |                 if (activeSection != "" && ownLevel <= activeSectionLevel) {
0662 |                     activeSection = ""
0663 |                     activeSectionLevel = 999
0664 |                 }
0665 |             }
0666 |         }
0667 | 
0668 |         // ---------------- Narrative sections ----------------
0669 |         if (!table(so) && !row(so) && !cell(so)) {
0670 | 
0671 |             string narrativeSection = ""
0672 | 
0673 |             string directSection = sectionKeyForObject(so)
0674 | 
0675 |             if (directSection != "")
0676 |                 narrativeSection = directSection
0677 |             else {
0678 |                 narrativeSection = sectionKeyFromParents(so)
0679 | 
0680 |                 if (narrativeSection == "" && !gtdManagedStructure)
0681 |                     narrativeSection = activeSection
0682 |             }
0683 | 
0684 |             if (narrativeSection == "") {
0685 |                 string unmappedText = so."Object Text" ""
0686 |                 if (unmappedText != "") {
0687 |                     string unmappedId = safeField(identifier(so))
0688 |                     string unmappedType = safeField(so."Requirement Type" "")
0689 |                     out << "D|CONTENT_SKIPPED|" << unmappedId << "|NO_SECTION|RequirementType=" << unmappedType << "\n"
0690 |                 }
0691 |             }
0692 | 
0693 |             if (narrativeSection != "" && isContentSection(narrativeSection)) {
0694 | 
0695 |                 string sectionText = so."Object Text" ""
0696 |                 string sectionReqType = so."Requirement Type" ""
0697 | 
0698 |                 // In requirement sections, real requirements are emitted by
0699 |                 // the REQ branch below. Any other Object Text is a normal TEXT
0700 |                 // event and remains in sequence.
0701 |                 bool emitAsText = true
0702 | 
0703 |                 if (isRequirementSection(narrativeSection) && sectionReqType != "" && gtdBlank(ownHeading) && gtdBlank(getPictName(so)))
0704 |                     emitAsText = false
0705 | 
0706 |                 if (sectionText != "" && emitAsText && isRequirementSection(narrativeSection)) {
0707 |                     string noTypeId = safeField(identifier(so))
0708 |                     out << "D|REQ_AS_TEXT|" << noTypeId << "|" << narrativeSection << "|EMPTY_REQUIREMENT_TYPE\n"
0709 |                 }
0710 | 
0711 |                 if (sectionText != "" && emitAsText) {
0712 |                     string sfSectionText = safeField(sectionText)
0713 | 
0714 |                     // Ordered content record used by the publisher.
0715 |                     out << "O|" << narrativeSection << "|TEXT|" << sfSectionText << "\n"
0716 |                 }
0717 |             }
0718 |         }
0719 | 
0720 |         // ---------------- Ordered requirement content ----------------
0721 |         // O|Section|REQ|Id|Text|VerificationMethod|VerificationReference
0722 |         //
0723 |         // This record is emitted in the SAME "entire m" traversal as tables,
0724 |         // so the physical DOORS order is preserved:
0725 |         // SYS-40 -> table -> SYS-41 remains SYS-40 -> table -> SYS-41.
0726 |         if (!table(so) && !row(so) && !cell(so)) {
0727 | 
0728 |             string orderedSection = ""
0729 | 
0730 |             string directReqSection = sectionKeyForObject(so)
0731 | 
0732 |             if (directReqSection != "")
0733 |                 orderedSection = directReqSection
0734 |             else {
0735 |                 orderedSection = sectionKeyFromParents(so)
0736 | 
0737 |                 if (orderedSection == "" && !gtdManagedStructure)
0738 |                     orderedSection = activeSection
0739 |             }
0740 | 
0741 |             if (orderedSection != "" && isRequirementSection(orderedSection)) {
0742 | 
0743 |                 string orderedReqType = so."Requirement Type" ""
0744 |                 string orderedReqText = so."Object Text" ""
0745 | 
0746 |                 if (orderedReqType != "" && orderedReqText != "" && gtdBlank(ownHeading) && gtdBlank(getPictName(so))) {
0747 | 
0748 |                     string orderedReqId = identifier(so)
0749 |                     string orderedVerMethod = so."Verification Method" ""
0750 |                     string orderedVerRef = so."Verification Reference" ""
0751 | 
0752 |                     string sfOrderedReqId = safeField(orderedReqId)
0753 |                     string sfOrderedReqText = safeField(orderedReqText)
0754 |                     string sfOrderedVerMethod = safeField(orderedVerMethod)
0755 |                     string sfOrderedVerRef = safeField(orderedVerRef)
0756 | 
0757 |                     out << "O|" << orderedSection << "|REQ|" << sfOrderedReqId << "|" << sfOrderedReqText << "|" << sfOrderedVerMethod << "|" << sfOrderedVerRef << "\n"
0758 |                 }
0759 |             }
0760 |         }
0761 | 
0762 |         // ---------------- Native DOORS picture objects ----------------
0763 |         // Picture objects remain siblings of requirements so requirements stay leaf objects.
0764 |         // O|Section|IMAGE|ObjectId|PngPath|Width10pt|Height10pt|PictureName
0765 |         if (!table(so) && !row(so) && !cell(so)) {
0766 | 
0767 |             string pictureName = getPictName(so)
0768 | 
0769 |             if (!null pictureName && pictureName != "") {
0770 | 
0771 |                 string pictureSection = sectionKeyForObject(so)
0772 | 
0773 |                 if (pictureSection == "") {
0774 |                     pictureSection = sectionKeyFromParents(so)
0775 | 
0776 |                     if (pictureSection == "" && !gtdManagedStructure)
0777 |                         pictureSection = activeSection
0778 |                 }
0779 | 
0780 |                 string sfPictureId = safeField(identifier(so))
0781 |                 string sfPictureName = safeField(pictureName)
0782 | 
0783 |                 if (pictureSection != "" && isContentSection(pictureSection)) {
0784 | 
0785 |                     string pictureFileId = goodFileName(identifier(so))
0786 |                     if (pictureFileId == "") pictureFileId = "picture"
0787 | 
0788 |                     string picturePath = tmpBase "_IMG_" pictureFileId ".png"
0789 |                     string exportError = exportPicture(so, picturePath, formatPNG)
0790 | 
0791 |                     if (null exportError || exportError == "") {
0792 |                         int llx = 0
0793 |                         int lly = 0
0794 |                         int urx = 0
0795 |                         int ury = 0
0796 |                         getPictBB(so, llx, lly, urx, ury)
0797 | 
0798 |                         int pictureWidth10pt = urx - llx
0799 |                         int pictureHeight10pt = ury - lly
0800 |                         if (pictureWidth10pt < 0) pictureWidth10pt = 0 - pictureWidth10pt
0801 |                         if (pictureHeight10pt < 0) pictureHeight10pt = 0 - pictureHeight10pt
0802 | 
0803 |                         string sfPicturePath = safeField(picturePath)
0804 |                         string sfPictureWidth = pictureWidth10pt ""
0805 |                         string sfPictureHeight = pictureHeight10pt ""
0806 | 
0807 |                         out << "O|" << pictureSection << "|IMAGE|" << sfPictureId << "|" << sfPicturePath << "|" << sfPictureWidth << "|" << sfPictureHeight << "|" << sfPictureName << "\n"
0808 |                     }
0809 |                     else {
0810 |                         string sfPictureError = safeField(exportError)
0811 |                         out << "D|IMAGE_EXPORT_ERROR|" << sfPictureId << "|" << pictureSection << "|" << sfPictureError << "\n"
0812 |                     }
0813 |                 }
0814 |                 else {
0815 |                     out << "D|IMAGE_SKIPPED|" << sfPictureId << "|NO_SECTION|" << sfPictureName << "\n"
0816 |                 }
0817 |             }
0818 |         }
0819 | 
0820 |         // ---------------- Native DOORS tables ----------------
0821 |         if (table(so)) {
0822 | 
0823 |             string tableSection = sectionKeyFromParents(so)
0824 | 
0825 |             // Table header can be a sibling immediately after a mapped heading.
0826 |             if (tableSection == "" && !gtdManagedStructure)
0827 |                 tableSection = activeSection
0828 | 
0829 |             string sfTableId = safeField(identifier(so))
0830 | 
0831 |             // Accept a native DOORS table under ANY mapped content section.
0832 |             if (tableSection != "" && isContentSection(tableSection)) {
0833 | 
0834 |                 int rowNo = 0
0835 |                 bool orderedContentTable = isContentSection(tableSection)
0836 | 
0837 |                 if (orderedContentTable) {
0838 |                     out << "O|" << tableSection << "|TABLE_START|" << sfTableId << "\n"
0839 |                 }
0840 | 
0841 |                 for tr in table so do {
0842 | 
0843 |                     rowNo++
0844 |                     int colNo = 0
0845 | 
0846 |                     for tc in row tr do {
0847 | 
0848 |                         colNo++
0849 | 
0850 |                         string cellText = tc."Object Text" ""
0851 | 
0852 |                         if (cellText == "")
0853 |                             cellText = tc."Object Heading" ""
0854 | 
0855 |                         string sfCellText = safeField(cellText)
0856 |                         string rowNoText = rowNo ""
0857 |                         string colNoText = colNo ""
0858 | 
0859 |                         // O CELL records preserve the exact table location
0860 |                         // within ANY mapped 1.x / 2.x / 3.x section.
0861 |                         if (orderedContentTable) {
0862 |                             out << "O|" << tableSection << "|CELL|" << sfTableId << "|" << rowNoText << "|" << colNoText << "|" << sfCellText << "\n"
0863 |                         }
0864 |                     }
0865 |                 }
0866 | 
0867 |                 if (orderedContentTable) {
0868 |                     out << "O|" << tableSection << "|TABLE_END|" << sfTableId << "\n"
0869 |                 }
0870 |             }
0871 |             else {
0872 |                 out << "D|TABLE_SKIPPED|" << sfTableId << "|NO_SECTION\n"
0873 |             }
0874 |         }
0875 |     }
0876 | }
0877 | 
0878 | tableContents(oldTableContents)
0879 | 
0880 | string sfTraceFilter = safeField(traceLinkModulePath)
0881 | out << "D|TRACE_DIRECTION|OUTGOING|" << sfTraceFilter << "\n"
0882 | 
0883 | int sourceValidationWarnings = 0
0884 | 
0885 | Object o
0886 | 
0887 | for o in entire m do {
0888 |     if (!isDeleted(o) && !table(o) && !row(o) && !cell(o)) {
0889 |     string reqType = o."Requirement Type" ""
0890 |     string objText = o."Object Text" ""
0891 | 
0892 |     if (reqType != "" && objText != "" && gtdBlank(o."Object Heading" "") && gtdBlank(getPictName(o))) {
0893 | 
0894 |         string reqId = identifier(o)
0895 |         string verMethod = o."Verification Method" ""
0896 |         string verRef = o."Verification Reference" ""
0897 | 
0898 |         string sfReqId      = safeField(reqId)
0899 |         string sfReqType    = safeField(reqType)
0900 |         string sfObjText    = safeField(objText)
0901 |         string sfVerMethod  = safeField(verMethod)
0902 |         string sfVerRef     = safeField(verRef)
0903 | 
0904 |         out << "R|" << sfReqId << "|" << sfReqType << "|" << sfObjText << "|" << sfVerMethod << "|" << sfVerRef << "\n"
0905 | 
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


### PROJECT_FILES/GTD/GUNCEL/GTD_Build_Document.ps1

SHA256 (original bytes): `271ac27d3057aa00941496b14014204491b3cc0b67c26958ad682c7f8a613372`  
Lines: 1125. Line-number prefixes are for review only.

````text
0001 | param(
0002 |     [Parameter(Mandatory=$true)][string]$DataPath,
0003 |     [Parameter(Mandatory=$true)][string]$TemplatePath,
0004 |     [Parameter(Mandatory=$true)][string]$OutputName
0005 | )
0006 | 
0007 | $ErrorActionPreference = "Stop"
0008 | Add-Type -AssemblyName System.IO.Compression
0009 | Add-Type -AssemblyName System.IO.Compression.FileSystem
0010 | 
0011 | $desktop = [Environment]::GetFolderPath("Desktop")
0012 | if ([string]::IsNullOrWhiteSpace($desktop)) {
0013 |     $desktop = Join-Path $env:USERPROFILE "Desktop"
0014 | }
0015 | 
0016 | $logPath = Join-Path $desktop "GTD_Publish_Log.txt"
0017 | $outputPath = Join-Path $desktop $OutputName
0018 | 
0019 | function Log([string]$Text) {
0020 |     ("{0:yyyy-MM-dd HH:mm:ss}  {1}" -f (Get-Date), $Text) |
0021 |         Add-Content -LiteralPath $logPath -Encoding UTF8
0022 | }
0023 | 
0024 | function Format-GtdDate([string]$Value) {
0025 |     if ([string]::IsNullOrWhiteSpace($Value)) { return "" }
0026 | 
0027 |     $cultures = @(
0028 |         [System.Globalization.CultureInfo]::InvariantCulture,
0029 |         [System.Globalization.CultureInfo]::GetCultureInfo("en-US"),
0030 |         [System.Globalization.CultureInfo]::GetCultureInfo("en-GB"),
0031 |         [System.Globalization.CultureInfo]::GetCultureInfo("tr-TR")
0032 |     )
0033 | 
0034 |     foreach ($culture in $cultures) {
0035 |         $dt = [datetime]::MinValue
0036 |         if ([datetime]::TryParse(
0037 |             $Value,
0038 |             $culture,
0039 |             [System.Globalization.DateTimeStyles]::AllowWhiteSpaces,
0040 |             [ref]$dt
0041 |         )) {
0042 |             return $dt.ToString("dd.MM.yyyy", [System.Globalization.CultureInfo]::InvariantCulture)
0043 |         }
0044 |     }
0045 | 
0046 |     # If parsing fails, keep the original value rather than blanking it.
0047 |     Log ("DATE FORMAT WARNING: Could not parse [" + $Value + "]; original value will be used.")
0048 |     return $Value
0049 | }
0050 | 
0051 | function Count-Literal([string]$Text, [string]$Needle) {
0052 |     if ([string]::IsNullOrEmpty($Needle)) { return 0 }
0053 |     $count = 0
0054 |     $start = 0
0055 |     while ($true) {
0056 |         $idx = $Text.IndexOf($Needle, $start, [System.StringComparison]::Ordinal)
0057 |         if ($idx -lt 0) { break }
0058 |         $count++
0059 |         $start = $idx + $Needle.Length
0060 |     }
0061 |     return $count
0062 | }
0063 | 
0064 | function Xml-Escape([string]$Value) {
0065 |     if ($null -eq $Value) { return "" }
0066 | 
0067 |     # Remove XML 1.0 illegal control chars first.
0068 |     $clean = [regex]::Replace($Value, "[\x00-\x08\x0B\x0C\x0E-\x1F]", "")
0069 | 
0070 |     # Escape &, <, >, quotes and apostrophes for safe insertion into XML text.
0071 |     return [System.Security.SecurityElement]::Escape($clean)
0072 | }
0073 | 
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
0089 |     $allCells = @($Cells)
0090 | 
0091 |     if ($allCells.Count -eq 0) {
0092 |         return ""
0093 |     }
0094 | 
0095 |     [void]$fragment.Append(
0096 |         '<w:tbl>' +
0097 |         '<w:tblPr>' +
0098 |         '<w:tblStyle w:val="TableGrid"/>' +
0099 |         '<w:tblW w:w="0" w:type="auto"/>' +
0100 |         '<w:tblLayout w:type="autofit"/>' +
0101 |         '</w:tblPr>'
0102 |     )
0103 | 
0104 |     $rowGroups = @($allCells | Group-Object row | Sort-Object { [int]$_.Name })
0105 | 
0106 |     foreach ($rg in $rowGroups) {
0107 |         [void]$fragment.Append('<w:tr>')
0108 | 
0109 |         $rowCells = @($rg.Group | Sort-Object { [int]$_.col })
0110 | 
0111 |         foreach ($cell in $rowCells) {
0112 |             $txt = Xml-Escape ([string]$cell.text)
0113 | 
0114 |             [void]$fragment.Append(
0115 |                 '<w:tc>' +
0116 |                 '<w:tcPr><w:tcW w:w="0" w:type="auto"/></w:tcPr>' +
0117 |                 '<w:p><w:pPr><w:pStyle w:val="Normal"/></w:pPr>' +
0118 |                 '<w:r><w:rPr>' +
0119 |                 '<w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:eastAsia="Arial" w:cs="Arial"/>' +
0120 |                 '<w:sz w:val="20"/><w:szCs w:val="20"/>' +
0121 |                 '</w:rPr><w:t xml:space="preserve">' +
0122 |                 $txt +
0123 |                 '</w:t></w:r></w:p>' +
0124 |                 '</w:tc>'
0125 |             )
0126 |         }
0127 | 
0128 |         [void]$fragment.Append('</w:tr>')
0129 |     }
0130 | 
0131 |     [void]$fragment.Append('</w:tbl>')
0132 |     return $fragment.ToString()
0133 | }
0134 | 
0135 | 
0136 | $script:GtdImagePartCounter = 0
0137 | $script:GtdDrawingId = 100000
0138 | 
0139 | function Ensure-PngContentType([string]$WordDir) {
0140 |     $root = Split-Path -Parent $WordDir
0141 |     $contentTypesPath = Join-Path $root '[Content_Types].xml'
0142 |     if (-not (Test-Path -LiteralPath $contentTypesPath)) {
0143 |         throw "[Content_Types].xml not found: $contentTypesPath"
0144 |     }
0145 | 
0146 |     $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
0147 |     $raw = [System.IO.File]::ReadAllText($contentTypesPath, [System.Text.Encoding]::UTF8)
0148 |     if ($raw -notmatch '<Default\b[^>]*Extension="png"') {
0149 |         $entry = '<Default Extension="png" ContentType="image/png"/>'
0150 |         $idx = $raw.LastIndexOf('</Types>', [System.StringComparison]::Ordinal)
0151 |         if ($idx -lt 0) { throw 'Invalid [Content_Types].xml: </Types> not found.' }
0152 |         $raw = $raw.Substring(0, $idx) + $entry + $raw.Substring($idx)
0153 |         [System.IO.File]::WriteAllText($contentTypesPath, $raw, $utf8NoBom)
0154 |         Log 'Added PNG content type to [Content_Types].xml.'
0155 |     }
0156 | }
0157 | 
0158 | function Add-ImageRelationship([string]$WordDir, [string]$Target) {
0159 |     $relsDir = Join-Path $WordDir '_rels'
0160 |     $relsPath = Join-Path $relsDir 'document.xml.rels'
0161 |     if (-not (Test-Path -LiteralPath $relsPath)) {
0162 |         throw "document.xml.rels not found: $relsPath"
0163 |     }
0164 | 
0165 |     $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
0166 |     $raw = [System.IO.File]::ReadAllText($relsPath, [System.Text.Encoding]::UTF8)
0167 | 
0168 |     do {
0169 |         $script:GtdImagePartCounter++
0170 |         $rid = 'rIdGtdImage' + $script:GtdImagePartCounter
0171 |     } while ($raw -match ('\bId="' + [regex]::Escape($rid) + '"'))
0172 | 
0173 |     $rel = '<Relationship Id="' + $rid + '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="' + $Target + '"/>'
0174 |     $idx = $raw.LastIndexOf('</Relationships>', [System.StringComparison]::Ordinal)
0175 |     if ($idx -lt 0) { throw 'Invalid document.xml.rels: </Relationships> not found.' }
0176 |     $raw = $raw.Substring(0, $idx) + $rel + $raw.Substring($idx)
0177 |     [System.IO.File]::WriteAllText($relsPath, $raw, $utf8NoBom)
0178 |     return $rid
0179 | }
0180 | 
0181 | function Get-ImageExtentEmu([int]$Width10pt, [int]$Height10pt) {
0182 |     # DOORS getPictBB returns tenths of a point. 1/10 pt = 1270 EMU.
0183 |     if ($Width10pt -le 0 -or $Height10pt -le 0) {
0184 |         $cx = [int64](4.0 * 914400)
0185 |         $cy = [int64](3.0 * 914400)
0186 |     }
0187 |     else {
0188 |         $cx = [int64]$Width10pt * 1270
0189 |         $cy = [int64]$Height10pt * 1270
0190 |     }
0191 | 
0192 |     # Keep pictures inside a typical A4 content area while preserving aspect ratio.
0193 |     $maxCx = [int64](6.25 * 914400)
0194 |     $maxCy = [int64](8.25 * 914400)
0195 |     $scale = 1.0
0196 |     if ($cx -gt $maxCx) { $scale = [Math]::Min($scale, [double]$maxCx / [double]$cx) }
0197 |     if ($cy -gt $maxCy) { $scale = [Math]::Min($scale, [double]$maxCy / [double]$cy) }
0198 |     if ($scale -lt 1.0) {
0199 |         $cx = [int64][Math]::Round([double]$cx * $scale)
0200 |         $cy = [int64][Math]::Round([double]$cy * $scale)
0201 |     }
0202 | 
0203 |     return [pscustomobject]@{ cx = $cx; cy = $cy }
0204 | }
0205 | 
0206 | function Build-ImageParagraphXml(
0207 |     [string]$WordDir,
0208 |     [string]$SourcePath,
0209 |     [string]$ObjectId,
0210 |     [string]$PictureName,
0211 |     [int]$Width10pt,
0212 |     [int]$Height10pt
0213 | ) {
0214 |     if (-not (Test-Path -LiteralPath $SourcePath)) {
0215 |         throw "Exported DOORS picture not found: $SourcePath"
0216 |     }
0217 | 
0218 |     Ensure-PngContentType $WordDir
0219 | 
0220 |     $mediaDir = Join-Path $WordDir 'media'
0221 |     if (-not (Test-Path -LiteralPath $mediaDir)) {
0222 |         New-Item -ItemType Directory -Path $mediaDir -Force | Out-Null
0223 |     }
0224 | 
0225 |     $safeId = ([string]$ObjectId -replace '[^A-Za-z0-9_.-]', '_')
0226 |     if ([string]::IsNullOrWhiteSpace($safeId)) { $safeId = 'picture' }
0227 | 
0228 |     $mediaName = ('gtd_{0}_{1}.png' -f $safeId, ([guid]::NewGuid().ToString('N').Substring(0,8)))
0229 |     $mediaPath = Join-Path $mediaDir $mediaName
0230 |     Copy-Item -LiteralPath $SourcePath -Destination $mediaPath -Force
0231 | 
0232 |     $target = 'media/' + $mediaName
0233 |     $rid = Add-ImageRelationship $WordDir $target
0234 | 
0235 |     $script:GtdDrawingId++
0236 |     $drawingId = $script:GtdDrawingId
0237 |     $extent = Get-ImageExtentEmu $Width10pt $Height10pt
0238 |     $cx = [string]$extent.cx
0239 |     $cy = [string]$extent.cy
0240 | 
0241 |     $displayName = [string]$PictureName
0242 |     if ([string]::IsNullOrWhiteSpace($displayName)) { $displayName = [string]$ObjectId }
0243 |     $displayName = Xml-Escape $displayName
0244 | 
0245 |     Log ("IMAGE PART object=" + $ObjectId + " source=" + $SourcePath + " target=" + $target + " rid=" + $rid + " cx=" + $cx + " cy=" + $cy)
0246 | 
0247 |     return (
0248 |         '<w:p>' +
0249 |         '<w:pPr><w:pStyle w:val="Normal"/><w:jc w:val="center"/></w:pPr>' +
0250 |         '<w:r><w:drawing>' +
0251 |         '<wp:inline distT="0" distB="0" distL="0" distR="0">' +
0252 |         '<wp:extent cx="' + $cx + '" cy="' + $cy + '"/>' +
0253 |         '<wp:effectExtent l="0" t="0" r="0" b="0"/>' +
0254 |         '<wp:docPr id="' + $drawingId + '" name="' + $displayName + '"/>' +
0255 |         '<wp:cNvGraphicFramePr><a:graphicFrameLocks xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" noChangeAspect="1"/></wp:cNvGraphicFramePr>' +
0256 |         '<a:graphic xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main">' +
0257 |         '<a:graphicData uri="http://schemas.openxmlformats.org/drawingml/2006/picture">' +
0258 |         '<pic:pic xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture">' +
0259 |         '<pic:nvPicPr><pic:cNvPr id="0" name="' + $displayName + '"/><pic:cNvPicPr/></pic:nvPicPr>' +
0260 |         '<pic:blipFill><a:blip xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" r:embed="' + $rid + '"/><a:stretch><a:fillRect/></a:stretch></pic:blipFill>' +
0261 |         '<pic:spPr><a:xfrm><a:off x="0" y="0"/><a:ext cx="' + $cx + '" cy="' + $cy + '"/></a:xfrm><a:prstGeom prst="rect"><a:avLst/></a:prstGeom></pic:spPr>' +
0262 |         '</pic:pic></a:graphicData></a:graphic>' +
0263 |         '</wp:inline>' +
0264 |         '</w:drawing></w:r>' +
0265 |         '</w:p>'
0266 |     )
0267 | }
0268 | 
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
0329 | 
0330 |             [void]$fragment.Append(
0331 |                 '<w:p>' +
0332 |                 '<w:pPr><w:pStyle w:val="Normal"/></w:pPr>' +
0333 |                 '<w:r><w:rPr>' +
0334 |                 '<w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:eastAsia="Arial" w:cs="Arial"/>' +
0335 |                 '<w:sz w:val="24"/><w:szCs w:val="24"/>' +
0336 |                 '</w:rPr><w:t xml:space="preserve">' +
0337 |                 $txt +
0338 |                 '</w:t></w:r>' +
0339 |                 '</w:p>'
0340 |             )
0341 | 
0342 |             $i++
0343 |             continue
0344 |         }
0345 | 
0346 |         if ($ev.kind -eq "REQ") {
0347 |             $id = Xml-Escape ([string]$ev.id)
0348 |             $txt = Xml-Escape ([string]$ev.text)
0349 | 
0350 |             [void]$fragment.Append(
0351 |                 '<w:p>' +
0352 |                 '<w:pPr><w:pStyle w:val="Normal"/></w:pPr>' +
0353 |                 '<w:r><w:rPr>' +
0354 |                 '<w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:eastAsia="Arial" w:cs="Arial"/>' +
0355 |                 '<w:b/><w:sz w:val="24"/><w:szCs w:val="24"/>' +
0356 |                 '</w:rPr><w:t xml:space="preserve">' +
0357 |                 $id + ' ' +
0358 |                 '</w:t></w:r>' +
0359 |                 '<w:r><w:rPr>' +
0360 |                 '<w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:eastAsia="Arial" w:cs="Arial"/>' +
0361 |                 '<w:sz w:val="24"/><w:szCs w:val="24"/>' +
0362 |                 '</w:rPr><w:t xml:space="preserve">' +
0363 |                 $txt +
0364 |                 '</w:t></w:r>' +
0365 |                 '</w:p>'
0366 |             )
0367 | 
0368 |             $i++
0369 |             continue
0370 |         }
0371 | 
0372 |         if ($ev.kind -eq "IMAGE") {
0373 |             $imageXml = Build-ImageParagraphXml `
0374 |                 $WordDir `
0375 |                 ([string]$ev.path) `
0376 |                 ([string]$ev.id) `
0377 |                 ([string]$ev.name) `
0378 |                 ([int]$ev.width10pt) `
0379 |                 ([int]$ev.height10pt)
0380 | 
0381 |             [void]$fragment.Append($imageXml)
0382 |             $i++
0383 |             continue
0384 |         }
0385 | 
0386 |         if ($ev.kind -eq "TABLE_START") {
0387 |             $tableId = [string]$ev.tableId
0388 |             $cells = New-Object System.Collections.ArrayList
0389 |             $i++
0390 | 
0391 |             while ($i -lt $eventList.Count) {
0392 |                 $inner = $eventList[$i]
0393 | 
0394 |                 if ($inner.kind -eq "CELL" -and [string]$inner.tableId -eq $tableId) {
0395 |                     [void]$cells.Add($inner)
0396 |                     $i++
0397 |                     continue
0398 |                 }
0399 | 
0400 |                 if ($inner.kind -eq "TABLE_END" -and [string]$inner.tableId -eq $tableId) {
0401 |                     $i++
0402 |                     break
0403 |                 }
0404 | 
0405 |                 # Defensive break if the stream is malformed.
0406 |                 break
0407 |             }
0408 | 
0409 |             [void]$fragment.Append((Build-OrderedTableXml $cells))
0410 |             continue
0411 |         }
0412 | 
0413 |         # CELL/TABLE_END should normally be consumed by TABLE_START.
0414 |         $i++
0415 |     }
0416 | 
0417 |     $newContent =
0418 |         $content.Substring(0, $match.Index) +
0419 |         $fragment.ToString() +
0420 |         $content.Substring($match.Index + $match.Length)
0421 | 
0422 |     [System.IO.File]::WriteAllText($DocumentPath, $newContent, $utf8NoBom)
0423 | }
0424 | 
0425 | function Build-TraceMatrixXml(
0426 |     [string]$TableXml,
0427 |     $Requirements,
0428 |     $TraceSources,
0429 |     $TraceFields,
0430 |     [string]$DefaultSystem
0431 | ) {
0432 |     $rowMatches = [regex]::Matches($TableXml, '<w:tr\b[^>]*>.*?</w:tr>', 'Singleline')
0433 |     if ($rowMatches.Count -lt 2) { throw 'Trace matrix template must have a header and a prototype row.' }
0434 |     $headerXml = $rowMatches[0].Value
0435 | 
0436 |     # Center every header cell both horizontally and vertically.
0437 |     $headerXml = [regex]::Replace($headerXml, '<w:vAlign\b[^>]*/>', '')
0438 |     $headerXml = [regex]::Replace($headerXml, '</w:tcPr>', '<w:vAlign w:val="center"/></w:tcPr>')
0439 |     $headerXml = [regex]::Replace($headerXml, '<w:jc\b[^>]*/>', '<w:jc w:val="center"/>')
0440 |     $headerXml = [regex]::Replace(
0441 |         $headerXml,
0442 |         '<w:pPr\b[^>]*>.*?</w:pPr>',
0443 |         { param($m)
0444 |             $ppr = $m.Value
0445 |             if ($ppr -notmatch '<w:jc\b') {
0446 |                 $ppr = [regex]::Replace($ppr, '</w:pPr>', '<w:jc w:val="center"/></w:pPr>')
0447 |             }
0448 |             return $ppr
0449 |         },
0450 |         [System.Text.RegularExpressions.RegexOptions]::Singleline
0451 |     )
0452 | 
0453 |     $prototypeCells = [regex]::Matches($rowMatches[1].Value, '<w:tc\b[^>]*>.*?</w:tc>', 'Singleline')
0454 |     if ($prototypeCells.Count -ne 5) { throw 'Trace matrix requires exactly five columns.' }
0455 |     $cellProperties = @()
0456 |     foreach ($cell in $prototypeCells) {
0457 |         $pr = [regex]::Match($cell.Value, '<w:tcPr\b[^>]*>.*?</w:tcPr>', 'Singleline').Value
0458 |         # Permit wrapping even where the original blank cells had noWrap.
0459 |         $pr = [regex]::Replace($pr, '<w:noWrap\b[^>]*/>', '')
0460 |         # Center cell content vertically.
0461 |         $pr = [regex]::Replace($pr, '<w:vAlign\b[^>]*/>', '')
0462 |         if ([string]::IsNullOrWhiteSpace($pr)) {
0463 |             $pr = '<w:tcPr><w:vAlign w:val="center"/></w:tcPr>'
0464 |         }
0465 |         else {
0466 |             $pr = [regex]::Replace($pr, '</w:tcPr>', '<w:vAlign w:val="center"/></w:tcPr>')
0467 |         }
0468 |         $cellProperties += $pr
0469 |     }
0470 |     $builder = New-Object System.Text.StringBuilder
0471 |     [void]$builder.Append($TableXml.Substring(0, $rowMatches[0].Index))
0472 |     [void]$builder.Append($headerXml)
0473 |     $rowCount = 0
0474 |     $unresolvedCount = 0
0475 |     $noSourceCount = 0
0476 |     foreach ($req in @($Requirements)) {
0477 |         $id = [string]$req.id
0478 |         if (-not $TraceSources.ContainsKey($id)) {
0479 |             throw ('No trace export record for ' + $id + '. Check GTD_Publish.dxl output.')
0480 |         }
0481 |         # The GTD traceability table uses a fixed value in the
0482 |         # "Ilgili Sistem/Altsistem" column for every data row.
0483 |         $relatedSystem = 'U/D'
0484 |         $note = ''
0485 |         $sourceType = ''
0486 |         $sourceReference = ''
0487 |         if ($TraceFields.ContainsKey($id)) {
0488 |             $note = [string]$TraceFields[$id].note
0489 |             $sourceType = [string]$TraceFields[$id].sourceType
0490 |             $sourceReference = [string]$TraceFields[$id].sourceReference
0491 |         }
0492 | 
0493 |         $sourceLabels = New-Object System.Collections.ArrayList
0494 | 
0495 |         switch ($sourceType) {
0496 |             'Higher-Level Requirement' {
0497 |                 foreach ($source in @($TraceSources[$id])) {
0498 |                     $sourceLabel = ''
0499 |                     switch ([string]$source.status) {
0500 |                         'RESOLVED' {
0501 |                             if ([string]::IsNullOrWhiteSpace([string]$source.id)) {
0502 |                                 $sourceLabel = 'Üst seviye kaynak okunamadı'
0503 |                                 $unresolvedCount++
0504 |                             }
0505 |                             else {
0506 |                                 $sourceLabel = [string]$source.id
0507 |                                 if (-not [string]::IsNullOrWhiteSpace([string]$source.module)) {
0508 |                                     $sourceLabel += "`n" + [string]$source.module
0509 |                                 }
0510 |                             }
0511 |                         }
0512 |                         'NONE' {
0513 |                             $sourceLabel = 'Üst seviye kaynak linki eksik'
0514 |                             $noSourceCount++
0515 |                         }
0516 |                         'UNREADABLE' {
0517 |                             $sourceLabel = 'Kaynak okunamadı'
0518 |                             if ($source.module) { $sourceLabel += "`n" + [string]$source.module }
0519 |                             $unresolvedCount++
0520 |                         }
0521 |                         'DELETED' {
0522 |                             $sourceLabel = 'Kaynak silinmiş'
0523 |                             if ($source.module) { $sourceLabel += "`n" + [string]$source.module }
0524 |                             $unresolvedCount++
0525 |                         }
0526 |                         default {
0527 |                             $sourceLabel = 'Kaynak durumu bilinmiyor'
0528 |                             $unresolvedCount++
0529 |                         }
0530 |                     }
0531 |                     [void]$sourceLabels.Add($sourceLabel)
0532 |                 }
0533 |             }
0534 |             'Derived' {
0535 |                 [void]$sourceLabels.Add('Türetilmiş Gereksinim')
0536 |             }
0537 |             'Standard / Regulation' {
0538 |                 if ([string]::IsNullOrWhiteSpace($sourceReference)) {
0539 |                     [void]$sourceLabels.Add('Standart / Mevzuat kaynağı eksik')
0540 |                     $unresolvedCount++
0541 |                 }
0542 |                 else {
0543 |                     [void]$sourceLabels.Add('Standart / Mevzuat: ' + $sourceReference)
0544 |                 }
0545 |             }
0546 |             'Interface' {
0547 |                 if ([string]::IsNullOrWhiteSpace($sourceReference)) {
0548 |                     [void]$sourceLabels.Add('Arayüz kaynağı eksik')
0549 |                     $unresolvedCount++
0550 |                 }
0551 |                 else {
0552 |                     [void]$sourceLabels.Add('Arayüz: ' + $sourceReference)
0553 |                 }
0554 |             }
0555 |             'Safety Analysis' {
0556 |                 if ([string]::IsNullOrWhiteSpace($sourceReference)) {
0557 |                     [void]$sourceLabels.Add('Emniyet analizi kaynağı eksik')
0558 |                     $unresolvedCount++
0559 |                 }
0560 |                 else {
0561 |                     [void]$sourceLabels.Add('Emniyet Analizi: ' + $sourceReference)
0562 |                 }
0563 |             }
0564 |             'Other' {
0565 |                 if ([string]::IsNullOrWhiteSpace($sourceReference)) {
0566 |                     [void]$sourceLabels.Add('Diğer kaynak referansı eksik')
0567 |                     $unresolvedCount++
0568 |                 }
0569 |                 else {
0570 |                     [void]$sourceLabels.Add($sourceReference)
0571 |                 }
0572 |             }
0573 |             default {
0574 |                 # Do not silently classify an unset source as Derived.
0575 |                 # If a valid upper link exists we can still show it, but the log
0576 |                 # will contain SOURCE_TYPE_EMPTY/UNKNOWN_SOURCE_TYPE from DXL.
0577 |                 $resolvedFallback = @($TraceSources[$id] | Where-Object { $_.status -eq 'RESOLVED' })
0578 |                 if ($resolvedFallback.Count -gt 0) {
0579 |                     foreach ($source in $resolvedFallback) {
0580 |                         $sourceLabel = [string]$source.id
0581 |                         if (-not [string]::IsNullOrWhiteSpace([string]$source.module)) {
0582 |                             $sourceLabel += "`n" + [string]$source.module
0583 |                         }
0584 |                         [void]$sourceLabels.Add($sourceLabel)
0585 |                     }
0586 |                 }
0587 |                 else {
0588 |                     [void]$sourceLabels.Add('Kaynak Türü Tanımsız')
0589 |                     $noSourceCount++
0590 |                 }
0591 |             }
0592 |         }
0593 | 
0594 |         foreach ($sourceLabel in @($sourceLabels)) {
0595 |             $values = @($id, $relatedSystem, [string]$req.verificationMethod, $note, [string]$sourceLabel)
0596 |             [void]$builder.Append('<w:tr><w:trPr><w:cantSplit/></w:trPr>')
0597 |             for ($col = 0; $col -lt 5; $col++) {
0598 |                 [void]$builder.Append('<w:tc>' + $cellProperties[$col])
0599 |                 [void]$builder.Append('<w:p><w:pPr><w:spacing w:before="0" w:after="60"/><w:jc w:val="center"/></w:pPr>')
0600 |                 $lines = @(([string]$values[$col]) -split "\r?\n")
0601 |                 for ($lineIndex = 0; $lineIndex -lt $lines.Count; $lineIndex++) {
0602 |                     if ($lineIndex -gt 0) { [void]$builder.Append('<w:r><w:br/></w:r>') }
0603 |                     $escaped = Xml-Escape ([string]$lines[$lineIndex])
0604 |                     [void]$builder.Append('<w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:cs="Arial"/><w:sz w:val="20"/><w:szCs w:val="20"/></w:rPr><w:t xml:space="preserve">' + $escaped + '</w:t></w:r>')
0605 |                 }
0606 |                 [void]$builder.Append('</w:p></w:tc>')
0607 |             }
0608 |             [void]$builder.Append('</w:tr>')
0609 |             $rowCount++
0610 |         }
0611 |     }
0612 |     if ($rowCount -eq 0) {
0613 |         [void]$builder.Append('<w:tr>')
0614 |         foreach ($pr in $cellProperties) { [void]$builder.Append('<w:tc>' + $pr + '<w:p><w:pPr><w:jc w:val="center"/></w:pPr></w:p></w:tc>') }
0615 |         [void]$builder.Append('</w:tr>')
0616 |     }
0617 |     [void]$builder.Append('</w:tbl>')
0618 |     Log ('TRACE_MATRIX rows=' + $rowCount + ' noSource=' + $noSourceCount + ' unresolved=' + $unresolvedCount)
0619 |     return $builder.ToString()
0620 | }
0621 | 
0622 | function Get-WordTablePlainText([string]$TableXml) {
0623 |     if ([string]::IsNullOrWhiteSpace($TableXml)) { return '' }
0624 | 
0625 |     $parts = [regex]::Matches(
0626 |         $TableXml,
0627 |         '<w:t\b[^>]*>(.*?)</w:t>',
0628 |         [System.Text.RegularExpressions.RegexOptions]::Singleline
0629 |     )
0630 | 
0631 |     return (($parts | ForEach-Object {
0632 |         [System.Net.WebUtility]::HtmlDecode($_.Groups[1].Value)
0633 |     }) -join ' ')
0634 | }
0635 | 
0636 | function Normalize-TraceSearchText([string]$Text) {
0637 |     if ([string]::IsNullOrWhiteSpace($Text)) { return '' }
0638 | 
0639 |     # Normalize Turkish/accented characters so trace-table discovery does not
0640 |     # depend on the exact Unicode representation saved by Word.
0641 |     $normalized = $Text.Normalize([System.Text.NormalizationForm]::FormD)
0642 |     $sb = New-Object System.Text.StringBuilder
0643 |     foreach ($ch in $normalized.ToCharArray()) {
0644 |         $cat = [System.Globalization.CharUnicodeInfo]::GetUnicodeCategory($ch)
0645 |         if ($cat -ne [System.Globalization.UnicodeCategory]::NonSpacingMark) {
0646 |             [void]$sb.Append($ch)
0647 |         }
0648 |     }
0649 | 
0650 |     $asciiLike = $sb.ToString().Normalize([System.Text.NormalizationForm]::FormC).ToUpperInvariant()
0651 |     # Turkish dotless i does not decompose; normalize it explicitly.
0652 |     $asciiLike = $asciiLike.Replace([char]0x0131, 'I').Replace([char]0x0130, 'I')
0653 |     $asciiLike = [regex]::Replace($asciiLike, '\s+', ' ').Trim()
0654 |     return $asciiLike
0655 | }
0656 | 
0657 | function Replace-TraceMatrixRaw([string]$DocumentPath, $Requirements, $TraceSources, $TraceFields, [string]$DefaultSystem) {
0658 |     $raw = [System.IO.File]::ReadAllText($DocumentPath, [System.Text.Encoding]::UTF8)
0659 |     $literalCount = Count-Literal $raw '{{TRACE_MATRIX}}'
0660 |     Log ('TRACE_MATRIX literalBefore=' + $literalCount)
0661 | 
0662 |     $matches = [regex]::Matches(
0663 |         $raw,
0664 |         '<w:tbl\b[^>]*>(?:(?!</w:tbl>).)*\{\{TRACE_MATRIX\}\}(?:(?!</w:tbl>).)*</w:tbl>',
0665 |         [System.Text.RegularExpressions.RegexOptions]::Singleline
0666 |     )
0667 | 
0668 |     $tableXml = ''
0669 |     $tableIndex = -1
0670 |     $tableLength = 0
0671 | 
0672 |     if ($matches.Count -eq 1) {
0673 |         $tableXml = $matches[0].Value
0674 |         $tableIndex = $matches[0].Index
0675 |         $tableLength = $matches[0].Length
0676 |         Log 'TRACE_MATRIX table resolved by direct regex.'
0677 |     }
0678 |     else {
0679 |         Log ('TRACE_MATRIX directTableMatches=' + $matches.Count + '; trying paragraph/table fallback.')
0680 | 
0681 |         # Fallback 1: marker may be split across Word runs.
0682 |         $paragraphMatches = [regex]::Matches(
0683 |             $raw,
0684 |             '<w:p\b[^>]*>.*?</w:p>',
0685 |             [System.Text.RegularExpressions.RegexOptions]::Singleline
0686 |         )
0687 | 
0688 |         $markerParagraphIndex = -1
0689 |         foreach ($candidate in $paragraphMatches) {
0690 |             $textParts = [regex]::Matches(
0691 |                 $candidate.Value,
0692 |                 '<w:t\b[^>]*>(.*?)</w:t>',
0693 |                 [System.Text.RegularExpressions.RegexOptions]::Singleline
0694 |             )
0695 |             $paragraphText = (($textParts | ForEach-Object {
0696 |                 [System.Net.WebUtility]::HtmlDecode($_.Groups[1].Value)
0697 |             }) -join '').Trim()
0698 | 
0699 |             if ($paragraphText -ceq '{{TRACE_MATRIX}}') {
0700 |                 $markerParagraphIndex = $candidate.Index
0701 |                 break
0702 |             }
0703 |         }
0704 | 
0705 |         if ($markerParagraphIndex -ge 0) {
0706 |             $tableIndex = $raw.LastIndexOf('<w:tbl', $markerParagraphIndex, [System.StringComparison]::Ordinal)
0707 |             $tableEndStart = $raw.IndexOf('</w:tbl>', $markerParagraphIndex, [System.StringComparison]::Ordinal)
0708 |             if ($tableIndex -ge 0 -and $tableEndStart -ge 0) {
0709 |                 $tableEnd = $tableEndStart + '</w:tbl>'.Length
0710 |                 $tableLength = $tableEnd - $tableIndex
0711 |                 $tableXml = $raw.Substring($tableIndex, $tableLength)
0712 |                 Log 'TRACE_MATRIX table resolved by marker-paragraph fallback.'
0713 |             }
0714 |         }
0715 |     }
0716 | 
0717 |     # Fallback 2: do not depend on {{TRACE_MATRIX}} at all. Identify the
0718 |     # prototype trace table by its visible column headers. This survives Word
0719 |     # splitting/removing the hidden marker run.
0720 |     if ($tableIndex -lt 0 -or [string]::IsNullOrWhiteSpace($tableXml)) {
0721 |         Log 'TRACE_MATRIX marker fallback failed; trying header-based table discovery.'
0722 | 
0723 |         $allTables = [regex]::Matches(
0724 |             $raw,
0725 |             '<w:tbl\b[^>]*>.*?</w:tbl>',
0726 |             [System.Text.RegularExpressions.RegexOptions]::Singleline
0727 |         )
0728 | 
0729 |         $headerCandidates = New-Object System.Collections.ArrayList
0730 |         foreach ($candidate in $allTables) {
0731 |             $plainRaw = Get-WordTablePlainText $candidate.Value
0732 |             $plain = Normalize-TraceSearchText $plainRaw
0733 | 
0734 |             $hasReq = $plain.Contains('GEREKSINIM')
0735 |             $hasVerify = $plain.Contains('DOGRULAMA YONTEMI')
0736 |             $hasSource = $plain.Contains('KAYNAGI')
0737 |             $hasSystem = $plain.Contains('SISTEM')
0738 | 
0739 |             if ($hasReq -and $hasVerify -and $hasSource -and $hasSystem) {
0740 |                 [void]$headerCandidates.Add($candidate)
0741 |             }
0742 |         }
0743 | 
0744 |         Log ('TRACE_MATRIX headerTableMatches=' + $headerCandidates.Count)
0745 | 
0746 |         if ($headerCandidates.Count -eq 1) {
0747 |             $resolved = $headerCandidates[0]
0748 |             $tableXml = $resolved.Value
0749 |             $tableIndex = $resolved.Index
0750 |             $tableLength = $resolved.Length
0751 |             Log 'TRACE_MATRIX table resolved by header-based fallback.'
0752 |         }
0753 |     }
0754 | 
0755 |     # Fallback 3: use the unique table that contains the two strongest trace
0756 |     # headers. This is intentionally narrower than simply selecting the last
0757 |     # table and remains safe if the template gains additional tables later.
0758 |     if ($tableIndex -lt 0 -or [string]::IsNullOrWhiteSpace($tableXml)) {
0759 |         $strongCandidates = New-Object System.Collections.ArrayList
0760 |         foreach ($candidate in $allTables) {
0761 |             $plain = Normalize-TraceSearchText (Get-WordTablePlainText $candidate.Value)
0762 |             if ($plain.Contains('DOGRULAMA YONTEMI') -and $plain.Contains('GEREKSINIMIN KAYNAGI')) {
0763 |                 [void]$strongCandidates.Add($candidate)
0764 |             }
0765 |         }
0766 |         Log ('TRACE_MATRIX strongHeaderMatches=' + $strongCandidates.Count)
0767 |         if ($strongCandidates.Count -eq 1) {
0768 |             $resolved = $strongCandidates[0]
0769 |             $tableXml = $resolved.Value
0770 |             $tableIndex = $resolved.Index
0771 |             $tableLength = $resolved.Length
0772 |             Log 'TRACE_MATRIX table resolved by strong-header fallback.'
0773 |         }
0774 |     }
0775 | 
0776 |     if ($tableIndex -lt 0 -or [string]::IsNullOrWhiteSpace($tableXml)) {
0777 |         throw ('TRACE_MATRIX table could not be resolved. literalCount=' + $literalCount + '; directTableMatches=' + $matches.Count)
0778 |     }
0779 | 
0780 |     $replacement = Build-TraceMatrixXml $tableXml $Requirements $TraceSources $TraceFields $DefaultSystem
0781 |     $newRaw = $raw.Substring(0, $tableIndex) + $replacement + $raw.Substring($tableIndex + $tableLength)
0782 |     [System.IO.File]::WriteAllText($DocumentPath, $newRaw, (New-Object System.Text.UTF8Encoding($false)))
0783 | 
0784 |     $afterRaw = [System.IO.File]::ReadAllText($DocumentPath, [System.Text.Encoding]::UTF8)
0785 |     Log ('TRACE_MATRIX literalAfter=' + (Count-Literal $afterRaw '{{TRACE_MATRIX}}'))
0786 | }
0787 | 
0788 | function Validate-XmlFiles([string]$Root) {
0789 |     $xmlFiles = @()
0790 |     $xmlFiles += Get-ChildItem -LiteralPath $Root -Recurse -Filter "*.xml" |
0791 |         Where-Object { -not $_.PSIsContainer }
0792 |     $xmlFiles += Get-ChildItem -LiteralPath $Root -Recurse -Filter "*.rels" |
0793 |         Where-Object { -not $_.PSIsContainer }
0794 | 
0795 |     foreach ($xf in $xmlFiles) {
0796 |         $reader = $null
0797 |         try {
0798 |             $settings = New-Object System.Xml.XmlReaderSettings
0799 |             $settings.CheckCharacters = $true
0800 |             $reader = [System.Xml.XmlReader]::Create($xf.FullName, $settings)
0801 |             while ($reader.Read()) { }
0802 |         }
0803 |         catch {
0804 |             Log ("INVALID XML PART: " + $xf.FullName)
0805 |             Log $_.Exception.Message
0806 |             throw ("Invalid XML generated in " + $xf.Name + ": " + $_.Exception.Message)
0807 |         }
0808 |         finally {
0809 |             if ($null -ne $reader) {
0810 |                 $reader.Dispose()
0811 |                 $reader = $null
0812 |             }
0813 |         }
0814 |     }
0815 | }
0816 | 
0817 | try {
0818 |     "" | Set-Content -LiteralPath $logPath -Encoding UTF8
0819 |     Log "GTD publish started."
0820 |     Log "DataPath: $DataPath"
0821 |     Log "TemplatePath: $TemplatePath"
0822 |     Log "OutputPath: $outputPath"
0823 | 
0824 |     if (-not (Test-Path -LiteralPath $DataPath)) {
0825 |         throw "Data file not found: $DataPath"
0826 |     }
0827 | 
0828 |     if (-not (Test-Path -LiteralPath $TemplatePath)) {
0829 |         throw "Template not found: $TemplatePath"
0830 |     }
0831 | 
0832 |     Log "===== TEMPLATE IDENTITY ====="
0833 |     $tplItem = Get-Item -LiteralPath $TemplatePath
0834 |     $tplHash = (Get-FileHash -LiteralPath $TemplatePath -Algorithm SHA256).Hash.ToLowerInvariant()
0835 |     Log ("Template FullName: " + $tplItem.FullName)
0836 |     Log ("Template Length: " + $tplItem.Length)
0837 |     Log ("Template LastWriteTime: " + $tplItem.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss"))
0838 |     Log ("Template SHA256: " + $tplHash)
0839 |     # --------------------------------------------------------
0840 |     # Read simple pipe-delimited DOORS data.
0841 |     # --------------------------------------------------------
0842 |     $meta = @{}
0843 |     $reqs = New-Object System.Collections.ArrayList
0844 |     $orderedContent = @{}
0845 |     $traceSources = @{}
0846 |     $traceFields = @{}
0847 | 
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
0864 |                 verificationReference = $parts[5]
0865 |             })
0866 |         }
0867 |         elseif ($parts[0] -eq "Q" -and $parts.Count -ge 4) {
0868 |             $sourceType = ''
0869 |             $sourceReference = ''
0870 |             if ($parts.Count -ge 5) { $sourceType = $parts[4] }
0871 |             if ($parts.Count -ge 6) { $sourceReference = $parts[5] }
0872 |             $traceFields[$parts[1]] = [pscustomobject]@{
0873 |                 relatedSystem = $parts[2]
0874 |                 note = $parts[3]
0875 |                 sourceType = $sourceType
0876 |                 sourceReference = $sourceReference
0877 |             }
0878 |         }
0879 |         elseif ($parts[0] -eq "X" -and $parts.Count -ge 6) {
0880 |             $traceId = $parts[1]
0881 |             if (-not $traceSources.ContainsKey($traceId)) {
0882 |                 $traceSources[$traceId] = New-Object System.Collections.ArrayList
0883 |             }
0884 |             [void]$traceSources[$traceId].Add([pscustomobject]@{
0885 |                 id = $parts[2]; module = $parts[3]; linkModule = $parts[4]; status = $parts[5]
0886 |             })
0887 |         }
0888 |         elseif ($parts[0] -eq "O" -and $parts.Count -ge 3) {
0889 |             $key = $parts[1]
0890 |             if (-not $orderedContent.ContainsKey($key)) {
0891 |                 $orderedContent[$key] = New-Object System.Collections.ArrayList
0892 |             }
0893 | 
0894 |             $kind = $parts[2]
0895 | 
0896 |             if ($kind -eq "TEXT" -and $parts.Count -ge 4) {
0897 |                 [void]$orderedContent[$key].Add([pscustomobject]@{
0898 |                     kind = "TEXT"
0899 |                     text = $parts[3]
0900 |                 })
0901 |             }
0902 |             elseif ($kind -eq "REQ" -and $parts.Count -ge 7) {
0903 |                 [void]$orderedContent[$key].Add([pscustomobject]@{
0904 |                     kind = "REQ"
0905 |                     id = $parts[3]
0906 |                     text = $parts[4]
0907 |                     verificationMethod = $parts[5]
0908 |                     verificationReference = $parts[6]
0909 |                 })
0910 |             }
0911 |             elseif ($kind -eq "IMAGE" -and $parts.Count -ge 7) {
0912 |                 $pictureName = ""
0913 |                 if ($parts.Count -ge 8) { $pictureName = $parts[7] }
0914 |                 [void]$orderedContent[$key].Add([pscustomobject]@{
0915 |                     kind = "IMAGE"
0916 |                     id = $parts[3]
0917 |                     path = $parts[4]
0918 |                     width10pt = [int]$parts[5]
0919 |                     height10pt = [int]$parts[6]
0920 |                     name = $pictureName
0921 |                 })
0922 |             }
0923 |             elseif ($kind -eq "TABLE_START" -and $parts.Count -ge 4) {
0924 |                 [void]$orderedContent[$key].Add([pscustomobject]@{
0925 |                     kind = "TABLE_START"
0926 |                     tableId = $parts[3]
0927 |                 })
0928 |             }
0929 |             elseif ($kind -eq "CELL" -and $parts.Count -ge 7) {
0930 |                 [void]$orderedContent[$key].Add([pscustomobject]@{
0931 |                     kind = "CELL"
0932 |                     tableId = $parts[3]
0933 |                     row = [int]$parts[4]
0934 |                     col = [int]$parts[5]
0935 |                     text = $parts[6]
0936 |                 })
0937 |             }
0938 |             elseif ($kind -eq "TABLE_END" -and $parts.Count -ge 4) {
0939 |                 [void]$orderedContent[$key].Add([pscustomobject]@{
0940 |                     kind = "TABLE_END"
0941 |                     tableId = $parts[3]
0942 |                 })
0943 |             }
0944 |         }
0945 |         elseif ($parts[0] -eq "D") {
0946 |             Log ("DXL " + (($parts | Select-Object -Skip 1) -join " | "))
0947 |         }
0948 |     }
0949 | 
0950 |     Log ("Metadata records: " + $meta.Count)
0951 |     Log ("Requirements: " + $reqs.Count)
0952 |     Log ("Ordered content sections: " + $orderedContent.Count)
0953 | 
0954 |     foreach ($group in ($reqs | Group-Object type | Sort-Object Name)) {
0955 |         Log ("Requirement type [" + $group.Name + "]: " + $group.Count)
0956 |     }
0957 | 
0958 |     foreach ($key in ($orderedContent.Keys | Sort-Object)) {
0959 |         $events = @($orderedContent[$key])
0960 |         $reqCount = @($events | Where-Object { $_.kind -eq "REQ" }).Count
0961 |         $imageCount = @($events | Where-Object { $_.kind -eq "IMAGE" }).Count
0962 |         $tableCount = @($events | Where-Object { $_.kind -eq "TABLE_START" }).Count
0963 |         $textCount = @($events | Where-Object { $_.kind -eq "TEXT" }).Count
0964 |         Log ("Content [" + $key + "]: total=" + $events.Count +
0965 |              " req=" + $reqCount + " image=" + $imageCount +
0966 |              " table=" + $tableCount + " text=" + $textCount)
0967 |     }
0968 | 
0969 |     if ($meta.Count -eq 0) {
0970 |         throw "DOORS data file was read but no metadata records were found."
0971 |     }
0972 | 
0973 |     Copy-Item -LiteralPath $TemplatePath -Destination $outputPath -Force
0974 | 
0975 |     $work = Join-Path $env:TEMP ("GTD_BUILD_" + [guid]::NewGuid().ToString("N"))
0976 |     New-Item -ItemType Directory -Path $work -Force | Out-Null
0977 |     Log "Work folder: $work"
0978 | 
0979 |     try {
0980 |         [System.IO.Compression.ZipFile]::ExtractToDirectory($outputPath,$work)
0981 | 
0982 |         $projDept = [string]$meta["ProjectName"]
0983 |         if ([string]$meta["Department"]) {
0984 |             if ($projDept) { $projDept += " / " }
0985 |             $projDept += [string]$meta["Department"]
0986 |         }
0987 | 
0988 |         $map = @{
0989 |             "{{SYS}}"       = [string]$meta["SystemName"]
0990 |             "{{DOCNO}}"     = [string]$meta["DocumentNumber"]
0991 |             "{{REV}}"       = [string]$meta["DocumentRevision"]
0992 |             "{{DATE}}"      = Format-GtdDate ([string]$meta["DocumentDate"])
0993 |             "{{PROJ_DEPT}}" = $projDept
0994 |             "{{PROJNO}}"    = [string]$meta["ProjectNumber"]
0995 |             "{{WORK}}"      = [string]$meta["WorkPackage"]
0996 |             "{{SDVIL}}"     = [string]$meta["SDVILNumber"]
0997 |             "{{CLASS}}"     = [string]$meta["Classification"]
0998 |         }
0999 | 
1000 |         $wordDir = Join-Path $work "word"
1001 | 
1002 |         # IMPORTANT:
1003 |         # Do NOT parse + re-save Word XML parts here.
1004 |         $xmlParts = @(
1005 |             Get-ChildItem -LiteralPath $wordDir -Filter "*.xml" |
1006 |             Where-Object { -not $_.PSIsContainer }
1007 |         )
1008 | 
1009 |         # Build the traceability matrix before any marker replacement so the
1010 |         # template placeholder is still untouched.
1011 |         $docXml = Join-Path $wordDir "document.xml"
1012 |         Log "===== TRACE MATRIX BEFORE ALL REPLACEMENTS ====="
1013 |         Replace-TraceMatrixRaw $docXml $reqs $traceSources $traceFields ([string]$meta["SystemName"])
1014 | 
1015 |         Log "Replacing scalar markers..."
1016 |         foreach ($part in $xmlParts) {
1017 |             Replace-ScalarMarkersRaw $part.FullName $map
1018 |         }
1019 | 
1020 |         foreach ($key in $map.Keys) {
1021 |             $left = 0
1022 |             foreach ($part in $xmlParts) {
1023 |                 $raw = [System.IO.File]::ReadAllText($part.FullName, [System.Text.Encoding]::UTF8)
1024 |                 $left += Count-Literal $raw $key
1025 |             }
1026 |             if ($left -gt 0) {
1027 |                 Log ("WARNING: scalar marker remains " + $key + " count=" + $left)
1028 |             }
1029 |         }
1030 | 
1031 |         $orderedMarkers = @{
1032 |             # 1. GENEL
1033 |             "AMAC"              = "{{SEC_AMAC}}"
1034 |             "KAPSAM"            = "{{SEC_KAPSAM}}"
1035 |             "PROJE_TANITIMI"    = "{{SEC_PROJE_TANITIMI}}"
1036 |             "SISTEM_GENEL"      = "{{SEC_SISTEM_GENEL}}"
1037 |             "URUN_GENEL"        = "{{SEC_URUN_GENEL}}"
1038 |             "KISALTMALAR"       = "{{SEC_KISALTMALAR}}"
1039 |             "TANIMLAR"          = "{{SEC_TANIMLAR}}"
1040 |             "UYGULANABILIR_DOKUMANLAR" = "{{SEC_UYGULANABILIR_DOKUMANLAR}}"
1041 |             "STANDARTLAR"       = "{{SEC_STANDARTLAR}}"
1042 |             "DIGER_DOKUMANLAR"  = "{{SEC_DIGER_DOKUMANLAR}}"
1043 | 
1044 |             # 2. SİSTEMİN TANIMLAMASI
1045 |             "DURUM_MODLAR"      = "{{SEC_DURUM_MODLAR}}"
1046 |             "OMUR_DONGUSU"      = "{{SEC_OMUR_DONGUSU}}"
1047 |             "SINIRLAMALAR"      = "{{SEC_SINIRLAMALAR}}"
1048 | 
1049 |             # 3. GEREKSİNİMLER
1050 |             "REQ_ISLEVSEL"      = "{{REQ_ISLEVSEL}}"
1051 |             "REQ_PERFORMANS"    = "{{REQ_PERFORMANS}}"
1052 |             "REQ_FIZIKSEL"      = "{{REQ_FIZIKSEL}}"
1053 |             "REQ_ARAYUZ"        = "{{REQ_ARAYUZ}}"
1054 |             "REQ_CEVRESEL"      = "{{REQ_CEVRESEL}}"
1055 |             "REQ_EMNIYET"       = "{{REQ_EMNIYET}}"
1056 |             "REQ_ELD"           = "{{REQ_ELD}}"
1057 |             "REQ_GUV_GIZ"       = "{{REQ_GUV_GIZ}}"
1058 |             "REQ_ERGONOMI"      = "{{REQ_ERGONOMI}}"
1059 |             "REQ_MARKALAMA"     = "{{REQ_MARKALAMA}}"
1060 |             "REQ_BILGISAYAR"    = "{{REQ_BILGISAYAR}}"
1061 |         }
1062 | 
1063 |         Log "Writing ordered DOORS content..."
1064 | 
1065 |         foreach ($key in $orderedMarkers.Keys) {
1066 |             $events = @()
1067 |             if ($orderedContent.ContainsKey($key)) {
1068 |                 $events = @($orderedContent[$key])
1069 |             }
1070 | 
1071 |             $marker = $orderedMarkers[$key]
1072 |             $rawBefore = [System.IO.File]::ReadAllText($docXml, [System.Text.Encoding]::UTF8)
1073 |             $markerCount = Count-Literal $rawBefore $marker
1074 |             if ($markerCount -eq 0) {
1075 |                 Log ("WARNING: ordered marker not found " + $marker)
1076 |             }
1077 | 
1078 |             Replace-OrderedContentMarkerRaw $docXml $marker $events $wordDir
1079 | 
1080 |             if ($events.Count -gt 0) {
1081 |                 Log ("WROTE [" + $key + "] events=" + $events.Count)
1082 |             }
1083 |         }
1084 | 
1085 | 
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


### PROJECT_FILES/GTD/GUNCEL/GTD_Module_Info.dxl

SHA256 (original bytes): `10437d6ec52bcb11e7d9ed5cd6f2929052e6d47037554f4fcf61bfe8febd8d1b`  
Lines: 292. Line-number prefixes are for review only.

````text
0001 | // ============================================================
0002 | // GTD_Module_Info.dxl
0003 | // DOORS Classic 9.6.1.x
0004 | //
0005 | // GTD module metadata entry form.
0006 | // Required:
0007 | //   System Name
0008 | //   Prefix (built-in DOORS module Prefix)
0009 | //   Document Number
0010 | //   Document Revision
0011 | //   Document Date
0012 | //   Project Name
0013 | //   Project Number
0014 | //   Department
0015 | //   Classification
0016 | //
0017 | // Optional:
0018 | //   Work Package
0019 | //   SDVIL Number
0020 | //
0021 | // Run GTD_Setup_Module.dxl first to create the module attributes.
0022 | // ============================================================
0023 | 
0024 | pragma runLim, 0
0025 | 
0026 | Module gtdInfoModule = current
0027 | 
0028 | if (null gtdInfoModule) {
0029 |     ack "Acik bir formal module bulunamadi."
0030 |     halt
0031 | }
0032 | 
0033 | if (baseline(gtdInfoModule)) {
0034 |     ack "Baseline uzerinde module bilgileri degistirilemez."
0035 |     halt
0036 | }
0037 | 
0038 | if (!isEdit(gtdInfoModule)) {
0039 |     ack "Module bilgilerini kaydetmek icin module'u Exclusive Edit modunda acin."
0040 |     halt
0041 | }
0042 | 
0043 | // ------------------------------------------------------------
0044 | // Required schema check
0045 | // ------------------------------------------------------------
0046 | string gtdRequiredAttrs[] = {
0047 |     "System Name",
0048 |     "Document Number",
0049 |     "Document Revision",
0050 |     "Document Date",
0051 |     "Project Name",
0052 |     "Project Number",
0053 |     "Department",
0054 |     "Work Package",
0055 |     "SDVIL Number",
0056 |     "Classification"
0057 | }
0058 | 
0059 | int gtdAttrIndex
0060 | Buffer gtdMissingSchema = create
0061 | 
0062 | for (gtdAttrIndex = 0; gtdAttrIndex < 10; gtdAttrIndex++) {
0063 |     AttrDef gtdAd = find(gtdInfoModule, gtdRequiredAttrs[gtdAttrIndex])
0064 | 
0065 |     if (null gtdAd || !gtdAd.module) {
0066 |         if (length(stringOf(gtdMissingSchema)) > 0)
0067 |             gtdMissingSchema += "\n"
0068 | 
0069 |         gtdMissingSchema += gtdRequiredAttrs[gtdAttrIndex]
0070 |     }
0071 | }
0072 | 
0073 | if (length(stringOf(gtdMissingSchema)) > 0) {
0074 |     string gtdSchemaText = stringOf(gtdMissingSchema)
0075 |     delete(gtdMissingSchema)
0076 | 
0077 |     ack "GTD module semasi eksik.\n\nEksik Module Attribute:\n" gtdSchemaText
0078 |     halt
0079 | }
0080 | 
0081 | delete(gtdMissingSchema)
0082 | 
0083 | // ------------------------------------------------------------
0084 | // Helpers
0085 | // ------------------------------------------------------------
0086 | string gtdTrim(string s)
0087 | {
0088 |     int n = length(s)
0089 |     int first = 0
0090 |     int last = n - 1
0091 | 
0092 |     while (first < n) {
0093 |         string c = s[first:first]
0094 |         if (c == " " || c == "\t" || c == "\r" || c == "\n")
0095 |             first++
0096 |         else
0097 |             break
0098 |     }
0099 | 
0100 |     while (last >= first) {
0101 |         string c = s[last:last]
0102 |         if (c == " " || c == "\t" || c == "\r" || c == "\n")
0103 |             last--
0104 |         else
0105 |             break
0106 |     }
0107 | 
0108 |     if (last < first)
0109 |         return ""
0110 | 
0111 |     return s[first:last]
0112 | }
0113 | 
0114 | bool gtdValidPrefix(string s)
0115 | {
0116 |     s = gtdTrim(s)
0117 | 
0118 |     if (s == "")
0119 |         return false
0120 | 
0121 |     string allowed = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_-"
0122 | 
0123 |     int i
0124 |     int j
0125 | 
0126 |     for (i = 0; i < length(s); i++) {
0127 |         string c = s[i:i]
0128 |         bool ok = false
0129 | 
0130 |         for (j = 0; j < length(allowed); j++) {
0131 |             if (c == allowed[j:j]) {
0132 |                 ok = true
0133 |                 break
0134 |             }
0135 |         }
0136 | 
0137 |         if (!ok)
0138 |             return false
0139 |     }
0140 | 
0141 |     return true
0142 | }
0143 | 
0144 | // ------------------------------------------------------------
0145 | // Current values
0146 | // ------------------------------------------------------------
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
0167 | 
0168 | DBE gtdSystemNameField       = field(gtdInfoDb, "System Name *:",       gtdSystemName,       45, false)
0169 | DBE gtdPrefixField           = field(gtdInfoDb, "DOORS Prefix *:",      gtdPrefix,           25, false)
0170 | DBE gtdDocumentNumberField   = field(gtdInfoDb, "Document Number *:",   gtdDocumentNumber,   35, false)
0171 | DBE gtdDocumentRevisionField = field(gtdInfoDb, "Document Revision *:", gtdDocumentRevision, 15, false)
0172 | 
0173 | label(gtdInfoDb, "Document Date *:")
0174 | beside gtdInfoDb
0175 | DBE gtdDocumentDateField = date(gtdInfoDb, 18, dateOnly(gtdDocumentDate), true)
0176 | left gtdInfoDb
0177 | 
0178 | DBE gtdProjectNameField   = field(gtdInfoDb, "Project Name *:",   gtdProjectName,   45, false)
0179 | DBE gtdProjectNumberField = field(gtdInfoDb, "Project Number *:", gtdProjectNumber, 30, false)
0180 | DBE gtdDepartmentField    = field(gtdInfoDb, "Department *:",     gtdDepartment,    40, false)
0181 | DBE gtdWorkPackageField   = field(gtdInfoDb, "Work Package:",     gtdWorkPackage,   30, false)
0182 | DBE gtdSDVILNumberField   = field(gtdInfoDb, "SDVIL Number:",     gtdSDVILNumber,   30, false)
0183 | 
0184 | string gtdClassificationChoices[] = {
0185 |     "TASNİF DIŞI",
0186 |     "HİZMETE ÖZEL",
0187 |     "GİZLİ",
0188 |     "ÇOK GİZLİ"
0189 | }
0190 | 
0191 | int gtdClassificationIndex = 0
0192 | 
0193 | if (gtdClassification == "HİZMETE ÖZEL") gtdClassificationIndex = 1
0194 | else if (gtdClassification == "GİZLİ") gtdClassificationIndex = 2
0195 | else if (gtdClassification == "ÇOK GİZLİ") gtdClassificationIndex = 3
0196 | 
0197 | DBE gtdClassificationChoice = choice(
0198 |     gtdInfoDb,
0199 |     "Classification *:",
0200 |     gtdClassificationChoices,
0201 |     4,
0202 |     gtdClassificationIndex,
0203 |     25,
0204 |     false
0205 | )
0206 | 
0207 | // ------------------------------------------------------------
0208 | // Save / cancel callbacks
0209 | // ------------------------------------------------------------
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
0281 | void gtdCancelInfo(DB db)
0282 | {
0283 |     release db
0284 | }
0285 | 
0286 | ok(gtdInfoDb, "Kaydet", gtdSaveInfo)
0287 | close(gtdInfoDb, true, gtdCancelInfo)
0288 | 
0289 | realize gtdInfoDb
0290 | minimumSize(gtdInfoDb, 520, 430)
0291 | block gtdInfoDb
0292 | destroy gtdInfoDb
````


### PROJECT_FILES/GTD/GUNCEL/GTD_Open_Check.dxl

SHA256 (original bytes): `7e14ae469db219e069b4137457c9fe90937065226caf6f1db076d79f4d4d5cf4`  
Lines: 150. Line-number prefixes are for review only.

````text
0001 | // ============================================================
0002 | // GTD_Open_Check.dxl
0003 | // Body used by persistent trigger: GTD_Module_Open_Check
0004 | // Scope: current project -> all formal modules
0005 | // Event: post open
0006 | // Priority: 10
0007 | //
0008 | // A module is treated as a GTD module only when it has:
0009 | //   GTD Template Version
0010 | //   GTD Form Path
0011 | //
0012 | // Required values checked:
0013 | //   Prefix
0014 | //   System Name
0015 | //   Document Number
0016 | //   Document Revision
0017 | //   Document Date
0018 | //   Project Name
0019 | //   Project Number
0020 | //   Department
0021 | //   Classification
0022 | //
0023 | // Optional:
0024 | //   Work Package
0025 | //   SDVIL Number
0026 | //
0027 | // When required data is missing, reads GTD Form Path once and eval_()s
0028 | // GTD_Module_Info.dxl once.
0029 | // ============================================================
0030 | 
0031 | pragma runLim, 0
0032 | 
0033 | void gtdAppendMissing(Buffer b, string fieldName)
0034 | {
0035 |     if (length(stringOf(b)) > 0)
0036 |         b += "\n"
0037 | 
0038 |     b += fieldName
0039 | }
0040 | 
0041 | void gtdRunOpenCheck()
0042 | {
0043 |     Trigger gtdTrigger = current()
0044 | 
0045 |     // For a post-open module trigger, this obtains the opened module.
0046 |     // The 0 variant also allows correct baseline detection.
0047 |     Module gtdModule = module(gtdTrigger, 0)
0048 | 
0049 |     if (null gtdModule)
0050 |         return
0051 | 
0052 |     if (baseline(gtdModule))
0053 |         return
0054 | 
0055 |     AttrDef adVersion = find(gtdModule, "GTD Template Version")
0056 |     AttrDef adFormPath = find(gtdModule, "GTD Form Path")
0057 | 
0058 |     // Not a GTD module: silently ignore.
0059 |     if (null adVersion || null adFormPath)
0060 |         return
0061 | 
0062 |     if (!adVersion.module || !adFormPath.module)
0063 |         return
0064 | 
0065 |     string templateVersion = gtdModule."GTD Template Version" ""
0066 |     string formPath = gtdModule."GTD Form Path" ""
0067 | 
0068 |     // GTD setup marker is not configured: silently ignore.
0069 |     if (templateVersion == "" || formPath == "")
0070 |         return
0071 | 
0072 |     Buffer missing = create
0073 | 
0074 |     // Built-in module Prefix.
0075 |     string modulePrefix = gtdModule."Prefix" ""
0076 | 
0077 |     if (modulePrefix == "")
0078 |         gtdAppendMissing(missing, "Prefix")
0079 | 
0080 |     string requiredStringAttrs[] = {
0081 |         "System Name",
0082 |         "Document Number",
0083 |         "Document Revision",
0084 |         "Project Name",
0085 |         "Project Number",
0086 |         "Department",
0087 |         "Classification"
0088 |     }
0089 | 
0090 |     int i
0091 | 
0092 |     for (i = 0; i < 7; i++) {
0093 |         string attrName = requiredStringAttrs[i]
0094 |         AttrDef ad = find(gtdModule, attrName)
0095 | 
0096 |         if (null ad || !ad.module) {
0097 |             gtdAppendMissing(missing, attrName " [attribute missing]")
0098 |         }
0099 |         else {
0100 |             string value = gtdModule.(attrName) ""
0101 | 
0102 |             if (value == "")
0103 |                 gtdAppendMissing(missing, attrName)
0104 |         }
0105 |     }
0106 | 
0107 |     AttrDef adDate = find(gtdModule, "Document Date")
0108 | 
0109 |     if (null adDate || !adDate.module) {
0110 |         gtdAppendMissing(missing, "Document Date [attribute missing]")
0111 |     }
0112 |     else {
0113 |         Date documentDate = gtdModule."Document Date"
0114 | 
0115 |         if (null documentDate)
0116 |             gtdAppendMissing(missing, "Document Date")
0117 |     }
0118 | 
0119 |     string missingText = stringOf(missing)
0120 | 
0121 |     if (missingText == "") {
0122 |         delete(missing)
0123 |         return
0124 |     }
0125 | 
0126 |     if (!fileExists_(formPath)) {
0127 |         warningBox "GTD module bilgileri eksik fakat form dosyasi bulunamadi.\n\nGTD Form Path:\n" formPath "\n\nEksik alanlar:\n" missingText
0128 |         delete(missing)
0129 |         return
0130 |     }
0131 | 
0132 |     string formCode = readFile(formPath)
0133 | 
0134 |     if (formCode == "") {
0135 |         warningBox "GTD form dosyasi okunamadi veya bos:\n\n" formPath
0136 |         delete(missing)
0137 |         return
0138 |     }
0139 | 
0140 |     // Run the shared form exactly once.
0141 |     string evalError = eval_(formCode)
0142 | 
0143 |     if (evalError != "") {
0144 |         warningBox "GTD_Module_Info.dxl calistirilirken hata olustu:\n\n" evalError
0145 |     }
0146 | 
0147 |     delete(missing)
0148 | }
0149 | 
0150 | gtdRunOpenCheck()
````


### PROJECT_FILES/GTD/GUNCEL/GTD_Install_Open_Trigger.dxl

SHA256 (original bytes): `bcd18eba4113efbfcc10f0af2366c6883b8c813b073141ca4e5724df1bc58f61`  
Lines: 204. Line-number prefixes are for review only.

````text
0001 | // ============================================================
0002 | // GTD_Install_Open_Trigger.dxl
0003 | //
0004 | // Installs/replaces one persistent trigger in the CURRENT PROJECT:
0005 | //
0006 | //   Name     : GTD_Module_Open_Check
0007 | //   Scope    : module->all->formal
0008 | //   Type     : post
0009 | //   Event    : open
0010 | //   Priority : 10
0011 | //
0012 | // Run once with the intended DOORS project current/selected.
0013 | // Requires modify access to that project.
0014 | // ============================================================
0015 | 
0016 | pragma runLim, 0
0017 | 
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
0043 |     gtdTriggerCode += "//\n"
0044 |     gtdTriggerCode += "// A module is treated as a GTD module only when it has:\n"
0045 |     gtdTriggerCode += "//   GTD Template Version\n"
0046 |     gtdTriggerCode += "//   GTD Form Path\n"
0047 |     gtdTriggerCode += "//\n"
0048 |     gtdTriggerCode += "// Required values checked:\n"
0049 |     gtdTriggerCode += "//   Prefix\n"
0050 |     gtdTriggerCode += "//   System Name\n"
0051 |     gtdTriggerCode += "//   Document Number\n"
0052 |     gtdTriggerCode += "//   Document Revision\n"
0053 |     gtdTriggerCode += "//   Document Date\n"
0054 |     gtdTriggerCode += "//   Project Name\n"
0055 |     gtdTriggerCode += "//   Project Number\n"
0056 |     gtdTriggerCode += "//   Department\n"
0057 |     gtdTriggerCode += "//   Classification\n"
0058 |     gtdTriggerCode += "//\n"
0059 |     gtdTriggerCode += "// Optional:\n"
0060 |     gtdTriggerCode += "//   Work Package\n"
0061 |     gtdTriggerCode += "//   SDVIL Number\n"
0062 |     gtdTriggerCode += "//\n"
0063 |     gtdTriggerCode += "// When required data is missing, reads GTD Form Path once and eval_()s\n"
0064 |     gtdTriggerCode += "// GTD_Module_Info.dxl once.\n"
0065 |     gtdTriggerCode += "// ============================================================\n"
0066 |     gtdTriggerCode += "\n"
0067 |     gtdTriggerCode += "pragma runLim, 0\n"
0068 |     gtdTriggerCode += "\n"
0069 |     gtdTriggerCode += "void gtdAppendMissing(Buffer b, string fieldName)\n"
0070 |     gtdTriggerCode += "{\n"
0071 |     gtdTriggerCode += "    if (length(stringOf(b)) > 0)\n"
0072 |     gtdTriggerCode += "        b += \"\\n\"\n"
0073 |     gtdTriggerCode += "\n"
0074 |     gtdTriggerCode += "    b += fieldName\n"
0075 |     gtdTriggerCode += "}\n"
0076 |     gtdTriggerCode += "\n"
0077 |     gtdTriggerCode += "void gtdRunOpenCheck()\n"
0078 |     gtdTriggerCode += "{\n"
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
0101 |     gtdTriggerCode += "    string templateVersion = gtdModule.\"GTD Template Version\" \"\"\n"
0102 |     gtdTriggerCode += "    string formPath = gtdModule.\"GTD Form Path\" \"\"\n"
0103 |     gtdTriggerCode += "\n"
0104 |     gtdTriggerCode += "    // GTD setup marker is not configured: silently ignore.\n"
0105 |     gtdTriggerCode += "    if (templateVersion == \"\" || formPath == \"\")\n"
0106 |     gtdTriggerCode += "        return\n"
0107 |     gtdTriggerCode += "\n"
0108 |     gtdTriggerCode += "    Buffer missing = create\n"
0109 |     gtdTriggerCode += "\n"
0110 |     gtdTriggerCode += "    // Built-in module Prefix.\n"
0111 |     gtdTriggerCode += "    string modulePrefix = gtdModule.\"Prefix\" \"\"\n"
0112 |     gtdTriggerCode += "\n"
0113 |     gtdTriggerCode += "    if (modulePrefix == \"\")\n"
0114 |     gtdTriggerCode += "        gtdAppendMissing(missing, \"Prefix\")\n"
0115 |     gtdTriggerCode += "\n"
0116 |     gtdTriggerCode += "    string requiredStringAttrs[] = {\n"
0117 |     gtdTriggerCode += "        \"System Name\",\n"
0118 |     gtdTriggerCode += "        \"Document Number\",\n"
0119 |     gtdTriggerCode += "        \"Document Revision\",\n"
0120 |     gtdTriggerCode += "        \"Project Name\",\n"
0121 |     gtdTriggerCode += "        \"Project Number\",\n"
0122 |     gtdTriggerCode += "        \"Department\",\n"
0123 |     gtdTriggerCode += "        \"Classification\"\n"
0124 |     gtdTriggerCode += "    }\n"
0125 |     gtdTriggerCode += "\n"
0126 |     gtdTriggerCode += "    int i\n"
0127 |     gtdTriggerCode += "\n"
0128 |     gtdTriggerCode += "    for (i = 0; i < 7; i++) {\n"
0129 |     gtdTriggerCode += "        string attrName = requiredStringAttrs[i]\n"
0130 |     gtdTriggerCode += "        AttrDef ad = find(gtdModule, attrName)\n"
0131 |     gtdTriggerCode += "\n"
0132 |     gtdTriggerCode += "        if (null ad || !ad.module) {\n"
0133 |     gtdTriggerCode += "            gtdAppendMissing(missing, attrName \" [attribute missing]\")\n"
0134 |     gtdTriggerCode += "        }\n"
0135 |     gtdTriggerCode += "        else {\n"
0136 |     gtdTriggerCode += "            string value = gtdModule.(attrName) \"\"\n"
0137 |     gtdTriggerCode += "\n"
0138 |     gtdTriggerCode += "            if (value == \"\")\n"
0139 |     gtdTriggerCode += "                gtdAppendMissing(missing, attrName)\n"
0140 |     gtdTriggerCode += "        }\n"
0141 |     gtdTriggerCode += "    }\n"
0142 |     gtdTriggerCode += "\n"
0143 |     gtdTriggerCode += "    AttrDef adDate = find(gtdModule, \"Document Date\")\n"
0144 |     gtdTriggerCode += "\n"
0145 |     gtdTriggerCode += "    if (null adDate || !adDate.module) {\n"
0146 |     gtdTriggerCode += "        gtdAppendMissing(missing, \"Document Date [attribute missing]\")\n"
0147 |     gtdTriggerCode += "    }\n"
0148 |     gtdTriggerCode += "    else {\n"
0149 |     gtdTriggerCode += "        Date documentDate = gtdModule.\"Document Date\"\n"
0150 |     gtdTriggerCode += "\n"
0151 |     gtdTriggerCode += "        if (null documentDate)\n"
0152 |     gtdTriggerCode += "            gtdAppendMissing(missing, \"Document Date\")\n"
0153 |     gtdTriggerCode += "    }\n"
0154 |     gtdTriggerCode += "\n"
0155 |     gtdTriggerCode += "    string missingText = stringOf(missing)\n"
0156 |     gtdTriggerCode += "\n"
0157 |     gtdTriggerCode += "    if (missingText == \"\") {\n"
0158 |     gtdTriggerCode += "        delete(missing)\n"
0159 |     gtdTriggerCode += "        return\n"
0160 |     gtdTriggerCode += "    }\n"
0161 |     gtdTriggerCode += "\n"
0162 |     gtdTriggerCode += "    if (!fileExists_(formPath)) {\n"
0163 |     gtdTriggerCode += "        warningBox \"GTD module bilgileri eksik fakat form dosyasi bulunamadi.\\n\\nGTD Form Path:\\n\" formPath \"\\n\\nEksik alanlar:\\n\" missingText\n"
0164 |     gtdTriggerCode += "        delete(missing)\n"
0165 |     gtdTriggerCode += "        return\n"
0166 |     gtdTriggerCode += "    }\n"
0167 |     gtdTriggerCode += "\n"
0168 |     gtdTriggerCode += "    string formCode = readFile(formPath)\n"
0169 |     gtdTriggerCode += "\n"
0170 |     gtdTriggerCode += "    if (formCode == \"\") {\n"
0171 |     gtdTriggerCode += "        warningBox \"GTD form dosyasi okunamadi veya bos:\\n\\n\" formPath\n"
0172 |     gtdTriggerCode += "        delete(missing)\n"
0173 |     gtdTriggerCode += "        return\n"
0174 |     gtdTriggerCode += "    }\n"
0175 |     gtdTriggerCode += "\n"
0176 |     gtdTriggerCode += "    // Run the shared form exactly once.\n"
0177 |     gtdTriggerCode += "    string evalError = eval_(formCode)\n"
0178 |     gtdTriggerCode += "\n"
0179 |     gtdTriggerCode += "    if (evalError != \"\") {\n"
0180 |     gtdTriggerCode += "        warningBox \"GTD_Module_Info.dxl calistirilirken hata olustu:\\n\\n\" evalError\n"
0181 |     gtdTriggerCode += "    }\n"
0182 |     gtdTriggerCode += "\n"
0183 |     gtdTriggerCode += "    delete(missing)\n"
0184 |     gtdTriggerCode += "}\n"
0185 |     gtdTriggerCode += "\n"
0186 |     gtdTriggerCode += "gtdRunOpenCheck()\n"
0187 | 
0188 | Trigger gtdInstalledTrigger = trigger(
0189 |     "GTD_Module_Open_Check",
0190 |     module->all->formal,
0191 |     post,
0192 |     open,
0193 |     10,
0194 |     stringOf(gtdTriggerCode)
0195 | )
0196 | 
0197 | delete(gtdTriggerCode)
0198 | 
0199 | if (null gtdInstalledTrigger) {
0200 |     ack "GTD_Module_Open_Check trigger'i kurulamadi.\n\nProje modify yetkisini ve current project secimini kontrol edin."
0201 |     halt
0202 | }
0203 | 
0204 | ack "GTD_Module_Open_Check kuruldu.\n\nScope: current project / all formal modules\nEvent: post open\nPriority: 10"
````


### PROJECT_FILES/GTD/GUNCEL/GTD_Remove_Open_Trigger.dxl

SHA256 (original bytes): `65bd19a1ee873ac50898515a1f1e75f88e3930fb4c5ad2a3d34d22aa2d0b4f26`  
Lines: 26. Line-number prefixes are for review only.

````text
0001 | // ============================================================
0002 | // GTD_Remove_Open_Trigger.dxl
0003 | // Removes GTD_Module_Open_Check from the CURRENT PROJECT.
0004 | // ============================================================
0005 | 
0006 | pragma runLim, 0
0007 | 
0008 | Project gtdProject = current Project
0009 | 
0010 | if (null gtdProject) {
0011 |     ack "Once trigger'in bulundugu projeyi current project yapin."
0012 |     halt
0013 | }
0014 | 
0015 | string gtdDeleteError = delete(
0016 |     "GTD_Module_Open_Check",
0017 |     module->all->formal,
0018 |     post,
0019 |     open,
0020 |     10
0021 | )
0022 | 
0023 | if (null gtdDeleteError)
0024 |     ack "GTD_Module_Open_Check kaldirildi."
0025 | else
0026 |     ack "Trigger kaldirilamadi veya zaten yok.\n\n" gtdDeleteError
````



---

# Maintenance generation and verification sources


Review code changes against these sources too; direct edits to generated DXL can be overwritten when rebuilding.

### PROJECT_FILES/GTD/BAKIM/build_package.py

SHA256 (original bytes): `2a871e532e2f879cff40e1436495ca8cb79b06684a464e9296a9bcd96086ac92`  
Lines: 303. Line-number prefixes are for review only.

````text
0001 | from pathlib import Path
0002 | import json
0003 | import re
0004 | 
0005 | ROOT = Path(__file__).resolve().parents[1]
0006 | if (ROOT/'ORIJINAL_DOSYALAR').is_dir():
0007 |     SRC, OUT, WORK = ROOT/'ORIJINAL_DOSYALAR', ROOT/'GUNCEL', ROOT/'BAKIM'
0008 | else:
0009 |     SRC, OUT, WORK = ROOT/'upload', ROOT/'output/GTD/GUNCEL', ROOT/'work'
0010 | 
0011 | # Order and immediate parents are taken from TPL_GTD_Publisher.docx.
0012 | SECTIONS = [
0013 |     ('ROOT_GENEL', 'GENEL', -1),
0014 |     ('AMAC', 'Amaç', 0),
0015 |     ('KAPSAM', 'Kapsam', 0),
0016 |     ('PROJE_TANITIMI', 'Proje Tanıtımı', 0),
0017 |     ('SISTEM_GENEL', 'Sisteme Genel Bakış', 3),
0018 |     ('URUN_GENEL', 'Ürüne Genel Bakış', 3),
0019 |     ('GROUP_KISALTMALAR_TANIMLAR', 'Kısaltmalar/Tanımlar', 0),
0020 |     ('KISALTMALAR', 'Kısaltmalar', 6),
0021 |     ('TANIMLAR', 'Tanımlar', 6),
0022 |     ('UYGULANABILIR_DOKUMANLAR', 'Uygulanabilir Dokümanlar', 0),
0023 |     ('STANDARTLAR', 'Standartlar', 9),
0024 |     ('DIGER_DOKUMANLAR', 'Diğer Dokümanlar', 9),
0025 |     ('ROOT_SISTEM_TANIMLAMASI', 'SİSTEMİN TANIMLAMASI', -1),
0026 |     ('DURUM_MODLAR', 'Durum ve Modlar', 12),
0027 |     ('OMUR_DONGUSU', 'Ömür Döngüsü', 12),
0028 |     ('SINIRLAMALAR', 'Sınırlamalar', 12),
0029 |     ('ROOT_GEREKSINIMLER', 'GEREKSİNİMLER', -1),
0030 |     ('REQ_ISLEVSEL', 'İşlevsel Gereksinimler', 16),
0031 |     ('REQ_PERFORMANS', 'Performans Gereksinimleri', 16),
0032 |     ('REQ_FIZIKSEL', 'Fiziksel Gereksinimler', 16),
0033 |     ('REQ_ARAYUZ', 'Arayüz Gereksinimleri', 16),
0034 |     ('REQ_CEVRESEL', 'Çevresel Gereksinimler', 16),
0035 |     ('REQ_EMNIYET', 'Emniyet Gereksinimleri', 16),
0036 |     ('REQ_ELD', 'Entegre Lojistik Destek Gereksinimleri', 16),
0037 |     ('REQ_GUV_GIZ', 'Güvenlik ve Gizlilik Gereksinimleri', 16),
0038 |     ('REQ_ERGONOMI', 'Ergonomi Gereksinimleri', 16),
0039 |     ('REQ_MARKALAMA', 'Markalama ve Etiketleme Gereksinimleri', 16),
0040 |     ('REQ_BILGISAYAR', 'Bilgisayar Kaynak Gereksinimleri', 16),
0041 | ]
0042 | 
0043 | 
0044 | def dxl_string(value):
0045 |     """ASCII source, UTF-8 runtime string, independent of the editor encoding."""
0046 |     parts = []
0047 |     plain = ''
0048 |     for c in value:
0049 |         if ord(c) < 128:
0050 |             plain += c
0051 |         else:
0052 |             if plain:
0053 |                 parts.append(json.dumps(plain)); plain = ''
0054 |             bs = list(c.encode('utf-8'))
0055 |             parts.append('headingBytes(' + ', '.join(map(str, bs + [-1]*(3-len(bs)))) + ')')
0056 |     if plain or not parts:
0057 |         parts.append(json.dumps(plain))
0058 |     return ' '.join(parts)
0059 | 
0060 | 
0061 | publisher = (SRC/'GTD_Publish.dxl').read_text()
0062 | normalizer = publisher[publisher.index('string headingBytes('):publisher.index('string sectionKeyForHeading(')]
0063 | legacy_map = publisher[publisher.index('string sectionKeyForHeading('):publisher.index('bool isContentSection(')]
0064 | # Preserve all of the previously accepted spelling aliases.
0065 | containers = '''    if (headingEndsWith(h, "genel")) return "ROOT_GENEL"
0066 |     if (headingEndsWith(h, "kisaltmalar/tanimlar")) return "GROUP_KISALTMALAR_TANIMLAR"
0067 |     if (headingEndsWith(h, "kisaltmalarvetanimlar")) return "GROUP_KISALTMALAR_TANIMLAR"
0068 |     if (headingEndsWith(h, "sistemintanimlamasi")) return "ROOT_SISTEM_TANIMLAMASI"
0069 |     if (headingEndsWith(h, "sistemintanimi")) return "ROOT_SISTEM_TANIMLAMASI"
0070 |     if (headingEndsWith(h, "gereksinimler")) return "ROOT_GEREKSINIMLER"
0071 | '''
0072 | legacy_map = legacy_map.replace('    return ""\n}', containers + '    return ""\n}')
0073 | content_funcs = publisher[publisher.index('bool isContentSection('):publisher.index('// IMPORTANT: this starts at parent(x), not x.')]
0074 | arrays = 'const int GTD_SECTION_COUNT = 28\n'
0075 | arrays += 'string gtdSectionKeys[] = {\n' + ',\n'.join('    '+json.dumps(k) for k,_,_ in SECTIONS) + '\n}\n'
0076 | arrays += 'string gtdSectionHeadings[] = {\n' + ',\n'.join('    '+dxl_string(h) for _,h,_ in SECTIONS) + '\n}\n'
0077 | arrays += 'int gtdSectionParents[] = {' + ', '.join(str(p) for _,_,p in SECTIONS) + '}\n'
0078 | common = '// BEGIN GTD SECTION MODEL - keep identical in setup, publisher and Control.\n'
0079 | common += normalizer + arrays + legacy_map + content_funcs + '''
0080 | int gtdSectionIndex(string key)
0081 | {
0082 |     int i
0083 |     for (i = 0; i < GTD_SECTION_COUNT; i++)
0084 |         if (gtdSectionKeys[i] == key) return i
0085 |     return -1
0086 | }
0087 | 
0088 | bool gtdBlank(string s)
0089 | {
0090 |     int i
0091 |     for (i = 0; i < length(s); i++) {
0092 |         string c = s[i:i]
0093 |         if (c != " " && c != "\\t" && c != "\\r" && c != "\\n") return false
0094 |     }
0095 |     return true
0096 | }
0097 | 
0098 | string gtdStoredSectionKey(Object o)
0099 | {
0100 |     if (null o) return ""
0101 |     Module om = module(o)
0102 |     AttrDef ad = find(om, "GTD Section Key")
0103 |     if (null ad || !ad.object) return ""
0104 |     return o."GTD Section Key" ""
0105 | }
0106 | 
0107 | string sectionKeyForObject(Object o)
0108 | {
0109 |     if (null o || isDeleted(o)) return ""
0110 |     if (table(o) || row(o) || cell(o)) return ""
0111 |     if (!gtdBlank(getPictName(o))) return ""
0112 |     string h = o."Object Heading" ""
0113 |     if (gtdBlank(h)) return ""
0114 |     string key = gtdStoredSectionKey(o)
0115 |     // A nonempty unknown key must not fall back to the visible title.
0116 |     if (!gtdBlank(key)) {
0117 |         if (gtdSectionIndex(key) >= 0) return key
0118 |         return ""
0119 |     }
0120 |     return sectionKeyForHeading(h)
0121 | }
0122 | 
0123 | string gtdSectionIdentityIssue(Object o)
0124 | {
0125 |     string stored = gtdStoredSectionKey(o)
0126 |     if (gtdBlank(stored)) return ""
0127 |     if (table(o) || row(o) || cell(o)) return "SECTION_KEY_ON_TABLE"
0128 |     if (gtdSectionIndex(stored) < 0) return "UNKNOWN_SECTION_KEY"
0129 |     string h = o."Object Heading" ""
0130 |     if (gtdBlank(h)) return "SECTION_KEY_WITHOUT_HEADING"
0131 |     string pict = getPictName(o)
0132 |     if (!gtdBlank(pict)) return "SECTION_KEY_ON_PICTURE"
0133 |     string titleKey = sectionKeyForHeading(h)
0134 |     if (titleKey != "" && titleKey != stored) return "SECTION_KEY_TITLE_CONFLICT"
0135 |     return ""
0136 | }
0137 | 
0138 | // Start at the parent: a section heading is not its own requirement.
0139 | // A recognized container closes the search; do not inherit a stale section.
0140 | string sectionKeyFromParents(Object x)
0141 | {
0142 |     Object p = parent(x)
0143 |     while (!null p) {
0144 |         string key = sectionKeyForObject(p)
0145 |         if (key != "") {
0146 |             if (isContentSection(key)) return key
0147 |             return ""
0148 |         }
0149 |         p = parent(p)
0150 |     }
0151 |     return ""
0152 | }
0153 | // END GTD SECTION MODEL
0154 | '''
0155 | (WORK/'section_model.dxl').write_text(common, encoding='ascii')
0156 | (WORK/'section_manifest.json').write_text(json.dumps(SECTIONS,ensure_ascii=False,indent=2))
0157 | 
0158 | # Publisher keeps the established text protocol and Word builder unchanged.
0159 | start = publisher.index('string headingBytes(')
0160 | end = publisher.index('// Self-check both source encodings')
0161 | publisher = publisher[:start] + common + '\n' + publisher[end:]
0162 | publisher = publisher.replace('Run GTD_Setup_Requirement_Source_Attributes.dxl once', 'Run GTD_Setup_Module.dxl once')
0163 | publisher = publisher.replace('ownSection = sectionKeyForHeading(ownHeading)', 'ownSection = sectionKeyForObject(so)')
0164 | publisher = publisher.replace('sectionKeyForHeading(ownHeading)', 'sectionKeyForObject(so)')
0165 | publisher = publisher.replace('if (ownSection != "") {\n                activeSection', 'if (isContentSection(ownSection)) {\n                activeSection')
0166 | for variable in ['narrativeSection','orderedSection','pictureSection','tableSection']:
0167 |     publisher = publisher.replace(f'if ({variable} == "")\n', f'if ({variable} == "" && !gtdManagedStructure)\n')
0168 | publisher = publisher.replace('if (isRequirementSection(narrativeSection) && sectionReqType != "")', 'if (isRequirementSection(narrativeSection) && sectionReqType != "" && gtdBlank(ownHeading) && gtdBlank(getPictName(so)))')
0169 | publisher = publisher.replace('if (orderedReqType != "" && orderedReqText != "")', 'if (orderedReqType != "" && orderedReqText != "" && gtdBlank(ownHeading) && gtdBlank(getPictName(so)))')
0170 | publisher = publisher.replace('if (reqType != "" && objText != "")', 'if (reqType != "" && objText != "" && gtdBlank(o."Object Heading" "") && gtdBlank(getPictName(o)))')
0171 | gate = '''
0172 | // Managed modules use hierarchy, never the legacy sibling fallback.
0173 | AttrDef gtdKeyAttr = find(m, "GTD Section Key")
0174 | bool gtdManagedStructure = !null gtdKeyAttr
0175 | if (gtdManagedStructure) {
0176 |     Buffer structureIssues = create
0177 |     if (gtdBlank(systemName) || gtdBlank(documentNumber) || gtdBlank(documentRevision) ||
0178 |         gtdBlank(documentDate) || gtdBlank(projectName) || gtdBlank(projectNumber) ||
0179 |         gtdBlank(department) || gtdBlank(classification) || gtdBlank(m."Prefix" ""))
0180 |         structureIssues += "Required document metadata is missing; run GTD_Module_Info.dxl.\\n"
0181 |     AttrDef setupStateAttr = find(m, "GTD Setup State")
0182 |     if (null setupStateAttr || !setupStateAttr.module)
0183 |         structureIssues += "GTD Setup State missing; run GTD_Setup_Module.dxl.\\n"
0184 |     else {
0185 |         string setupState = m."GTD Setup State" ""
0186 |         if (setupState != "READY")
0187 |             structureIssues += "Setup is incomplete; resolve the setup log and run it again.\\n"
0188 |     }
0189 |     int sectionCount[GTD_SECTION_COUNT]
0190 |     int si
0191 |     for (si = 0; si < GTD_SECTION_COUNT; si++) sectionCount[si] = 0
0192 |     Object checkObject
0193 |     for checkObject in entire m do {
0194 |         if (isDeleted(checkObject)) continue
0195 |         string issue = gtdSectionIdentityIssue(checkObject)
0196 |         if (issue != "") structureIssues += identifier(checkObject) " : " issue "\\n"
0197 |         if (table(checkObject) || row(checkObject) || cell(checkObject)) continue
0198 |         string key = sectionKeyForObject(checkObject)
0199 |         int idx = gtdSectionIndex(key)
0200 |         if (idx >= 0) {
0201 |             sectionCount[idx]++
0202 |             Object p = parent(checkObject)
0203 |             int pi = gtdSectionParents[idx]
0204 |             string expectedParent = ""
0205 |             if (pi >= 0) expectedParent = gtdSectionKeys[pi]
0206 |             string actualParent = sectionKeyForObject(p)
0207 |             bool wrongParent = false
0208 |             if (pi < 0 && !null p) wrongParent = true
0209 |             if (pi >= 0 && (null p || actualParent != expectedParent)) wrongParent = true
0210 |             if (wrongParent) structureIssues += identifier(checkObject) " : WRONG_PARENT " key "\\n"
0211 |         }
0212 |         string rt = checkObject."Requirement Type" ""
0213 |         string txt = checkObject."Object Text" ""
0214 |         string head = checkObject."Object Heading" ""
0215 |         if (!gtdBlank(rt) && !gtdBlank(txt) && gtdBlank(head) && gtdBlank(getPictName(checkObject))) {
0216 |             string containing = sectionKeyFromParents(checkObject)
0217 |             if (!isRequirementSection(containing))
0218 |                 structureIssues += identifier(checkObject) " : REQUIREMENT_OUTSIDE_SECTION\\n"
0219 |         }
0220 |     }
0221 |     for (si = 0; si < GTD_SECTION_COUNT; si++)
0222 |         if (sectionCount[si] != 1)
0223 |             structureIssues += gtdSectionKeys[si] " : expected one heading; found " sectionCount[si] "\\n"
0224 |     if (length(stringOf(structureIssues)) > 0) {
0225 |         string structureLog = tempFileName() "_GTD_Structure_Check.txt"
0226 |         Stream structureOut = write(structureLog)
0227 |         if (!null structureOut) {
0228 |             structureOut << stringOf(structureIssues)
0229 |             close(structureOut)
0230 |         }
0231 |         print stringOf(structureIssues)
0232 |         close(out)
0233 |         ack "GTD bolum yapisi tamamlanmamis. Yayin durduruldu.\\nSetup'i tekrar calistirin.\\n\\nKontrol raporu:\\n" structureLog
0234 |         delete(structureIssues)
0235 |         halt
0236 |     }
0237 |     delete(structureIssues)
0238 | }
0239 | 
0240 | '''
0241 | publisher = publisher.replace('bool oldTableContents = tableContents(m)', gate+'bool oldTableContents = tableContents(m)')
0242 | publisher = publisher.replace('// A recognized heading ALWAYS wins and immediately becomes active.', '// A content heading becomes active; a container closes sibling context.')
0243 | publisher = publisher.replace('            else {\n            }\n', '')
0244 | (OUT/'GTD_Publish.dxl').write_text(publisher, encoding='ascii')
0245 | 
0246 | control = (SRC/'GTD_Requirement_Review_Control.dxl').read_text()
0247 | start = control.index('string headingBytes(')
0248 | end = control.index('string expectedTypeNormalized(')
0249 | control = control[:start] + common + '\n' + control[end:]
0250 | control = control.replace('requirementSectionFromParents(o)', 'sectionKeyFromParents(o)')
0251 | control = control.replace('else if (table(o) || row(o) || cell(o)) {', 'else if (isDeleted(o) || table(o) || row(o) || cell(o)) {')
0252 | control = control.replace('if (!null pictureName && pictureName != "") {', 'if ((!null pictureName && pictureName != "") || !isBlank(o."Object Heading" "")) {')
0253 | # The new setup creates all these definitions; also fail readably if run on a raw module.
0254 | control = control.replace('''        if (isBlank(objectText) || sectionKey == "") {
0255 |             display ""
0256 |         }
0257 |         else {''', '''        Module controlModule = module(o)
0258 |         AttrDef typeDefinition = find(controlModule, "Requirement Type")
0259 |         AttrDef methodDefinition = find(controlModule, "Verification Method")
0260 |         if (isBlank(objectText)) {
0261 |             display ""
0262 |         }
0263 |         else if (null typeDefinition || null methodDefinition) {
0264 |             display "HATA: Setup eksik"
0265 |         }
0266 |         else if (!isRequirementSection(sectionKey)) {
0267 |             string existingType = o."Requirement Type" ""
0268 |             if (!isBlank(existingType)) display "HATA: Gereksinim standart baslik disinda"
0269 |             else display ""
0270 |         }
0271 |         else {''')
0272 | control = control.replace('Module m = current', 'Module m = module(o)')
0273 | control = control.replace('//   - objects outside requirement sections', '//   - untyped narrative outside requirement sections')
0274 | control = control.replace('// Headings, narrative objects and anything outside requirement\n        // sections are intentionally not checked.', '// Untyped narrative outside requirement sections is ignored.\n        // Typed objects outside those sections need manual placement.')
0275 | control = control.replace('else if (null typeDefinition || null methodDefinition)', 'else if (null typeDefinition || null methodDefinition || !typeDefinition.object || !methodDefinition.object)')
0276 | (OUT/'GTD_Requirement_Review_Control.dxl').write_text(control,encoding='ascii')
0277 | 
0278 | setup = (WORK/'setup_body.dxl').read_text(encoding='ascii')
0279 | setup = setup.replace('// INSERT SECTION MODEL HERE', common)
0280 | setup = setup.replace('// INSERT ENUM LABELS HERE', '''string gtdRequirementTypes[] = {
0281 | ''' + ',\n'.join('    '+dxl_string(x) for x in ['İşlevsel','Performans','Fiziksel','Arayüz','Çevresel','Emniyet','Entegre Lojistik Destek','Güvenlik ve Gizlilik','Ergonomi','Markalama ve Etiketleme','Bilgisayar Kaynak']) + '''
0282 | }
0283 | string gtdVerificationMethods[] = {
0284 | ''' + ',\n'.join('    '+dxl_string(x) for x in ['Analiz','Gösterim','Muayene','Test','Uygunluk Belgesi']) + '\n}\n')
0285 | (OUT/'GTD_Setup_Module.dxl').write_text(setup,encoding='ascii')
0286 | 
0287 | # Keep the embedded trigger body byte-for-byte in step with its readable file.
0288 | open_check = (SRC/'GTD_Open_Check(1).dxl').read_text().replace(
0289 |     '// Master/template marker is not configured: silently ignore.',
0290 |     '// GTD setup marker is not configured: silently ignore.')
0291 | (OUT/'GTD_Open_Check.dxl').write_text(open_check, encoding='ascii')
0292 | installer = (SRC/'GTD_Install_Open_Trigger(1).dxl').read_text()
0293 | a = installer.index('    gtdTriggerCode += ')
0294 | b = installer.index('\nTrigger gtdInstalledTrigger')
0295 | embedded = ''.join('    gtdTriggerCode += '+json.dumps(line)+'\n' for line in open_check.splitlines(keepends=True))
0296 | installer = installer[:a] + embedded + installer[b:]
0297 | (OUT/'GTD_Install_Open_Trigger.dxl').write_text(installer,encoding='ascii')
0298 | info = (SRC/'GTD_Module_Info(1).dxl').read_text().replace(
0299 |     '// Assumes the GTD master/setup has already created the module attributes.',
0300 |     '// Run GTD_Setup_Module.dxl first to create the module attributes.')
0301 | (OUT/'GTD_Module_Info.dxl').write_text(info, encoding='utf-8')
0302 | 
0303 | print('Built setup, publisher and Control from one section model.')
````


### PROJECT_FILES/GTD/BAKIM/setup_body.dxl

SHA256 (original bytes): `0c63c2a518cead17baa33e80d435c7e22888355879830074184ccd941fd21774`  
Lines: 604. Line-number prefixes are for review only.

````text
0001 | // GTD_Setup_Module.dxl - DOORS Classic 9.6.1.x
0002 | // Run in the visible target formal module, in Exclusive Edit mode.
0003 | // Creates missing schema, headings and views. Reuses existing heading objects.
0004 | // Never moves/deletes an existing object, changes an enum, or creates a baseline.
0005 | // GTD Template Version is retained as a compatibility marker for the open trigger.
0006 | 
0007 | pragma runLim, 0
0008 | 
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
0019 | // INSERT SECTION MODEL HERE
0020 | 
0021 | // INSERT ENUM LABELS HERE
0022 | string gtdSourceTypes[] = {
0023 |     "Higher-Level Requirement", "Derived", "Standard / Regulation",
0024 |     "Interface", "Safety Analysis", "Other"
0025 | }
0026 | string gtdModuleStrings[] = {
0027 |     "System Name", "Document Number", "Document Revision", "Project Name",
0028 |     "Project Number", "Department", "Work Package", "SDVIL Number",
0029 |     "Classification", "GTD Template Version", "GTD Form Path",
0030 |     "GTD Word Template Path", "GTD Publisher Script Path", "GTD Trace Link Module",
0031 |     "GTD Tool Folder", "GTD Setup State"
0032 | }
0033 | string gtdObjectTexts[] = {
0034 |     "Verification Reference", "Rationale", "Remarks", "Traceability Note"
0035 | }
0036 | 
0037 | string gtdLogPath = tempFileName() "_GTD_Setup_Log.txt"
0038 | Stream gtdLogStream = write(gtdLogPath)
0039 | if (null gtdLogStream) {
0040 |     ack "Setup log dosyasi acilamadi. Degisiklik yapilmadi."
0041 |     halt
0042 | }
0043 | int gtdCreatedAttrs = 0
0044 | int gtdCreatedHeadings = 0
0045 | int gtdReusedHeadings = 0
0046 | int gtdBlockedHeadings = 0
0047 | int gtdCreatedViews = 0
0048 | int gtdUpdatedViews = 0
0049 | int gtdSchemaErrors = 0
0050 | int gtdReviewNeeded = 0
0051 | bool gtdMutationStarted = false
0052 | 
0053 | void gtdLog(string text)
0054 | {
0055 |     gtdLogStream << text << "\n"
0056 |     print text "\n"
0057 | }
0058 | 
0059 | void gtdFail(string message)
0060 | {
0061 |     if (gtdMutationStarted) {
0062 |         AttrDef stateDef = find(gtdSetupModule, "GTD Setup State")
0063 |         if (!null stateDef && stateDef.module) {
0064 |             noError()
0065 |             gtdSetupModule."GTD Setup State" = "INCOMPLETE"
0066 |             string stateErr = lastError()
0067 |             if (!gtdBlank(stateErr)) gtdLog("STATE_UPDATE_FAILED | " stateErr)
0068 |         }
0069 |     }
0070 |     gtdLog("STOP | " message)
0071 |     close(gtdLogStream)
0072 |     ack "GTD setup tamamlanamadi.\n" message "\n\nLog:\n" gtdLogPath
0073 |     halt
0074 | }
0075 | 
0076 | string gtdReadModuleString(string name)
0077 | {
0078 |     AttrDef ad = find(gtdSetupModule, name)
0079 |     if (null ad || !ad.module) return ""
0080 |     return gtdSetupModule.(name) ""
0081 | }
0082 | 
0083 | string gtdTrim(string s)
0084 | {
0085 |     int a = 0
0086 |     int z = length(s) - 1
0087 |     while (a <= z && gtdBlank(s[a:a])) a++
0088 |     while (z >= a && gtdBlank(s[z:z])) z--
0089 |     if (z < a) return ""
0090 |     return s[a:z]
0091 | }
0092 | 
0093 | string gtdFolderOf(string path)
0094 | {
0095 |     int i
0096 |     for (i = length(path)-1; i >= 0; i--)
0097 |         if (path[i:i] == "\\" || path[i:i] == "/") {
0098 |             if (i == 0) return path[0:0]
0099 |             return path[0:i-1]
0100 |         }
0101 |     return ""
0102 | }
0103 | 
0104 | bool gtdTextType(AttrType at)
0105 | {
0106 |     if (null at) return false
0107 |     return at.type == attrString || at.type == attrText
0108 | }
0109 | 
0110 | // Only validation here. All schema conflicts are collected before any mutation.
0111 | void gtdCheckAttribute(string name, bool moduleScope, string kind)
0112 | {
0113 |     AttrDef ad = find(gtdSetupModule, name)
0114 |     if (null ad) return
0115 |     bool valid = true
0116 |     if (moduleScope && !ad.module) valid = false
0117 |     if (!moduleScope && !ad.object) valid = false
0118 |     AttrType at = ad.type
0119 |     if (null at) valid = false
0120 |     else {
0121 |         if (kind == "Date" && at.type != attrDate) valid = false
0122 |         if (kind == "Text" && !gtdTextType(at)) valid = false
0123 |         if (kind == "Choice" && !gtdTextType(at) && at.type != attrEnumeration) valid = false
0124 |         if (kind == "Key") {
0125 |             if (at.type != attrString || ad.inherit || ad.dxl || ad.multi) valid = false
0126 |         }
0127 |     }
0128 |     if (!valid) {
0129 |         gtdSchemaErrors++
0130 |         gtdLog("SCHEMA_CONFLICT | " name " | existing definition preserved")
0131 |     }
0132 | }
0133 | 
0134 | bool gtdHasEnumLabel(AttrType at, string label, bool normalize)
0135 | {
0136 |     int i
0137 |     for (i = 0; i < at.size; i++) {
0138 |         string value = at.strings[i]
0139 |         if (normalize) {
0140 |             if (compactHeading(value) == compactHeading(label)) return true
0141 |         }
0142 |         else if (value == label) return true
0143 |     }
0144 |     return false
0145 | }
0146 | 
0147 | void gtdCheckEnumeration(string attrName, string typeName, string labels[], int count, bool normalize)
0148 | {
0149 |     AttrDef ad = find(gtdSetupModule, attrName)
0150 |     AttrType at = null
0151 |     if (!null ad) at = ad.type
0152 |     else at = find(gtdSetupModule, typeName)
0153 |     if (null at) return
0154 |     // Existing String/Text definitions remain editable and retain their values.
0155 |     if (!null ad && gtdTextType(at)) return
0156 |     if (at.type != attrEnumeration) {
0157 |         gtdSchemaErrors++
0158 |         gtdLog("TYPE_CONFLICT | " typeName)
0159 |         return
0160 |     }
0161 |     int i
0162 |     for (i = 0; i < count; i++) {
0163 |         if (!gtdHasEnumLabel(at, labels[i], normalize)) {
0164 |             gtdSchemaErrors++
0165 |             gtdLog("ENUM_VALUE_MISSING | " attrName " | " labels[i] " | enum preserved; extend/map explicitly")
0166 |         }
0167 |     }
0168 | }
0169 | 
0170 | void gtdEnsureAttribute(string name, bool moduleScope, string typeName)
0171 | {
0172 |     AttrDef ad = find(gtdSetupModule, name)
0173 |     if (!null ad) {
0174 |         gtdLog("KEEP_ATTRIBUTE | " name)
0175 |         return
0176 |     }
0177 |     noError()
0178 |     if (moduleScope) ad = create module type typeName attribute name
0179 |     else ad = create object type typeName (inherit false) attribute name
0180 |     string err = lastError()
0181 |     if (null ad || !gtdBlank(err)) gtdFail("ATTRIBUTE_CREATE_FAILED | " name " | " err)
0182 |     gtdCreatedAttrs++
0183 |     gtdLog("CREATE_ATTRIBUTE | " name)
0184 | }
0185 | 
0186 | void gtdEnsureEnumeration(string attrName, string typeName, string labels[], int count)
0187 | {
0188 |     AttrDef ad = find(gtdSetupModule, attrName)
0189 |     if (!null ad) {
0190 |         gtdLog("KEEP_ATTRIBUTE | " attrName)
0191 |         return
0192 |     }
0193 |     AttrType at = find(gtdSetupModule, typeName)
0194 |     if (null at) {
0195 |         int values[count]
0196 |         int i
0197 |         for (i = 0; i < count; i++) values[i] = i+1
0198 |         string err = ""
0199 |         noError()
0200 |         at = create(typeName, labels, values, err)
0201 |         string runtimeErr = lastError()
0202 |         if (null at || !gtdBlank(err) || !gtdBlank(runtimeErr))
0203 |             gtdFail("ENUM_CREATE_FAILED | " typeName " | " err " " runtimeErr)
0204 |         gtdLog("CREATE_TYPE | " typeName)
0205 |     }
0206 |     gtdEnsureAttribute(attrName, false, typeName)
0207 | }
0208 | 
0209 | void gtdSetModuleString(string name, string value, bool onlyIfBlank)
0210 | {
0211 |     string old = gtdReadModuleString(name)
0212 |     if (old == value || (onlyIfBlank && !gtdBlank(old))) return
0213 |     noError()
0214 |     gtdSetupModule.(name) = value
0215 |     string err = lastError()
0216 |     if (!gtdBlank(err)) gtdFail("MODULE_VALUE_FAILED | " name " | " err)
0217 |     gtdLog("SET_MODULE_ATTRIBUTE | " name)
0218 | }
0219 | 
0220 | gtdLog("GTD SETUP | " fullName(gtdSetupModule))
0221 | gtdLog("Existing object identities, links, enum definitions and requirement values are preserved.")
0222 | int gtdI
0223 | for (gtdI = 0; gtdI < 16; gtdI++) {
0224 |     string kind = "Text"
0225 |     if (gtdModuleStrings[gtdI] == "Classification") kind = "Choice"
0226 |     gtdCheckAttribute(gtdModuleStrings[gtdI], true, kind)
0227 | }
0228 | gtdCheckAttribute("Document Date", true, "Date")
0229 | for (gtdI = 0; gtdI < 4; gtdI++) gtdCheckAttribute(gtdObjectTexts[gtdI], false, "Text")
0230 | gtdCheckAttribute("Requirement Source Reference", false, "Text")
0231 | gtdCheckAttribute("Requirement Type", false, "Choice")
0232 | gtdCheckAttribute("Verification Method", false, "Choice")
0233 | gtdCheckAttribute("Requirement Source Type", false, "Choice")
0234 | gtdCheckAttribute("GTD Section Key", false, "Key")
0235 | gtdCheckEnumeration("Requirement Type", "GTD Requirement Type", gtdRequirementTypes, 11, true)
0236 | gtdCheckEnumeration("Requirement Source Type", "GTD Requirement Source Type", gtdSourceTypes, 6, false)
0237 | // Existing verification vocabularies are retained; only a missing attribute/type is initialized.
0238 | AttrDef gtdExistingMethod = find(gtdSetupModule, "Verification Method")
0239 | if (null gtdExistingMethod)
0240 |     gtdCheckEnumeration("Verification Method", "GTD Verification Method", gtdVerificationMethods, 5, true)
0241 | if (gtdSchemaErrors > 0) gtdFail("Schema conflicts found. No module changes were made.")
0242 | 
0243 | // Capture the folder of the current package. Existing configured paths are retained.
0244 | string gtdFolder = gtdReadModuleString("GTD Tool Folder")
0245 | if (gtdBlank(gtdFolder)) gtdFolder = gtdFolderOf(gtdReadModuleString("GTD Publisher Script Path"))
0246 | string gtdTracePath = gtdReadModuleString("GTD Trace Link Module")
0247 | bool gtdProceed = false
0248 | DB gtdSetupDb = create("GTD Modul Kurulumu", styleCentered | styleStandard)
0249 | label(gtdSetupDb, "GUNCEL klasorunun tam yolunu girin. Mevcut dosya yolu attribute'lari korunur.")
0250 | DBE gtdFolderField = field(gtdSetupDb, "GTD dosyalarinin klasoru:", gtdFolder, 65, false)
0251 | DBE gtdTraceField = field(gtdSetupDb, "Kaynak link modulu (tam DOORS yolu):", gtdTracePath, 65, false)
0252 | label(gtdSetupDb, "Link modulu henuz belirlenmediyse bos birakilabilir; yayin oncesinde doldurulur.")
0253 | 
0254 | void gtdAcceptSetup(DB db)
0255 | {
0256 |     gtdFolder = gtdTrim(get(gtdFolderField))
0257 |     if (gtdBlank(gtdFolder)) {
0258 |         warningBox "GTD dosyalarinin klasor yolunu girin."
0259 |         return
0260 |     }
0261 |     string enteredTrace = gtdTrim(get(gtdTraceField))
0262 |     if (!gtdBlank(enteredTrace) && enteredTrace[0:0] != "/") {
0263 |         warningBox "Kaynak link modulu / ile baslayan tam DOORS yolu olmali."
0264 |         return
0265 |     }
0266 |     if (gtdBlank(gtdTracePath)) gtdTracePath = enteredTrace
0267 |     else if (enteredTrace != gtdTracePath) {
0268 |         warningBox "Mevcut GTD Trace Link Module degeri korunur. Degistirmek icin module attribute'unu duzenleyin."
0269 |         return
0270 |     }
0271 |     gtdProceed = true
0272 |     release db
0273 | }
0274 | 
0275 | void gtdCancelSetup(DB db)
0276 | {
0277 |     release db
0278 | }
0279 | 
0280 | ok(gtdSetupDb, "Kurulumu calistir", gtdAcceptSetup)
0281 | close(gtdSetupDb, true, gtdCancelSetup)
0282 | realize gtdSetupDb
0283 | block gtdSetupDb
0284 | destroy gtdSetupDb
0285 | if (!gtdProceed) {
0286 |     gtdLog("CANCELLED | No module changes were made.")
0287 |     close(gtdLogStream)
0288 |     halt
0289 | }
0290 | current = gtdSetupModule
0291 | if (baseline(gtdSetupModule) || !isEdit(gtdSetupModule)) gtdFail("Module is no longer editable.")
0292 | 
0293 | int gtdLast = length(gtdFolder)-1
0294 | while (gtdLast >= 0 && (gtdFolder[gtdLast:gtdLast] == "\\" || gtdFolder[gtdLast:gtdLast] == "/")) gtdLast--
0295 | if (gtdLast < 0) gtdFail("Invalid tool folder.")
0296 | gtdFolder = gtdFolder[0:gtdLast]
0297 | string gtdFormPath = gtdReadModuleString("GTD Form Path")
0298 | string gtdTemplatePath = gtdReadModuleString("GTD Word Template Path")
0299 | string gtdBuilderPath = gtdReadModuleString("GTD Publisher Script Path")
0300 | if (gtdBlank(gtdFormPath)) gtdFormPath = gtdFolder "\\GTD_Module_Info.dxl"
0301 | if (gtdBlank(gtdTemplatePath)) gtdTemplatePath = gtdFolder "\\TPL_GTD_Publisher.docx"
0302 | if (gtdBlank(gtdBuilderPath)) gtdBuilderPath = gtdFolder "\\GTD_Build_Document.ps1"
0303 | string gtdControlPath = gtdFolder "\\GTD_Requirement_Review_Control.dxl"
0304 | if (!fileExists_(gtdFormPath)) gtdFail("FILE_MISSING | " gtdFormPath)
0305 | if (!fileExists_(gtdTemplatePath)) gtdFail("FILE_MISSING | " gtdTemplatePath)
0306 | if (!fileExists_(gtdBuilderPath)) gtdFail("FILE_MISSING | " gtdBuilderPath)
0307 | if (!fileExists_(gtdControlPath)) gtdFail("FILE_MISSING | " gtdControlPath)
0308 | string gtdControlCode = readFile(gtdControlPath)
0309 | if (gtdBlank(gtdControlCode)) gtdFail("Control DXL could not be read.")
0310 | 
0311 | // Create the internal state first. Any interrupted run remains visibly incomplete.
0312 | gtdEnsureAttribute("GTD Setup State", true, "String")
0313 | gtdMutationStarted = true
0314 | gtdSetModuleString("GTD Setup State", "INCOMPLETE", false)
0315 | for (gtdI = 0; gtdI < 16; gtdI++) gtdEnsureAttribute(gtdModuleStrings[gtdI], true, "String")
0316 | gtdEnsureAttribute("Document Date", true, "Date")
0317 | for (gtdI = 0; gtdI < 4; gtdI++) gtdEnsureAttribute(gtdObjectTexts[gtdI], false, "Text")
0318 | gtdEnsureAttribute("Requirement Source Reference", false, "String")
0319 | gtdEnsureAttribute("GTD Section Key", false, "String")
0320 | gtdEnsureEnumeration("Requirement Type", "GTD Requirement Type", gtdRequirementTypes, 11)
0321 | gtdEnsureEnumeration("Verification Method", "GTD Verification Method", gtdVerificationMethods, 5)
0322 | gtdEnsureEnumeration("Requirement Source Type", "GTD Requirement Source Type", gtdSourceTypes, 6)
0323 | gtdSetModuleString("GTD Template Version", "GTD_SETUP", true)
0324 | gtdSetModuleString("GTD Form Path", gtdFormPath, true)
0325 | gtdSetModuleString("GTD Word Template Path", gtdTemplatePath, true)
0326 | gtdSetModuleString("GTD Publisher Script Path", gtdBuilderPath, true)
0327 | gtdSetModuleString("GTD Trace Link Module", gtdTracePath, true)
0328 | gtdSetModuleString("GTD Tool Folder", gtdFolder, false)
0329 | 
0330 | // Scan the whole module, including objects hidden by a filter or outline.
0331 | Object gtdCandidates[GTD_SECTION_COUNT]
0332 | Object gtdResolved[GTD_SECTION_COUNT]
0333 | int gtdCandidateCount[GTD_SECTION_COUNT]
0334 | bool gtdIdentityConflict[GTD_SECTION_COUNT]
0335 | for (gtdI = 0; gtdI < GTD_SECTION_COUNT; gtdI++) {
0336 |     gtdCandidates[gtdI] = null
0337 |     gtdResolved[gtdI] = null
0338 |     gtdCandidateCount[gtdI] = 0
0339 |     gtdIdentityConflict[gtdI] = false
0340 | }
0341 | Object gtdScan
0342 | for gtdScan in entire gtdSetupModule do {
0343 |     if (isDeleted(gtdScan)) continue
0344 |     string issue = gtdSectionIdentityIssue(gtdScan)
0345 |     if (issue != "") {
0346 |         gtdReviewNeeded++
0347 |         gtdLog("IDENTITY_CONFLICT | " identifier(gtdScan) " | " issue)
0348 |         int storedIndex = gtdSectionIndex(gtdStoredSectionKey(gtdScan))
0349 |         if (storedIndex >= 0) gtdIdentityConflict[storedIndex] = true
0350 |         if (!table(gtdScan) && !row(gtdScan) && !cell(gtdScan)) {
0351 |             int titleIndex = gtdSectionIndex(sectionKeyForHeading(gtdScan."Object Heading" ""))
0352 |             if (titleIndex >= 0) gtdIdentityConflict[titleIndex] = true
0353 |         }
0354 |     }
0355 |     string key = sectionKeyForObject(gtdScan)
0356 |     int idx = gtdSectionIndex(key)
0357 |     if (idx >= 0) {
0358 |         gtdCandidateCount[idx]++
0359 |         gtdCandidates[idx] = gtdScan
0360 |         gtdLog("FOUND_HEADING | " key " | " identifier(gtdScan))
0361 |     }
0362 | }
0363 | 
0364 | Object gtdCreateHeading(int idx, Object requiredParent)
0365 | {
0366 |     Object nextKnown = null
0367 |     int j
0368 |     for (j = idx+1; j < GTD_SECTION_COUNT; j++) {
0369 |         if (gtdSectionParents[j] != gtdSectionParents[idx]) continue
0370 |         if (gtdCandidateCount[j] != 1 || gtdIdentityConflict[j]) continue
0371 |         Object candidate = gtdCandidates[j]
0372 |         if (parent(candidate) == requiredParent) {
0373 |             nextKnown = candidate
0374 |             break
0375 |         }
0376 |     }
0377 |     Object created = null
0378 |     noError()
0379 |     if (!null nextKnown) created = create before nextKnown
0380 |     else if (!null requiredParent) created = create last below requiredParent
0381 |     else {
0382 |         // create(Module) PREPENDS, so use it only when there is no live root.
0383 |         Object lastRoot = null
0384 |         Object rootObject
0385 |         for rootObject in entire gtdSetupModule do {
0386 |             if (isDeleted(rootObject)) continue
0387 |             if (null parent(rootObject)) lastRoot = rootObject
0388 |         }
0389 |         if (null lastRoot) created = create(gtdSetupModule)
0390 |         else created = create after lastRoot
0391 |     }
0392 |     string err = lastError()
0393 |     if (null created || !gtdBlank(err)) gtdFail("HEADING_CREATE_FAILED | " gtdSectionKeys[idx] " | " err)
0394 |     noError()
0395 |     created."Object Heading" = gtdSectionHeadings[idx]
0396 |     created."GTD Section Key" = gtdSectionKeys[idx]
0397 |     err = lastError()
0398 |     if (!gtdBlank(err)) gtdFail("HEADING_VALUE_FAILED | " gtdSectionKeys[idx] " | " err)
0399 |     gtdCreatedHeadings++
0400 |     gtdLog("CREATE_HEADING | " gtdSectionKeys[idx] " | " identifier(created))
0401 |     return created
0402 | }
0403 | 
0404 | for (gtdI = 0; gtdI < GTD_SECTION_COUNT; gtdI++) {
0405 |     string sectionKey = gtdSectionKeys[gtdI]
0406 |     int parentIdx = gtdSectionParents[gtdI]
0407 |     Object expectedParent = null
0408 |     if (parentIdx >= 0) expectedParent = gtdResolved[parentIdx]
0409 |     if (gtdIdentityConflict[gtdI] || gtdCandidateCount[gtdI] > 1) {
0410 |         gtdBlockedHeadings++
0411 |         gtdLog("BLOCK_HEADING | " sectionKey " | duplicate or conflicting identity; no new heading")
0412 |         continue
0413 |     }
0414 |     if (parentIdx >= 0 && null expectedParent) {
0415 |         gtdBlockedHeadings++
0416 |         gtdLog("BLOCK_HEADING | " sectionKey " | parent unresolved; no new heading")
0417 |         continue
0418 |     }
0419 |     if (gtdCandidateCount[gtdI] == 1) {
0420 |         Object existing = gtdCandidates[gtdI]
0421 |         if (parent(existing) != expectedParent) {
0422 |             gtdBlockedHeadings++
0423 |             string parentLabel = "MODULE_ROOT"
0424 |             if (!null expectedParent) parentLabel = identifier(expectedParent)
0425 |             gtdLog("WRONG_PARENT | " sectionKey " | " identifier(existing) " | expected parent " parentLabel " | move manually, then rerun")
0426 |             continue
0427 |         }
0428 |         if (gtdBlank(gtdStoredSectionKey(existing))) {
0429 |             noError()
0430 |             existing."GTD Section Key" = sectionKey
0431 |             string err = lastError()
0432 |             if (!gtdBlank(err)) gtdFail("HEADING_TAG_FAILED | " identifier(existing) " | " err)
0433 |         }
0434 |         gtdResolved[gtdI] = existing
0435 |         gtdReusedHeadings++
0436 |         gtdLog("REUSE_HEADING | " sectionKey " | " identifier(existing))
0437 |     }
0438 |     else gtdResolved[gtdI] = gtdCreateHeading(gtdI, expectedParent)
0439 | }
0440 | 
0441 | bool gtdViewExists(string viewName)
0442 | {
0443 |     string candidate
0444 |     for candidate in views(gtdSetupModule) do
0445 |         if (candidate == viewName) return true
0446 |     return false
0447 | }
0448 | 
0449 | void gtdAppendColumn(string attrName, int colWidth)
0450 | {
0451 |     int n = 0
0452 |     Column c
0453 |     for c in gtdSetupModule do n++
0454 |     c = insert column n
0455 |     attribute(c, attrName)
0456 |     title(c, attrName)
0457 |     width(c, colWidth)
0458 | }
0459 | 
0460 | void gtdEnsureView(string viewName, bool review)
0461 | {
0462 |     bool viewAlreadyExists = gtdViewExists(viewName)
0463 |     View v = view(viewName)
0464 |     noError()
0465 |     if (viewAlreadyExists) {
0466 |         bool loaded = load(v)
0467 |         string loadErr = lastError()
0468 |         if (!loaded || !gtdBlank(loadErr)) gtdFail("VIEW_LOAD_FAILED | " viewName " | " loadErr)
0469 |         if (!review) {
0470 |             gtdLog("KEEP_VIEW | " viewName)
0471 |             return
0472 |         }
0473 |     }
0474 |     else {
0475 |         bool standardLoaded = load(view("Standard view"))
0476 |         string loadErr = lastError()
0477 |         if (!standardLoaded || !gtdBlank(loadErr)) gtdFail("Standard view could not be loaded.")
0478 |         // Only the unsaved display is rebuilt; no existing saved view is replaced.
0479 |         Column c
0480 |         int oldColumnCount = 0
0481 |         for c in gtdSetupModule do oldColumnCount++
0482 |         int ci
0483 |         for (ci = 0; ci < oldColumnCount; ci++) delete(column 0)
0484 |         c = insert column 0
0485 |         attribute(c, "Object Identifier")
0486 |         title(c, "ID")
0487 |         width(c, 100)
0488 |         c = insert column 1
0489 |         main(c)
0490 |         title(c, "Baslik / Metin")
0491 |         width(c, 450)
0492 |         gtdAppendColumn("Requirement Type", 140)
0493 |         gtdAppendColumn("Verification Method", 130)
0494 |         gtdAppendColumn("Verification Reference", 160)
0495 |         gtdAppendColumn("Requirement Source Type", 175)
0496 |         gtdAppendColumn("Requirement Source Reference", 210)
0497 |         if (!review) {
0498 |             gtdAppendColumn("Rationale", 200)
0499 |             gtdAppendColumn("Remarks", 180)
0500 |             gtdAppendColumn("Traceability Note", 200)
0501 |         }
0502 |     }
0503 |     bool changed = !viewAlreadyExists
0504 |     if (review) {
0505 |         Column controlColumn = null
0506 |         Column col
0507 |         int n = 0
0508 |         int controlCount = 0
0509 |         for col in gtdSetupModule do {
0510 |             if (title(col) == "Control") {
0511 |                 controlColumn = col
0512 |                 controlCount++
0513 |             }
0514 |             n++
0515 |         }
0516 |         if (controlCount > 1) {
0517 |             gtdReviewNeeded++
0518 |             gtdLog("VIEW_CONFLICT | Requirement Review has multiple Control columns; kept unchanged")
0519 |             return
0520 |         }
0521 |         bool controlWasMissing = null controlColumn
0522 |         if (controlWasMissing) {
0523 |             controlColumn = insert column n
0524 |             title(controlColumn, "Control")
0525 |             width(controlColumn, 300)
0526 |             changed = true
0527 |         }
0528 |         string oldCode = ""
0529 |         if (!controlWasMissing && gtdBlank(attrName(controlColumn)) && !main(controlColumn)) oldCode = dxl(controlColumn)
0530 |         else if (!controlWasMissing && viewAlreadyExists) {
0531 |             gtdReviewNeeded++
0532 |             gtdLog("VIEW_CONFLICT | Control title belongs to a non-DXL column; kept unchanged")
0533 |             return
0534 |         }
0535 |         if (oldCode != gtdControlCode) {
0536 |             dxl(controlColumn, gtdControlCode)
0537 |             changed = true
0538 |         }
0539 |     }
0540 |     if (changed) {
0541 |         noError()
0542 |         refresh(gtdSetupModule)
0543 |         string refreshErr = lastError()
0544 |         if (!gtdBlank(refreshErr)) gtdFail("VIEW_REFRESH_FAILED | " viewName " | " refreshErr)
0545 |         noError()
0546 |         if (viewAlreadyExists) save(v)
0547 |         else {
0548 |             // Default view access inheritance is retained; no module ACL is changed.
0549 |             ViewDef def = create(gtdSetupModule, true)
0550 |             useWindows(def, false)
0551 |             save(gtdSetupModule, v, def)
0552 |         }
0553 |         string err = lastError()
0554 |         if (!gtdBlank(err)) gtdFail("VIEW_SAVE_FAILED | " viewName " | " err)
0555 |         if (viewAlreadyExists) {
0556 |             gtdUpdatedViews++
0557 |             gtdLog("UPDATE_CONTROL_ONLY | " viewName)
0558 |         }
0559 |         else {
0560 |             gtdCreatedViews++
0561 |             gtdLog("CREATE_VIEW | " viewName)
0562 |         }
0563 |     }
0564 |     else gtdLog("KEEP_VIEW | " viewName)
0565 | }
0566 | 
0567 | gtdEnsureView("Requirement Entry", false)
0568 | gtdEnsureView("Requirement Review", true)
0569 | noError()
0570 | bool gtdReviewLoaded = load(view("Requirement Review"))
0571 | string gtdReviewLoadError = lastError()
0572 | if (!gtdReviewLoaded || !gtdBlank(gtdReviewLoadError)) gtdFail("Requirement Review view could not be loaded.")
0573 | string gtdFinalState = "READY"
0574 | if (gtdBlockedHeadings > 0 || gtdReviewNeeded > 0) gtdFinalState = "NEEDS_REVIEW"
0575 | gtdSetModuleString("GTD Setup State", gtdFinalState, false)
0576 | noError()
0577 | save(gtdSetupModule)
0578 | string gtdSaveError = lastError()
0579 | if (!gtdBlank(gtdSaveError)) gtdFail("MODULE_SAVE_FAILED | " gtdSaveError)
0580 | gtdLog("SUMMARY | state=" gtdFinalState " | attributes created=" gtdCreatedAttrs " | headings created=" gtdCreatedHeadings " | headings reused=" gtdReusedHeadings " | headings blocked=" gtdBlockedHeadings " | views created=" gtdCreatedViews " | views updated=" gtdUpdatedViews)
0581 | gtdLog("Move existing requirements as existing objects under the proper headings; fill missing values manually.")
0582 | gtdLog("No baseline was created. Document Revision, Document Date and Prefix were not assigned by setup.")
0583 | close(gtdLogStream)
0584 | ack "GTD setup tamamlandi.\nDurum: " gtdFinalState "\n\nOlusturulan baslik: " gtdCreatedHeadings "\nKullanilan mevcut baslik: " gtdReusedHeadings "\nCozum bekleyen baslik: " gtdBlockedHeadings "\n\nLog:\n" gtdLogPath "\n\nGereksinimleri uygun basliklarin altina mevcut nesneleriyle tasiyin."
0585 | 
0586 | // The metadata dialog is part of the same entry-point run when data is missing.
0587 | // It saves only on the user's Kaydet action, using the existing project form.
0588 | bool gtdInfoMissing = gtdBlank(gtdReadModuleString("System Name")) ||
0589 |     gtdBlank(gtdReadModuleString("Document Number")) ||
0590 |     gtdBlank(gtdReadModuleString("Document Revision")) ||
0591 |     gtdBlank(gtdReadModuleString("Project Name")) ||
0592 |     gtdBlank(gtdReadModuleString("Project Number")) ||
0593 |     gtdBlank(gtdReadModuleString("Department")) ||
0594 |     gtdBlank(gtdReadModuleString("Classification")) ||
0595 |     gtdBlank(gtdSetupModule."Prefix" "")
0596 | Date gtdInfoDate = gtdSetupModule."Document Date"
0597 | if (null gtdInfoDate) gtdInfoMissing = true
0598 | if (gtdInfoMissing && gtdFinalState == "READY") {
0599 |     string formCode = readFile(gtdFormPath)
0600 |     if (!gtdBlank(formCode)) {
0601 |         string formError = eval_(formCode)
0602 |         if (!gtdBlank(formError)) ack "GTD_Module_Info formu calistirilamadi:\n" formError
0603 |     }
0604 | }
````


### PROJECT_FILES/GTD/BAKIM/verify_package.py

SHA256 (original bytes): `5e96d3147ccc1f3a56a334fa6f6031f51591588d139c42fc5bdb3ba6a270cb3c`  
Lines: 123. Line-number prefixes are for review only.

````text
0001 | """Static cross-file contracts. This is not a DOORS/DXL execution test."""
0002 | from pathlib import Path
0003 | from zipfile import ZipFile
0004 | import hashlib
0005 | import json
0006 | import re
0007 | import xml.etree.ElementTree as ET
0008 | 
0009 | ROOT = Path(__file__).resolve().parents[1]
0010 | if (ROOT/'ORIJINAL_DOSYALAR').is_dir():
0011 |     SRC, OUT = ROOT/'ORIJINAL_DOSYALAR', ROOT/'GUNCEL'
0012 | else:
0013 |     SRC, OUT = ROOT/'upload', ROOT/'output/GTD/GUNCEL'
0014 | 
0015 | results = []
0016 | def check(label, condition):
0017 |     results.append((label, bool(condition)))
0018 |     if not condition:
0019 |         raise AssertionError(label)
0020 | 
0021 | def array(code, name):
0022 |     return re.search(r'\b'+re.escape(name)+r'\[\]\s*=\s*\{(.*?)\}', code, re.S).group(1)
0023 | 
0024 | def strings(body):
0025 |     # Constant string concatenation plus the established headingBytes helper.
0026 |     pattern = r'"(?:[^"\\]|\\.)*"|headingBytes\(\d+,\s*-?\d+,\s*-?\d+\)|,'
0027 |     items, current = [], bytearray()
0028 |     for token in re.findall(pattern, body):
0029 |         if token == ',':
0030 |             items.append(current.decode('utf-8')); current = bytearray()
0031 |         elif token.startswith('"'):
0032 |             current.extend(json.loads(token).encode('utf-8'))
0033 |         else:
0034 |             current.extend(x for x in map(int,re.findall(r'-?\d+',token)) if x >= 0)
0035 |     if current: items.append(current.decode('utf-8'))
0036 |     return items
0037 | 
0038 | def scrub(code):
0039 |     # Preserve line breaks while removing comments and quoted strings.
0040 |     return re.sub(r'//[^\n]*|/\*.*?\*/|"(?:[^"\\]|\\.)*"', lambda m:'\n'*m.group().count('\n'), code, flags=re.S)
0041 | 
0042 | def balanced(code):
0043 |     stack = []
0044 |     close = {')':'(',']':'[','}':'{'}
0045 |     for c in scrub(code):
0046 |         if c in '([{': stack.append(c)
0047 |         elif c in close:
0048 |             if not stack or stack.pop() != close[c]: return False
0049 |     return not stack
0050 | 
0051 | codes = {p.name:p.read_text() for p in OUT.glob('*.dxl')}
0052 | setup = codes['GTD_Setup_Module.dxl']
0053 | publisher = codes['GTD_Publish.dxl']
0054 | control = codes['GTD_Requirement_Review_Control.dxl']
0055 | for name,code in codes.items():
0056 |     check('Balanced DXL delimiters: '+name, balanced(code))
0057 |     check('No generation placeholders: '+name, 'INSERT SECTION MODEL HERE' not in code and 'INSERT ENUM LABELS HERE' not in code)
0058 | 
0059 | blocks = [re.search(r'// BEGIN GTD SECTION MODEL.*?// END GTD SECTION MODEL',code,re.S).group() for code in (setup,publisher,control)]
0060 | check('The three section models are identical', len(set(blocks)) == 1)
0061 | keys = strings(array(setup,'gtdSectionKeys'))
0062 | headings = strings(array(setup,'gtdSectionHeadings'))
0063 | parents = [int(x) for x in re.findall(r'-?\d+',array(setup,'gtdSectionParents'))]
0064 | check('28 unique headings with valid parents', len(keys) == len(headings) == len(parents) == 28 and len(set(keys)) == 28 and all(-1 <= p < i for i,p in enumerate(parents)))
0065 | 
0066 | ns = {'w':'http://schemas.openxmlformats.org/wordprocessingml/2006/main'}
0067 | w = '{'+ns['w']+'}'
0068 | with ZipFile(SRC/'TPL_GTD_Publisher.docx') as z:
0069 |     root = ET.fromstring(z.read('word/document.xml'))
0070 |     template_heads, template_parents, stack, markers = [], [], [], []
0071 |     in_scope = False
0072 |     verification = []
0073 |     in_verification = False
0074 |     for para in root.findall('./w:body/w:p',ns):
0075 |         text = ''.join(t.text or '' for t in para.findall('.//w:t',ns)).strip()
0076 |         st = para.find('./w:pPr/w:pStyle',ns)
0077 |         style = st.get(w+'val','') if st is not None else ''
0078 |         if text == 'GENEL' and style == 'Heading1': in_scope = True
0079 |         if text == 'GEREKSİNİM DOĞRULAMA YÖNTEMİ': in_scope = False; in_verification = True
0080 |         if text == 'İZLENEBİLİRLİK MATRİSİ': in_verification = False
0081 |         if in_verification and style == 'Heading2': verification.append(text)
0082 |         if not in_scope: continue
0083 |         if re.fullmatch(r'Heading[123]',style):
0084 |             level = int(style[-1])
0085 |             stack = stack[:level-1]
0086 |             template_parents.append(stack[-1] if stack else -1)
0087 |             template_heads.append(text)
0088 |             stack.append(len(template_heads)-1)
0089 |         markers.extend(re.findall(r'\{\{((?:SEC_|REQ_)[A-Z_]+)\}\}',text))
0090 | check('Setup heading text and hierarchy equal the Word template sections 1–3', headings == template_heads and parents == template_parents)
0091 | content_keys = [k for k in keys if not k.startswith(('ROOT_','GROUP_'))]
0092 | marker_keys = [x[4:] if x.startswith('SEC_') else x for x in markers]
0093 | check('24 content keys cover every Word placeholder exactly once', len(marker_keys) == 24 and set(marker_keys) == set(content_keys) and len(set(marker_keys)) == 24)
0094 | builder = (OUT/'GTD_Build_Document.ps1').read_text(encoding='utf-8-sig')
0095 | ordered_block = re.search(r'\$orderedMarkers\s*=\s*@\{(.*?)\n\s*\}',builder,re.S).group(1)
0096 | ps_keys = re.findall(r'"([A-Z_]+)"\s*=',ordered_block)
0097 | check('PowerShell consumes all 24 mapped sections', set(ps_keys) == set(content_keys))
0098 | check('New verification choices match Word section 4', strings(array(setup,'gtdVerificationMethods')) == verification)
0099 | original_sources = strings(re.search(r'enumNames\[6\]\s*=\s*\{(.*?)\}',(SRC/'GTD_Setup_Requirement_Source_Attributes.dxl').read_text(),re.S).group(1))
0100 | check('All six requirement source choices are preserved', strings(array(setup,'gtdSourceTypes')) == original_sources)
0101 | 
0102 | defined = set(strings(array(setup,'gtdModuleStrings')) + strings(array(setup,'gtdObjectTexts')))
0103 | defined.update(re.findall(r'gtdEnsureAttribute\("([^"]+)"',setup))
0104 | defined.update(re.findall(r'gtdEnsureEnumeration\("([^"]+)"',setup))
0105 | used = set(re.findall(r'\b\w+\."([^"\n]+)"','\n'.join(codes.values())))
0106 | check('Every literal custom attribute read is created by setup', used <= defined | {'Object Heading','Object Text','Prefix'})
0107 | check('Setup has no object move, delete, link or enum modify operation', re.search(r'\b(move|hardDelete|softDelete|modify|createLink|createBaseline)\s*\(',scrub(setup)) is None)
0108 | object_writes = set(re.findall(r'\b(?:created|existing)\."([^"]+)"\s*=',setup))
0109 | check('Setup writes only heading text and section key on objects', object_writes == {'Object Heading','GTD Section Key'})
0110 | check('Setup never assigns Prefix, Document Date or Document Revision', not re.search(r'gtdSetModuleString\("(?:Prefix|Document Date|Document Revision)"',setup) and not re.search(r'\."(?:Prefix|Document Date|Document Revision)"\s*=',setup))
0111 | check('Section key creation explicitly disables inheritance', '(inherit false)' in setup)
0112 | check('Managed publishing has no sibling fallback', publisher.count('&& !gtdManagedStructure)') == 4)
0113 | check('Headings and pictures excluded from requirement and matrix records', 'gtdBlank(ownHeading) && gtdBlank(getPictName(so))' in publisher and 'gtdBlank(o."Object Heading" "") && gtdBlank(getPictName(o))' in publisher)
0114 | 
0115 | installer = codes['GTD_Install_Open_Trigger.dxl']
0116 | embedded = ''.join(json.loads(x) for x in re.findall(r'gtdTriggerCode \+= ("(?:[^"\\]|\\.)*")',installer))
0117 | check('Installed trigger body equals the readable open-check file', embedded == codes['GTD_Open_Check.dxl'])
0118 | for name in ['TPL_GTD_Publisher.docx','GTD_Build_Document.ps1']:
0119 |     check('Original bytes preserved: '+name,(SRC/name).read_bytes() == (OUT/name).read_bytes())
0120 | for name in ['GTD_Setup_Module.dxl','GTD_Publish.dxl','GTD_Requirement_Review_Control.dxl']:
0121 |     check('Encoding-independent ASCII DXL source: '+name, codes[name].isascii())
0122 | for label, ok in results: print(('PASS | ' if ok else 'FAIL | ')+label)
0123 | print(f'\n{len(results)} static contract checks passed. DOORS compilation and execution were not performed.')
````



# Original source attribute helper — historical input


### PROJECT_FILES/GTD/ORIJINAL_DOSYALAR/GTD_Setup_Requirement_Source_Attributes.dxl

SHA256 (original bytes): `0109d5be70542704fe51536743458928a8884b077423c75871303fd8ac1ecd56`  
Lines: 85. Line-number prefixes are for review only.

````text
0001 | // ============================================================
0002 | // GTD one-time setup - Requirement Source attributes
0003 | // Run from the target formal module in Exclusive Edit mode.
0004 | // ============================================================
0005 | 
0006 | pragma runLim, 0
0007 | 
0008 | Module m = current
0009 | if (null m) {
0010 |     ack "Acik bir formal module bulunamadi."
0011 |     halt
0012 | }
0013 | 
0014 | if (!isEdit(m)) {
0015 |     ack "Bu kurulum attribute type/definition olusturur.\nModulu Exclusive Edit modunda acip tekrar calistirin."
0016 |     halt
0017 | }
0018 | 
0019 | string sourceTypeName = "GTD Requirement Source Type"
0020 | string sourceAttrName = "Requirement Source Type"
0021 | string sourceRefAttrName = "Requirement Source Reference"
0022 | 
0023 | // ------------------------------------------------------------
0024 | // 1) Enumerated attribute type
0025 | // ------------------------------------------------------------
0026 | AttrType atSource = find(m, sourceTypeName)
0027 | if (null atSource) {
0028 |     string enumNames[6] = {
0029 |         "Higher-Level Requirement",
0030 |         "Derived",
0031 |         "Standard / Regulation",
0032 |         "Interface",
0033 |         "Safety Analysis",
0034 |         "Other"
0035 |     }
0036 |     int enumValues[6] = {1, 2, 3, 4, 5, 6}
0037 |     int enumColors[6] = {-1, -1, -1, -1, -1, -1}
0038 |     string errType = ""
0039 | 
0040 |     atSource = create(sourceTypeName, enumNames, enumValues, enumColors, errType)
0041 |     if (null atSource || errType != "") {
0042 |         ack "Requirement Source enumeration type olusturulamadi:\n" errType
0043 |         halt
0044 |     }
0045 | }
0046 | 
0047 | // ------------------------------------------------------------
0048 | // 2) Object attribute using the enumeration type
0049 | // ------------------------------------------------------------
0050 | AttrDef adSource = find(m, sourceAttrName)
0051 | if (null adSource) {
0052 |     noError()
0053 |     adSource = create object type sourceTypeName attribute sourceAttrName
0054 |     string errSource = lastError()
0055 |     if (null adSource || (!null errSource && errSource != "")) {
0056 |         ack "Requirement Source Type attribute olusturulamadi:\n" errSource
0057 |         halt
0058 |     }
0059 | }
0060 | else if (!adSource.object) {
0061 |     ack "Requirement Source Type mevcut fakat Object Attribute degil.\nLutfen attribute tanimini kontrol edin."
0062 |     halt
0063 | }
0064 | 
0065 | // ------------------------------------------------------------
0066 | // 3) Free-text reference for standards / ICD / safety analysis etc.
0067 | // ------------------------------------------------------------
0068 | AttrDef adRef = find(m, sourceRefAttrName)
0069 | if (null adRef) {
0070 |     noError()
0071 |     adRef = create object type "String" attribute sourceRefAttrName
0072 |     string errRef = lastError()
0073 |     if (null adRef || (!null errRef && errRef != "")) {
0074 |         ack "Requirement Source Reference attribute olusturulamadi:\n" errRef
0075 |         halt
0076 |     }
0077 | }
0078 | else if (!adRef.object) {
0079 |     ack "Requirement Source Reference mevcut fakat Object Attribute degil.\nLutfen attribute tanimini kontrol edin."
0080 |     halt
0081 | }
0082 | 
0083 | save(m)
0084 | 
0085 | ack "GTD requirement source alanlari hazir.\n\nRequirement Source Type:\n- Higher-Level Requirement\n- Derived\n- Standard / Regulation\n- Interface\n- Safety Analysis\n- Other\n\nRequirement Source Reference: String\n\nBu iki attribute'u module view'a kolon olarak ekleyebilirsiniz."
````



---

# Original-to-current differences


Diff line numbers refer to original and current files. NEW setup has no original main counterpart; its full current source appears above. Unchanged file hashes were compared against the uploads.


## DIFFS/GTD_Publish.dxl.diff


````diff
--- ORIJINAL_DOSYALAR/GTD_Publish.dxl
+++ GUNCEL/GTD_Publish.dxl
@@ -85,9 +85,9 @@
 // Requirement source classification. These are object attributes.
 AttrDef adSourceType = find(m, "Requirement Source Type")
 AttrDef adSourceReference = find(m, "Requirement Source Reference")
 if (null adSourceType || null adSourceReference) {
-    ack "Requirement source attributes are missing.\nRun GTD_Setup_Requirement_Source_Attributes.dxl once while the module is open in Exclusive Edit mode."
+    ack "Requirement source attributes are missing.\nRun GTD_Setup_Module.dxl once while the module is open in Exclusive Edit mode."
     halt
 }
 
 string systemName       = m."System Name" ""
@@ -162,8 +162,9 @@
 //   by checking the END of the normalized heading.
 // - Parent lookup starts at parent(x), never at x itself.
 // ------------------------------------------------------------
 // All source characters are ASCII. Construct runtime bytes explicitly.
+// BEGIN GTD SECTION MODEL - keep identical in setup, publisher and Control.
 string headingBytes(int first, int second, int third)
 {
     Buffer b = create
     char c1 = charOf(first)
@@ -310,8 +311,70 @@
     }
     return true
 }
 
+const int GTD_SECTION_COUNT = 28
+string gtdSectionKeys[] = {
+    "ROOT_GENEL",
+    "AMAC",
+    "KAPSAM",
+    "PROJE_TANITIMI",
+    "SISTEM_GENEL",
+    "URUN_GENEL",
+    "GROUP_KISALTMALAR_TANIMLAR",
+    "KISALTMALAR",
+    "TANIMLAR",
+    "UYGULANABILIR_DOKUMANLAR",
+    "STANDARTLAR",
+    "DIGER_DOKUMANLAR",
+    "ROOT_SISTEM_TANIMLAMASI",
+    "DURUM_MODLAR",
+    "OMUR_DONGUSU",
+    "SINIRLAMALAR",
+    "ROOT_GEREKSINIMLER",
+    "REQ_ISLEVSEL",
+    "REQ_PERFORMANS",
+    "REQ_FIZIKSEL",
+    "REQ_ARAYUZ",
+    "REQ_CEVRESEL",
+    "REQ_EMNIYET",
+    "REQ_ELD",
+    "REQ_GUV_GIZ",
+    "REQ_ERGONOMI",
+    "REQ_MARKALAMA",
+    "REQ_BILGISAYAR"
+}
+string gtdSectionHeadings[] = {
+    "GENEL",
+    "Ama" headingBytes(195, 167, -1),
+    "Kapsam",
+    "Proje Tan" headingBytes(196, 177, -1) "t" headingBytes(196, 177, -1) "m" headingBytes(196, 177, -1),
+    "Sisteme Genel Bak" headingBytes(196, 177, -1) headingBytes(197, 159, -1),
+    headingBytes(195, 156, -1) "r" headingBytes(195, 188, -1) "ne Genel Bak" headingBytes(196, 177, -1) headingBytes(197, 159, -1),
+    "K" headingBytes(196, 177, -1) "saltmalar/Tan" headingBytes(196, 177, -1) "mlar",
+    "K" headingBytes(196, 177, -1) "saltmalar",
+    "Tan" headingBytes(196, 177, -1) "mlar",
+    "Uygulanabilir Dok" headingBytes(195, 188, -1) "manlar",
+    "Standartlar",
+    "Di" headingBytes(196, 159, -1) "er Dok" headingBytes(195, 188, -1) "manlar",
+    "S" headingBytes(196, 176, -1) "STEM" headingBytes(196, 176, -1) "N TANIMLAMASI",
+    "Durum ve Modlar",
+    headingBytes(195, 150, -1) "m" headingBytes(195, 188, -1) "r D" headingBytes(195, 182, -1) "ng" headingBytes(195, 188, -1) "s" headingBytes(195, 188, -1),
+    "S" headingBytes(196, 177, -1) "n" headingBytes(196, 177, -1) "rlamalar",
+    "GEREKS" headingBytes(196, 176, -1) "N" headingBytes(196, 176, -1) "MLER",
+    headingBytes(196, 176, -1) headingBytes(197, 159, -1) "levsel Gereksinimler",
+    "Performans Gereksinimleri",
+    "Fiziksel Gereksinimler",
+    "Aray" headingBytes(195, 188, -1) "z Gereksinimleri",
+    headingBytes(195, 135, -1) "evresel Gereksinimler",
+    "Emniyet Gereksinimleri",
+    "Entegre Lojistik Destek Gereksinimleri",
+    "G" headingBytes(195, 188, -1) "venlik ve Gizlilik Gereksinimleri",
+    "Ergonomi Gereksinimleri",
+    "Markalama ve Etiketleme Gereksinimleri",
+    "Bilgisayar Kaynak Gereksinimleri"
+}
+int gtdSectionParents[] = {-1, 0, 0, 0, 3, 3, 0, 6, 6, 0, 9, 9, -1, 12, 12, 12, -1, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16}
 string sectionKeyForHeading(string h)
 {
     if (headingEndsWith(h, "amac")) return "AMAC"
     if (headingEndsWith(h, "kapsam")) return "KAPSAM"
@@ -340,8 +403,14 @@
     if (headingEndsWith(h, "ergonomigereksinimleri")) return "REQ_ERGONOMI"
     if (headingEndsWith(h, "markalamaveetiketlemegereksinimleri")) return "REQ_MARKALAMA"
     if (headingEndsWith(h, "bilgisayarkaynakgereksinimleri")) return "REQ_BILGISAYAR"
 
+    if (headingEndsWith(h, "genel")) return "ROOT_GENEL"
+    if (headingEndsWith(h, "kisaltmalar/tanimlar")) return "GROUP_KISALTMALAR_TANIMLAR"
+    if (headingEndsWith(h, "kisaltmalarvetanimlar")) return "GROUP_KISALTMALAR_TANIMLAR"
+    if (headingEndsWith(h, "sistemintanimlamasi")) return "ROOT_SISTEM_TANIMLAMASI"
+    if (headingEndsWith(h, "sistemintanimi")) return "ROOT_SISTEM_TANIMLAMASI"
+    if (headingEndsWith(h, "gereksinimler")) return "ROOT_GEREKSINIMLER"
     return ""
 }
 
 bool isContentSection(string k)
@@ -390,28 +459,83 @@
     if (k == "REQ_BILGISAYAR") return true
     return false
 }
 
-// IMPORTANT: this starts at parent(x), not x.
-// It therefore means "which recognized section contains x?"
+
+int gtdSectionIndex(string key)
+{
+    int i
+    for (i = 0; i < GTD_SECTION_COUNT; i++)
+        if (gtdSectionKeys[i] == key) return i
+    return -1
+}
+
+bool gtdBlank(string s)
+{
+    int i
+    for (i = 0; i < length(s); i++) {
+        string c = s[i:i]
+        if (c != " " && c != "\t" && c != "\r" && c != "\n") return false
+    }
+    return true
+}
+
+string gtdStoredSectionKey(Object o)
+{
+    if (null o) return ""
+    Module om = module(o)
+    AttrDef ad = find(om, "GTD Section Key")
+    if (null ad || !ad.object) return ""
+    return o."GTD Section Key" ""
+}
+
+string sectionKeyForObject(Object o)
+{
+    if (null o || isDeleted(o)) return ""
+    if (table(o) || row(o) || cell(o)) return ""
+    if (!gtdBlank(getPictName(o))) return ""
+    string h = o."Object Heading" ""
+    if (gtdBlank(h)) return ""
+    string key = gtdStoredSectionKey(o)
+    // A nonempty unknown key must not fall back to the visible title.
+    if (!gtdBlank(key)) {
+        if (gtdSectionIndex(key) >= 0) return key
+        return ""
+    }
+    return sectionKeyForHeading(h)
+}
+
+string gtdSectionIdentityIssue(Object o)
+{
+    string stored = gtdStoredSectionKey(o)
+    if (gtdBlank(stored)) return ""
+    if (table(o) || row(o) || cell(o)) return "SECTION_KEY_ON_TABLE"
+    if (gtdSectionIndex(stored) < 0) return "UNKNOWN_SECTION_KEY"
+    string h = o."Object Heading" ""
+    if (gtdBlank(h)) return "SECTION_KEY_WITHOUT_HEADING"
+    string pict = getPictName(o)
+    if (!gtdBlank(pict)) return "SECTION_KEY_ON_PICTURE"
+    string titleKey = sectionKeyForHeading(h)
+    if (titleKey != "" && titleKey != stored) return "SECTION_KEY_TITLE_CONFLICT"
+    return ""
+}
+
+// Start at the parent: a section heading is not its own requirement.
+// A recognized container closes the search; do not inherit a stale section.
 string sectionKeyFromParents(Object x)
 {
     Object p = parent(x)
-
     while (!null p) {
-        if (!table(p) && !row(p) && !cell(p)) {
-            string h = p."Object Heading" ""
-            string k = sectionKeyForHeading(h)
-
-            if (k != "")
-                return k
-        }
-
+        string key = sectionKeyForObject(p)
+        if (key != "") {
+            if (isContentSection(key)) return key
+            return ""
+        }
         p = parent(p)
     }
-
     return ""
 }
+// END GTD SECTION MODEL
 
 // Self-check both source encodings before processing module objects.
 string checkAnsi = "Ama" headingBytes(231, -1, -1)
 string checkUtf8 = "Ama" headingBytes(195, 167, -1)
@@ -424,8 +548,77 @@
     ack "Heading normalization self-check failed. Export stopped."
     halt
 }
 
+
+// Managed modules use hierarchy, never the legacy sibling fallback.
+AttrDef gtdKeyAttr = find(m, "GTD Section Key")
+bool gtdManagedStructure = !null gtdKeyAttr
+if (gtdManagedStructure) {
+    Buffer structureIssues = create
+    if (gtdBlank(systemName) || gtdBlank(documentNumber) || gtdBlank(documentRevision) ||
+        gtdBlank(documentDate) || gtdBlank(projectName) || gtdBlank(projectNumber) ||
+        gtdBlank(department) || gtdBlank(classification) || gtdBlank(m."Prefix" ""))
+        structureIssues += "Required document metadata is missing; run GTD_Module_Info.dxl.\n"
+    AttrDef setupStateAttr = find(m, "GTD Setup State")
+    if (null setupStateAttr || !setupStateAttr.module)
+        structureIssues += "GTD Setup State missing; run GTD_Setup_Module.dxl.\n"
+    else {
+        string setupState = m."GTD Setup State" ""
+        if (setupState != "READY")
+            structureIssues += "Setup is incomplete; resolve the setup log and run it again.\n"
+    }
+    int sectionCount[GTD_SECTION_COUNT]
+    int si
+    for (si = 0; si < GTD_SECTION_COUNT; si++) sectionCount[si] = 0
+    Object checkObject
+    for checkObject in entire m do {
+        if (isDeleted(checkObject)) continue
+        string issue = gtdSectionIdentityIssue(checkObject)
+        if (issue != "") structureIssues += identifier(checkObject) " : " issue "\n"
+        if (table(checkObject) || row(checkObject) || cell(checkObject)) continue
+        string key = sectionKeyForObject(checkObject)
+        int idx = gtdSectionIndex(key)
+        if (idx >= 0) {
+            sectionCount[idx]++
+            Object p = parent(checkObject)
+            int pi = gtdSectionParents[idx]
+            string expectedParent = ""
+            if (pi >= 0) expectedParent = gtdSectionKeys[pi]
+            string actualParent = sectionKeyForObject(p)
+            bool wrongParent = false
+            if (pi < 0 && !null p) wrongParent = true
+            if (pi >= 0 && (null p || actualParent != expectedParent)) wrongParent = true
+            if (wrongParent) structureIssues += identifier(checkObject) " : WRONG_PARENT " key "\n"
+        }
+        string rt = checkObject."Requirement Type" ""
+        string txt = checkObject."Object Text" ""
+        string head = checkObject."Object Heading" ""
+        if (!gtdBlank(rt) && !gtdBlank(txt) && gtdBlank(head) && gtdBlank(getPictName(checkObject))) {
+            string containing = sectionKeyFromParents(checkObject)
+            if (!isRequirementSection(containing))
+                structureIssues += identifier(checkObject) " : REQUIREMENT_OUTSIDE_SECTION\n"
+        }
+    }
+    for (si = 0; si < GTD_SECTION_COUNT; si++)
+        if (sectionCount[si] != 1)
+            structureIssues += gtdSectionKeys[si] " : expected one heading; found " sectionCount[si] "\n"
+    if (length(stringOf(structureIssues)) > 0) {
+        string structureLog = tempFileName() "_GTD_Structure_Check.txt"
+        Stream structureOut = write(structureLog)
+        if (!null structureOut) {
+            structureOut << stringOf(structureIssues)
+            close(structureOut)
+        }
+        print stringOf(structureIssues)
+        close(out)
+        ack "GTD bolum yapisi tamamlanmamis. Yayin durduruldu.\nSetup'i tekrar calistirin.\n\nKontrol raporu:\n" structureLog
+        delete(structureIssues)
+        halt
+    }
+    delete(structureIssues)
+}
+
 bool oldTableContents = tableContents(m)
 tableContents(true)
 
 Object so
@@ -454,12 +647,12 @@
             ownHeading = so."Object Heading" ""
             ownLevel = level(so)
 
             if (ownHeading != "")
-                ownSection = sectionKeyForHeading(ownHeading)
-
-            // A recognized heading ALWAYS wins and immediately becomes active.
-            if (ownSection != "") {
+                ownSection = sectionKeyForObject(so)
+
+            // A content heading becomes active; a container closes sibling context.
+            if (isContentSection(ownSection)) {
                 activeSection = ownSection
                 activeSectionLevel = ownLevel
             }
             else if (ownHeading != "") {
@@ -476,16 +669,16 @@
         if (!table(so) && !row(so) && !cell(so)) {
 
             string narrativeSection = ""
 
-            string directSection = sectionKeyForHeading(ownHeading)
+            string directSection = sectionKeyForObject(so)
 
             if (directSection != "")
                 narrativeSection = directSection
             else {
                 narrativeSection = sectionKeyFromParents(so)
 
-                if (narrativeSection == "")
+                if (narrativeSection == "" && !gtdManagedStructure)
                     narrativeSection = activeSection
             }
 
             if (narrativeSection == "") {
@@ -506,9 +699,9 @@
                 // the REQ branch below. Any other Object Text is a normal TEXT
                 // event and remains in sequence.
                 bool emitAsText = true
 
-                if (isRequirementSection(narrativeSection) && sectionReqType != "")
+                if (isRequirementSection(narrativeSection) && sectionReqType != "" && gtdBlank(ownHeading) && gtdBlank(getPictName(so)))
                     emitAsText = false
 
                 if (sectionText != "" && emitAsText && isRequirementSection(narrativeSection)) {
                     string noTypeId = safeField(identifier(so))
@@ -533,25 +726,25 @@
         if (!table(so) && !row(so) && !cell(so)) {
 
             string orderedSection = ""
 
-            string directReqSection = sectionKeyForHeading(ownHeading)
+            string directReqSection = sectionKeyForObject(so)
 
             if (directReqSection != "")
                 orderedSection = directReqSection
             else {
                 orderedSection = sectionKeyFromParents(so)
 
-                if (orderedSection == "")
+                if (orderedSection == "" && !gtdManagedStructure)
                     orderedSection = activeSection
             }
 
             if (orderedSection != "" && isRequirementSection(orderedSection)) {
 
                 string orderedReqType = so."Requirement Type" ""
                 string orderedReqText = so."Object Text" ""
 
-                if (orderedReqType != "" && orderedReqText != "") {
+                if (orderedReqType != "" && orderedReqText != "" && gtdBlank(ownHeading) && gtdBlank(getPictName(so))) {
 
                     string orderedReqId = identifier(so)
                     string orderedVerMethod = so."Verification Method" ""
                     string orderedVerRef = so."Verification Reference" ""
@@ -574,14 +767,14 @@
             string pictureName = getPictName(so)
 
             if (!null pictureName && pictureName != "") {
 
-                string pictureSection = sectionKeyForHeading(ownHeading)
+                string pictureSection = sectionKeyForObject(so)
 
                 if (pictureSection == "") {
                     pictureSection = sectionKeyFromParents(so)
 
-                    if (pictureSection == "")
+                    if (pictureSection == "" && !gtdManagedStructure)
                         pictureSection = activeSection
                 }
 
                 string sfPictureId = safeField(identifier(so))
@@ -629,9 +822,9 @@
 
             string tableSection = sectionKeyFromParents(so)
 
             // Table header can be a sibling immediately after a mapped heading.
-            if (tableSection == "")
+            if (tableSection == "" && !gtdManagedStructure)
                 tableSection = activeSection
 
             string sfTableId = safeField(identifier(so))
 
@@ -695,9 +888,9 @@
     if (!isDeleted(o) && !table(o) && !row(o) && !cell(o)) {
     string reqType = o."Requirement Type" ""
     string objText = o."Object Text" ""
 
-    if (reqType != "" && objText != "") {
+    if (reqType != "" && objText != "" && gtdBlank(o."Object Heading" "") && gtdBlank(getPictName(o))) {
 
         string reqId = identifier(o)
         string verMethod = o."Verification Method" ""
         string verRef = o."Verification Reference" ""
@@ -763,10 +956,8 @@
                 string sfTraceSourceId = safeField(traceSourceId)
                 string sfTraceSourceModule = safeField(traceSourceModule)
                 out << "X|" << sfReqId << "|" << sfTraceSourceId << "|" << sfTraceSourceModule << "|" << sfActualLinkPath << "|" << traceStatus << "\n"
             }
-            else {
-            }
         }
         if (matchedTraceLinks == 0) {
             out << "X|" << sfReqId << "||||NONE\n"
         }
````



## DIFFS/GTD_Requirement_Review_Control.dxl.diff


````diff
--- ORIJINAL_DOSYALAR/GTD_Requirement_Review_Control.dxl
+++ GUNCEL/GTD_Requirement_Review_Control.dxl
@@ -9,9 +9,9 @@
 // Non-requirement objects are ignored:
 //   - picture objects
 //   - native tables / rows / cells
 //   - headings / objects without Object Text
-//   - objects outside requirement sections
+//   - untyped narrative outside requirement sections
 //
 // Source rules:
 //   Higher-Level Requirement -> source trace link required
 //   Derived                  -> source trace link must NOT exist
@@ -26,8 +26,9 @@
 // ------------------------------------------------------------
 // Encoding-safe Turkish heading normalization copied from the
 // GTD publisher logic. Source code remains ASCII-only.
 // ------------------------------------------------------------
+// BEGIN GTD SECTION MODEL - keep identical in setup, publisher and Control.
 string headingBytes(int first, int second, int third)
 {
     Buffer b = create
     char c1 = charOf(first)
@@ -44,22 +45,21 @@
     delete(b)
     return result
 }
 
+// Replace complete strings: works without assuming one byte per Turkish letter.
 string replaceHeadingToken(string s, string token, string replacement)
 {
     Buffer b = create
     int i = 0
     int n = length(s)
     int t = length(token)
-
     while (i < n) {
         bool matched = false
         if (i + t <= n) {
             string part = s[i:(i + t - 1)]
             if (part == token) matched = true
         }
-
         if (matched) {
             b += replacement
             i = i + t
         }
@@ -67,19 +67,17 @@
             b += s[i:i]
             i++
         }
     }
-
     string result = stringOf(b)
     delete(b)
     return result
 }
 
 string compactHeading(string s)
 {
     string token = ""
-
-    // UTF-8 Turkish letters.
+    // Decode complete UTF-8 sequences before single-byte Windows-1254.
     token = headingBytes(195, 135, -1)
     s = replaceHeadingToken(s, token, "c")
     token = headingBytes(195, 167, -1)
     s = replaceHeadingToken(s, token, "c")
@@ -102,10 +100,9 @@
     token = headingBytes(195, 156, -1)
     s = replaceHeadingToken(s, token, "u")
     token = headingBytes(195, 188, -1)
     s = replaceHeadingToken(s, token, "u")
-
-    // Windows-1254 Turkish letters.
+    // Windows Turkish bytes (also covers common Latin-1 letters).
     token = headingBytes(199, -1, -1)
     s = replaceHeadingToken(s, token, "c")
     token = headingBytes(231, -1, -1)
     s = replaceHeadingToken(s, token, "c")
@@ -128,40 +125,33 @@
     token = headingBytes(220, -1, -1)
     s = replaceHeadingToken(s, token, "u")
     token = headingBytes(252, -1, -1)
     s = replaceHeadingToken(s, token, "u")
-
-    // Common non-breaking / zero-width spaces.
     token = headingBytes(194, 160, -1)
     s = replaceHeadingToken(s, token, "")
     token = headingBytes(226, 128, 175)
     s = replaceHeadingToken(s, token, "")
     token = headingBytes(226, 128, 139)
     s = replaceHeadingToken(s, token, "")
     token = headingBytes(160, -1, -1)
     s = replaceHeadingToken(s, token, "")
-
     string upperChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
     string lowerChars = "abcdefghijklmnopqrstuvwxyz"
     Buffer b = create
     int i
     int j
     int n = length(s)
-
     for (i = 0; i < n; i++) {
         string ch = s[i:i]
-
         for (j = 0; j < 26; j++) {
             if (ch == upperChars[j:j]) {
                 ch = lowerChars[j:j]
                 break
             }
         }
-
         if (ch != " " && ch != "\t" && ch != "\r" && ch != "\n" && ch != ":")
             b += ch
     }
-
     string result = stringOf(b)
     delete(b)
     return result
 }
@@ -171,29 +161,101 @@
     string c = compactHeading(h)
     string s = compactHeading(suffix)
     int lc = length(c)
     int ls = length(s)
-
     if (ls == 0 || lc < ls) return false
-
     string tail = c[(lc - ls):(lc - 1)]
     if (tail != s) return false
-
-    // Only allow a numeric/manual numbering prefix before the heading.
+    // Only a manual numeric prefix may precede a known heading.
+    // An arbitrary heading ending in a known name must not steal its section.
     int i
     for (i = 0; i < lc - ls; i++) {
         string ch = c[i:i]
-        if (ch != "0" && ch != "1" && ch != "2" && ch != "3" && ch != "4" &&
-            ch != "5" && ch != "6" && ch != "7" && ch != "8" && ch != "9" &&
-            ch != "." && ch != ")" && ch != "(" && ch != "-")
+        if (ch != "0" && ch != "1" && ch != "2" && ch != "3" && ch != "4" && ch != "5" && ch != "6" && ch != "7" && ch != "8" && ch != "9" && ch != "." && ch != ")" && ch != "(" && ch != "-")
             return false
     }
-
     return true
 }
 
-string requirementSectionKeyForHeading(string h)
-{
+const int GTD_SECTION_COUNT = 28
+string gtdSectionKeys[] = {
+    "ROOT_GENEL",
+    "AMAC",
+    "KAPSAM",
+    "PROJE_TANITIMI",
+    "SISTEM_GENEL",
+    "URUN_GENEL",
+    "GROUP_KISALTMALAR_TANIMLAR",
+    "KISALTMALAR",
+    "TANIMLAR",
+    "UYGULANABILIR_DOKUMANLAR",
+    "STANDARTLAR",
+    "DIGER_DOKUMANLAR",
+    "ROOT_SISTEM_TANIMLAMASI",
+    "DURUM_MODLAR",
+    "OMUR_DONGUSU",
+    "SINIRLAMALAR",
+    "ROOT_GEREKSINIMLER",
+    "REQ_ISLEVSEL",
+    "REQ_PERFORMANS",
+    "REQ_FIZIKSEL",
+    "REQ_ARAYUZ",
+    "REQ_CEVRESEL",
+    "REQ_EMNIYET",
+    "REQ_ELD",
+    "REQ_GUV_GIZ",
+    "REQ_ERGONOMI",
+    "REQ_MARKALAMA",
+    "REQ_BILGISAYAR"
+}
+string gtdSectionHeadings[] = {
+    "GENEL",
+    "Ama" headingBytes(195, 167, -1),
+    "Kapsam",
+    "Proje Tan" headingBytes(196, 177, -1) "t" headingBytes(196, 177, -1) "m" headingBytes(196, 177, -1),
+    "Sisteme Genel Bak" headingBytes(196, 177, -1) headingBytes(197, 159, -1),
+    headingBytes(195, 156, -1) "r" headingBytes(195, 188, -1) "ne Genel Bak" headingBytes(196, 177, -1) headingBytes(197, 159, -1),
+    "K" headingBytes(196, 177, -1) "saltmalar/Tan" headingBytes(196, 177, -1) "mlar",
+    "K" headingBytes(196, 177, -1) "saltmalar",
+    "Tan" headingBytes(196, 177, -1) "mlar",
+    "Uygulanabilir Dok" headingBytes(195, 188, -1) "manlar",
+    "Standartlar",
+    "Di" headingBytes(196, 159, -1) "er Dok" headingBytes(195, 188, -1) "manlar",
+    "S" headingBytes(196, 176, -1) "STEM" headingBytes(196, 176, -1) "N TANIMLAMASI",
+    "Durum ve Modlar",
+    headingBytes(195, 150, -1) "m" headingBytes(195, 188, -1) "r D" headingBytes(195, 182, -1) "ng" headingBytes(195, 188, -1) "s" headingBytes(195, 188, -1),
+    "S" headingBytes(196, 177, -1) "n" headingBytes(196, 177, -1) "rlamalar",
+    "GEREKS" headingBytes(196, 176, -1) "N" headingBytes(196, 176, -1) "MLER",
+    headingBytes(196, 176, -1) headingBytes(197, 159, -1) "levsel Gereksinimler",
+    "Performans Gereksinimleri",
+    "Fiziksel Gereksinimler",
+    "Aray" headingBytes(195, 188, -1) "z Gereksinimleri",
+    headingBytes(195, 135, -1) "evresel Gereksinimler",
+    "Emniyet Gereksinimleri",
+    "Entegre Lojistik Destek Gereksinimleri",
+    "G" headingBytes(195, 188, -1) "venlik ve Gizlilik Gereksinimleri",
+    "Ergonomi Gereksinimleri",
+    "Markalama ve Etiketleme Gereksinimleri",
+    "Bilgisayar Kaynak Gereksinimleri"
+}
+int gtdSectionParents[] = {-1, 0, 0, 0, 3, 3, 0, 6, 6, 0, 9, 9, -1, 12, 12, 12, -1, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16}
+string sectionKeyForHeading(string h)
+{
+    if (headingEndsWith(h, "amac")) return "AMAC"
+    if (headingEndsWith(h, "kapsam")) return "KAPSAM"
+    if (headingEndsWith(h, "projetanimi")) return "PROJE_TANITIMI"
+    if (headingEndsWith(h, "projetanitimi")) return "PROJE_TANITIMI"
+    if (headingEndsWith(h, "sistemegenelbakis")) return "SISTEM_GENEL"
+    if (headingEndsWith(h, "urunegenelbakis")) return "URUN_GENEL"
+    if (headingEndsWith(h, "kisaltmalar")) return "KISALTMALAR"
+    if (headingEndsWith(h, "tanimlar")) return "TANIMLAR"
+    if (headingEndsWith(h, "uygulanabilirdokumanlar")) return "UYGULANABILIR_DOKUMANLAR"
+    if (headingEndsWith(h, "standartlar")) return "STANDARTLAR"
+    if (headingEndsWith(h, "digerdokumanlar")) return "DIGER_DOKUMANLAR"
+    if (headingEndsWith(h, "durumvemodlar")) return "DURUM_MODLAR"
+    if (headingEndsWith(h, "omurdongusu")) return "OMUR_DONGUSU"
+    if (headingEndsWith(h, "sinirlamalar")) return "SINIRLAMALAR"
+
     if (headingEndsWith(h, "islevselgereksinimleri")) return "REQ_ISLEVSEL"
     if (headingEndsWith(h, "islevselgereksinimler")) return "REQ_ISLEVSEL"
     if (headingEndsWith(h, "performansgereksinimleri")) return "REQ_PERFORMANS"
     if (headingEndsWith(h, "fizikselgereksinimler")) return "REQ_FIZIKSEL"
@@ -204,26 +266,140 @@
     if (headingEndsWith(h, "guvenlikvegizlilikgereksinimleri")) return "REQ_GUV_GIZ"
     if (headingEndsWith(h, "ergonomigereksinimleri")) return "REQ_ERGONOMI"
     if (headingEndsWith(h, "markalamaveetiketlemegereksinimleri")) return "REQ_MARKALAMA"
     if (headingEndsWith(h, "bilgisayarkaynakgereksinimleri")) return "REQ_BILGISAYAR"
+
+    if (headingEndsWith(h, "genel")) return "ROOT_GENEL"
+    if (headingEndsWith(h, "kisaltmalar/tanimlar")) return "GROUP_KISALTMALAR_TANIMLAR"
+    if (headingEndsWith(h, "kisaltmalarvetanimlar")) return "GROUP_KISALTMALAR_TANIMLAR"
+    if (headingEndsWith(h, "sistemintanimlamasi")) return "ROOT_SISTEM_TANIMLAMASI"
+    if (headingEndsWith(h, "sistemintanimi")) return "ROOT_SISTEM_TANIMLAMASI"
+    if (headingEndsWith(h, "gereksinimler")) return "ROOT_GEREKSINIMLER"
     return ""
 }
 
-string requirementSectionFromParents(Object x)
+bool isContentSection(string k)
+{
+    if (k == "AMAC") return true
+    if (k == "KAPSAM") return true
+    if (k == "PROJE_TANITIMI") return true
+    if (k == "SISTEM_GENEL") return true
+    if (k == "URUN_GENEL") return true
+    if (k == "KISALTMALAR") return true
+    if (k == "TANIMLAR") return true
+    if (k == "UYGULANABILIR_DOKUMANLAR") return true
+    if (k == "STANDARTLAR") return true
+    if (k == "DIGER_DOKUMANLAR") return true
+    if (k == "DURUM_MODLAR") return true
+    if (k == "OMUR_DONGUSU") return true
+    if (k == "SINIRLAMALAR") return true
+
+    if (k == "REQ_ISLEVSEL") return true
+    if (k == "REQ_PERFORMANS") return true
+    if (k == "REQ_FIZIKSEL") return true
+    if (k == "REQ_ARAYUZ") return true
+    if (k == "REQ_CEVRESEL") return true
+    if (k == "REQ_EMNIYET") return true
+    if (k == "REQ_ELD") return true
+    if (k == "REQ_GUV_GIZ") return true
+    if (k == "REQ_ERGONOMI") return true
+    if (k == "REQ_MARKALAMA") return true
+    if (k == "REQ_BILGISAYAR") return true
+
+    return false
+}
+
+bool isRequirementSection(string k)
+{
+    if (k == "REQ_ISLEVSEL") return true
+    if (k == "REQ_PERFORMANS") return true
+    if (k == "REQ_FIZIKSEL") return true
+    if (k == "REQ_ARAYUZ") return true
+    if (k == "REQ_CEVRESEL") return true
+    if (k == "REQ_EMNIYET") return true
+    if (k == "REQ_ELD") return true
+    if (k == "REQ_GUV_GIZ") return true
+    if (k == "REQ_ERGONOMI") return true
+    if (k == "REQ_MARKALAMA") return true
+    if (k == "REQ_BILGISAYAR") return true
+    return false
+}
+
+
+int gtdSectionIndex(string key)
+{
+    int i
+    for (i = 0; i < GTD_SECTION_COUNT; i++)
+        if (gtdSectionKeys[i] == key) return i
+    return -1
+}
+
+bool gtdBlank(string s)
+{
+    int i
+    for (i = 0; i < length(s); i++) {
+        string c = s[i:i]
+        if (c != " " && c != "\t" && c != "\r" && c != "\n") return false
+    }
+    return true
+}
+
+string gtdStoredSectionKey(Object o)
+{
+    if (null o) return ""
+    Module om = module(o)
+    AttrDef ad = find(om, "GTD Section Key")
+    if (null ad || !ad.object) return ""
+    return o."GTD Section Key" ""
+}
+
+string sectionKeyForObject(Object o)
+{
+    if (null o || isDeleted(o)) return ""
+    if (table(o) || row(o) || cell(o)) return ""
+    if (!gtdBlank(getPictName(o))) return ""
+    string h = o."Object Heading" ""
+    if (gtdBlank(h)) return ""
+    string key = gtdStoredSectionKey(o)
+    // A nonempty unknown key must not fall back to the visible title.
+    if (!gtdBlank(key)) {
+        if (gtdSectionIndex(key) >= 0) return key
+        return ""
+    }
+    return sectionKeyForHeading(h)
+}
+
+string gtdSectionIdentityIssue(Object o)
+{
+    string stored = gtdStoredSectionKey(o)
+    if (gtdBlank(stored)) return ""
+    if (table(o) || row(o) || cell(o)) return "SECTION_KEY_ON_TABLE"
+    if (gtdSectionIndex(stored) < 0) return "UNKNOWN_SECTION_KEY"
+    string h = o."Object Heading" ""
+    if (gtdBlank(h)) return "SECTION_KEY_WITHOUT_HEADING"
+    string pict = getPictName(o)
+    if (!gtdBlank(pict)) return "SECTION_KEY_ON_PICTURE"
+    string titleKey = sectionKeyForHeading(h)
+    if (titleKey != "" && titleKey != stored) return "SECTION_KEY_TITLE_CONFLICT"
+    return ""
+}
+
+// Start at the parent: a section heading is not its own requirement.
+// A recognized container closes the search; do not inherit a stale section.
+string sectionKeyFromParents(Object x)
 {
     Object p = parent(x)
-
     while (!null p) {
-        if (!table(p) && !row(p) && !cell(p)) {
-            string h = p."Object Heading" ""
-            string k = requirementSectionKeyForHeading(h)
-            if (k != "") return k
+        string key = sectionKeyForObject(p)
+        if (key != "") {
+            if (isContentSection(key)) return key
+            return ""
         }
         p = parent(p)
     }
-
     return ""
 }
+// END GTD SECTION MODEL
 
 string expectedTypeNormalized(string sectionKey)
 {
     if (sectionKey == "REQ_ISLEVSEL")   return "islevsel"
@@ -288,26 +464,37 @@
 
 if (null o) {
     display ""
 }
-else if (table(o) || row(o) || cell(o)) {
+else if (isDeleted(o) || table(o) || row(o) || cell(o)) {
     display ""
 }
 else {
     string pictureName = getPictName(o)
 
     // Native picture objects are document content, not requirements.
-    if (!null pictureName && pictureName != "") {
+    if ((!null pictureName && pictureName != "") || !isBlank(o."Object Heading" "")) {
         display ""
     }
     else {
         string objectText = o."Object Text" ""
-        string sectionKey = requirementSectionFromParents(o)
-
-        // Headings, narrative objects and anything outside requirement
-        // sections are intentionally not checked.
-        if (isBlank(objectText) || sectionKey == "") {
+        string sectionKey = sectionKeyFromParents(o)
+
+        // Untyped narrative outside requirement sections is ignored.
+        // Typed objects outside those sections need manual placement.
+        Module controlModule = module(o)
+        AttrDef typeDefinition = find(controlModule, "Requirement Type")
+        AttrDef methodDefinition = find(controlModule, "Verification Method")
+        if (isBlank(objectText)) {
             display ""
+        }
+        else if (null typeDefinition || null methodDefinition || !typeDefinition.object || !methodDefinition.object) {
+            display "HATA: Setup eksik"
+        }
+        else if (!isRequirementSection(sectionKey)) {
+            string existingType = o."Requirement Type" ""
+            if (!isBlank(existingType)) display "HATA: Gereksinim standart baslik disinda"
+            else display ""
         }
         else {
             Buffer issues = create
 
@@ -336,9 +523,9 @@
                     addIssue(issues, "HATA: Yanlis Requirement Type")
             }
 
             // ---------------- Source validation ----------------
-            Module m = current
+            Module m = module(o)
 
             if (null m) {
                 addIssue(issues, "HATA: Module bulunamadi")
             }
````



## DIFFS/GTD_Module_Info.dxl.diff


````diff
--- ORIJINAL_DOSYALAR/GTD_Module_Info(1).dxl
+++ GUNCEL/GTD_Module_Info.dxl
@@ -17,9 +17,9 @@
 // Optional:
 //   Work Package
 //   SDVIL Number
 //
-// Assumes the GTD master/setup has already created the module attributes.
+// Run GTD_Setup_Module.dxl first to create the module attributes.
 // ============================================================
 
 pragma runLim, 0
````



## DIFFS/GTD_Open_Check.dxl.diff


````diff
--- ORIJINAL_DOSYALAR/GTD_Open_Check(1).dxl
+++ GUNCEL/GTD_Open_Check.dxl
@@ -64,9 +64,9 @@
 
     string templateVersion = gtdModule."GTD Template Version" ""
     string formPath = gtdModule."GTD Form Path" ""
 
-    // Master/template marker is not configured: silently ignore.
+    // GTD setup marker is not configured: silently ignore.
     if (templateVersion == "" || formPath == "")
         return
 
     Buffer missing = create
````



## DIFFS/GTD_Install_Open_Trigger.dxl.diff


````diff
--- ORIJINAL_DOSYALAR/GTD_Install_Open_Trigger(1).dxl
+++ GUNCEL/GTD_Install_Open_Trigger.dxl
@@ -100,9 +100,9 @@
     gtdTriggerCode += "\n"
     gtdTriggerCode += "    string templateVersion = gtdModule.\"GTD Template Version\" \"\"\n"
     gtdTriggerCode += "    string formPath = gtdModule.\"GTD Form Path\" \"\"\n"
     gtdTriggerCode += "\n"
-    gtdTriggerCode += "    // Master/template marker is not configured: silently ignore.\n"
+    gtdTriggerCode += "    // GTD setup marker is not configured: silently ignore.\n"
     gtdTriggerCode += "    if (templateVersion == \"\" || formPath == \"\")\n"
     gtdTriggerCode += "        return\n"
     gtdTriggerCode += "\n"
     gtdTriggerCode += "    Buffer missing = create\n"
````



## DIFFS/GTD_Remove_Open_Trigger.dxl.diff


````diff
# NO CONTENT CHANGE: GTD_Remove_Open_Trigger(1).dxl -> GTD_Remove_Open_Trigger.dxl
````



## DIFFS/GTD_Build_Document.ps1.diff


````diff
# NO CONTENT CHANGE: GTD_Build_Document.ps1 -> GTD_Build_Document.ps1
````



END OF REVIEW INPUT — GTD-HANDOFF-2026-09-13-a3cc85b1e006


Şimdi görevi uygula. CLAUDE_REVIEW_REPORT.md raporunu hazırla; gerçekte yürütülmeyen testleri sonuç gibi yazma.
