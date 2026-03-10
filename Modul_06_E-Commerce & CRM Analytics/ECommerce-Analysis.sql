/* 

Bugünün Simülasyonu: E-Ticaret Dünyası (Trendy-Data)
İşte üzerinde çalışacağımız tablo yapıları:

Tablo 1: Kullanicilar

id (INT)
ad_soyad (VARCHAR)
kayit_tarihi (DATE)
sehir (VARCHAR)

Tablo 2: Siparisler

siparis_id (INT)
kullanici_id (INT)
urun_adi (VARCHAR)
fiyat (DECIMAL)
siparis_tarihi (DATETIME)

*/
-- Soru-1 : 2025-11-28 tarihinden bugüne kadar en az bir sipariş vermiş olan kullanıcıların yaşadığı benzersiz (unique) şehir listesini getiren SQL sorgusunu yazabilir misin?

SELECT 
    DISTINCT b.sehir AS unq_sehir
FROM siparisler a
INNER JOIN kullanicilar b ON a.kullanici_id = b.id
WHERE a.siparis_tarihi >= '2025-11-28';

--Soru-2 : Her bir şehir için toplam sipariş tutarını (fiyatların toplamı) hesaplayan ve en yüksek geliri elde ettiğimiz şehri en üstte gösterecek şekilde sıralayan SQL sorgusunu yazabilir misin?

SELECT 
    b.sehir, 
    SUM(a.fiyat) AS toplam_gelir
FROM siparisler a
INNER JOIN kullanicilar b ON a.kullanici_id = b.id
GROUP BY b.sehir
ORDER BY toplam_gelir DESC;

--Soru-3 : Her bir kullanıcının adını (ad_soyad), toplam harcamasını ve toplam sipariş sayısını getiren bir sorgu yazar mısın?

SELECT 
	b.id,
    b.ad_soyad,
    SUM(a.fiyat) AS toplam_harcama,
    COUNT(a.id) AS siparis_sayisi 
FROM siparisler a
INNER JOIN kullanicilar b ON a.kullanici_id = b.id
GROUP BY b.id, b.ad_soyad; 

--Soru-4 : Toplam harcaması (sum(fiyat)) 5.000 TL'den büyük olan müşterilerin isimlerini ve toplam harcama tutarlarını getiren sorguyu yazar mısın?

SELECT 
	b.id,
    b.ad_soyad, 
    SUM(a.fiyat) AS top_fiyat
FROM siparisler a
INNER JOIN kullanicilar b ON a.kullanici_id = b.id
GROUP BY b.id, b.ad_soyad 
HAVING SUM(a.fiyat) > 5000;

--Soru-5 : Siparisler tablosundaki tüm kayıtlar arasından, fiyatı, tüm siparişlerin ortalama fiyatından (AVG(fiyat)) yüksek olanları getiren SQL sorgusunu yazar mısın?

SELECT
    urun_adi,
    fiyat
FROM siparisler
WHERE fiyat > (SELECT AVG(fiyat) FROM siparisler);

--Soru-6 : Her bir kayıt yılına göre (2023, 2024 vb.) toplam yapılan harcama tutarını getiren bir sorgu yazabilir miyiz?

SELECT
    DATE_PART('year', k.kayit_tarihi) AS kayit_yili,
    SUM(s.fiyat) AS toplam_harcama,
    COUNT(s.id) AS toplam_siparis_sayisi
FROM siparisler AS s
INNER JOIN kullanicilar AS k ON s.kullanici_id = k.id
GROUP BY kayit_yili
ORDER BY kayit_yili DESC;

-- Soru-7 : Her şehir özelinde, satılan ürünleri fiyatına göre sıralayıp, her şehrin en pahalı ürününü getiren bir sorgu yazar mısın?

WITH sirali_liste AS (
    SELECT 
        b.sehir,
        a.urun_adi,
        a.fiyat,
        ROW_NUMBER() OVER(PARTITION BY b.sehir ORDER BY a.fiyat DESC) as sira
    FROM siparisler a
    INNER JOIN kullanicilar b ON a.kullanici_id = b.id
)
SELECT 
    sehir, 
    urun_adi, 
    fiyat
FROM sirali_liste
WHERE sira = 1; 

-- Soru-8 : Hiç sipariş vermemiş olan veya son sipariş tarihi 2025-12-13'ten önce olan kullanıcıları nasıl buluruz?

SELECT 
    b.id, 
    b.ad_soyad, 
    MAX(a.siparis_tarihi) AS son_siparis_tarihi
FROM kullanicilar b
LEFT JOIN siparisler a ON b.id = a.kullanici_id
GROUP BY b.id, b.ad_soyad
HAVING MAX(a.siparis_tarihi) < '2025-12-13' 
    OR MAX(a.siparis_tarihi) IS NULL;

/* Soru-9 : Siparişleri şu kurallara göre etiketleyen bir sorgu yazar mısın?

Fiyatı 10.000 TL ve üzeri ise: 'Lüks Segment'
Fiyatı 2.000 TL ile 10.000 TL arası ise: 'Orta Segment'
Fiyatı 2.000 TL altı ise: 'Ekonomik Segment'

İstenen Sütunlar: urun_adi, fiyat ve bu etiketleri içeren segment sütunu. */

SELECT
    urun_adi,
    fiyat,
    CASE 
        WHEN fiyat < 2000 THEN 'Ekonomik Segment'
        WHEN fiyat >= 2000 AND fiyat < 10000 THEN 'Orta Segment'
        ELSE 'Lüks Segment'
    END AS segment
FROM siparisler
ORDER BY fiyat DESC; 

/* Soru-10: Aşağıdaki sütunları içeren bir rapor yazar mısın?

Şehir Adı, Toplam Sipariş Sayısı, Toplam Gelir
Şehirdeki "Lüks Segment" Ürün Sayısı 
Sonuçları Toplam Gelir'e göre büyükten küçüğe sırala. */

SELECT
    b.sehir,
    COUNT(a.id) AS toplam_siparis_sayisi,
    SUM(a.fiyat) AS top_gelir,
    SUM(CASE WHEN a.fiyat >= 10000 THEN 1 ELSE 0 END) AS lux_segment_sayisi
FROM siparisler a
INNER JOIN kullanicilar b ON a.kullanici_id = b.id
GROUP BY b.sehir
ORDER BY top_gelir DESC;



















