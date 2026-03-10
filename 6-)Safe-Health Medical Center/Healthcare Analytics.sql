/* 

Bugünün Simülasyonu: Şehir Hastanesi Veri Analizi
İşte üzerinde çalışacağımız tablo yapıları:

Tablo 1: Hastalar

hasta_id (INT)
ad (VARCHAR)
soyad (VARCHAR)
dogum_tarihi (DATE)
telefon (VARCHAR)
kan_grubu (VARCHAR)

Tablo 2: Doktorlar

doktor_id (INT)
ad_soyad (VARCHAR)
uzmanlik_alani (VARCHAR)
unvan (VARCHAR)

Tablo 3: Randevular

randevu_id (INT)
hasta_id (VARCHAR)
doktor_id (VARCHAR)
randevu_tarihi (VARCHAR)
durum (VARCHAR)

*/


/* 
Soru-1 : KVKK için:

1.  ad ve soyad sütunlarını BÜYÜK HARFLE birleştir (UPPER ve ||).
2.  telefon numarasının ilk 4 hanesini alıp sonuna *** ekle (LEFT ve ||).

*/

SELECT
    UPPER(ad || ' ' || soyad) AS tam_ad,
    LEFT(telefon, 4) || '***' AS gizli_telefon
FROM Hastalar;

/* 
Soru-2 : Doktor Yoğunluk Raporu

1. Doktorun adını (ad_soyad) ve uzmanlık alanını getir.
2. Bu doktora ait toplam randevu sayısını hesapla.
3. Sadece durumu 'Tamamlandı' olan randevuları say.
4. En yoğun doktoru en üstte göster.

*/


SELECT
    d.ad_soyad,
    d.uzmanlik_alani,
    COUNT(r.randevu_id) AS tamamlanan_randevu_sayisi
FROM Doktorlar d
INNER JOIN Randevular r ON d.doktor_id = r.doktor_id
WHERE r.durum = 'Tamamlandı'
GROUP BY d.ad_soyad, d.uzmanlik_alani
ORDER BY tamamlanan_randevu_sayisi DESC;

/* 
Soru-3 : Kronik Hasta Takibi 

1.  Hastanın adını ve soyadını (Hastalar tablosundan), doktorun adını da (Doktorlar tablosundan) getir.
2.  Bu ikili kombinasyon (Hasta + Doktor) için toplam randevu sayısını hesapla.
3.  Sadece toplam randevu sayısı 1'den büyük olanları getir.

*/

SELECT
    h.hasta_id,
    UPPER(h.ad || ' ' || h.soyad) AS hasta_tam_ad,
    d.ad_soyad AS doktor_adi,
    COUNT(r.randevu_id) AS randevu_sayisi
FROM Hastalar h
INNER JOIN Randevular r ON h.hasta_id = r.hasta_id
INNER JOIN Doktorlar d ON r.doktor_id = d.doktor_id
GROUP BY h.hasta_id, h.ad, h.soyad, d.ad_soyad
HAVING COUNT(r.randevu_id) > 1
ORDER BY randevu_sayisi DESC;

/* 
Soru-4 : Gece Kuşu Muayeneleri (Saat Analizi)

1. Sadece öğleden sonra (saat 13:00 ve sonrası) gerçekleşen randevuları getir.
2. Çıktıda hastanın adı, doktorun adı ve sadece randevu saati (HH:MI formatında) görünsün.

*/

SELECT
    UPPER(h.ad || ' ' || h.soyad) AS hasta_tam_ad,
    d.ad_soyad AS doktor_adi,
    TO_CHAR(r.randevu_tarihi, 'HH24:MI') AS randevu_saati
FROM Hastalar h
INNER JOIN Randevular r ON h.hasta_id = r.hasta_id
INNER JOIN Doktorlar d ON r.doktor_id = d.doktor_id
WHERE EXTRACT(HOUR FROM r.randevu_tarihi) >= 13
ORDER BY r.randevu_tarihi ASC;

/* 
Soru-5 : Kan Grubu ve Yaş Analizi

1. Her bir kan grubunu listele.
2. O kan grubuna sahip toplam hasta sayısını bul.
3. O kan grubundaki hastaların ortalama yaşını hesapla (Bugünün tarihini baz alarak).

*/


SELECT
   kan_grubu,
   COUNT(hasta_id) AS hasta_sayisi,
   ROUND(AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, dogum_tarihi)))::DECIMAL, 1) AS ortalama_hasta_yasi
FROM Hastalar
GROUP BY kan_grubu
ORDER BY hasta_sayisi DESC;
   

/* 
Soru-6 : İptal Edilen Randevu Analizi (Doktor Performansı)

1. Doktorun adını (ad_soyad) getir.
2. Toplam randevu sayısını (count) getir.
3. Toplam iptal edilen randevu sayısını getir.
4. İptal Oranını hesapla: (İptal Sayısı / Toplam Sayı) * 100.

*/

SELECT
    d.ad_soyad,
    COUNT(r.randevu_id) AS toplam_randevu,
    SUM(CASE WHEN r.durum = 'İptal' THEN 1 ELSE 0 END) AS iptal_sayisi,
    ROUND(
        (SUM(CASE WHEN r.durum = 'İptal' THEN 1 ELSE 0 END)::DECIMAL / COUNT(r.randevu_id)) * 100, 
        2
    ) AS iptal_orani_yuzde
FROM Doktorlar d  
INNER JOIN Randevular r ON d.doktor_id = r.doktor_id
GROUP BY d.ad_soyad
ORDER BY iptal_orani_yuzde DESC;

/* 
Soru-7 : Soyadı Benzerliği (Akraba Hastalar?)

1.  Aynı soyadına sahip birden fazla hasta olup olmadığını bul.
2.  Soyadını ve o soyadına sahip kaç kişi olduğunu getir.
3. Sonuçları sayıya göre çoktan aza sırala.

*/


SELECT
   UPPER(soyad) AS soyad,
   COUNT(hasta_id) AS hasta_sayisi
FROM Hastalar
GROUP BY soyad
HAVING COUNT(hasta_id) > 1 -- Sadece potansiyel akrabaları/grupları listeler
ORDER BY hasta_sayisi DESC;

/* 
Soru-8 : Eksik Bilgi Kontrolü (Veri Kalitesi)

1.  Telefon numarası NULL (boş) olan veya kan grubu bilgisi girilmemiş hastaların listesini getir.
2.  Ad, soyad ve hangi verinin eksik olduğunu gösteren bir durum sütunu ekle.


*/

SELECT
    ad,
    soyad,
    CASE WHEN telefon IS NULL THEN 'Telefon Eksik' ELSE 'Tamam' END AS telefon_durumu,
    CASE WHEN kan_grubu IS NULL THEN 'Kan Grubu Eksik' ELSE 'Tamam' END AS kan_grubu_durumu
FROM Hastalar
WHERE telefon IS NULL OR kan_grubu IS NULL;

/* 
Soru-9 : Doktorlar İçin "Unvan" Güncellemesi (String Manipulation)

1. Unvanı en başa al (Büyük harfle).
2. Adı olduğu gibi bırak, soyadı tamamen büyük yap.

*/


SELECT
    UPPER(unvan) || ' ' || ad_soyad AS unvanli_doktor_adi
FROM Doktorlar
ORDER BY unvanli_doktor_adi ASC;

/* 
Soru-10 : "Günün Özeti" Paneli

1. Toplam Randevu Sayısı
2. Toplam Tamamlanan Muayene Sayısı
3. Toplam İptal Edilen Muayene Sayısı
4. Hastaneye gelen Benzersiz (Unique) Hasta Sayısı

*/

SELECT
   COUNT(randevu_id) AS toplam_randevu_sayisi,
   SUM(CASE WHEN durum = 'Tamamlandı' THEN 1 ELSE 0 END) AS tamamlanan_muayene_sayisi,
   SUM(CASE WHEN durum = 'İptal' THEN 1 ELSE 0 END) AS iptal_edilen_muayene_sayisi,
   COUNT(DISTINCT hasta_id) AS benzersiz_hasta_sayisi
FROM Randevular
WHERE randevu_tarihi >= '2026-01-20' AND randevu_tarihi < '2026-01-21'; 
 




