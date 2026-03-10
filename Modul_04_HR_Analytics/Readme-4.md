# 👥 Day 5: HR Analytics & Workforce Planning (Global-Talent Corp)

5. günde, bir insan kaynakları departmanının operasyonel verileri üzerinden maaş adaleti, kıdem analizi, bütçe simülasyonları ve turnover oranları analiz edilmiştir.

## 📊 Veri Seti Yapısı
- **Calisanlar:** ad_soyad, maas, ise_giris_tarihi, yonetici_id, durum (Aktif/Ayrıldı).
- **Departmanlar:** dept_id, dept_ad.

## 🎯 Analitik Odak Noktaları
1. **Budget Forecasting:** %15'lik zam simülasyonu ile şirkete gelecek ek maliyetin hesaplanması.
2. **Tenure & Loyalty:** 5 yıl ve üzeri kıdemi olan çalışanların plaket ve yan hak yönetimi için tespiti.
3. **Salary Equity (Maaş Adaleti):** Alt sorgular (Subqueries) kullanılarak departman ortalamasının altında kalan "underpaid" çalışanların analizi.
4. **Organizational Structure:** Self-Join tekniği ile çalışan-yönetici hiyerarşisinin ve çapraz departman bağlılıklarının raporlanması.
5. **Turnover Metrics:** Şirketin personel tutma başarısını ölçen "İşten Ayrılma Oranı" hesaplaması.
6. **Advanced Ranking:** Window Functions (`RANK()`, `OVER()`) ile departman içi maaş sıralamaları.

## 🛠️ Teknik Kazanımlar
- **Window Functions:** `PARTITION BY` ile veri satırlarını kaybetmeden grupsal analiz yapma.
- **Self-Join:** Aynı tabloyu iki farklı rolde (Çalışan vs Yönetici) birleştirme.
- **Subqueries:** Karmaşık filtreleme ve karşılaştırma senaryolarını yönetme.
- **Date Arithmetic:** `AGE()` ve `EXTRACT()` fonksiyonları ile dinamik kıdem hesabı.

---
