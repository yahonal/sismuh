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
