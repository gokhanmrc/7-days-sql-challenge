# 📦 Modül 03: E-Commerce & Supply Chain Analytics (Mega-Shop)

Bu çalışma, "Mega-Shop" e-ticaret platformunun satış performansını, lojistik süreçlerini ve stok verimliliğini analiz etmek üzerine kurgulanmıştır. Bir Veri Analisti olarak amacım; operasyonel darboğazları tespit etmek ve tedarik zinciri süreçlerini veriyle optimize etmektir.

## 📊 Veri Seti Mimarisi
Analiz, uçtan uca bir e-ticaret döngüsünü temsil eden 3 temel tablo üzerinden yürütülmüştür:
- **Musteriler:** Üyelik tipleri (Premium/Standard) ve kayıt geçmişi.
- **Urunler:** Kategori bilgileri, birim fiyatlar ve anlık stok adetleri.
- **Siparisler:** Sipariş ve teslimat tarihleri, adetler ve iade durumlarını içeren işlem verileri.

## 🎯 Analitik Odak Noktaları & İş Soruları
Bu modülde tedarik zinciri ve müşteri yaşam döngüsü yönetimi için şu 5 kritik alana odaklanılmıştır:

1.  **Supply Chain Efficiency (SLA):** Sipariş ve teslimat tarihleri arasındaki farklar üzerinden kargo performans analizi. 5 günü aşan gecikmelerin tespiti.
2.  **Inventory Management (Stok Yönetimi):** Kritik stok seviyelerinin (Kritik/Azalıyor/Yeterli) `CASE WHEN` mantığı ile dinamik takibi ve stoksuzluk riskinin önlenmesi.
3.  **Revenue & Returns:** Kategori bazlı brüt ciro hesaplamaları ve ürün iade oranlarının operasyonel maliyete etkisinin analizi.
4.  **Churn & Inactivity (Pasif Müşteri):** Sisteme kayıtlı olup henüz ilk siparişini vermemiş "pasif" kullanıcıların segmentasyonu.
5.  **Premium vs. Standard Analytics:** Üyelik tipine göre sepet ortalaması ve harcama alışkanlıklarının karşılaştırılması.

## 🛠️ Teknik Uygulamalar (SQL Stack)
- **Date Arithmetic:** `(s.teslim_tarihi - s.siparis_tarihi)` hesaplamaları ile lojistik hız ölçümü.
- **Advanced Joins:** `LEFT JOIN` kullanarak sipariş vermeyen müşterilerin (NULL yönetimi) tespiti.
- **Dynamic Labeling:** `CASE WHEN` ile stok ve fiyat bazlı ürün segmentasyonu.
- **Sorting & Ranking:** En çok satılan ve en çok iade edilen ürünlerin `ORDER BY` ve `SUM` ile hiyerarşik listelenmesi.

## 📈 Örnek Bulgular
- Teslimatı 5 günü geçen siparişlerin belirli kategorilerde yoğunlaştığı tespit edilerek lojistik partner güncellenmesi önerilmiştir.
- Stok seviyesi "Kritik" olan ürünler için otomatik tedarik alarmı kurgusu oluşturulmuştur.
- "Premium" üyelerin, standart üyelere göre %X daha yüksek sepet ortalamasına sahip olduğu gözlemlenmiştir.
