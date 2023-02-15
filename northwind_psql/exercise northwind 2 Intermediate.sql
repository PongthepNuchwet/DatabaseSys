-- Northwind Database Exercise Soluations
-- Consider the Northwind database whose schema is given in Figure 1. This database contains information of orders placed by customerS. For every order the detail is given of what products were sold, for what unit price and in what quantity. The employee that secured the order is recorded as well as the date in which the order was inserted. For customers the city they live in etC. is recorded, and for employees their salesdistrict. For this database, create queries to generate the following reports:


-- 51. Select the number of sales per category and country.
SELECT category_name ,country,COUNT(*) AS COUNT

-- 52. Create a report that shows the product name AND supplier id for all products supplied by Exotic Liquids, Grandma Kelly's Homestead, AND Tokyo TraderS.
SELECT S.supplier_id, S.company_name,P.product_id ,P.product_name 
FROM products P
JOIN suppliers S ON P.supplier_id = S.supplier_id
WHERE S.company_name IN ('Exotic Liquids', 'Grandma Kelly''s Homestead', 'Tokyo TraderS'); 
-- 53. Create a report that shows all products by name that are in the "Seafood" category. 

-- 54. Create a report that shows all companies by name that sell products in Category ID 8.

-- 55. Create a report that shows all companies by name that sell products in the Seafood category.

-- 56. Create a report showing the Order ID, the name of the company that placed the order, and the first AND last name of the associated employeE. Only show orders placed after January 1, 1998 that shipped after they were required. Sort by Company NamE.
 
-- 57. Which products are provided by which supplierS.

-- 58. Create a report that shows the order ids AND the associated employee names for orders that shipped after the required datE.

-- 59. Create a report that shows the total quantity of products (FROM the Order_Details table) ordered. Only show records for products for which the quantity ordered is fewer than 200.
SELECT P.product_name,
		SUM(O.quantity)
FROM products P
JOIN order_details O ON (P.product_id = O.product_id)
GROUP BY P.product_name
Having SUM(O.quantity) < 200
;
-- 60. Create a report that shows the total number of orders by Customer since December 31, 1996. The report should only return rows for which the number orders is greater than 15. The report should return the following 5 rowS.
SELECT C.company_name,
	COUNT(O.order_id)
FROM orders O
JOIN customers C ON(O.customer_id = C.customer_id)
WHERE O.order_date >= '31-dec-1996'
GROUP BY C.company_name
HAVING COUNT(O.order_id) > 15
ORDER BY COUNT(O.order_id)
;
-- 61. Create a report that shows the company name, order id, AND total price of all products of which Northwind has sold more than $10,000 worth. There is no need for a GROUP BY clause in this report.
SELECT C.company_name , O.order_id , ((OD.unit_price - (OD.unit_price * OD.discount)) * OD.quantity)::NUMERIC::MONEY AS total
FROM orders O JOIN customers C ON (O.customer_id = C.customer_id) JOIN order_details OD ON (O.order_id = OD.order_id)
WHERE ((OD.unit_price - (OD.unit_price * OD.discount)) * OD.quantity) > 10000
;
-- 62. Create a report that shows the number of employees AND customers FROM each city that has employees in it. 
SELECT COUNT(distinct(E.employee_id)) AS numemp,
       COUNT(distinct(C.customer_id)) AS numcus,
       E.city,
       C.city
FROM employees E
JOIN customers C ON (E.city=C.city)
GROUP BY E.city , C.city
ORDER BY numemp ;
-- 63. Create a report that shows the company names AND faxes for all customerS. If the customer doesn't have a fax, the report should show "No Fax" in that field
SELECT C.company_name , (CASE WHEN  fax IS NULL THEN 'NO Fax' ELSE fax END ) fax  FROM customers C 

-- 64. Select the 3 top-selling categories overall
-- (hint: use “LIMIT” construction).
SELECT category_name,
	country,
	COUNT(*) AS COUNT 
FROM order_details O,
	products P,
	categories C,
	suppliers S
WHERE O.product_id = P.product_id
	AND P.category_id = C.category_id
	AND P.supplier_id = S.supplier_id
GROUP BY category_name, 
	country
ORDER BY COUNT(*) DESC, category_name
LIMIT 3
;
-- 65. List total amount of sales by employee and year (discount in OrderDetails is at unit_price level). Which employees have an increase in sales over the three reported years?

SELECT first_name,
	last_name,
	DATE_PART('YEAR', order_date) AS YEAR,
	(SUM((1 - discount) * OD.unit_price * quantity))::NUMERIC::MONEY AS totalamount
FROM orders O,
	order_details OD,
	employees E
WHERE O.order_id = OD.order_id
	AND O.employee_id = E.employee_id
GROUP BY first_name,
	last_name,
	DATE_PART('YEAR', order_date)
ORDER BY first_name,
	last_name,
	DATE_PART('YEAR', order_date)
;
-- 66. Get an individual sales report by month for employee 9 (Dodsworth) in 1997.
SELECT first_name,
	last_name,
	DATE_PART('YEAR', order_date) AS YEAR,
	(SUM((1 - discount) * OD.unit_price * quantity))::NUMERIC::MONEY AS totalamount
FROM orders O,
	order_details OD,
	employees E
WHERE O.order_id = OD.order_id
	AND O.employee_id = 9
    AND DATE_PART('YEAR', order_date) = 1997
GROUP BY first_name,
	last_name,
	DATE_PART('YEAR', order_date)
ORDER BY first_name,
	last_name,
	DATE_PART('YEAR', order_date)
;
-- 68. Get a sales report by country and month.
SELECT country
,DATE_PART('YEAR', order_date) AS YEAR
,DATE_PART('MONTH', order_date) AS MONTH
,(SUM((1-discount) * OD.unit_price* quantity)) AS totalamount
FROM orders O,
order_details OD,
products P,
suppliers S 
WHERE O.order_id = OD.order_id
AND OD.product_id = p.product_id
AND P.supplier_id = S.supplier_id 
GROUP BY country,
DATE_PART('YEAR', order_date) 
,DATE_PART('MONTH', order_date)
ORDER BY country,
DATE_PART('YEAR', order_date)
,DATE_PART('MONTH', order_date);
-- 69. Order Details Extended, calculates sales price for each order after discount is applied.

SELECT DISTINCT y.order_id,
	y.product_id,
	x.product_name,
	y.unit_price,
	y.quantity,
	y.discount,
	ROUND((y.Unit_Price * y.Quantity * (1 - y.Discount))::NUMERIC, 2) AS ExtendedPrice
FROM products x
INNER JOIN order_details y ON x.product_id = y.product_id
ORDER BY y.order_id
;
-- 70. Ten Most Expensive Products
-- Query 1

 
-- Query 2


-- 71. Products Above Average Price, shows how to use sub-query to get a single value (average unit price) that can be used in the outer-query.

-- 72. Quarterly Orders by Product, shows how to convert order dates to the corresponding quarters. 
-- It also demonstrates how SUM function is used together with CASE statement to get sales for each quarter, where quarters are converted from OrderDate column.
