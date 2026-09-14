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
