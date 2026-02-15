/* 

Bugünün Simülasyonu: Bankacılık ve Finans "Global-Safe Bank"
İşte üzerinde çalışacağımız tablo yapıları:

1. Banka_Musterileri
musteri_id (INT)
ad_soyad (VARCHAR)
sehir (VARCHAR)
meslek (VARCHAR)
gelir_duzeyi (DECIMAL)
musteri_segmenti (VARCHAR)

2. Kredi_Kartlari
kart_no (VARCHAR)
musteri_id (INT)
limit_tl (DECIMAL)
kart_tipi (VARCHAR)
kesim_gunu (INT)

3. Islemler 
islem_id (SERIAL)
kart_no (VARCHAR)
islem_tarihi (TIMESTAMP)
tutar (DECIMAL)
islem_tipi (VARCHAR)
is_fraud (BOOLEAN - Varsayılan: FALSE)

*/
--Soru-1: 2025-12-30 tarihinde, aynı gün içerisinde 5'ten fazla işlem yapmış olan kart numaralarını ve yaptıkları toplam işlem sayısını bul.

SELECT
    kart_no,
    COUNT(islem_id) AS islem_sayisi
FROM Islemler
WHERE islem_tarihi::DATE = '2025-12-30'
GROUP BY kart_no
HAVING COUNT(islem_id) > 5;

/*
Soru-2: 
1. Müşterinin adını (ad_soyad), aylık gelirini (gelir_duzeyi) ve toplam kart limitini (limit_tl) getir.
2. Öyle bir filtre yaz ki; sadece toplam limiti, aylık gelirinin 2 katından fazla olan müşteriler listelensin.
*/

SELECT
    a.ad_soyad,
    a.gelir_duzeyi,
    SUM(b.limit_tl) AS top_limit
FROM Banka_Musterileri a
INNER JOIN Kredi_Kartlari b ON a.musteri_id = b.musteri_id
GROUP BY a.ad_soyad, a.gelir_duzeyi
HAVING SUM(b.limit_tl) > (a.gelir_duzeyi * 2);

/*
Soru-3: 
1. Her bir müşteri segmenti için; toplam harcama tutarını ve yapılan işlem sayısını getir.
2. Bu raporu toplam harcama tutarına göre büyükten küçüğe sırala.
*/

SELECT
    b.musteri_segmenti,
    SUM(i.tutar) AS top_harcama,
    COUNT(i.islem_id) AS top_islem_sayisi
FROM Banka_Musterileri b
INNER JOIN Kredi_Kartlari k ON b.musteri_id = k.musteri_id
INNER JOIN Islemler i ON k.kart_no = i.kart_no
GROUP BY b.musteri_segmenti
ORDER BY top_harcama DESC;

/*
Soru-4: 
1. islem_tipi = 'Yurt_Disi' olan işlemleri bul.
2. Bu işlemleri yapan müşterilerin ad_soyad, gelir_duzeyi ve işlemin tutar bilgisini getir.
3. Sadece işlem tutarı, aylık gelirinin %25'inden fazla olan (yani geliriyle orantısız harcama yapan) satırları listele.
*/

SELECT
    b.ad_soyad,
    b.gelir_duzeyi,
    SUM(i.tutar) AS toplam_yurtdisi_harcama
FROM Banka_Musterileri b
INNER JOIN Kredi_Kartlari k ON b.musteri_id = k.musteri_id
INNER JOIN Islemler i ON k.kart_no = i.kart_no
WHERE i.islem_tipi = 'Yurt_Disi'
GROUP BY b.ad_soyad, b.gelir_duzeyi
HAVING SUM(i.tutar) > (b.gelir_duzeyi * 0.25)
ORDER BY toplam_yurtdisi_harcama DESC;

/*
Soru-5: 
1. Gece saat 00:00 ile 05:00 arasında (05:00 dahil değil) yapılan işlemleri bul.
2. Bu işlemleri yapan müşterilerin ad_soyadlarını, islem_tarihini ve tutarını getir.
3. Sonuçları saate göre sırala.
*/

SELECT
    b.ad_soyad,
    i.islem_tarihi, -- Hem tarih hem saat görünmeli
    i.tutar
FROM Banka_Musterileri b
INNER JOIN Kredi_Kartlari k ON b.musteri_id = k.musteri_id
INNER JOIN Islemler i ON k.kart_no = i.kart_no
WHERE i.islem_tarihi::TIME >= '00:00:00' 
  AND i.islem_tarihi::TIME < '05:00:00'
ORDER BY i.islem_tarihi ASC;

/*
Soru-6: 
1. Her bir kart için; kartın limit_tl değerini ve bu kartla yapılan toplam harcama tutarını getir.
2. Harcama tutarının limite oranını hesapla (Örn: toplam_harcama / limit_tl * 100) ve buna doluluk_orani ismini ver.
3. Sadece doluluk_orani %80'in üzerinde olan kartları listele.
*/

SELECT
    k.kart_no,
    k.limit_tl,
    SUM(i.tutar) AS top_harcama,
    ROUND((SUM(i.tutar) / k.limit_tl) * 100, 2) AS doluluk_orani
FROM Kredi_Kartlari k
INNER JOIN Islemler i ON k.kart_no = i.kart_no
GROUP BY k.kart_no, k.limit_tl
HAVING (SUM(i.tutar) / k.limit_tl) * 100 > 80
ORDER BY doluluk_orani DESC;

/*
Soru-7: 
1. sehir bilgisi 'İstanbul' veya 'Ankara' olan,
2. islem_tipi 'ATM' olan,
3. tutarı 200 TL'den küçük olan tüm işlemlerin; müşteri adını, şehri ve işlem tutarını getir.
*/

SELECT
    b.ad_soyad,
    b.sehir,
    i.tutar
FROM Banka_Musterileri b
INNER JOIN Kredi_Kartlari k ON b.musteri_id = k.musteri_id
INNER JOIN Islemler i ON k.kart_no = i.kart_no
WHERE b.sehir IN ('İstanbul', 'Ankara')
  AND i.islem_tipi = 'ATM'
  AND i.tutar < 200
ORDER BY i.tutar ASC;

/*
Soru-8: 
1. musteri_segmenti 'Gold' veya 'Silver' olan,
2. Toplam harcaması 50.000 TL'nin üzerinde olan müşterilerin; adını ve toplam harcamasını getir.
*/

SELECT
    b.musteri_id,
    b.ad_soyad,
    SUM(i.tutar) AS toplam_harcama
FROM Banka_Musterileri b
INNER JOIN Kredi_Kartlari k ON b.musteri_id = k.musteri_id
INNER JOIN Islemler i ON k.kart_no = i.kart_no
WHERE b.musteri_segmenti IN ('Gold', 'Silver')
GROUP BY b.musteri_id, b.ad_soyad
HAVING SUM(i.tutar) > 50000
ORDER BY toplam_harcama DESC;

/*
Soru-9: 
1. 2025-12-29 ve 2025-12-30 tarihleri arasında yapılan tüm işlemlerin; islem_tipine göre toplam tutarını getir.
*/

SELECT
    islem_tipi,
    SUM(tutar) AS top_tutar
FROM Islemler
WHERE islem_tarihi::DATE BETWEEN '2025-12-29' AND '2025-12-30'
GROUP BY islem_tipi
ORDER BY top_tutar DESC; 

/*
Soru-10: 
Her bir kart için şu bilgileri tek bir satırda getir:

kart_no
Toplam işlem sayısı
Toplam harcama tutarı
En büyük tekil harcaması 
Bu kartın sahibi olan müşterinin ad_soyad bilgisi.

Sıralama: En çok harcama yapan kart en üstte olsun.
*/

SELECT
    k.kart_no,
    b.ad_soyad,
    COUNT(i.islem_id) AS top_islem_adedi,
    SUM(i.tutar) AS top_harcama_tutari,
    MAX(i.tutar) AS max_harcama
FROM Kredi_Kartlari k
INNER JOIN Banka_Musterileri b ON k.musteri_id = b.musteri_id
INNER JOIN Islemler i ON k.kart_no = i.kart_no
GROUP BY k.kart_no, b.ad_soyad
ORDER BY top_harcama_tutari DESC;



















