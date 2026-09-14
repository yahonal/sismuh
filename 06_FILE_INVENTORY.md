# Dosya envanteri ve değişiklik kapsamı

Devir kimliği: **GTD-HANDOFF-2026-09-13-a3cc85b1e006**

Güncel aday dosyaların yolu `PROJECT_FILES/GTD/GUNCEL/`; eski eşleri `PROJECT_FILES/GTD/ORIJINAL_DOSYALAR/` altındadır.

| Güncel dosya | Yüklenen eş | Durum | Kapsam |
|---|---|---|---|
| GTD_Setup_Module.dxl | Ana dosya yüklenmemişti | NEW | Yeni ana setup; kaynak helper görevi ana kurulumda birleşti. |
| GTD_Publish.dxl | GTD_Publish.dxl | MODIFIED | Ortak bölüm modeli, managed yapı kontrolü ve nesne türü filtreleri. |
| GTD_Requirement_Review_Control.dxl | GTD_Requirement_Review_Control.dxl | MODIFIED | Bölüm kimliği, owning module ve nesne kapsamı kontrolleri. |
| GTD_Module_Info.dxl | GTD_Module_Info(1).dxl | COMMENT_AND_NAME | Setup açıklaması ve dağıtım adı; temel form işlevi korundu. |
| GTD_Open_Check.dxl | GTD_Open_Check(1).dxl | COMMENT_AND_NAME | Setup açıklaması ve dağıtım adı; temel kontrol işlevi korundu. |
| GTD_Install_Open_Trigger.dxl | GTD_Install_Open_Trigger(1).dxl | EMBEDDED_BODY_AND_NAME | Gömülü gövde Open Check dosyası ile eşlendi; temel trigger işlevi korundu. |
| GTD_Remove_Open_Trigger.dxl | GTD_Remove_Open_Trigger(1).dxl | RENAME_ONLY | İçerik aynı; indirme eki dağıtım adından çıkarıldı. |
| GTD_Build_Document.ps1 | GTD_Build_Document.ps1 | UNCHANGED | Bayt düzeyinde aynı. |
| TPL_GTD_Publisher.docx | TPL_GTD_Publisher.docx | UNCHANGED | Bayt düzeyinde aynı. |

Yüklenen `GTD_Setup_Requirement_Source_Attributes.dxl` güncel bağımsız giriş noktası olarak dağıtılmıyor; orijinali saklı ve görevleri ana setup kapsamına alındı.

## Bayt kanıtı

| Güncel dosya | SHA256 |
|---|---|
| GTD_Build_Document.ps1 | `271ac27d3057aa00941496b14014204491b3cc0b67c26958ad682c7f8a613372` |
| GTD_Install_Open_Trigger.dxl | `bcd18eba4113efbfcc10f0af2366c6883b8c813b073141ca4e5724df1bc58f61` |
| GTD_Module_Info.dxl | `10437d6ec52bcb11e7d9ed5cd6f2929052e6d47037554f4fcf61bfe8febd8d1b` |
| GTD_Open_Check.dxl | `7e14ae469db219e069b4137457c9fe90937065226caf6f1db076d79f4d4d5cf4` |
| GTD_Publish.dxl | `ae9ede7a815a42475ae0856e4c4039d62e07ccf312d04ddbb2516c895f2e01c8` |
| GTD_Remove_Open_Trigger.dxl | `65bd19a1ee873ac50898515a1f1e75f88e3930fb4c5ad2a3d34d22aa2d0b4f26` |
| GTD_Requirement_Review_Control.dxl | `016bd67910b1398ecebe1b091f292e6c4325785c3441fbb060c7640642d44a11` |
| GTD_Setup_Module.dxl | `8db1c858798ccbd26f61f5937e41ef5ee5976eb8609a84bc1158b55ed927165d` |
| TPL_GTD_Publisher.docx | `1e2857f51b35ca0a84c4ccde6cfe2be3152cf0fae07638666b2506dfb7665d2c` |

Bakım araçları ve orijinal dosyaların ayrıntılı hash bilgisi `EVIDENCE/FILE_MANIFEST.json` içindedir. Salt içerik inceleme metinleri okunabilirlik için satır numarası ekler; bayt otoritesi arşivdeki gerçek dosyalardır.

## Önceki uygulama adayının korunması

Bu tur yalnız devir dokümanları ve okuma paketlerini oluşturur. `PROJECT_FILES/GTD` ağacı önceki GTD paketinden birebir kopyalanır; çalıştırılabilir dosyaların hiçbiri bu devir için yeniden üretilmemiş veya düzeltilmemiştir.
