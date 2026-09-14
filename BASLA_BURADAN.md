# GTD — Claude / Gemini devir paketi

Devir kimliği: **GTD-HANDOFF-2026-09-13-a3cc85b1e006**  
Durum: Uygulama adayı hazır; bağımsız inceleme, araştırma ve gerçek DOORS/Windows testleri bekleniyor.

## Claude'a verilecekler

Yeni Claude konuşmasına `MODEL_INPUTS/CLAUDE_REVIEW_INPUT.md` ve `PROJECT_FILES/GTD/GUNCEL/TPL_GTD_Publisher.docx` dosyalarını yükleyin. Şunu yazın:

> Ekli CLAUDE_REVIEW_INPUT.md içindeki Reviewer görevini uygula. Kodları, farkları ve Word şablonunu inceleyip CLAUDE_REVIEW_REPORT.md raporunu üret. Bulguları dosya/işlev/satır kanıtıyla ver; hedef ortamda çalıştırılmayan testleri açık bırak.

Tek Markdown girişinde görevi, proje kararları, bütün güncel DXL/PS1 metinleri, gerekli üretim kaynakları ve farklar var. `.dxl` uzantısını ayrı ayrı yüklemek zorunlu değil. Orijinaller veya diğer destekler istenirse bu arşivden ilgili dosyayı ayrıca sağlayabilirsiniz.

## Gemini'ye verilecekler

Yeni Gemini konuşmasına `MODEL_INPUTS/GEMINI_RESEARCH_INPUT.md` dosyasını yükleyin. Şunu yazın:

> Ekli GEMINI_RESEARCH_INPUT.md içindeki Researcher görevini uygula. RQ01–RQ13 sorularını birincil kaynaklarla araştırıp GEMINI_RESEARCH_REPORT.md raporunu üret. DOORS 9.6.1.3 uyumluluğunu diğer sürümlerden ayır; her iddiayı kaynağıyla destekle ve doğrulanamayanları belirt.

Görev dosyası gerekli bağlamı ve gerçek kod kesitlerini içerir. Kaynak araştırmasına erişebilen bir oturum kullanın; araştırma yapılmadan teknik doğrulama tamamlanmış sayılmaz. Gemini tam şablon veya kaynak isterse `PROJECT_FILES` altından eklenebilir.

## Raporlar döndüğünde

Claude ve Gemini kendi görevlerini birbirinden bağımsız tamamlayabilir. İki raporu ChatGPT'ye bu devir kimliğiyle birlikte getirin. Şunu yazın:

> Bu iki raporu GTD devir paketine göre değerlendir. Aynı kök nedenleri birleştir; her bulgu için kabul/reddet/ertele gerekçesi, gerekli düzeltme ve doğrulama adımını çıkar. Uygulanmamış baseline diff işini tamamlanmış sayma.

`AI_ROLES/CHATGPT_LEAD.md` birleştirme kurallarını; `REVIEW_RETURN` rapor ve kayıt şablonunu içerir. Hiçbir modelin önerisi otomatik kabul edilmiş proje kararına dönüşmez.

## İçerik

| Konum | Amaç |
|---|---|
| 00_MASTER_CONTEXT.md | Ortak durum, roller, dosya önceliği ve test sınırları |
| 01_DECISIONS.md | Kabul edilmiş kararlar ile uygulama tercihlerinin ayrımı |
| 02_ARCHITECTURE_AND_WORKFLOW.md | Kurulum, manuel taşıma, yayın ve bileşenler |
| 03_REQUIREMENT_RULES.md | Tür/bölüm, doğrulama ve kaynak/link kuralları |
| 04_RELEASE_BASELINE_CHANGE_WORKFLOW.md | PLM release, manuel baseline ve uygulanmamış diff aracı |
| 05_OPEN_ITEMS.md | Bilinen açık işler ve inceleme soruları |
| 06_FILE_INVENTORY.md | Eski/güncel eşleme, gerçek değişiklikler, hash'ler |
| 07_VALIDATION_AND_ACCEPTANCE.md | Mevcut statik kanıt ve gerçek test sınırları |
| MODEL_INPUTS | Her modele doğrudan yüklenebilen görev + içerik dosyası |
| AI_ROLES | Ayrı tekrar kullanılabilir rol görevleri |
| PROJECT_FILES/GTD | Önceki güncel paketin birebir kopyası: GUNCEL / ORIJINAL_DOSYALAR / BAKIM |
| DIFFS | Yüklenen kaynaklar ile güncel metin dosyalarının gerçek farkları |
| EVIDENCE | Dosya manifesti, bölüm/Word dökümü, kaynak başlangıcı ve 26 NOT_RUN kabul senaryosu |
| REVIEW_RETURN | Rapor şablonu ve henüz boş birleşik bulgu kayıt tablosu |

## Okuma ve doğrulama notu

ZIP saklama ve tüm dosyaları birlikte taşıma içindir. Modeliniz arşivi açamıyorsa ZIP'i bilgisayarınızda çıkarıp yukarıdaki Markdown girişlerini ve gerektiğinde DOCX'i yükleyin. Markdown girişi okunamaz veya kesilirse `00`–`07` bağlam dosyaları ve `AI_ROLES` görevini önce, kaynak dosyaları sonra ekleyin. İncelenmeyen dosyaların açıkça raporlanmasını isteyin.

Bu turda GTD çalıştırılabilir dosyaları değiştirilmedi. 34 statik kontrol raporu önceki adayın kanıtıdır; burada ürün testi yeniden yapılmış değildir. Devir bütünlüğü ayrıca kontrol edilmiştir. Word/PS1'in değişmemiş olması runtime uyumluluğu veya ürün kabulü anlamına gelmez. Bu tarih ve devir kimliği DOORS baseline veya doküman revizyonu değildir.
