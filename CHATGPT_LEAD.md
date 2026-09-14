# ChatGPT — Lead ve raporları birleştirme görevi

Devir kimliği: **GTD-HANDOFF-2026-09-13-a3cc85b1e006**

Kullanıcı bu devir paketini ve `CLAUDE_REVIEW_REPORT.md` / `GEMINI_RESEARCH_REPORT.md` raporlarını geri getirdiğinde:

1. Raporların devir kimliğini ve inceledikleri dosya hash/satırlarını karşılaştır. Farklı sürüm incelenmişse önce ilgili bulguyu bu adaya eşleştir; tüm incelemeyi otomatik geçersiz sayma.
2. RV/RS bulgularını mevcut kaynak dosyalarına veya açılmış birincil kaynağa göre doğrula. İki modelin uzlaşması tek başına doğrulama değildir. Kapsam veya test eksikliği ile kanıtlanmış kod hatasını ayrı değerlendir.
3. Aynı kök nedenli bulguları birleştir; referans RV/RS-ID'lerini koru. Yeni/önceden var/etkileşim kökenini kaybetme.
4. `REVIEW_RETURN/REVIEW_REGISTER.csv` içine önem, kanıt, D/I/O-ID, karar, gerekçe, eylem ve doğrulama kaydı ekle. Durumlar: OPEN, ACCEPTED, REJECTED, DEFERRED, FIXED_PENDING_TEST, VERIFIED. Kullanıcı kararı veya kanıt yokken VERIFIED kullanma.
5. Kullanıcıya önce somut sonucu, sonra gerekçeyi anlat. Kabul edilmiş süreç kararını değiştiren önerinin etkisini açıklaştır. Rutin, yetkilendirilmiş kod düzeltmesini ayrıca izin sorusuyla durdurma; yeni mimari/süreç tercihi kabul edilmeden kesin karar diye yazma.
6. Düzeltme gerekiyorsa üretilen DXL yanında generator/setup_body kaynağını da güncelle; uygun statik kontrolleri ve gerçek ortam için gerekli testleri belirle. Bu devir kopyasını sabit tut; yeni aday için yeni devir kimliği oluştur.
7. `01_DECISIONS.md`, `05_OPEN_ITEMS.md`, dosya envanteri ve doğrulama durumunu sadece gerçekten değişen kapsamda güncelle. Hedef ortam testi yapılmadıysa bunu sonuçta koru.

Beklenen birleşik teslimat: önem sırasına göre bulgu değerlendirmesi; kabul/reddet/ertele gerekçesi; uygulanacak düzeltmeler; yeni aday dosyaları (yetkilendirilmişse); kapanan ve hâlâ açık testler. Review raporlarını önceki sohbetlerin tamamıyla tekrar taşımak gerekmemeli.
