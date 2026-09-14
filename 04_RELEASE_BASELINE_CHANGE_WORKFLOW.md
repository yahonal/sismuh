# Release, baseline ve değişiklik kaydı

## Kabul edilmiş akış

Sistem mühendisi DOORS'taki çalışma modülünden Word çıktısı üretir. Doküman PLM'de görüş/onay sürecine girer. Görüşlerle içerik revize edilebilir ve yeni Word çıktısı alınabilir. Bu taslak/görüş aşamasında araç otomatik DOORS baseline oluşturmaz.

PLM'de doküman resmî olarak release olduğunda sistem mühendisi DOORS'a girip **manuel baseline** alır. Sonraki doküman revizyonu için tasarlanan değişiklik aracı, **son release baseline'ı ile güncel çalışma modülünü** karşılaştıracaktır.

Document Revision ve Document Date araç tarafından otomatik artırılmaz. Module Info formu boş tarih için bugünü kullanıcıya önerir; kaydetme kullanıcının Kaydet işlemiyle olur. Bu davranış otomatik release tarihi/sürüm tayini değildir.

## Mevcut kodun durumu

Setup/publisher'da otomatik baseline oluşturma işlevi yoktur. Bu pakette baseline karşılaştırması yapan veya Word Değişiklik Kaydı'nı otomatik dolduran ayrı revizyon aracı da yoktur. Sadece şablonda Değişiklik Kaydı bulunması bu özelliğin uygulanmış olduğunu kanıtlamaz.

## Araştırılması ve süreçte netleştirilmesi gereken nokta

**İncelenecek senaryo; gerçekleşmiş hata olarak raporlanmamalı:** PLM'ye gönderilen Word çıktıktan sonra çalışma modülü değişirse, release anında alınan baseline yayımlanmış Word ile aynı içerik kümesini temsil etmeyebilir. Bu olasılık, baseline'ı otomatik erkene çekme kararı değildir.

Researcher, mevcut manuel baseline zamanını koruyarak yayımlanan DOCX ile DOORS içeriğinin hangi kayıtlarla eşlenebileceğini araştırmalıdır. Öneriler; yayın anı modül/nesne kapsamı, doküman revizyonu, çıktı hash'i, review değişikliklerinin izlenmesi ve release-baseline eşleme kaydı gibi seçenekleri gerekçe ve operasyon yüküyle değerlendirebilir. Bu kayıtlar mevcut kodda uygulanmış değildir.

Gelecek diff aracı için olası kapsam soruları: eklenen/silinen gereksinimler, Object Text ve seçili attribute değişiklikleri, başlık/konum değişikliği, link değişikliği, görsel/tablolar, silinmiş nesnelerin takibi ve baseline dışındaki kaynak modüllerin sürümleri. Bunlar açık tasarım sorularıdır; tamamlanmış gereksinim veya onaylanmış standart kapsamı olarak yazılmamalı.
