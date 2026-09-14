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
