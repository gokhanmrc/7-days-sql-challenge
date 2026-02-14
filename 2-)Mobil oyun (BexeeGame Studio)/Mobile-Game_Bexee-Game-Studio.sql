/*
Bugünün Simülasyonu: Mobil oyun firması "Bexee-Game Studio"

Tablo 1: Oyuncular

oyuncu_id (INT)
takma_ad (VARCHAR)
ulke (VARCHAR)
kayit_tarihi (DATE)
cihaz_modeli (VARCHAR)

Tablo 2: Oyun_Oturumlari

oturum_id (INT)
oyuncu_id (INT)
skor (INT)
seviye (INT)
sure_dk (INT)
tarih (TIMESTAMP)

Tablo 3: Satin_Almalar

islem_id (INT)
oyuncu_id (INT)
urun_adi (VARCHAR)
tutar (DECIMAL)
tarih (TIMESTAMP)
*/

--Soru 1: Bugün (2025-12-28) oyuna giren toplam benzersiz oyuncu sayısını (DAU) ve bu oyuncuların oturum başına ortalama ne kadar süre (dakika) oyunda kaldığını getiren sorguyu yazabilir misin?

SELECT
    COUNT(DISTINCT oyuncu_id) AS DAU,
    AVG(sure_dk) AS Ortalama_Sure
FROM Oyun_Oturumlari
WHERE tarih >= '2025-12-28 00:00:00' 
  AND tarih < '2025-12-29 00:00:00';

--Soru 2: Her bir ülkeye göre, yapılan toplam harcama tutarını ve harcama yapan benzersiz oyuncu sayısını getiren bir sorgu yazar mısın?

SELECT
	b.ulke,
    SUM(a.tutar) AS toplam_harcama,
    COUNT(DISTINCT a.oyuncu_id) AS benzersiz_kullanici
FROM Satin_Almalar a
INNER JOIN Oyuncular b ON a.oyuncu_id = b.oyuncu_id
GROUP BY 1 
ORDER BY toplam_harcama DESC;

--Soru 3: Cihaz modellerine göre (iPhone 15, Samsung S23 vb.) oyuncuların yaptığı ortalama skoru ve ortalama oyun süresini getiren bir sorgu yazar mısın?

SELECT
    a.cihaz_modeli,
    ROUND(AVG(b.skor), 0) AS ort_skor,
    ROUND(AVG(b.sure_dk), 1) AS ort_sure,
    COUNT(b.oturum_id) AS toplam_oturum_sayisi 
FROM Oyuncular a
INNER JOIN Oyun_Oturumlari b ON a.oyuncu_id = b.oyuncu_id
GROUP BY 1
HAVING COUNT(b.oturum_id) > 10 -- Bonus: Sadece anlamlı veri olan cihazları getir
ORDER BY ort_skor DESC;

/* Soru 4: Balina (Whale) Analizi - Gelir Dağılımı 
1. Oyuncuların takma adlarını (takma_ad) ve toplam harcama tutarlarını getir.
2. Sadece en çok harcama yapan ilk 3 kişiyi listele.
3. Bu 3 kişinin hangi ülkeden olduğunu da yanına ekle. */

SELECT
    b.takma_ad,
    b.ulke,
    SUM(a.tutar) AS top_harcama
FROM Satin_Almalar a
INNER JOIN Oyuncular b ON a.oyuncu_id = b.oyuncu_id -- Sadece kayıtlı oyuncuları getir
GROUP BY b.takma_ad, b.ulke -- Gruplama tam ve net
ORDER BY top_harcama DESC
LIMIT 3;

/* Soru 5: Seviye Zorluk Analizi 
1. Her bir seviye (level) için; toplam kaç oturum (session) yapıldığını, ortalama skoru ve ortalama süreyi getir.
2. Sadece en az 2 kez oynanmış (session sayısı > 1) seviyeleri listele.
3. Seviyeleri 1'den 50'ye doğru sıralı getir. */

SELECT
    seviye,
    COUNT(oturum_id) AS oturum_sayisi,
    ROUND(AVG(skor), 2) AS ort_skor, 
    ROUND(AVG(sure_dk), 1) AS ort_sure
FROM Oyun_Oturumlari
GROUP BY seviye
HAVING COUNT(oturum_id) > 1
ORDER BY seviye ASC;

/* Soru 6: "Zaman Dilimi" Analizi (Durgun Saatler)
Günün hangi saatlerinde kaç oturum açıldığını gösteren bir rapor hazırla.
1. Saat bilgisini tarih sütunundan çıkar (İpucu: EXTRACT(HOUR FROM tarih)).
2. Her bir saat dilimi için toplam oturum sayısını getir.
3. En az oturum olan saatten en çok olana doğru sırala. */

SELECT
    EXTRACT(HOUR FROM tarih) AS saat_bilgisi,
    COUNT(oturum_id) AS oturum_sayisi
FROM Oyun_Oturumlari
GROUP BY 1
ORDER BY oturum_sayisi ASC;

/* Soru 7: Segmentasyon (Oyuncu Tiplerini Belirleme)
Oyun stüdyosu, oyuncuları harcama alışkanlıklarına göre kategorize etmek istiyor ki her gruba farklı bildirimler (push notification) gönderebilelim.
Oyuncuları şu şekilde etiketleyen bir rapor hazırla:
Hiç harcama yapmamış olanlar -> 'Free-to-Play'
Toplam harcaması 100 TL altı olanlar -> 'Low Spender'
Toplam harcaması 100 TL ve üzeri olanlar -> 'High Spender' */

WITH Oyuncu_Harcama AS (
    SELECT
        a.takma_ad,
        COALESCE(SUM(b.tutar), 0) AS net_harcama -- NULL'u burada halledelim
    FROM Oyuncular a
    LEFT JOIN Satin_Almalar b ON a.oyuncu_id = b.oyuncu_id
    GROUP BY a.takma_ad
)
SELECT 
    takma_ad,
    net_harcama,
    CASE 
        WHEN net_harcama = 0 THEN 'Free-to-Play' -- İşte şimdi oldu!
        WHEN net_harcama < 100 THEN 'Low Spender'
        ELSE 'High Spender'
    END AS gamer_title
FROM Oyuncu_Harcama
ORDER BY net_harcama DESC;

/* Soru 8: Popüler Ürün Analizi (Ekonomi Dengesi)
"En çok hangi ürünü satıyoruz ve bu ürünlerden toplam ne kadar gelir elde ettik?"
1. urun_adi, bu ürünün kaç kez satıldığı (satis_adedi) ve getirdiği toplam geliri (toplam_gelir) listeleyen bir sorgu yazar mısın?
2. En çok satılan ürünü en üstte görmek istiyoruz. */

SELECT
    urun_adi,
    COUNT(islem_id) AS satis_adedi,
    SUM(tutar) AS toplam_gelir
FROM Satin_Almalar
GROUP BY urun_adi
ORDER BY satis_adedi DESC; 

/* Soru 9: "Loyalty" (Sadakat) Analizi
Bir oyuncunun ne kadar süredir bizimle olduğunu bilmek, ona sunacağımız teklifleri belirler.
1. Oyuncuların takma_adlarını ve oyuna kayıt oldukları tarihten bugüne (2025-12-28) kadar kaç gün geçtiğini hesapla.
2. Bu sütuna sadakat_gunu ismini ver.
3. Sadece en eski 5 oyuncuyu getir. */

SELECT 
    takma_ad,
    ('2025-12-28'::DATE - kayit_tarihi) AS sadakat_gunu
FROM Oyuncular
ORDER BY sadakat_gunu DESC
LIMIT 5;

/* Soru 10: "Whale"lerin Oyun Tercihi (İleri Seviye)
"En çok harcama yapan (High Spender) oyuncularımız, genellikle hangi seviyelerde (level) daha çok vakit geçiriyor?"
1. Sadece toplam harcaması 100 TL ve üzeri olan oyuncuları filtrele.
2. Bu oyuncuların Oyun_Oturumlari tablosundaki verilerine bakarak, hangi seviyede ne kadar toplam süre harcadıklarını bul.
3. Sonucu toplam süreye göre azalan şekilde sırala. */

WITH High_Spenders AS (
    SELECT
        oyuncu_id
    FROM Satin_Almalar
    GROUP BY oyuncu_id
    HAVING SUM(tutar) >= 100
)
SELECT
    b.seviye,
    SUM(b.sure_dk) AS toplam_sure_dk
FROM High_Spenders a
INNER JOIN Oyun_Oturumlari b ON a.oyuncu_id = b.oyuncu_id
GROUP BY b.seviye
ORDER BY toplam_sure_dk DESC;
	
	