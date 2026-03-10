/* 

Bugünün Simülasyonu: Mega-Corp İnsan Kaynakları
İşte üzerinde çalışacağımız tablo yapıları:

Tablo 1: Departmanlar

dept_id (INT)
dept_ad (VARCHAR)
lokasyon (VARCHAR)

Tablo 2: Calisanlar

id (INT)
ad_soyad (INT)
maas (DECIMAL)
ise_giris_tarihi (DATE)
dept_id (INT)
yonetici_id (INT) -- Bir çalışanın yöneticisi de bu tablodadır (Self-Join için)
durum (VARCHAR)

*/

/* 
Soru-1 :

1.  Departman adını (dept_ad) getir.
2.  Her departmandaki toplam maaş giderini ve çalışan sayısını hesapla.
3.  Sadece 'Aktif' olan çalışanları dahil et.
4.  En yüksek gideri olan departmanı en üstte göster.

*/

SELECT
    d.dept_ad,
    SUM(c.maas) AS toplam_maas_gideri,
    COUNT(c.id) AS aktif_calisan_sayisi
FROM Departmanlar d
INNER JOIN Calisanlar c ON d.dept_id = c.dept_id
WHERE c.durum = 'Aktif'
GROUP BY d.dept_ad
ORDER BY toplam_maas_gideri DESC;

/* 
Soru-2 : Şirket kültürü gereği, şirkette 5 yılını doldurmuş olan çalışanlara "Sadakat Plaketi" verilecek. Bugünün tarihini 2024-01-01 kabul edelim.

1.  5 yıl veya daha fazla süredir çalışanların (yani işe giriş tarihi 2019-01-01 ve öncesi olanların) listesini hazırla.
2.  Müşteri adı (ad_soyad), ise_giris_tarihi ve kaç yıldır çalıştıkları bilgisini (kidem_yili) getir.
3.  Sadece 'Aktif' çalışanları listele.

*/


SELECT
    ad_soyad,
    ise_giris_tarihi,
    EXTRACT(YEAR FROM AGE('2024-01-01', ise_giris_tarihi)) AS kidem_yili
FROM Calisanlar
WHERE durum = 'Aktif'
  AND EXTRACT(YEAR FROM AGE('2024-01-01', ise_giris_tarihi)) >= 5
ORDER BY kidem_yili DESC;

/* 
Soru-3 : İK müdürü, "Yazılım" departmanındaki maaş adaletini kontrol etmek istiyor.

1.  Sadece 'Yazılım' departmanındaki 'Aktif' çalışanları bul.
2.  Bu departmanın ortalama maaşını bir kenara not et (SQL bunu senin için yapsın).
3.  Departman ortalamasının altında maaş alan kişilerin adını ve maaşını getir.

*/

SELECT 
    c.ad_soyad,
    c.maas,
    d.dept_ad
FROM Calisanlar c
INNER JOIN Departmanlar d ON d.dept_id = c.dept_id 
WHERE d.dept_ad = 'Yazılım'
  AND c.durum = 'Aktif'
  AND c.maas < (
      SELECT AVG(c2.maas) 
      FROM Calisanlar c2 
      INNER JOIN Departmanlar d2 ON d2.dept_id = c2.dept_id 
      WHERE d2.dept_ad = 'Yazılım' 
        AND c2.durum = 'Aktif'
  )
ORDER BY c.maas ASC;

/* 
Soru-4 : En Yüksek Maaş Kimde? (Departman Şampiyonları)

1. Her departmanın adını getir.
2. O departmandaki en yüksek maaşı (MAX) getir.
3. Yanına o departmandaki en düşük maaşı (MIN) getir.
4. Bu ikisi arasındaki farkı da maas_araligi olarak hesapla.

*/

SELECT 
    d.dept_ad,
    MAX(c.maas) AS en_yuksek_maas,
    MIN(c.maas) AS en_dusuk_maas,
    MAX(c.maas) - MIN(c.maas) AS maas_araligi
FROM Calisanlar c
INNER JOIN Departmanlar d ON d.dept_id = c.dept_id 
GROUP BY d.dept_ad
ORDER BY maas_araligi DESC;

/* 
Soru-5 : Hiyerarşi Analizi (Self-Join)

1. Çalışanın adını (ad_soyad) getir.
2. Yanına o çalışanın bağlı olduğu yöneticinin adını getir.
3. Yöneticisi olmayanları (örneğin Genel Müdür) listede görmek istemiyoruz.

*/

SELECT 
    c.ad_soyad AS calisan_adi,
    y.ad_soyad AS bagli_oldugu_yonetici
FROM Calisanlar c
INNER JOIN Calisanlar y ON c.yonetici_id = y.id
ORDER BY y.ad_soyad;

/* 
Soru-6 : Zam Simülasyonu (%15 Artış)

1. Mevcut toplam maaş giderini getir.
2. %15 zamlı yeni toplam maaş giderini hesapla.
3. Aradaki farkı ek_maliyet olarak göster.

*/

SELECT 
    SUM(maas) AS mevcut_toplam_butce,
    ROUND(SUM(maas * 1.15), 2) AS yeni_toplam_butce,
    ROUND(SUM(maas * 0.15), 2) AS sirkete_ek_maliyet
FROM Calisanlar
WHERE durum = 'Aktif';

/* 
Soru-7 : Departman Değiştirenler (Subquery Challenge)

1.  Çalışanın adı, kendi departman adı ve yöneticisinin departman adını getir.
2.  Kendi departman ID'si, yöneticisinin departman ID'sinden farklı olan çalışanları bul.

*/

SELECT 
    c.ad_soyad AS calisan_adi,
    dc.dept_ad AS calisan_departman,
    y.ad_soyad AS yonetici_adi,
    dy.dept_ad AS yonetici_departman
FROM Calisanlar c
INNER JOIN Calisanlar y ON c.yonetici_id = y.id
INNER JOIN Departmanlar dc ON c.dept_id = dc.dept_id
INNER JOIN Departmanlar dy ON y.dept_id = dy.dept_id
WHERE c.dept_id != y.dept_id;

/* 
Soru-8 : GROUP BY kullanmadan, her çalışanın kendi departmanı içindeki maaş sıralamasını merak ediyoruz.

1.  Çalışan adı, departman adı ve maaşını getir.
2.  Yanına RANK() OVER (PARTITION BY dept_id ORDER BY maas DESC) fonksiyonunu kullanarak her departmanın kendi içinde 1., 2., 3. kim olduğunu yazdır.


*/

SELECT
    c.ad_soyad,
    d.dept_ad,
    c.maas,
    RANK() OVER (PARTITION BY d.dept_id ORDER BY c.maas DESC) AS departman_ici_sira
FROM Departmanlar d
INNER JOIN Calisanlar c ON d.dept_id = c.dept_id
ORDER BY d.dept_ad, departman_ici_sira ASC;

/* 
Soru-9 : Turnover (İşten Ayrılma) Oranı

1. Toplam çalışan sayısını bul.
2. 'Ayrıldı' durumunda olan çalışan sayısını bul.
3. Bu ikisini birbirine oranlayıp turnover_orani olarak getir.

*/

SELECT 
    COUNT(id) AS toplam_calisan_sayisi,
    SUM(CASE WHEN durum = 'Ayrıldı' THEN 1 ELSE 0 END) AS toplam_ayrilan_sayisi,
    ROUND(
        (SUM(CASE WHEN durum = 'Ayrıldı' THEN 1 ELSE 0 END)::DECIMAL / NULLIF(COUNT(id), 0)) * 100, 
        2
    ) AS turnover_orani
FROM Calisanlar;

/* 
Soru-10 : "Yetenek vs. Maaş" Matrisi

1. Yazılım departmanındaki her çalışanın adını ve maaşını getir.
2. Yanına o departmanın toplam maaş bütçesini getir (Tüm satırlarda aynı toplam yazmalı).
3. Yanına, o çalışanın maaşının departman bütçesinin yüzde kaçı olduğunu hesaplayıp yaz ((maas / toplam_butce) * 100).

*/

SELECT 
    c.ad_soyad,
    c.maas,
    SUM(c.maas) OVER (PARTITION BY d.dept_id) AS departman_toplam_butce,
    ROUND(
        (c.maas::DECIMAL / SUM(c.maas) OVER (PARTITION BY d.dept_id)) * 100, 
        2
    ) AS maas_yuzdesi
FROM Calisanlar c
INNER JOIN Departmanlar d ON d.dept_id = c.dept_id 
WHERE d.dept_ad = 'Yazılım' AND c.durum = 'Aktif';




