# 👥 Modül 04: HR & Workforce Analytics (Global-Talent Corp)

Bu çalışma, bir insan kaynakları departmanının operasyonel verileri üzerinden; **Maaş Adaleti, Turnover (İşten Ayrılma) Analizi ve Organizasyonel Hiyerarşi** süreçlerini analiz etmek üzerine kurgulanmıştır. 
## 📊 Veri Seti Mimarisi
Analiz, kurumsal hiyerarşiyi ve finansal verileri temsil eden 2 temel tablo üzerinden yürütülmüştür:
- **Calisanlar:** Maaş bilgileri, işe giriş tarihleri, çalışan durumu (Aktif/Ayrıldı) ve yönetici eşleşmeleri.
- **Departmanlar:** Departman isimleri ve lokasyon bazlı tanımlamalar.

## 🎯 Analitik Odak Noktaları & İş Soruları
Bu modülde bir WFM ve İK Analistinin yanıt araması gereken şu 5 kritik alana odaklanılmıştır:

1.  **Turnover Rate (İşten Ayrılma Oranı):** Şirketin personel tutma başarısını ölçmek adına toplam çalışan ile işten ayrılanların oranlanması.
2.  **Salary Equity (Maaş Adaleti):** `Window Functions` ve `Subqueries` kullanılarak, departman ortalamasının altında kalan ancak performansı yüksek (kıdemli) "underpaid" çalışanların tespiti.
3.  **Organizational Hierarchy (Self-Join):** Aynı tabloyu kendisine joinleyerek, çalışanların yöneticileriyle olan hiyerarşik bağının ve raporlama hattının raporlanması.
4.  **Tenure & Loyalty:** 5 yıl ve üzeri kıdemi olan çalışanların tespiti; yan hak ve bağlılık yönetimi için segmentasyon.
5.  **Budget Forecasting:** Departman bazlı maaş simülasyonları ve zam senaryolarının (Örn: %15 artış) toplam maliyet üzerindeki etkisinin analizi.

## 🛠️ Teknik Uygulamalar (SQL Stack)
- **Window Functions:** `RANK() OVER (PARTITION BY ...)` kullanarak departman içi maaş ve kıdem sıralamaları.
- **Self-Join:** `Calisanlar c1 INNER JOIN Calisanlar c2` yapısı ile çalışan-yönetici ilişkisinin kurulması.
- **Advanced Aggregation:** `SUM(CASE WHEN durum = 'Ayrıldı' THEN 1 ELSE 0 END)` mantığı ile tek sorguda oran hesaplama (Turnover).
- **Subqueries:** Departman ortalamalarını hesaplayıp ana tabloya dinamik filtre olarak uygulama.

## 📈 Örnek Bulgular
- Departman bazlı turnover oranları analiz edilerek, ayrılma eğiliminin yüksek olduğu alanlar için iyileştirme önerileri sunulmuştur.
- Maaş skalasının dışında kalan çalışanlar tespit edilerek bütçe planlaması için veri desteği sağlanmıştır.
- Organizasyon şeması SQL üzerinden dinamik hale getirilerek raporlama hatlarındaki kopukluklar giderilmiştir.
