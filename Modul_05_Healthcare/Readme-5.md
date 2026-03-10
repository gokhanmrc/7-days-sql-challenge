# 🏥 Day 6: Healthcare Analytics (Safe-Health Medical Center)

6. günde, bir sağlık kuruluşunun randevu sistemleri, doktor performansları ve hasta demografisi üzerinden operasyonel ve KVKK uyumlu analizler yapılmıştır.

## 📊 Veri Seti Yapısı
- **Hastalar:** ad, soyad, dogum_tarihi, kan_grubu, telefon.
- **Doktorlar:** ad_soyad, uzmanlik_alani, unvan.
- **Randevular:** randevu_id, hasta_id, doktor_id, randevu_tarihi, durum (Tamamlandı/İptal).

## 🎯 Analitik Odak Noktaları
1. **Data Privacy (KVKK):** `UPPER`, `LEFT` ve `||` operatörleri ile hassas verilerin maskelenmesi.
2. **Capacity Planning:** Doktor bazlı randevu yoğunluğu ve "Tamamlanan" iş yükü analizi.
3. **Chronic Patient Tracking:** Aynı doktor-hasta eşleşmesi üzerinden `HAVING` ile tedavi sürekliliği takibi.
4. **No-Show & Performance:** İptal edilen randevuların toplam randevulara oranı (Cancellation Rate).
5. **Time-Based Analysis:** `EXTRACT` ve `TO_CHAR` ile öğleden sonra yoğunluğu ve saatlik randevu dağılımı.
6. **Data Quality:** `IS NULL` ve `CASE WHEN` ile eksik veri girişi denetimi.

## 🛠️ Teknik Kazanımlar
- **Advanced Aggregation:** `COUNT(DISTINCT)` ile tekilleştirilmiş veri sayımı.
- **Data Formatting:** Tarih ve saat verilerinin raporlama standartlarına (HH24:MI) dönüştürülmesi.
- **Strategic Filtering:** Zaman aralıkları ve mantıksal durumlar üzerinden operasyonel raporlama.

---
