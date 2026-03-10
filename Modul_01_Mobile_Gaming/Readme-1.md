# 🎮 Modül 01: Mobile Gaming Analytics (Bexee-Game Studio)

Bu çalışma, bir mobil oyun firmasının oyun ekonomisini, oyuncu harcama alışkanlıklarını ve bağlılık metriklerini analiz etmek üzerine kurgulanmıştır. Bir Veri Analisti olarak temel amacım; ham oyun verisinden **Monetization (Gelir)** ve **Retention (Bağlılık)** içgörüleri üretmektir.

## 📊 Veri Seti Mimarisi
Analiz, oyun içi ekosistemi temsil eden 3 ilişkili tablo üzerinden yürütülmüştür:
- **Oyuncular:** Demografik veriler ve teknik donanım (Cihaz modelleri) bilgileri.
- **Oyun_Oturumlari:** Aktivite süreleri, skorlar ve seviye bazlı etkileşim verileri.
- **Satin_Almalar:** Mikro-işlemler (IAP) ve oyuncu harcama detayları.

## 🎯 Analitik Odak Noktaları & İş Soruları
Bu modülde aşağıdaki kritik KPI'ların hesaplanması ve analizi gerçekleştirilmiştir:

1.  **Engagement (Bağlılık) Analizi:** Günlük Aktif Kullanıcı (**DAU**) sayısının tespiti ve oturum başı ortalama sürelerin ölçümlenmesi.
2.  **Monetization (Gelir Üretimi):** Ülke bazlı gelir dağılımı ve ödeme yapan kullanıcıların toplam kitleye oranı.
3.  **Whale & Player Segmentation:** Oyuncuların harcama miktarlarına göre `Free-to-Play`, `Low Spender` ve `High Spender (Whale)` olarak sınıflandırılması.
4.  **Behavioral Insights:** "Whale" olarak tanımlanan en değerli oyuncuların hangi oyun seviyelerinde (level) daha fazla vakit geçirdiğinin ve hangi cihazları tercih ettiğinin tespiti.
5.  **Loyalty (Sadakat) Analizi:** Kayıt tarihinden itibaren geçen sürenin hesaplanarak "Sadık Oyuncu" kitlesinin belirlenmesi.

## 🛠️ Teknik Uygulamalar (SQL Stack)
- **Advanced Aggregation:** `COUNT(DISTINCT)` ve `AVG` ile DAU ve etkileşim metrikleri.
- **CTE (Common Table Expressions):** Karmaşık segmentasyon mantıklarını modüler ve okunabilir bloklara ayırma.
- **Logical Branching:** `CASE WHEN` ile dinamik oyuncu segmentasyonu (Whale tespiti).
- **Date Arithmetic:** `::DATE` dönüşümleri ve tarih farkları ile sadakat günü hesaplama.

## 📈 Örnek Bulgular
- Toplam harcaması 100 TL ve üzeri olan "Whale" oyuncuların büyük çoğunluğunun X cihaz modelini kullandığı ve 10. seviye üzerinde yoğunlaştığı gözlemlenmiştir.
- Bu veriler ışığında, oyun içi tekliflerin (IAP) bu segmentteki oyuncuların bulunduğu seviyelere göre optimize edilmesi önerilmektedir.
