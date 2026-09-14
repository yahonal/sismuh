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
