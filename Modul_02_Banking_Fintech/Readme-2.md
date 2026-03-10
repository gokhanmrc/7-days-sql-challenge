# 💳 Modül 02: Fintech & Banking Analytics (Global-Safe Bank)

Bu çalışma, "Global-Safe Bank" adlı kurgusal bir finans kuruluşunun veri setleri üzerinden; **Risk Yönetimi, Dolandırıcılık (Fraud) Tespiti ve Müşteri Kredi Limit Analizi** süreçlerini simüle etmektedir. Bir Veri Analisti olarak amacım, bankanın finansal güvenliğini koruyacak ve müşteri segmentasyonunu optimize edecek içgörüler sunmaktır.

## 📊 Veri Seti Mimarisi
Analiz, bankacılık ekosistemini temsil eden 3 temel tablo üzerinden yürütülmüştür:
- **Banka_Musterileri:** Demografik veriler, meslek grupları ve gelir düzeyleri.
- **Kredi_Kartlari:** Müşteri bazlı kredi limitleri ve kart tipleri (Gold, Silver, Platinum).
- **Islemler:** İşlem tarihleri, tutarlar ve "is_fraud" (sahtecilik) bayraklarını içeren işlem geçmişi.

## 🎯 Analitik Odak Noktaları & İş Soruları
Bu modülde bankacılık sektörünün en kritik şu 5 ana başlığına odaklanılmıştır:

1.  **Risk Profiling (Gelir-Limit Dengesi):** Aylık geliri ile toplam kredi kartı limiti arasında orantısızlık (Örn: Limit > 2x Gelir) olan yüksek riskli müşterilerin tespiti.
2.  **Fraud Detection (Dolandırıcılık Tespiti):** Şüpheli zaman dilimlerinde (00:00 - 05:00) yapılan işlemlerin analizi ve yurt dışı harcama trendlerinin takibi.
3.  **Utilization (Kullanım Oranı) Analizi:** Müşterilerin toplam harcamalarının limitlerine oranının (`Utilization Rate`) hesaplanması ve %80 kritik eşiğini aşanların belirlenmesi.
4.  **VIP Segment Monitoring:** Gold ve Silver segmentindeki müşterilerin harcama hacimlerinin takibi ve yüksek tutarlı (>50.000 TL) işlemlerin raporlanması.
5.  **Transaction Health:** Aynı gün içerisinde normalin üzerinde (5'ten fazla) işlem yapan kartların tespiti.

## 🛠️ Teknik Uygulamalar (SQL Stack)
- **Advanced Filtering & Logic:** `HAVING` ve `CASE WHEN` ile riskli işlem gruplarının filtrelenmesi.
- **Data Casting:** `::DATE` veya `::TIMESTAMP` dönüşümleri ile zaman bazlı trend analizleri.
- **Joins & Aggregations:** 3 tablonun `INNER JOIN` ile bağlanarak müşteri bazlı toplam harcama ve limit dengesinin kurulması.
- **Logical Operators:** `BETWEEN`, `IN` ve `AND/OR` yapıları ile karmaşık kural setlerinin (Fraud kuralları) uygulanması.

## 📈 Örnek Bulgular
- Müşterilerin %X'lik bir kısmının gelir düzeyine oranla çok yüksek kredi limitine sahip olduğu ve bu durumun potansiyel bir kredi riski oluşturduğu tespit edilmiştir.
- Gece yarısı yapılan işlemlerin toplam işlem hacmi içindeki payı analiz edilerek, güvenlik protokollerinin bu saat dilimlerinde sıkılaştırılması önerilmiştir.
