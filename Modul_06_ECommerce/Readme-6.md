# 🛒 Modül 06: E-Commerce & CRM Analytics (Trendy-Data)

Bu çalışma, "Trendy-Data" e-ticaret platformunun kullanıcı davranışlarını ve satış performansını analiz ederek; **Müşteri Segmentasyonu, Satış Trendleri ve CRM Stratejileri** geliştirmek üzerine kurgulanmıştır. Bir Veri Analisti olarak amacım; kullanıcıların satın alma alışkanlıklarını anlamak ve pazarlama bütçesinin en verimli şekilde kullanılmasını sağlayacak içgörüler üretmektir.

## 📊 Veri Seti Mimarisi
Analiz, müşteri etkileşimlerini temsil eden 2 temel tablo üzerinden yürütülmüştür:
- **Kullanicilar:** Kayıt tarihleri, lokasyon (şehir) ve demografik veriler.
- **Siparisler:** Ürün bazlı fiyatlar, sipariş tarihleri ve kategori bilgileri.

## 🎯 Analitik Odak Noktaları & İş Soruları
Bu modülde CRM ve Satış Analitiği çerçevesinde şu 5 kritik alana odaklanılmıştır:

1.  **RFM Foundation (Recency & Monetary):** Kullanıcıların son sipariş tarihlerine göre aktiflik durumlarının (Recency) ve toplam harcama miktarlarının (Monetary) tespiti.
2.  **Customer Segmentation:** `CASE WHEN` yapısı ile ürün fiyatlarına göre 'Lüks', 'Orta' ve 'Ekonomik' segmentlerin oluşturulması ve bu segmentlerin toplam cirodaki payı.
3.  **Geographic Sales Performance:** Şehir bazlı gelir dağılımı ve en yüksek sepet ortalamasına sahip bölgelerin belirlenmesi.
4.  **Churn & Inactivity Management:** Belirli bir tarihten (Örn: 15 Aralık) beri sipariş vermemiş veya sisteme kayıt olup hiç harcama yapmamış "kayıp/potansiyel" kitlenin analizi.
5.  **Basket Analysis (Sepet Ortalaması):** Kullanıcı başına düşen sipariş adedi ve ortalama ürün fiyatlarının (`AVG`) hesaplanması.

## 🛠️ Teknik Uygulamalar (SQL Stack)
- **Window Functions:** `ROW_NUMBER() OVER (PARTITION BY ...)` kullanarak şehir bazlı en pahalı ürünlerin ve en çok harcama yapan müşterilerin dinamik sıralanması.
- **Conditional Aggregation:** `SUM(CASE WHEN ...)` mantığı ile tek sorgu üzerinden kompleks segment raporları (Örn: Şehir bazlı lüks ürün satış adedi).
- **Subqueries & CTE:** Ortalama sepet tutarının üzerindeki işlemleri filtrelemek için iç içe sorgu yapıları.
- **Advanced Joins:** `LEFT JOIN` ve `IS NULL` kontrolü ile "Hayalet Müşteri" (siparişi olmayan) analizi.

## 📈 Örnek Bulgular
- Toplam gelirin büyük bir kısmının "Lüks Segment" ürünlerden geldiği, ancak işlem hacminin "Ekonomik Segment"te yoğunlaştığı tespit edilmiştir.
- Son 30 gündür inaktif olan kullanıcılar için lokasyon bazlı geri kazanım (retention) kampanyaları önerilmiştir.
- Şehir bazlı yapılan analizlerde, X şehrinin en yüksek sepet ortalamasına sahip olduğu görülerek lojistik ve reklam önceliği bu bölgeye yönlendirilmiştir.
