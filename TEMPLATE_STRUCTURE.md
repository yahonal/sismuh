# Word şablonu: mekanik yapı ve metin dökümü

Kaynak: `PROJECT_FILES/GTD/GUNCEL/TPL_GTD_Publisher.docx`  
SHA256: `1e2857f51b35ca0a84c4ccde6cfe2be3152cf0fae07638666b2506dfb7665d2c`

Bu döküm DOCX XML öğelerinden okunur; sayfa görünümü, çizimler, resimler ve alanların yeniden hesaplanmış sonuçları değildir. Reviewer mümkünse gerçek DOCX ekini de açmalıdır.

## Ana gövde: başlıklar

| Gövde öğesi | Stil | Metin |
|---|---|---|
| 49 | Heading1 | GENEL |
| 50 | Heading2 | Amaç |
| 53 | Heading2 | Kapsam |
| 55 | Heading2 | Proje Tanıtımı |
| 58 | Heading3 | Sisteme Genel Bakış |
| 60 | Heading3 | Ürüne Genel Bakış |
| 62 | Heading2 | Kısaltmalar/Tanımlar |
| 63 | Heading3 | Kısaltmalar |
| 66 | Heading3 | Tanımlar |
| 69 | Heading2 | Uygulanabilir Dokümanlar |
| 71 | Heading3 | Standartlar |
| 74 | Heading3 | Diğer Dokümanlar |
| 77 | Heading1 | SİSTEMİN TANIMLAMASI |
| 78 | Heading2 | Durum ve Modlar |
| 80 | Heading2 | Ömür Döngüsü |
| 82 | Heading2 | Sınırlamalar |
| 84 | Heading1 | GEREKSİNİMLER |
| 85 | Heading2 | İşlevsel Gereksinimler  |
| 87 | Heading2 | Performans Gereksinimleri  |
| 89 | Heading2 | Fiziksel Gereksinimler  |
| 91 | Heading2 | Arayüz Gereksinimleri  |
| 93 | Heading2 | Çevresel Gereksinimler  |
| 95 | Heading2 | Emniyet Gereksinimleri  |
| 97 | Heading2 | Entegre Lojistik Destek Gereksinimleri  |
| 99 | Heading2 | Güvenlik ve Gizlilik Gereksinimleri  |
| 101 | Heading2 | Ergonomi Gereksinimleri  |
| 103 | Heading2 | Markalama ve Etiketleme Gereksinimleri  |
| 105 | Heading2 | Bilgisayar Kaynak Gereksinimleri  |
| 107 | Heading1 | GEREKSİNİM DOĞRULAMA YÖNTEMİ |
| 108 | Heading2 | Analiz  |
| 109 | Heading2 | Gösterim  |
| 110 | Heading2 | Muayene  |
| 111 | Heading2 | Test  |
| 112 | Heading2 | Uygunluk Belgesi  |

## Marker envanteri

- `{{CLASS}}`
- `{{DATE}}`
- `{{DOCNO}}`
- `{{PROJNO}}`
- `{{PROJ_DEPT}}`
- `{{REQ_ARAYUZ}}`
- `{{REQ_BILGISAYAR}}`
- `{{REQ_CEVRESEL}}`
- `{{REQ_ELD}}`
- `{{REQ_EMNIYET}}`
- `{{REQ_ERGONOMI}}`
- `{{REQ_FIZIKSEL}}`
- `{{REQ_GUV_GIZ}}`
- `{{REQ_ISLEVSEL}}`
- `{{REQ_MARKALAMA}}`
- `{{REQ_PERFORMANS}}`
- `{{REV}}`
- `{{SDVIL}}`
- `{{SEC_AMAC}}`
- `{{SEC_DIGER_DOKUMANLAR}}`
- `{{SEC_DURUM_MODLAR}}`
- `{{SEC_KAPSAM}}`
- `{{SEC_KISALTMALAR}}`
- `{{SEC_OMUR_DONGUSU}}`
- `{{SEC_PROJE_TANITIMI}}`
- `{{SEC_SINIRLAMALAR}}`
- `{{SEC_SISTEM_GENEL}}`
- `{{SEC_STANDARTLAR}}`
- `{{SEC_TANIMLAR}}`
- `{{SEC_URUN_GENEL}}`
- `{{SEC_UYGULANABILIR_DOKUMANLAR}}`
- `{{SYS}}`
- `{{TRACE_MATRIX}}`
- `{{WORK}}`

## Ana gövde: metin ve tablolar

````text
[001] PARAGRAPH style=default: 
[002] TABLE
  row 1: Dok. No | : | {{DOCNO}}
  row 2: Rev. | : | {{REV}}
  row 3: Tarih | : | {{DATE}}
  row 4: Proje/Bölüm | : | {{PROJ_DEPT}}
  row 5: İş Paketi  | : | {{WORK}}
  row 6: SDVİL No  | : | {{SDVIL}}
[003] PARAGRAPH style=default: 
[004] TABLE
  row 1: {{SYS}} /  /  /  / GEREKSİNİM TANIMLAMA DOKÜMANI
[005] PARAGRAPH style=default: 
[006] TABLE
  row 1: DAĞITIM LİSTESİ*
  row 2: Adet | Adı ve Soyadı | Bölüm/Unvan | Kurum/Kuruluş
  row 3:  |  |  | 
  row 4:  |  |  | 
  row 5:  |  |  | 
[007] PARAGRAPH style=default: 
[008] PARAGRAPH style=default: 
[009] TABLE
  row 1: DEĞİŞİKLİK KAYDI
  row 2: Rev. | Tarih | Sayfa | Değişiklik Tanımı
  row 3:  |  |  | 
[010] PARAGRAPH style=default: 
[011] PARAGRAPH style=Caption: İÇİNDEKİLER
[012] PARAGRAPH style=TOC1: 1. GENEL7
[013] PARAGRAPH style=TOC2: 1.1. Amaç7
[014] PARAGRAPH style=TOC2: 1.2. Kapsam7
[015] PARAGRAPH style=TOC2: 1.3. Proje Tanıtımı7
[016] PARAGRAPH style=TOC2: 1.4. Kısaltmalar/Tanımlar8
[017] PARAGRAPH style=TOC2: 1.5. Uygulanabilir Dokümanlar8
[018] PARAGRAPH style=TOC1: 2. SİSTEMİN TANIMLAMASI8
[019] PARAGRAPH style=TOC2: 2.1. Durum ve Modlar8
[020] PARAGRAPH style=TOC2: 2.2. Ömür Döngüsü8
[021] PARAGRAPH style=TOC2: 2.3. Sınırlamalar9
[022] PARAGRAPH style=TOC1: 3. GEREKSİNİMLER9
[023] PARAGRAPH style=TOC2: 3.1. İşlevsel Gereksinimler9
[024] PARAGRAPH style=TOC2: 3.2. Performans Gereksinimleri9
[025] PARAGRAPH style=TOC2: 3.3. Fiziksel Gereksinimler9
[026] PARAGRAPH style=TOC2: 3.4. Arayüz Gereksinimleri9
[027] PARAGRAPH style=TOC2: 3.5. Çevresel Gereksinimler9
[028] PARAGRAPH style=TOC2: 3.6. Emniyet Gereksinimleri10
[029] PARAGRAPH style=TOC2: 3.7. Entegre Lojistik Destek Gereksinimleri10
[030] PARAGRAPH style=TOC2: 3.8. Güvenlik ve Gizlilik Gereksinimleri10
[031] PARAGRAPH style=TOC2: 3.9. Ergonomi Gereksinimleri10
[032] PARAGRAPH style=TOC2: 3.10. Markalama ve Etiketleme Gereksinimleri10
[033] PARAGRAPH style=TOC2: 3.11. Bilgisayar Kaynak Gereksinimleri11
[034] PARAGRAPH style=TOC1: 4. GEREKSİNİM DOĞRULAMA YÖNTEMİ11
[035] PARAGRAPH style=TOC2: 4.1. Analiz11
[036] PARAGRAPH style=TOC2: 4.2. Gösterim11
[037] PARAGRAPH style=TOC2: 4.3. Muayene11
[038] PARAGRAPH style=TOC2: 4.4. Test11
[039] PARAGRAPH style=TOC2: 4.5. Uygunluk Belgesi12
[040] PARAGRAPH style=TOC1: 5. İZLENEBİLİRLİK MATRİSİ12
[041] PARAGRAPH style=default: 
[042] PARAGRAPH style=Caption: ŞEKİL LİSTESİ
[043] PARAGRAPH style=default: 
[044] PARAGRAPH style=default: 
[045] PARAGRAPH style=Caption: TABLO LİSTESİ
[046] PARAGRAPH style=TableofFigures: Tablo 1 İzlenebilirlik Matrisi12
[047] PARAGRAPH style=TableofFigures: 
[048] PARAGRAPH style=default: 
[049] PARAGRAPH style=Heading1: GENEL
[050] PARAGRAPH style=Heading2: Amaç
[051] PARAGRAPH style=default: {{SEC_AMAC}}
[052] PARAGRAPH style=default: 
[053] PARAGRAPH style=Heading2: Kapsam
[054] PARAGRAPH style=default: {{SEC_KAPSAM}}
[055] PARAGRAPH style=Heading2: Proje Tanıtımı
[056] PARAGRAPH style=default: {{SEC_PROJE_TANITIMI}}
[057] PARAGRAPH style=default: 
[058] PARAGRAPH style=Heading3: Sisteme Genel Bakış
[059] PARAGRAPH style=default: {{SEC_SISTEM_GENEL}}
[060] PARAGRAPH style=Heading3: Ürüne Genel Bakış
[061] PARAGRAPH style=default: {{SEC_URUN_GENEL}}
[062] PARAGRAPH style=Heading2: Kısaltmalar/Tanımlar
[063] PARAGRAPH style=Heading3: Kısaltmalar
[064] PARAGRAPH style=default: {{SEC_KISALTMALAR}}
[065] PARAGRAPH style=default: 
[066] PARAGRAPH style=Heading3: Tanımlar
[067] PARAGRAPH style=default: {{SEC_TANIMLAR}}
[068] PARAGRAPH style=default: 
[069] PARAGRAPH style=Heading2: Uygulanabilir Dokümanlar
[070] PARAGRAPH style=default: {{SEC_UYGULANABILIR_DOKUMANLAR}}
[071] PARAGRAPH style=Heading3: Standartlar
[072] PARAGRAPH style=default: {{SEC_STANDARTLAR}}
[073] PARAGRAPH style=default: 
[074] PARAGRAPH style=Heading3: Diğer Dokümanlar
[075] PARAGRAPH style=default: {{SEC_DIGER_DOKUMANLAR}}
[076] PARAGRAPH style=default: 
[077] PARAGRAPH style=Heading1: SİSTEMİN TANIMLAMASI
[078] PARAGRAPH style=Heading2: Durum ve Modlar
[079] PARAGRAPH style=default: {{SEC_DURUM_MODLAR}}
[080] PARAGRAPH style=Heading2: Ömür Döngüsü
[081] PARAGRAPH style=default: {{SEC_OMUR_DONGUSU}}
[082] PARAGRAPH style=Heading2: Sınırlamalar
[083] PARAGRAPH style=default: {{SEC_SINIRLAMALAR}}
[084] PARAGRAPH style=Heading1: GEREKSİNİMLER
[085] PARAGRAPH style=Heading2: İşlevsel Gereksinimler 
[086] PARAGRAPH style=default: {{REQ_ISLEVSEL}}
[087] PARAGRAPH style=Heading2: Performans Gereksinimleri 
[088] PARAGRAPH style=default: {{REQ_PERFORMANS}}
[089] PARAGRAPH style=Heading2: Fiziksel Gereksinimler 
[090] PARAGRAPH style=default: {{REQ_FIZIKSEL}}
[091] PARAGRAPH style=Heading2: Arayüz Gereksinimleri 
[092] PARAGRAPH style=default: {{REQ_ARAYUZ}}
[093] PARAGRAPH style=Heading2: Çevresel Gereksinimler 
[094] PARAGRAPH style=default: {{REQ_CEVRESEL}}
[095] PARAGRAPH style=Heading2: Emniyet Gereksinimleri 
[096] PARAGRAPH style=default: {{REQ_EMNIYET}}
[097] PARAGRAPH style=Heading2: Entegre Lojistik Destek Gereksinimleri 
[098] PARAGRAPH style=default: {{REQ_ELD}}
[099] PARAGRAPH style=Heading2: Güvenlik ve Gizlilik Gereksinimleri 
[100] PARAGRAPH style=default: {{REQ_GUV_GIZ}}
[101] PARAGRAPH style=Heading2: Ergonomi Gereksinimleri 
[102] PARAGRAPH style=default: {{REQ_ERGONOMI}}
[103] PARAGRAPH style=Heading2: Markalama ve Etiketleme Gereksinimleri 
[104] PARAGRAPH style=default: {{REQ_MARKALAMA}}
[105] PARAGRAPH style=Heading2: Bilgisayar Kaynak Gereksinimleri 
[106] PARAGRAPH style=default: {{REQ_BILGISAYAR}}
[107] PARAGRAPH style=Heading1: GEREKSİNİM DOĞRULAMA YÖNTEMİ
[108] PARAGRAPH style=Heading2: Analiz 
[109] PARAGRAPH style=Heading2: Gösterim 
[110] PARAGRAPH style=Heading2: Muayene 
[111] PARAGRAPH style=Heading2: Test 
[112] PARAGRAPH style=Heading2: Uygunluk Belgesi 
[113] PARAGRAPH style=default: İZLENEBİLİRLİK MATRİSİ
[114] PARAGRAPH style=default: Tablo 1 İzlenebilirlik Matrisi
[115] TABLE
  row 1: GEREKSİNİMNO | İLGİLİ SİSTEM /  / ALT SİSTEM* | DOĞRULAMA YÖNTEMİ | AÇIKLAMA** | GEREKSİNİMİN KAYNAĞI
  row 2: {{TRACE_MATRIX}} |  |   |  |  
[116] PARAGRAPH style=default: 
[117] PARAGRAPH style=default: 
````

## Header / footer metinleri

### word/header1.xml

````text
{{CLASS}}
````

### word/footer2.xml

````text
{{CLASS}}
Gereksinim_Tanımlama_Dokümanı_Şablonu_Rev.0
````

### word/header3.xml

````text

{{SYS}}GEREKSİNİM TANIMLAMA DOKÜMANI



Dok. No 
{{DOCNO}}


Rev. No
{{REV}}


Tarih
{{DATE}}


Sayfa No
12 / 12
Gizlilik Derecesi
{{CLASS}}

Proje/Bölüm
{{PROJ_DEPT}}
````

### word/header2.xml

````text


BELGE NO 
: {{DOCNO}}


GÜNC. NO
: {{REV}}


SAYFA NO
: 2 / 7
PROJE / NO
: {{PROJNO}}
BELGE TİPİ
: GTD
KISIM
:
GİZLİLİK DERECESİ
: {{CLASS}}
````

### word/footer1.xml

````text

{{CLASS}}
Gereksinim_Tanımlama_Dokümanı_Şablonu_Rev.0
````
