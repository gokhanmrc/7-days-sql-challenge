# 📦 Day 4: Advanced E-Commerce & Supply Chain (Mega-Shop)

4. günde, "Trendy-Data" simülasyonu genişletilerek lojistik süreçler, stok yönetimi ve kategori bazlı performans analizleri üzerine yoğunlaşılmıştır.

## 📊 Veri Seti Yapısı
- **Musteriler:** Üyelik tipleri (Premium/Standard) ve demografik veriler.
- **Urunler:** Kategori bilgileri, birim fiyatlar ve güncel stok adetleri.
- **Siparisler:** Sipariş/Teslimat tarihleri ve iade durumlarını içeren operasyonel veriler.

## 🎯 Analitik Odak Noktaları
1. **Supply Chain (SLA):** Sipariş ve teslimat tarihleri arasındaki farklar üzerinden kargo performans analizi.
2. **Inventory Management:** Kritik stok seviyelerinin (Kritik/Azalıyor/Yeterli) `CASE WHEN` ile dinamik takibi.
3. **Financial Metrics:** Brüt ciro hesaplamaları ve iade oranlarının kategori bazlı dağılımı.
4. **CRM Insights:** Üyelik tipi bazlı müşteri harcama alışkanlıkları ve kişi başı ortalama harcama tespiti.
5. **Churn & Retention:** Kayıtlı olup henüz sipariş vermemiş "pasif" kitle analizi.

## 🛠️ Teknik Kazanımlar
- **Advanced Aggregation:** Tek bir sorguda `COUNT`, `SUM`, `AVG` ve `MAX` fonksiyonlarının bir arada kullanımı.
- **Logical Branching:** `CASE WHEN` ile dinamik metrik etiketleme (Stok durumu, İade sayımı).
- **Date Arithmetic:** Tarih farkları üzerinden operasyonel hız ölçümü.
- **Complex Joins:** Üçlü tablo birleştirmeleriyle veri zenginleştirme.

---
