SELECT * FROM blinkit_data

SELECT COUNT(*) AS Number_of_Items FROM blinkit_data

UPDATE blinkit_data
SET Item_Fat_Content = 
CASE 
WHEN Item_Fat_Content IN ('LF', 'low fat') THEN 'Low Fat'
WHEN Item_Fat_Content = 'reg' THEN 'Regular'
ELSE Item_Fat_Content
END

SELECT DISTINCT(Item_Fat_Content) from blinkit_data

SELECT SUM(Total_Sales) AS Total_Sales
from blinkit_data

SELECT CAST(SUM(Total_Sales)/ 1000000 AS DECIMAL(10, 2)) AS Total_Sales_Millions
FROM blinkit_data

-- Finding Avg Value
SELECT AVG(Total_Sales) AS Avg_Sales FROM blinkit_data

SELECT CAST(AVG(Total_Sales) AS DECIMAL(10, 2)) AS Avg_Sales FROM blinkit_data

-- Fat Content

SELECT CAST(SUM(Total_Sales) / 1000000 AS DECIMAL(10, 2)) AS Low_Fat_Content
FROM blinkit_data
WHERE Item_Fat_Content = 'Low Fat'

-- Outlet Establishment Year

SELECT CAST(SUM(Total_Sales) / 1000000 AS DECIMAL(10, 2)) AS Outlet_Establishment_Year
FROM blinkit_data
WHERE Outlet_Establishment_Year = 2022

-- Findind Avg Sales on Year in Outlet

SELECT CAST(AVG(Total_Sales) AS DECIMAL(10, 1)) AS Avg_Sales FROM blinkit_data
WHERE Outlet_Establishment_Year = 2022

SELECT COUNT(*) AS No_Of_Items FROM blinkit_data
WHERE Outlet_Establishment_Year = 2022

-- Average Ratings

SELECT CASt(AVG(Rating) AS DECIMAL(10, 1)) AS Avg_Rating FROM blinkit_data

-- Granular Requirements

SELECT * FROM blinkit_data

--1. Total Sales by Fat Conntent

SELECT Item_Fat_Content, CAST(SUM(Total_Sales)/1000 AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY Item_Fat_Content
ORDER BY Total_Sales DESC

-- or 
-- another code find data via year

SELECT Item_Fat_Content, 
		CAST(SUM(Total_Sales)/1000 AS DECIMAL(10, 2)) AS Total_Sales_Thousands,
		CAST(AVG(Total_Sales) AS DECIMAL(10, 1)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10, 2)) AS Avg_Rating
FROM blinkit_data
WHERE Outlet_Establishment_Year = 2022
GROUP BY Item_Fat_Content
ORDER BY Total_Sales_Thousands DESC


-- Total Sales by Item Type
 
 select * from blinkit_data

SELECT Item_Type,
		CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST(AVG(Total_Sales) AS DECIMAL(10, 2)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Item_Type
ORDER BY Total_Sales DESC

-- For getting top 5 result

SELECT TOP 5 Item_Type,
		CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST(AVG(Total_Sales) AS DECIMAL(10, 2)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Item_Type
ORDER BY Total_Sales DESC

-- For getting bottom 5

SELECT TOP 5 Item_Type,
		CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST(AVG(Total_Sales) AS DECIMAL(10, 2)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Item_Type
ORDER BY Total_Sales ASC

-- Fat Content by Outlet of Total Sales

SELECT * FROM blinkit_data

-- Asecnding Order
SELECT Outlet_Location_Type, Item_Fat_Content,
		CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST(AVG(Total_Sales) AS DECIMAL(10, 2)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Outlet_Location_Type, Item_Fat_Content
ORDER BY Total_Sales ASC

-- Descending Oreder
SELECT Outlet_Location_Type, Item_Fat_Content,
		CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST(AVG(Total_Sales) AS DECIMAL(10, 2)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Outlet_Location_Type, Item_Fat_Content
ORDER BY Total_Sales DESC

-- Finding data through sales

SELECT Outlet_Location_Type, Item_Fat_Content,
		CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY Outlet_Location_Type, Item_Fat_Content
ORDER BY Total_Sales ASC

-- ANOTHER CODE TO FIND BEST DATA

SELECT Outlet_Location_Type,  
		ISNULL([Low Fat], 0) AS Low_Fat,  
		ISNULL([Regular], 0) AS Regular 
FROM  
( 
	SELECT Outlet_Location_Type, Item_Fat_Content,  
		CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales 
	FROM blinkit_data 
	GROUP BY Outlet_Location_Type, Item_Fat_Content 
) AS SourceTable 
PIVOT  
( 
	SUM(Total_Sales)  
	FOR Item_Fat_Content IN ([Low Fat], [Regular]) 
) AS PivotTable 
ORDER BY Outlet_Location_Type;


-- Total Sales by Outlet Establishments

SELECT * FROM blinkit_data

-- Ascending Order
SELECT Outlet_Establishment_Year,
		CAST(SUM(Total_Sales) AS DECIMAL(10, 2)) AS Total_Sales,
		CAST(AVG(Total_Sales) AS DECIMAL(10, 1)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10, 2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year ASC

-- Descending Order
SELECT Outlet_Establishment_Year,
		CAST(SUM(Total_Sales) AS DECIMAL(10, 2)) AS Total_Sales,
		CAST(AVG(Total_Sales) AS DECIMAL(10, 1)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10, 2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year DESC

-- Percentage of Sales by Outlet Size

SELECT * FROM blinkit_data

SELECT  
	Outlet_Size,  
	CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales, 
	CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS 
DECIMAL(10,2)) AS Sales_Percentage 
FROM blinkit_data 
GROUP BY Outlet_Size 
ORDER BY Total_Sales DESC; 

-- Sales by Outlet Location

SELECT Outlet_Location_Type, CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS 
Total_Sales 
FROM blinkit_data 
GROUP BY Outlet_Location_Type 
ORDER BY Total_Sales DESC 

-- All Metrics by Outlet Type

SELECT Outlet_Type,  
		CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales, 
		CAST(AVG(Total_Sales) AS DECIMAL(10,0)) AS Avg_Sales, 
		COUNT(*) AS No_Of_Items, 
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating, 
		CAST(AVG(Item_Visibility) AS DECIMAL(10,2)) AS Item_Visibility 
FROM blinkit_data 
GROUP BY Outlet_Type 
ORDER BY Total_Sales DESC