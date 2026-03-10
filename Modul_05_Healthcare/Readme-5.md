# 🏥 Modül 05: Healthcare Analytics & Data Privacy (Safe-Health)

Bu çalışma, bir sağlık kuruluşunun randevu sistemleri ve hasta verileri üzerinden; **Veri Gizliliği (KVKK), Operasyonel Kapasite Planlaması ve Hasta Davranış Analizi** süreçlerini simüle etmektedir. Bir Veri Analisti olarak amacım, hassas verileri korurken operasyonel verimliliği artıracak içgörüler sunmaktır.

## 📊 Veri Seti Mimarisi
Analiz, sağlık ekosistemini temsil eden 3 ilişkili tablo üzerinden yürütülmüştür:
- **Hastalar:** Ad-soyad, doğum tarihi, kan grubu ve iletişim bilgileri.
- **Doktorlar:** Uzmanlık alanları ve unvan bilgileri.
- **Randevular:** Randevu tarihleri ve durumları (Tamamlandı/İptal).

## 🎯 Analitik Odak Noktaları & İş Soruları
Bu modülde sağlık sektörünün yasal ve operasyonel gerekliliklerine uygun şu 5 ana başlığa odaklanılmıştır:

1.  **Data Privacy & Masking (KVKK):** `UPPER`, `LEFT` ve string birleştirme operatörleri ile hassas hasta bilgilerinin (Ad-Soyad, Telefon) raporlama ekranları için maskelenmesi.
2.  **No-Show & Cancellation Analysis:** Randevularına gelmeyen hastaların oranının hesaplanması ve iptal trendlerinin doktor performansına etkisinin analizi.
3.  **Capacity Planning (Doktor Yoğunluğu):** Doktor bazlı randevu sayılarının analizi ve en yoğun uzmanlık alanlarının tespiti ile kaynak optimizasyonu.
4.  **Chronic Patient Tracking:** Aynı doktor-hasta eşleşmesi üzerinden `HAVING` filtresi ile tedavi sürekliliği ve kronik vaka takibi analizi.
5.  **Time-Based Workload:** Randevu saatlerinin (Öğleden önce/sonra) yoğunluk analizi ve `EXTRACT` fonksiyonu ile saatlik yük dağılımı.

## 🛠️ Teknik Uygulamalar (SQL Stack)
- **String Manipulation:** `UPPER`, `LEFT` ve `||` operatörleri ile veri anonimleştirme teknikleri.
- **Date & Time Functions:** `EXTRACT` ve `TO_CHAR` ile tarih verilerinden saatlik ve periyodik raporlar üretme.
- **Data Quality Control:** `IS NULL` ve `CASE WHEN` yapıları ile eksik veri girişi denetimi (Veri kalitesi analizi).
- **Advanced Aggregation:** `COUNT(DISTINCT)` ile tekilleştirilmiş hasta ve işlem sayılarını hesaplama.

## 📈 Örnek Bulgular
- KVKK uyumluluğu çerçevesinde tüm raporlama altyapısı maskelenmiş veriler üzerine kurgulanmıştır.
- "No-Show" (Randevuya gelmeme) oranları analiz edilerek, operasyonel kaybı önlemek adına hatırlatma sistemleri için hedef kitle belirlenmiştir.
- Doktor bazlı iş yükü dağılımı incelenerek, poliklinik saatlerinin optimizasyonu için veri desteği sağlanmıştır.
