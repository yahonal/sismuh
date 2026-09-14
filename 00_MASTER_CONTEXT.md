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
