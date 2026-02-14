# 🎮 Day 2: Mobile Gaming Analytics (BexeeGame Studio)

Bu çalışmada, "BexeeGame Studio" isimli kurgusal bir mobil oyun firmasının verileri üzerinde, oyun ekonomisini ve oyuncu davranışlarını anlamaya yönelik SQL analizleri gerçekleştirilmiştir.

## 📊 Veri Seti Yapısı
Analizde birbirleriyle ilişkili 3 ana tablo kullanılmıştır:
- **Oyuncular:** Demografik bilgiler ve cihaz modelleri.
- **Oyun_Oturumlari:** Skor, seviye ve süre bazlı aktivite verileri.
- **Satin_Almalar:** Oyun içi harcamalar ve işlem detayları.

## 🎯 Analiz Odak Noktaları
Bu simülasyonda bir Veri Analisti olarak şu kritik iş sorularına yanıt arandı:
1. **Engagement (Etkileşim):** Günlük Aktif Kullanıcı (DAU) tespiti ve oturum başı ortalama süreler.
2. **Monetization (Gelir):** Ülke bazlı toplam gelirler ve harcama yapan oyuncu sayıları.
3. **Segmentation (Segmentasyon):** Harcama miktarlarına göre 'Free-to-Play', 'Low Spender' ve 'High Spender' (Whale) gruplandırması.
4. **Behavioral Insights:** En değerli oyuncuların (Whales) hangi zorluk seviyelerinde ve hangi cihaz modellerinde yoğunlaştığının tespiti.
5. **Loyalty (Sadakat):** Oyuncuların kayıt tarihinden itibaren geçen süreye göre sadakat analizi.

## 🛠️ Teknik Kazanımlar
- **CTE (Common Table Expressions):** Karmaşık sorguları modüler ve okunabilir hale getirmek için kullanıldı.
- **CASE WHEN:** Dinamik kullanıcı segmentasyonu ve etiketleme yapıldı.
- **Aggregate Functions:** `SUM`, `AVG`, `COUNT(DISTINCT)` ile metrik hesaplamaları.
- **Join Strategies:** Veri bütünlüğünü korumak adına `INNER JOIN` ve `LEFT JOIN` (NULL yönetimi ile) tercih edildi.
- **Date Functions:** Zaman serisi analizi ve gün farkı hesaplamaları gerçekleştirildi.

---
*Bu çalışma, "7-Days SQL Challenge" kapsamında Gökhan Meriç tarafından hazırlanmıştır.*
