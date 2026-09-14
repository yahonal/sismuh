# GTD modül kurulumu ve yayın paketi

Bu paket, ayrı bir DOORS şablon modülü kopyalamadan yeni veya mevcut formal module'ü GTD yapısına hazırlamak içindir. Hedef ortam IBM DOORS Classic 9.6.1.3 64 bit'tir. Yeni giriş noktası `GUNCEL/GTD_Setup_Module.dxl` dosyasıdır.

**Doğrulama durumu:** Dosyalar arası statik kontroller tamamlandı. Bu ortamda DOORS ve Windows PowerShell çalıştırılamadığı için yeni DXL'nin derlenmesi ve gerçek modülde yürütülmesi henüz doğrulanmadı. İlk çalıştırma, bir deneme modülünde yapılmalıdır. Aşağıdaki kabul senaryoları gerçek DOORS testi içindir.

## Dosyaların yeri

| Klasör | İçerik |
|---|---|
| `GUNCEL` | Birlikte kullanılacak güncel DXL, PowerShell ve Word dosyaları |
| `ORIJINAL_DOSYALAR` | Gönderilen dokuz dosyanın değiştirilmemiş kopyaları |
| `BAKIM` | Ortak bölüm modelinden DXL üretme ve statik kontrol araçları; DOORS'ta çalıştırılmaz |

Gönderilen dosyalar arasında ana `GTD_Setup_Module.dxl` bulunmuyordu. Ana setup, bu paketteki publisher, Control, modül bilgi formu ve Word şablonunun tanımlarından oluşturuldu. `GTD_Setup_Requirement_Source_Attributes.dxl` yardımcı dosyasının görevi ana setup'a alındı; güncel kullanımda ayrıca çalıştırılmaz.

## İlk kurulum

1. Paketi açın. `GUNCEL` klasöründeki dosyaları birlikte tutun. Örnek bir konum `C:\GTD\GUNCEL` olabilir; bu yol kodda zorunlu veya sabit değildir.
2. Yeni veya mevcut formal module'ü **Exclusive Edit** modunda açın. Çalışma yapılacak modül penceresi açık ve görünür olmalıdır.
3. DXL düzenleyicisinden bu paketteki **`GTD_Setup_Module.dxl`** dosyasını çalıştırın.
4. Açılan formda `GUNCEL` klasörünün tam yolunu girin. Kaynak gereksinim bağlantıları için kullanılacak link modülü biliniyorsa tam DOORS yolunu girin. Bu alan boş bırakılabilir; yayın öncesinde doldurulması gerekir.
5. Setup eksik tanımları ve başlıkları oluşturur, mevcut başlıkları tanır ve sonucu bir log dosyasına yazar. Log yolu sonuç penceresinde gösterilir; log ayrıca DXL çıktı alanına yazdırılır.
6. Yapı tamamlanmış ve zorunlu doküman bilgileri eksikse mevcut `GTD_Module_Info.dxl` formu aynı çalıştırmanın sonunda açılır. Formdaki bilgiler kullanıcı **Kaydet** düğmesine bastığında kaydedilir.

Mevcut `GTD Form Path`, `GTD Word Template Path`, `GTD Publisher Script Path` ve `GTD Trace Link Module` değerleri korunur. Yeni klasör bilgisi, boş dosya yollarını tamamlar ve güncel Control kodunu okumak için kullanılır. Dolu bir yol yanlışsa ilgili module attribute'ünü düzeltip setup'ı yeniden çalıştırın.

Setup modülü kaydeder. İşlem başladıktan sonra bir çalışma zamanı hatası olursa otomatik geri alma yapılmaz; log son başarılı işlemleri gösterir. Kurulum durumu tamamlanmamış olarak kalır. Hata giderildikten sonra yeniden çalıştırılması eksikleri tamamlamak için tasarlanmıştır.

## Başlıkların oluşturulması ve kullanılması

Setup, Word şablonunun 1–3. bölümlerindeki **28 başlığı** oluşturur: üç ana bölüm, Kısaltmalar/Tanımlar grubu ve 24 içerik bölümü. Başlık metnine elle bölüm numarası eklemez; DOORS hiyerarşisi numaralandırmayı belirler.

| Bulunan durum | Uygulanan davranış |
|---|---|
| Başlık yok, üst başlığı çözümlenmiş | Eksik başlık oluşturulur. |
| Başlık tek ve doğru üst başlık altında | Aynı nesne kullanılır; boşsa bölüm anahtarı atanır. |
| Aynı bölüme karşılık gelen birden fazla başlık | Hiçbiri seçilmez; yeni kopya oluşturulmaz. İlgili bölüm ve bağlı alt bölümler log'a yazılır. |
| Başlık yanlış üst başlık altında | Mevcut nesne korunur. Log, taşınması gereken üst başlığın kimliğini gösterir. |
| Üst başlık henüz çözümlenmemiş | O üst başlığa bağlı yeni alt başlıklar oluşturulmaz. |
| Görünümde filtreyle gizlenmiş başlık | Modülün tamamındaki taramada dikkate alınır. |
| Silinmiş başlık | Geri getirilmez; aktif başlık eşleşmesi sayılmaz. |
| Mevcut fakat tanınmayan farklı bir ad | Anlamsal tahmin yapılmaz. Bilinen başlığa veya doğru bölüm anahtarına elle eşleştirilmesi gerekir. |

İlk eşleştirme, başlık metninin ve hemen üstündeki başlığın kontrolüyle yapılır. Türkçe karakterler, büyük/küçük harfler, boşluklar ve mevcut kodda tanımlı elle yazılmış sayısal önekler dikkate alınır. Eski publisher'ın kabul ettiği yazım seçenekleri korunmuştur; örneğin Proje Tanımı/Proje Tanıtımı ve İşlevsel Gereksinimler/İşlevsel Gereksinimleri.

Tanınan başlığa **`GTD Section Key`** adlı String object attribute'ünde sabit bir anahtar yazılır. Bu attribute miras alınmaz ve gereksinimlere atanmaz. Sonraki çalıştırmalarda anahtar önceliklidir. Başlığı farklı bir serbest ifadeyle yeniden adlandırmak Word'daki hedef bölümünü değiştirmez. Başlığı başka bir tanımlı bölümün adıyla değiştirmek ise anahtar–başlık çelişkisi oluşturur ve raporlanır.

`GTD Section Key` değerlerini normal gereksinim girişi sırasında değiştirmeyin. Bir bölümü gerçekten yeniden sınıflandırmak gerekiyorsa başlık, üst başlık ve anahtarı birlikte değerlendirin. Ayrıntılı anahtar ve ebeveyn listesi `BAKIM/section_manifest.json` dosyasındadır.

## Eski gereksinimlerin yerleştirilmesi

Setup gereksinimleri otomatik taşımak veya içeriklerinden tür çıkarmak için tasarlanmadı. Sistem mühendisi, mevcut gereksinim nesnelerini **aynı modül içinde** ilgili başlıkların altına taşır. Nesneleri silip yeniden oluşturmak veya metinlerini yeni nesnelere kopyalamak bu geçişin parçası değildir.

Gereksinim, ilgili bölüm başlığının altında olmalıdır. Görsel olarak başlığın ardından gelmesi yeterli değildir. Görseller ve yerel DOORS tabloları da ilgili bölümün altında, gereksinimlerle kardeş nesneler olarak yerleştirilir. Böylece gereksinimler yaprak nesne kalabilir.

Taşıma sonrasında gereksinim ID'lerinin, kaynak/alt seviye linklerinin, metinlerinin ve geçmişlerinin korunduğunu kontrol edin. Eksik `Requirement Type`, doğrulama ve kaynak alanlarını sistem mühendisi doldurur. Setup bu alanlara gereksinim bazında değer atamaz.

`WRONG_PARENT` veya mükerrer başlık kayıtları varsa önce başlık yapısını düzeltin ve setup'ı tekrar çalıştırın. Mevcut başlık nesnesini doğru yere taşıdıktan sonra script aynı nesneyi kullanır ve o bölümde kalan eksikleri tamamlar.

## Attribute ve view davranışı

Yeni modülde doküman bilgileri ve yayın yolları için module attribute'leri; gereksinim türü, doğrulama, kaynak, gerekçe, açıklama ve izlenebilirlik notları için object attribute'leri oluşturulur. Dahili `GTD Setup State` kurulum sonucunu tutar. Eski açılış trigger'ı ile uyumluluk için **`GTD Template Version` adı korunmuştur**; bu alanın bulunması ayrı bir şablon modülü gerektirmez.

Mevcut attribute tanımları ve değerleri değiştirilmez. İstenen kapsam veya veri tipiyle çelişen bir tanım varsa setup, modülde değişiklik yapmadan durur. Kullanılacak mevcut gereksinim türü veya kaynak enum'ünde gerekli değerler yoksa bunları log'da belirtir; enum'ü kendiliğinden yeniden kurmaz veya yeniden numaralandırmaz. Mevcut String/Text türündeki uygun alanlar korunur.

Yeni `Requirement Type` enum'ü 11 gereksinim bölümünü karşılar. Yeni `Requirement Source Type` enum'ü gönderilen yardımcı dosyadaki altı seçeneği aynen kullanır. **Yeni `Verification Method` alanı için uygulanan tercih**, Word şablonundaki Analiz, Gösterim, Muayene, Test ve Uygunluk Belgesi seçeneklerinden oluşan tek seçimli enum'dür. Mevcut doğrulama alanının seçenekleri ve çoklu seçim ayarı değiştirilmez.

| View | Eksikse | Mevcutsa |
|---|---|---|
| `Requirement Entry` | ID, ana metin ve ilgili gereksinim alanlarıyla oluşturulur. | Kaydedilmiş view korunur. |
| `Requirement Review` | Kontrol için gerekli alanlar ve Control sütunuyla oluşturulur. | Yalnız eksik Control sütunu eklenir veya mevcut Control DXL kodu güncellenir; diğer sütunlar ve ayarlar korunur. |

Yeni view'lar modülün varsayılan erişim mirasıyla kaydedilir. Modül erişim yetkileri değiştirilmez. Mevcut Review'da birden fazla Control sütunu varsa veya Control başlığı başka türde bir sütun için kullanılmışsa script bunu ezmez; log'da çözüm ister. Yeni view oluştururken geçerli ekrandaki kaydedilmemiş view düzeni yeniden yüklenebilir; korunmasını istediğiniz özel görünüm düzenini önce kaydedin.

Control sütunu başlık, görsel, tablo, satır ve hücrelere gereksinim doğrulaması uygulamaz. Tür atanmış bir metin nesnesi standart gereksinim bölümü dışındaysa yerleştirme hatası gösterir. Gereksinim bölümündeki metinlerde tür, doğrulama yöntemi ve mevcut kaynak kuralları kontrol edilir.

## Yayın

1. Kurulumdaki başlık ve view sorunlarını çözün. `GTD Setup State` **READY** olmalıdır. Bu değer yalnız setup'ın tamamlandığını belirtir; gereksinim içeriği onayı değildir.
2. Gereksinimleri uygun başlıkların altına taşıyın ve Control bulgularını değerlendirin.
3. Bu paketteki **`GTD_Publish.dxl`** dosyasını çalıştırın. Eski publisher ile yeni setup'ı karıştırmayın.
4. DOCX çıktısını Word'da açın. İçindekiler, tablo/şekil listeleri ve sayfa alanlarını güncelleyin; çıktıyı gözden geçirip PLM sürecine alın.

Yeni yapıdaki modüllerde publisher, bölüm anahtarlarını ve gerçek ebeveyn ilişkilerini kullanır. Eksik zorunlu doküman bilgisi, eksik/mükerrer başlık, çelişkili anahtar, yanlış üst başlık veya bölüm dışında kalan tür atanmış gereksinim tespit ederse Word üretimini başlatmadan durur ve rapor yolu verir. Kurulumdan geçmemiş eski modüllerin başlık metnine dayalı aktarımı için eski ardışık nesne eşleştirme davranışı korunmuştur.

PowerShell'in metin, gereksinim, resim ve yerel tablo kayıt biçimi değiştirilmedi. **`GTD_Build_Document.ps1` ve `TPL_GTD_Publisher.docx` gönderilenlerle bayt düzeyinde aynıdır.** Word'daki 4. Gereksinim Doğrulama Yöntemi ve 5. İzlenebilirlik Matrisi bölümleri korunur. Setup bunları DOORS'ta oluşturmaz. Eski modülde varsa otomatik silmez.

Şablonun kayıtlı İçindekiler ve Tablo Listesi sayfa numaraları eski bir düzeni yansıtmaktadır. Buradaki şablon render'ı 8 sayfa üretirken önbellekteki bazı alan sonuçları 12. sayfaya işaret etmiştir. PowerShell bu alanları yeniden hesaplamaz; yayınlanan DOCX'te Word üzerinden alan güncellemesi gerekir.

PLM release sonrasında manuel baseline alma kararı devam eder. Setup ve publisher baseline oluşturmaz, doküman revizyonunu veya tarihini artırmaz. Bilgi formu boş tarih için bugünü önerir; modüle kayıt kullanıcı Kaydet dediğinde yapılır.

**Açık kalan iş:** Gönderilen dosyalarda son release baseline'ı ile güncel modülü karşılaştırıp Word Değişiklik Kaydı'nı otomatik dolduran bir revizyon aracı bulunmuyor. Bu pakette o özellik tamamlanmış kabul edilmedi.

## Güncel dosya listesi

| Dosya | Bu paketteki durumu |
|---|---|
| `GTD_Setup_Module.dxl` | Yeni ana kurulum; şema, başlıklar, view'lar, bölüm anahtarları ve log |
| `GTD_Publish.dxl` | Bölüm anahtarı ve yapı kontrolü eklendi; başlık/görsellerin gereksinim kayıtlarına girmesi önlendi |
| `GTD_Requirement_Review_Control.dxl` | Aynı bölüm modelini okur; başlık/görselleri atlar; bölüm dışındaki tür atanmış metinleri işaretler |
| `GTD_Module_Info.dxl` | Form işlevi korundu; setup yönergesi güncellendi, dosya adındaki indirme eki kaldırıldı |
| `GTD_Open_Check.dxl` | Açılış kontrolünün işlevi korundu; şablon açıklaması setup olarak güncellendi |
| `GTD_Install_Open_Trigger.dxl` | Mevcut trigger kurulum işlevi korundu; gömülü kod okunabilir Open Check dosyasıyla eşlendi |
| `GTD_Remove_Open_Trigger.dxl` | İçerik aynı; dosya adındaki indirme eki kaldırıldı |
| `GTD_Build_Document.ps1` | İçerik aynı |
| `TPL_GTD_Publisher.docx` | İçerik aynı |

Açılış kontrolünü yeni bir projede kullanmak isterseniz, o proje current iken `GTD_Install_Open_Trigger.dxl` bir kez çalıştırılır. Mevcut çalışan trigger'ın mantığı değiştirilmediği için bu setup değişikliği yeniden kurulum gerektirmez. `GTD_Open_Check.dxl` trigger gövdesidir; normal kullanımda tek başına çalıştırılmaz.

## Gerçek DOORS çalıştırması için kabul senaryoları

| Senaryo | Beklenen sonuç |
|---|---|
| Boş formal module | 28 başlık, gerekli attribute'ler ve iki view oluşur; gereksinim verisi uydurulmaz. |
| Setup'ı tekrar çalıştırma | Yeni başlık/attribute/view kopyası oluşmaz; aynı başlık ID'leri kullanılır. Kurulum durum geçişleri modül geçmişine kaydolabilir. |
| Filtreyle gizlenmiş mevcut başlık | Yeni kopyası oluşmaz. |
| Tek bir eksik başlık | Sadece eksik başlık doğru ebeveyn altında oluşturulur. |
| Yanlış yerdeki veya mükerrer başlık | İlgili başlık kopyalanmaz ve taşınmaz; log açıklayıcı kayıt içerir. |
| Bir başlığı farklı serbest adla değiştirme | Anahtarı sayesinde aynı bölümde kalır. Başka tanımlı bölümün adını vermek çelişki olarak raporlanır. |
| Eski gereksinimleri aynı modülde taşıma | Başlangıçta kaydedilen ID, metin, link ve geçmişler korunur; Control doğru bölümü kullanır. |
| Görsel veya tablo içeren modül | Bu nesneler gereksinim kontrolüne girmez; Word'da doğru bölüm ve sırada yer alır. |
| Mevcut özel Entry/Review düzeni | Entry korunur; Review'un Control haricindeki sütunları ve ayarları korunur. |
| Salt okunur modül veya baseline | Setup değişiklik yapmadan durur. |

Bu senaryolar burada çalıştırılmış test sonuçları değildir. Statik kontrol çıktısı `BAKIM/STATIK_KONTROL_SONUCU.txt` dosyasındadır.

## Bakım ve teknik başvuru

`BAKIM/build_package.py`, orijinal dosyalar ve `BAKIM/setup_body.dxl` üzerinden üç DXL'de aynı bölüm modelini üretir. Python ile çalıştırılır; DOORS istemcisinin buna ihtiyacı yoktur. Ardından `BAKIM/verify_package.py`, Word başlık hiyerarşisi, PowerShell marker'ları, attribute sözleşmesi, gömülü trigger kodu ve korunan dosya baytlarını kontrol eder. Bakım aracı, `GUNCEL` içindeki üretilen DXL'leri yeniden yazar; doğrudan bu DXL'lerde yapılan özel değişiklikler varsa önce üretim kaynağına alınmalıdır.

Nesne oluşturma konumları, attribute özellikleri ve view/column işlevleri için IBM tarafından yayımlanan [Telelogic DOORS DXL Reference Manual Release 9.1 kopyası](https://manuals.plus/m/a29c37c1bb2c5611140c6daddb57693d46e762afed91e38d52bbeb0efb7862a6) incelendi. Özellikle `create(Module)` ilk nesneyi oluşturduğu için mevcut modüle kök başlık ekleme işlemi son kök nesneden sonra yapılır. Bu başvuru, hedef DOORS 9.6.1.3 istemcisindeki gerçek derleme ve çalıştırma testinin yerine geçmez.
