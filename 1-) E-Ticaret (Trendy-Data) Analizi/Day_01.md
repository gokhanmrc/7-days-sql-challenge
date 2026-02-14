# 🛒 Day 1: E-Commerce Data Analysis (Trendy-Data)

7 günlük SQL maratonunun ilk gününde, bir e-ticaret platformunun (Trendy-Data) satış performansını ve müşteri davranışlarını analiz eden 10 farklı senaryo üzerinde çalışılmıştır.

## 📊 Veri Seti Yapısı
Analiz iki temel tablo üzerinden yürütülmüştür:
- **Kullanicilar:** Kullanıcı kimlikleri, isimler, kayıt tarihleri ve şehir bilgileri.
- **Siparisler:** Sipariş detayları, ürün isimleri, fiyatlar ve işlem tarihleri.

## 🎯 Analiz Odak Noktaları
Bu çalışmada iş birimleri için kritik olan şu metriklere odaklanılmıştır:
1. **Sales Performance:** Şehir bazlı toplam gelirler ve en yüksek kazanç sağlayan bölgelerin tespiti.
2. **Customer Behavior:** Kullanıcı başına düşen harcama ve sipariş adetleri.
3. **Advanced Filtering:** Ortalama sepet tutarının üzerindeki ürünlerin tespiti (Subqueries).
4. **Segmentation:** Ürünlerin fiyatlarına göre 'Lüks', 'Orta' ve 'Ekonomik' olarak sınıflandırılması.
5. **Churn & Inactivity:** Belirli tarihlerden beri sipariş vermeyen veya hiç etkileşime girmeyen "pasif" kullanıcıların analizi.
6. **Ranking:** Şehir bazında en pahalı ürünlerin `ROW_NUMBER()` ile dinamik olarak sıralanması.

## 🛠️ Teknik Kazanımlar
- **Window Functions:** Şehir bazlı en pahalı ürünleri bulmak için `ROW_NUMBER() OVER(PARTITION BY ...)` kullanıldı.
- **Conditional Aggregation:** `SUM(CASE WHEN ...)` yapısı ile tek bir sorguda gelişmiş raporlama (örneğin şehir bazlı lüks ürün sayısı) yapıldı.
- **Common Table Expressions (CTE):** Karmaşık sıralama mantıklarını daha yönetilebilir parçalara ayırmak için tercih edildi.
- **Subqueries:** Dinamik eşik değerleri (ortalama fiyat vb.) üzerinden filtreleme yapıldı.

---
