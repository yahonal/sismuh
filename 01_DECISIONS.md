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
