SELECT * FROM blinkit.blinkit_data;
use blinkit;
ALTER TABLE blinkit.blinkit_data
CHANGE `ï»¿Item Fat Content` Item_Fat_Content VARCHAR(50);

SELECT DISTINCT Item_Fat_Content
FROM blinkit_data;

SET SQL_SAFE_UPDATES = 0;
UPDATE blinkit_data
SET Item_Fat_Content =
CASE
    WHEN LOWER(TRIM(Item_Fat_Content)) IN ('lf','low fat') THEN 'Low Fat'
    WHEN LOWER(TRIM(Item_Fat_Content)) IN ('reg','regular') THEN 'Regular'
    ELSE Item_Fat_Content
END;

SET SQL_SAFE_UPDATES = 1;

select CONCAT (cast(sum(Sales) / 1000000 as decimal(10 , 2)),'M') as total_sales_milions 
from blinkit_data

SELECT CAST(AVG(Sales) AS INT )  AS AVERAGE
FROM blinkit_data;

SELECT CAST(AVG(Sales) AS signed) AS AVERAGE
FROM blinkit_data;

-- count no item

select count('Item Identifier')  from  blinkit_data;


-- calculate average rating
 select cast(avg(Rating) as decimal(10 , 1)) as avg_of_item  from blinkit_data;
 
 -- total sales by fat contain
 select Item_Fat_Content, cast(sum(Sales) as decimal(10, 2)) 
 from blinkit_data
 group by Item_Fat_Content;
--  
alter Table blinkit_data
rename column `Item Type` to Item_Type;
--  Total Sales by Item Type
select Item_Type, cast(sum(Sales) as decimal(10, 2)) as Sales_by_Item_Type
 from blinkit_data
 group by Item_Type
 ORDER BY Sales_by_Item_Type DESC;
 
 alter Table blinkit_data
rename column `Outlet Location Type` to Outlet_Location_Type;
 
  alter Table blinkit_data
rename column `Outlet Establishment Year` to Outlet_Establishment_Year;

select Outlet_Location_Type , Item_Fat_Content,
	cast(sum(sales) as decimal(10 , 2)) as total_sales 
    from blinkit_data
    group by Outlet_Location_Type , Item_Fat_Content , sales


-- E. Total Sales by Outlet Establishment
select Outlet_Establishment_Year,
	cast(sum(sales) as decimal( 10 , 2 )) as total_sales
	from blinkit_data
    group by Outlet_Establishment_Year
	order by Outlet_Establishment_Year asc
   --  
--  Percentage of Sales by Outlet Size

select `Outlet Size`,
	cast(sum(sales) as decimal(10 , 2)) as total_sales,
    cast(sum(sales) * 100.0 / sum(sum(sales)) over() as decimal(10 , 2)) as  percentage_sales 
from blinkit_data
group by `Outlet Size`;

SELECT Outlet_Location_Type, CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC

-- All Metrics by Outlet Type: 

SELECT `Outlet Type`, 
CAST(SUM(sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST(AVG(sales) AS DECIMAL(10,0)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating,
		CAST(AVG(`Item Visibility`) AS DECIMAL(10,2)) AS `Item Visibility`
FROM blinkit_data
GROUP BY `Outlet Type`

