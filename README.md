# U.S.-Agricultural-Production-Analysis-Using-PostgreSQL
Data Analytics Project | SQL | Data Cleaning | Exploratory Data Analysis
## Description
Analyzed agricultural production data from the United States Department of Agriculture (USDA) to uncover production trends and regional patterns across major agricultural commodities, including cheese, honey, milk, coffee, eggs, and yogurt.
## Dataset: 
The dataset was sourced from the United States Department of Agriculture (USDA) and contains state-level agricultural production data for several key commodities, including cheese, honey, milk, coffee, eggs, and yogurt. The data is organized across multiple relational tables and includes geographic identifiers, commodity categories, production values, and related attributes. The dataset provides a comprehensive view of agricultural output across the United States, enabling the analysis of regional production trends, commodity performance, and industry patterns through SQL-based data exploration and reporting.
## Columns and Descriptions
Each table had these columns
- `year`: The year of production (e.g., 2021).
- `period`: the specific month (e.g., April).
- `geo_level`: A unique identifier for each product (ranging from 1 to 100).
- `state_ansi`: The number of units of the product sold on that date, with a notable increase post-intervention.
- `commodity_id`:  A unique identifier for each diary product (ranging from 1 to 10)The price per unit of the product sold, ranging between 10 and 100.
- `domain`: The total revenue generated from the sale of the product on that date (calculated as quantity * unit_price).
- `value`: A boolean indicating the presence of a marketing campaign (True post-intervention, False pre-intervention).
## Tools & Technologies: 
PostgreSQL, SQL, Data Cleaning, Data Transformation, Relational Databases, Exploratory Data Analysis (EDA)
## Key Achievements:

Imported and managed agricultural datasets across 7 relational tables in PostgreSQL, creating a structured environment for analysis.
Cleaned, transformed, and validated production data to improve consistency and ensure analytical accuracy.
Analyzed agricultural output across 56 geographic regions within the United States to identify production patterns and commodity-specific trends.
Developed SQL queries using JOINs, CASE statements, and subqueries to combine datasets, categorize production metrics, and generate analytical insights.
Performed exploratory data analysis (EDA) to identify leading production regions, commodity distribution patterns, and variations in agricultural output.
Applied aggregation, filtering, and grouping techniques to compare production levels across commodities and regions.
Generated data-driven insights that highlighted regional strengths and production concentrations across key agricultural sectors.
Demonstrated the use of relational databases and structured querying techniques to transform raw data into actionable business intelligence.
## Business Impact: 
Delivered analytical insights into agricultural production trends, showcasing how SQL-driven analysis can support strategic planning, resource allocation, and evidence-based decision-making in agriculture and supply chain operations.
