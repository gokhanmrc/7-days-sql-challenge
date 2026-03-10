# 📊 SQL Analytics Portfolio
Bu portfolyo, bir veri analistinin farklı sektörlerdeki iş problemlerine SQL ile nasıl çözüm ürettiğini gösteren; Gaming, Fintech, E-Commerce, CRM, HR ve Healthcare alanlarına ait 60 adet derinlemesine vaka analizini içermektedir.

---

## 👨‍💻 Hakkımda
Ben **Gökhan Meriç**. 4 yıllık **Workforce Management (WFM)** ve **Real-Time Analysis** tecrübesine sahip bir veri analistiyim. Operasyonel verimlilik ve performans metrikleri konusundaki saha tecrübemi, SQL’in teknik gücüyle birleştirerek; ham veriyi stratejik kararları destekleyen "anlamlı iş sonuçlarına" dönüştürüyorum.

---

## 📂 Portfolyo İçeriği (Sektörel Vaka Analizleri)

| Modül | Sektör | Temel Analitik Odaklar | Teknik Yetkinlikler |
| :--- | :--- | :--- | :--- |
| **[Modül 01](./Modul_01_Mobile_Gaming)** | **Mobile Gaming** | **DAU, Whale Analysis, Monetization, Loyalty** | `CTE`, `Date Trunc`, `Filtering` |
| **[Modül 02](./Modul_02_Banking_Fintech)** | **Fintech & Banking** | **Fraud Detection, Risk Profiling, Limit Utilization** | `Subqueries`, `Logical CASE` |
| **[Modül 03](./Modul_03_Supply_Chain)** | **E-Commerce & Supply Chain** | **SLA (Kargo Süresi) Analizi, Inventory Mgmt, Churn** | `Complex Joins`, `Date Diff` |
| **[Modül 04](./Modul_04_HR_Analytics)** | **HR & Workforce** | **Turnover Rate, Salary Equity, Hierarchy Analysis** | `Window Functions`, `Self-Join` |
| **[Modül 05](./Modul_05_Healthcare)** | **Healthcare** | **KVKK Masking, No-Show Rate, Capacity Planning** | `String Manipulation`, `Regex` |
| **[Modül 06](./Modul_06_ECommerce)** | **E-Commerce Essentials** | **Sales Performance, Customer Segmentation (RFM)** | `Aggregate Functions`, `Group By` |

---

## 🚀 Öne Çıkan Analiz Örnekleri

### 🎮 1. Gaming: Whale & Retention Analizi
Oyuncuların harcama alışkanlıklarına göre segmentasyonu (`Free-to-Play` vs `High Spender`) ve en değerli oyuncuların (Whales) hangi zorluk seviyelerinde yoğunlaştığının tespiti.
* **Kritik Sorgu:** En yüksek harcama yapan oyuncuların cihaz modelleri ve oyun skorları arasındaki korelasyon.

### 💳 2. Fintech: Fraud & Risk Yönetimi
Gelir düzeyi ile kredi kartı limiti arasındaki dengesizliklerin tespiti ve şüpheli işlem saatlerine (00:00 - 05:00) göre alarm mekanizması kurgulanması.
* **Kritik Sorgu:** Müşteri geliri > 2x Limit olan riskli portföyün listelenmesi.

### 👥 3. HR: Workforce Planning & Turnover
WFM disipliniyle, departman bazlı "İşten Ayrılma Oranı" (Turnover) hesaplanması ve maaş adaleti için departman ortalamasının altında kalan yüksek performanslı çalışanların tespiti.
* **Kritik Sorgu:** `Window Functions` ile her departman içindeki maaş sıralaması.

### 🏥 4. Healthcare: KVKK & Operasyonel Verimlilik
Hassas hasta verilerinin maskelenmesi (Data Masking) ve randevularına gelmeyen (No-Show) hastaların doktor performansına etkisinin ölçülmesi.

---

## 🛠️ Teknik Stack (Advanced SQL)

Bu portfolyodaki projeler, sadece veri çekmek için değil, veri manipülasyonu ve optimizasyonu için şu teknikleri kullanır:
* **Window Functions:** `RANK()`, `ROW_NUMBER()`, `PARTITION BY` ile derinlemesine gruplandırma.
* **Complex Data Logic:** `CASE WHEN`, `COALESCE`, `NULLIF` ile kirli verinin temizlenmesi ve etiketlenmesi.
* **Relational Mapping:** `Self-Joins` (Hiyerarşi için) ve `Multiple Joins` (Star Schema yapıları için).
* **Optimization:** `CTE (With Clause)` kullanarak okunabilirliği yüksek, modüler sorgu mimarileri.

---

## 📫 İletişim
Bu analizler hakkında konuşmak veya yeni projelerde iş birliği yapmak isterseniz:
* **LinkedIn:** [linkedin.com/in/gokhanmrc/](https://www.linkedin.com/in/gokhanmrc/)
