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
