# Budget-Variance-Analysis
This project is made for comparing the budgets and the sales made by three different products or business units 
Originally,
- the data is provided as .xlsx file (excel book) with two sheets within. one for the budgeted amounts and the other for the actual sales
- the budgeted amount table had a column for each product and a column for the date
- the actual amounts on the other hand had pne column for the product name, one for the sales and one for the date
- dates in the budgeted amounts table were only the last day of the month indicating the budget for that month in total
- dates in the actual sales table were a variation of days within the month
preparing the data,
- inserted the data from excel to postgreSQL admin interface using the insert statements in both (Actual.sql) and (budget.sql)
- unpivoted the budget amount table in SQL (provided in BV analysis.sql)
- condcted a date trunc on the dates of both budget amounts table and actual sales table (after summation of all those within the same month)
- connected the two tables based on the date
- calculated the variance amount and the % variance using the standerdized equations
Data visualization,
- exported the results table to a seperate .csv file
- using powerBi, different measure were creating ex. sum of actual sales, total budgeted amount..etc
- key influencers 
