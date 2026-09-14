# Bölüm eşlemesi

Başlık ve parent verisi mevcut üretim manifestinden aynen alınmıştır. Parent anahtarı `MODULE_ROOT` ise üst nesne yoktur.

| Sıra | Key | Object Heading | Parent key | Word içerik marker |
|---|---|---|---|---|
| 1 | ROOT_GENEL | GENEL | MODULE_ROOT | — (kapsayıcı) |
| 2 | AMAC | Amaç | ROOT_GENEL | {{SEC_AMAC}} |
| 3 | KAPSAM | Kapsam | ROOT_GENEL | {{SEC_KAPSAM}} |
| 4 | PROJE_TANITIMI | Proje Tanıtımı | ROOT_GENEL | {{SEC_PROJE_TANITIMI}} |
| 5 | SISTEM_GENEL | Sisteme Genel Bakış | PROJE_TANITIMI | {{SEC_SISTEM_GENEL}} |
| 6 | URUN_GENEL | Ürüne Genel Bakış | PROJE_TANITIMI | {{SEC_URUN_GENEL}} |
| 7 | GROUP_KISALTMALAR_TANIMLAR | Kısaltmalar/Tanımlar | ROOT_GENEL | — (kapsayıcı) |
| 8 | KISALTMALAR | Kısaltmalar | GROUP_KISALTMALAR_TANIMLAR | {{SEC_KISALTMALAR}} |
| 9 | TANIMLAR | Tanımlar | GROUP_KISALTMALAR_TANIMLAR | {{SEC_TANIMLAR}} |
| 10 | UYGULANABILIR_DOKUMANLAR | Uygulanabilir Dokümanlar | ROOT_GENEL | {{SEC_UYGULANABILIR_DOKUMANLAR}} |
| 11 | STANDARTLAR | Standartlar | UYGULANABILIR_DOKUMANLAR | {{SEC_STANDARTLAR}} |
| 12 | DIGER_DOKUMANLAR | Diğer Dokümanlar | UYGULANABILIR_DOKUMANLAR | {{SEC_DIGER_DOKUMANLAR}} |
| 13 | ROOT_SISTEM_TANIMLAMASI | SİSTEMİN TANIMLAMASI | MODULE_ROOT | — (kapsayıcı) |
| 14 | DURUM_MODLAR | Durum ve Modlar | ROOT_SISTEM_TANIMLAMASI | {{SEC_DURUM_MODLAR}} |
| 15 | OMUR_DONGUSU | Ömür Döngüsü | ROOT_SISTEM_TANIMLAMASI | {{SEC_OMUR_DONGUSU}} |
| 16 | SINIRLAMALAR | Sınırlamalar | ROOT_SISTEM_TANIMLAMASI | {{SEC_SINIRLAMALAR}} |
| 17 | ROOT_GEREKSINIMLER | GEREKSİNİMLER | MODULE_ROOT | — (kapsayıcı) |
| 18 | REQ_ISLEVSEL | İşlevsel Gereksinimler | ROOT_GEREKSINIMLER | {{REQ_ISLEVSEL}} |
| 19 | REQ_PERFORMANS | Performans Gereksinimleri | ROOT_GEREKSINIMLER | {{REQ_PERFORMANS}} |
| 20 | REQ_FIZIKSEL | Fiziksel Gereksinimler | ROOT_GEREKSINIMLER | {{REQ_FIZIKSEL}} |
| 21 | REQ_ARAYUZ | Arayüz Gereksinimleri | ROOT_GEREKSINIMLER | {{REQ_ARAYUZ}} |
| 22 | REQ_CEVRESEL | Çevresel Gereksinimler | ROOT_GEREKSINIMLER | {{REQ_CEVRESEL}} |
| 23 | REQ_EMNIYET | Emniyet Gereksinimleri | ROOT_GEREKSINIMLER | {{REQ_EMNIYET}} |
| 24 | REQ_ELD | Entegre Lojistik Destek Gereksinimleri | ROOT_GEREKSINIMLER | {{REQ_ELD}} |
| 25 | REQ_GUV_GIZ | Güvenlik ve Gizlilik Gereksinimleri | ROOT_GEREKSINIMLER | {{REQ_GUV_GIZ}} |
| 26 | REQ_ERGONOMI | Ergonomi Gereksinimleri | ROOT_GEREKSINIMLER | {{REQ_ERGONOMI}} |
| 27 | REQ_MARKALAMA | Markalama ve Etiketleme Gereksinimleri | ROOT_GEREKSINIMLER | {{REQ_MARKALAMA}} |
| 28 | REQ_BILGISAYAR | Bilgisayar Kaynak Gereksinimleri | ROOT_GEREKSINIMLER | {{REQ_BILGISAYAR}} |
