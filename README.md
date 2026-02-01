# PIZZA SALES DASHBOARD using SQL techniques

This project demonstrates SQL techniques used by analysts to explore, clean, and analyze pizza sales and customer data. The analysis focuses on understanding order patterns, revenue, customer behavior, and menu performance to support business decision-making. And Power BI is used to represent the Business insights.

## Steps to Proceed

### 1. Data Setup
- CSV files are located in the `dataset/` folder
- Run `create_db.py` to create SQLite database (`pizza_sales.db`) with imported data
- Database contains 4 tables: orders, order_details, pizzas, pizza_types

### 2. SQL Analysis
- All analysis queries are written in `sql_queries_analysis.sql`
- Queries cover order analysis, revenue analysis, pizza performance, and trends
- Test queries using `test_queries.py`

### 3. PowerBI Dashboard Creation

#### Option 1: Connect to SQLite Database (Recommended)
1. Open PowerBI Desktop
2. Click "Get Data" → "More" → "SQLite database"
3. Select the `pizza_sales.db` file
4. Select all tables: orders, order_details, pizzas, pizza_types
5. Click "Load"
6. Create relationships:
   - orders.order_id → order_details.order_id
   - pizzas.pizza_id → order_details.pizza_id
   - pizza_types.pizza_type_id → pizzas.pizza_type_id
7. Use SQL queries from `sql_queries_analysis.sql` in Power Query or create DAX measures
8. Build visualizations for each analysis point

#### Option 2: Import CSV Files
1. Run `export_for_powerbi.py` to generate CSV files in `powerbi_data/` folder
2. Open PowerBI Desktop
3. Click "Get Data" → "Folder" → Select `powerbi_data` folder
4. Import all CSV files
5. Create relationships between datasets as needed
6. Build dashboard using the pre-aggregated data

### 4. Dashboard Visualizations
Create the following key visualizations:

#### Executive Summary Page
- **KPI Cards**: Total Orders (21,350), Total Revenue (₹2.93Cr), Avg Order Value, Customer Count
- **Trend Charts**: Revenue and Orders over time with moving averages
- **Top Performers**: Dynamic ranking of pizzas, categories, and time periods

#### Sales Performance Page
- **Time Series**: Monthly revenue with growth rates and 3-month moving averages
- **Seasonal Analysis**: Monthly patterns with holiday indicators
- **Growth Metrics**: Month-over-month and year-over-year growth visualizations

#### Product Analysis Page
- **Performance Matrix**: Size vs Category heatmap with conditional formatting
- **Profitability Dashboard**: Cost, revenue, profit analysis with ranking
- **Top Products**: Dynamic top N analysis with drill-down capabilities

#### Customer Insights Page
- **RFM Segmentation**: Customer segment distribution with interactive filters
- **Churn Analysis**: Risk indicators and retention metrics
- **CLV Distribution**: Customer lifetime value analysis with predictive elements

#### Operational Analytics Page
- **Peak Hours Analysis**: Time slot performance with staffing recommendations
- **Order Patterns**: Hourly trends with peak period identification
- **Capacity Planning**: Demand forecasting for operational decisions

#### Advanced Features to Implement
- **Slicers**: Date range, category, size, customer segment, time slot filters
- **Drill-through**: Click on any chart to see detailed breakdown
- **Tooltips**: Rich hover information showing multiple KPIs
- **Conditional Formatting**: Color-coded performance indicators
- **What-if Analysis**: Scenario planning for price changes and growth projections
- **Bookmarks**: Save and share specific dashboard views
- **Custom Tooltips**: Detailed information on hover with mini-charts

## Objectives

## Repo Structures

## Data Cleaning

## Analysis & Queries

### Basic Analysis (21 Queries)
Orders Volume Analysis
- Total unique orders, orders by month, day-of-week analysis, repeat customers, cumulative order trend.
Total Revenue from Pizza Sales
- Calculate total revenue from all pizza sales.
Highest-Priced Pizza
- Identify the most expensive pizza on the menu.
Most Common Pizza Size Ordered
- Determine the most frequently ordered pizza size.
Top 5 Most Ordered Pizza Types
- Find the top 5 pizza types based on quantity sold.
Total Quantity by Pizza Category
- Calculate total pizzas sold in each category.
Orders by Hour of the Day
- Understand peak ordering hours to optimize staffing.
Category-Wise Pizza Distribution
- Analyze category-wise sales and percentage share.
Average Pizzas Ordered per Day
- Measure daily pizza demand consistency.
Top 3 Pizzas by Revenue
- Identify pizzas generating the highest revenue.
Revenue Contribution per Pizza
- Percentage contribution of each pizza to total revenue.
Cumulative Revenue Over Time
- Monthly cumulative revenue trend since launch.
Top 3 Pizzas by Category (Revenue-Based)
- Top 3 pizzas by revenue in each category.
Orders by Weekday
- Determine busiest days of the week for orders.
Average Order Size
- Calculate average number of pizzas per order.
Seasonal Trends
- Analyze sales patterns by month and holidays.
Revenue by Pizza Size
- Revenue contribution of each pizza size (S, M, L, XL, XXL).

### Advanced Analysis (9 Complex Queries)
Customer Segmentation (RFM Analysis)
- Champions, Loyal Customers, Potential Loyalists, At Risk, Lost Customers segments.
Basket Analysis
- Most common pizza combinations ordered together.
Time Series Analysis
- Monthly growth rates, moving averages, trend analysis.
Profitability Analysis
- Cost estimation, profit margins, profitability ranking by pizza.
Customer Lifetime Value (CLV)
- CLV calculation, customer status classification.
Peak Hours Analysis with Time Slots
- Breakfast, Lunch, Dinner, Late Night categorization with performance metrics.
Size vs Category Performance Matrix
- Cross-analysis of pizza sizes and categories.
Customer Churn Analysis
- Churn prediction, customer retention insights.
Predictive Analytics
- Next month forecast using linear trend analysis.

## PowerBI Interactive Dashboard Features

### Advanced Interactivity Elements
1. **Dynamic Slicers**
   - Date range selector with relative date filtering
   - Multi-select category and size filters
   - Customer segment slicer for targeted analysis
   - Time slot selector (Breakfast/Lunch/Dinner/Late Night)

2. **Drill-Down Capabilities**
   - Category → Pizza Type → Size hierarchy
   - Time drill-down: Year → Month → Week → Day
   - Customer segmentation drill-through pages

3. **Conditional Formatting & Data Bars**
   - Heat maps for performance matrices
   - Data bars for ranking visualizations
   - Color-coded alerts for low-performing items
   - Dynamic icons based on performance thresholds

4. **Tooltips & Detailed Views**
   - Rich tooltips showing multiple KPIs
   - Cross-highlighting between related charts
   - Page navigation tooltips

5. **What-If Analysis**
   - Price sensitivity analysis
   - Seasonal adjustment scenarios
   - Growth projection sliders

6. **Custom Visuals & Advanced Charts**
   - Waterfall charts for profit analysis
   - Sankey diagrams for customer flow
   - Radar charts for multi-dimensional analysis
   - Decomposition trees for root cause analysis

### Dashboard Pages Structure
1. **Executive Summary**
   - KPI cards with trend indicators
   - Revenue vs Orders dual-axis chart
   - Top performers highlight

2. **Sales Performance**
   - Time series analysis with moving averages
   - Growth rate visualizations
   - Seasonal decomposition

3. **Product Analysis**
   - Pizza performance matrix
   - Category-size cross analysis
   - Profitability rankings

4. **Customer Insights**
   - RFM segmentation dashboard
   - Churn analysis with risk indicators
   - CLV distribution analysis

5. **Operational Analytics**
   - Peak hours analysis by time slots
   - Staffing optimization insights
   - Inventory management recommendations

6. **Predictive Analytics**
   - Forecast visualizations
   - Trend analysis with confidence intervals
   - Scenario planning tools

### PowerBI Best Practices Implemented
- **Performance Optimization**: Aggregated measures, query diagnostics
- **User Experience**: Consistent theming, intuitive navigation
- **Data Modeling**: Star schema design, calculated columns/tables
- **Security**: Row-level security for different user roles
- **Mobile Responsiveness**: Optimized layouts for different screen sizes

## Key Findings


