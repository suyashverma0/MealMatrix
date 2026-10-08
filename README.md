<h1 align="center">🍽️ MealMatrix</h1>
<h3 align="center">End-to-End Food Delivery Analytics using SQL, Python & Power BI</h3>

<p align="center">
  <img src="https://img.shields.io/badge/Python-3776AB?logo=python&logoColor=white" />
  <img src="https://img.shields.io/badge/SQL-4479A1?logo=postgresql&logoColor=white" />
  <img src="https://img.shields.io/badge/Power_BI-F2C811?logo=powerbi&logoColor=black" />
  <img src="https://img.shields.io/badge/Pandas-150458?logo=pandas&logoColor=white" />
  <img src="https://img.shields.io/badge/Matplotlib-11557C" />
  <img src="https://img.shields.io/badge/Seaborn-4C72B0" />
</p>

---

## 📖 What is MealMatrix?

**MealMatrix** is an end-to-end **Food Delivery Analytics** project that turns raw order data into business insights.

It analyzes **orders, customers, restaurants, menu items, delivery performance and business trends** using **SQL** and **Python**, and presents the results in an interactive **Power BI dashboard**.

In short, the project helps answer questions like:

- 💰 How much revenue is the platform making, and how is it trending?
- 🧑‍🤝‍🧑 Who are the most valuable and most loyal customers?
- 🏪 Which restaurants and menu items perform best?
- 🍕 Which cuisines are most popular?
- 🚴 How fast are deliveries, and where do delays happen?
- ⏰ When is demand highest (hour, day, month)?

---

## 🔄 Project Workflow

```text
Raw Data
   ↓
Data Validation & Cleaning        (Python / Pandas)
   ↓
Exploratory Data Analysis         (Python / Matplotlib / Seaborn)
   ↓
Business Analysis                 (SQL)
   ↓
KPI Calculation
   ↓
Interactive Dashboard             (Power BI)
   ↓
Business Insights & Decisions
```

---

## 🛠️ Tech Stack

| Purpose | Tools |
|---|---|
| Data cleaning & EDA | Python, Pandas, NumPy |
| Visualization | Matplotlib, Seaborn |
| Business queries | SQL |
| Dashboard & reporting | Power BI |

---

## 📁 Repository Structure

```text
MealMatrix/
│
├── dashboard/          # Power BI dashboard file and screenshots
├── data/               # Raw and cleaned datasets
├── python/             # Data cleaning and exploratory analysis scripts/notebooks
├── sql/                # SQL queries for business analysis
├── requirements.txt    # Python dependencies
└── README.md
```

---

## 🔍 What the Project Covers

### 1. Data Cleaning & Validation
- Handling missing values and duplicate records
- Fixing data types (dates, numeric fields)
- Standardizing text columns
- Detecting invalid values and outliers

### 2. Exploratory Data Analysis (EDA)
- Order, revenue and customer distributions
- Delivery time patterns
- Cuisine and restaurant comparisons
- Time-based trends (hourly, daily, monthly)

### 3. SQL Business Analysis
- Top restaurants and menu items by revenue and orders
- Customer behavior and repeat-order analysis
- Revenue trends over time
- Delivery performance analysis

### 4. Power BI Dashboard
- Interactive KPI cards and filters
- Revenue, order and customer trends
- Restaurant, cuisine and menu performance
- Delivery efficiency insights

---

## 📊 Key KPIs Tracked

- **Total Revenue**
- **Total Orders**
- **Average Order Value (AOV)**
- **Total & Repeat Customers**
- **Average Delivery Time**
- **Top Restaurants / Cuisines / Menu Items**
- **Peak Order Hours & Days**

---

## 🖼️ Dashboard Preview

> Add your dashboard screenshots to the `dashboard/` folder and link them here:
>
> `![Dashboard](dashboard/dashboard_preview.png)`

---

## 💡 Business Insights

> Add your own findings here, for example:
> - Which cuisine generates the most revenue
> - Peak ordering hours and days
> - Restaurants with the best and worst performance
> - Areas where delivery time is highest

---

## ▶️ How to Run

**1. Clone the repository**
```bash
git clone https://github.com/suyashverma0/MealMatrix.git
cd MealMatrix
```

**2. Install dependencies**
```bash
pip install -r requirements.txt
```

**3. Run the Python analysis**
Open the files inside the `python/` folder (scripts or Jupyter notebooks) and run them in order: cleaning first, then EDA.

**4. Run the SQL queries**
Load the data from `data/` into your SQL database and run the queries from the `sql/` folder.

**5. Open the dashboard**
Open the `.pbix` file from the `dashboard/` folder in **Power BI Desktop**.

---

## 🚀 Future Improvements

- Predict delivery time using machine learning
- Customer segmentation (RFM analysis)
- Demand forecasting
- Automated data refresh for the dashboard

---

## 👨‍💻 Author

**Suyash Verma**
🔗 [GitHub](https://github.com/suyashverma0)

---

<p align="center">⭐ If you like this project, give it a star!</p>
