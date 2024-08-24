-- Database: BudgetVariance

-- DROP DATABASE IF EXISTS "BudgetVariance";

CREATE DATABASE "BudgetVariance"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

CREATE TABLE Unpivoted_Budget (
    EOMonth DATE,
    Location VARCHAR(50),
    Budgeted NUMERIC
);
INSERT INTO Unpivoted_Budget (EOMonth, Location, Budgeted)
SELECT 
    EOMonth, 
    'Aspen' AS Location, 
    Aspen AS Budgeted
FROM 
    Budget
UNION ALL
SELECT 
    EOMonth, 
    'Carlota' AS Location, 
    Carlota AS Budgeted
FROM 
    Budget
UNION ALL
SELECT 
    EOMonth, 
    'Quad' AS Location, 
    Quad AS Budgeted
FROM 
    Budget;
	
-- monthly actuals table based on the month and the product 
CREATE TABLE Monthly_Actuals (
    EOMonth DATE,
    Product VARCHAR(512),
    Total_Sales NUMERIC
);
INSERT INTO Monthly_Actuals (EOMonth, Product, Total_Sales)
SELECT 
    DATE_TRUNC('month', Date) AS EOMonth,
    Product,
    SUM(Sales) AS Total_Sales
FROM 
    Actual
GROUP BY 
    DATE_TRUNC('month', Date),
    Product
ORDER BY 
    EOMonth,
    Product;

--calc variance amount and variance %
SELECT 
    ub.EOMonth,
    ub.Location AS Product,
    ub.Budgeted AS Budgeted_Amount,
    COALESCE(ma.Total_Sales, 0) AS Actual_Sales,
    (COALESCE(ma.Total_Sales, 0) - ub.Budgeted) AS Variance_Amount,
    ROUND(((COALESCE(ma.Total_Sales, 0) - ub.Budgeted) / NULLIF(ub.Budgeted, 0)) * 100, 2) AS Variance_Percentage
FROM 
    Unpivoted_Budget ub
LEFT JOIN 
    Monthly_Actuals ma
ON 
    DATE_TRUNC('month', ma.EOMonth) = DATE_TRUNC('month', ub.EOMonth)
    AND ub.Location = ma.Product
order by EOMonth, Product;
