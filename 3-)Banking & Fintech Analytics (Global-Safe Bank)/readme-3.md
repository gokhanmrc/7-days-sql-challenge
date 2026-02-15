# 💳 Day 3: Banking & Fintech Analytics (Global-Safe Bank)

3. gün simülasyonunda, "Global-Safe Bank" veri seti üzerinden risk yönetimi, dolandırıcılık tespiti ve müşteri segmentasyonu analizleri yapılmıştır.

## 📊 Veri Seti Yapısı
- **Banka_Musterileri:** musteri_id, ad_soyad, sehir, meslek, gelir_duzeyi, musteri_segmenti.
- **Kredi_Kartlari:** kart_no, musteri_id, limit_tl, kart_tipi, kesim_gunu.
- **Islemler:** islem_id, kart_no, islem_tarihi, tutar, islem_tipi, is_fraud.

## 🎯 Analitik Odak Noktaları
1. **Risk Profiling:** Müşterilerin aylık gelirleri ile toplam kredi kartı limitleri arasındaki orantısızlığın (limit > 2x gelir) tespiti.
2. **Fraud Detection:** Gece yarısı (00:00 - 05:00) yapılan işlemlerin ve geliriyle orantısız yurt dışı harcamalarının takibi.
3. **Utilization Analysis:** Kart limit doluluk oranlarının (`toplam_harcama / limit_tl`) hesaplanması ve %80 kritik eşiğinin izlenmesi.
4. **VIP Segment Monitoring:** 'Gold' ve 'Silver' segmentindeki yüksek hacimli (>50.000 TL) işlemlerin raporlanması.
5. **Holistic Dashboard:** Her bir kart için işlem adedi, toplam harcama ve en yüksek tekil harcama bilgisinin tek bir görünümde (`GROUP BY`) toplanması.

---
