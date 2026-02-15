/* 

Bugünün Simülasyonu: E-Ticaret Dünyası ve Tedarik zinciri (Mega-Shop)
İşte üzerinde çalışacağımız tablo yapıları:

Tablo 1: Musteriler 

musteri_id (INT)
ad_soyad (VARCHAR)
sehir (VARCHAR)
uyelik_tipi (VARCHAR)
kayit_tarihi (DATE)

Tablo 2: Urunler

urun_id (INT)
urun_adi (VARCHAR)
kategori (VARCHAR)
fiyat (DECIMAL)
stok_adedi (INT)

Tablo 3: Siparisler

siparis_id (INT)
musteri_id (INT)
urun_id (INT)
adet (INT)
siparis_tarihi (DATE)
teslim_tarihi (DATE)
iade_edildi_mi (BOOLEAN)

*/

/* 
Soru-1:

1. Urunler ve Siparisler tablolarını birleştir.
2. Ürün adına (urun_adi) göre gruplayarak, toplam kaç adet (SUM(adet)) satıldığını bul.
3. En çok satılandan en aza doğru sırala.

*/

SELECT
    u.urun_adi,
    SUM(s.adet) AS satilan_adet
FROM Urunler u
INNER JOIN Siparisler s ON u.urun_id = s.urun_id
GROUP BY u.urun_adi
ORDER BY satilan_adet DESC;

/* 
Soru-2:Henüz teslim edilmemiş (yani yolda olan veya depoda bekleyen) siparişleri tespit etmemiz lazım.

1-Siparisler ve Musteriler tablolarını birleştir.
2-Müşterinin ad_soyad bilgisini, siparis_tarihini ve siparis_idsini getir.
3-Kritik Filtre: Sadece teslim_tarihi bilgisi boş olan (NULL) kayıtları getir.
4-En eski sipariş en üstte olacak şekilde sırala.

*/

SELECT
    m.ad_soyad,
    s.siparis_tarihi,
    s.siparis_id
FROM Musteriler m
INNER JOIN Siparisler s ON m.musteri_id = s.musteri_id
WHERE s.teslim_tarihi IS NULL 
ORDER BY s.siparis_tarihi ASC;

/* 
Soru-3:

1. Sadece teslim edilmiş (yani teslim_tarihi NULL olmayan) siparişleri dikkate al.
2. Her bir kategori bazında, ürünlerin sipariş tarihinden teslim tarihine kadar geçen ortalama gün sayısını hesapla.
3. Sonuçları "en yavaş" kategoriden "en hızlıya" doğru sırala.

*/

SELECT
    u.kategori,
    AVG(s.teslim_tarihi - s.siparis_tarihi) AS ort_teslim_gunu
FROM Urunler u
INNER JOIN Siparisler s ON u.urun_id = s.urun_id
WHERE s.teslim_tarihi IS NOT NULL 
GROUP BY u.kategori
ORDER BY ort_teslim_gunu DESC;

/* 
Soru-4:

1. Her bir şehre göre, yapılan toplam harcama tutarını (adet * fiyat) hesapla.
2. Şehirleri en çok harcama yapandan en aza doğru sırala.

*/

SELECT 
    m.sehir,
    SUM(s.adet * u.fiyat) AS top_harcama
FROM Siparisler s
INNER JOIN Musteriler m ON m.musteri_id = s.musteri_id
INNER JOIN Urunler u ON u.urun_id = s.urun_id
GROUP BY m.sehir 
ORDER BY top_harcama DESC;

/* 
Soru-5:

1. Her bir ürün adı için; toplam kaç sipariş verildiğini ve bu siparişlerin kaç tanesinin iade edildiğini (iade_edildi_mi = TRUE) bul.
2. Ürünleri en çok iade edilenden en aza doğru sırala

*/

SELECT
    u.urun_adi,
    COUNT(s.siparis_id) AS toplam_siparis_sayisi,
    SUM(CASE WHEN s.iade_edildi_mi = TRUE THEN 1 ELSE 0 END) AS iade_edilen_siparis_sayisi,
    ROUND((SUM(CASE WHEN s.iade_edildi_mi = TRUE THEN 1 ELSE 0 END)::DECIMAL / COUNT(s.siparis_id)) * 100, 2) AS iade_orani_yuzde
FROM Siparisler s
INNER JOIN Urunler u ON u.urun_id = s.urun_id
GROUP BY u.urun_adi
ORDER BY iade_edilen_siparis_sayisi DESC;

/* 
Soru-6:

1.Üyelik Tipine göre (Standard, Premium); toplam müşteri sayısını ve bu grubun yaptığı toplam harcamayı getir.
2.Sonuçları toplam harcamaya göre sırala.

*/

SELECT 
    m.uyelik_tipi,
    COUNT(DISTINCT m.musteri_id) AS aktif_musteri_sayisi,
    SUM(s.adet * u.fiyat) AS toplam_harcama,
    ROUND(SUM(s.adet * u.fiyat) / COUNT(DISTINCT m.musteri_id), 2) AS musterı_bası_ort_harcama
FROM Siparisler s
INNER JOIN Musteriler m ON m.musteri_id = s.musteri_id
INNER JOIN Urunler u ON u.urun_id = s.urun_id
GROUP BY m.uyelik_tipi
ORDER BY toplam_harcama DESC;

/* 
Soru-7:

1. Her bir ürünün adını ve kalan stok adedini getir.
2. Yanına bir sütun daha ekle: Eğer stok 20'den az ise 'KRİTİK', 20 ile 50 arasında ise 'AZALIYOR', 50'den fazla ise 'YETERLİ' yazsın.
3. Bu yeni sütuna stok_durumu adını ver.

*/

SELECT 
    urun_adi,
    stok_adedi,
    CASE 
        WHEN stok_adedi < 20 THEN 'KRİTİK' 
        WHEN stok_adedi BETWEEN 20 AND 50 THEN 'AZALIYOR' 
        ELSE 'YETERLİ' 
    END AS stok_durumu	
FROM Urunler
ORDER BY stok_adedi ASC;

/* 
Soru-8: Sisteme kayıtlı olan ama hiç siparişi bulunmayan müşterilerin ad_soyad ve sehir bilgilerini getir.

*/

SELECT 
    m.ad_soyad,
    m.sehir
FROM Musteriler m 
LEFT JOIN Siparisler s ON m.musteri_id = s.musteri_id 
WHERE s.siparis_id IS NULL;
/* 
Soru-9:

1. Teslimatı 5 günden uzun süren (teslim_tarihi - siparis_tarihi > 5) siparişlerin; müşteri adını, ürün adını ve kaç günde teslim edildiğini getir.
2. Sadece teslim edilmiş olanları (IS NOT NULL) filtrelemeyi unutma.

*/

SELECT 
    m.ad_soyad,
    u.urun_adi,
    (s.teslim_tarihi - s.siparis_tarihi) AS kargo_suresi
FROM Siparisler s
INNER JOIN Musteriler m ON m.musteri_id = s.musteri_id
INNER JOIN Urunler u ON u.urun_id = s.urun_id
WHERE s.teslim_tarihi IS NOT NULL 
  AND (s.teslim_tarihi - s.siparis_tarihi) > 5
ORDER BY kargo_suresi DESC;

/* 
Soru-10:Her bir kategori için:

1. Toplam kaç ürün satıldı?
2. Toplam ciro ne kadar?
3. Toplam kaç iade alındı?
3. Ortalama Ürün Fiyatı nedir?
Sıralama: En yüksek cirolu kategori en üstte olsun.
*/

SELECT 
    u.kategori,
    SUM(s.adet) AS toplam_satilan_adet,
    SUM(s.adet * u.fiyat) AS toplam_ciro,
    SUM(CASE WHEN s.iade_edildi_mi = TRUE THEN s.adet ELSE 0 END) AS toplam_iade_adedi,
    ROUND(AVG(u.fiyat), 2) AS ortalam_satis_fiyati
FROM Siparisler s
INNER JOIN Urunler u ON u.urun_id = s.urun_id
GROUP BY u.kategori 
ORDER BY toplam_ciro DESC;

	












