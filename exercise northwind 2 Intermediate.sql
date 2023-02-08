-- Northwind Database Exercise Soluations
-- Consider the Northwind database whose schema is given in Figure 1. This database contains information of orders placed by customerS. For every order the detail is given of what products were sold, for what unit price and in what quantity. The employee that secured the order is recorded as well as the date in which the order was inserted. For customers the city they live in etC. is recorded, and for employees their salesdistrict. For this database, create queries to generate the following reports:


-- 51. Select the number of sales per category and country.

-- 52. Create a report that shows the product name AND supplier id for all products supplied by Exotic Liquids, Grandma Kelly's Homestead, AND Tokyo TraderS.

-- 53. Create a report that shows all products by name that are in the "Seafood" category. 

-- 54. Create a report that shows all companies by name that sell products in Category ID 8.

-- 55. Create a report that shows all companies by name that sell products in the Seafood category.

-- 56. Create a report showing the Order ID, the name of the company that placed the order, and the first AND last name of the associated employeE. Only show orders placed after January 1, 1998 that shipped after they were required. Sort by Company NamE.
 
-- 57. Which products are provided by which supplierS.

-- 58. Create a report that shows the order ids AND the associated employee names for orders that shipped after the required datE.

-- 59. Create a report that shows the total quantity of products (FROM the Order_Details table) ordered. Only show records for products for which the quantity ordered is fewer than 200.

-- 60. Create a report that shows the total number of orders by Customer since December 31, 1996. The report should only return rows for which the number orders is greater than 15. The report should return the following 5 rowS.

-- 61. Create a report that shows the company name, order id, AND total price of all products of which Northwind has sold more than $10,000 worth. There is no need for a GROUP BY clause in this report.

-- 62. Create a report that shows the number of employees AND customers FROM each city that has employees in it. 

-- 63. Create a report that shows the company names AND faxes for all customerS. If the customer doesn't have a fax, the report should show "No Fax" in that field

-- 64. Select the 3 top-selling categories overall
-- (hint: use “LIMIT” construction).

-- 65. List total amount of sales by employee and year (discount in OrderDetails is at unit_price level). Which employees have an increase in sales over the three reported years?

-- 66. Get an individual sales report by month for employee 9 (Dodsworth) in 1997.

-- 68. Get a sales report by country and month.

-- 69. Order Details Extended, calculates sales price for each order after discount is applied.

-- 70. Ten Most Expensive Products
-- Query 1

 
-- Query 2


-- 71. Products Above Average Price, shows how to use sub-query to get a single value (average unit price) that can be used in the outer-query.

-- 72. Quarterly Orders by Product, shows how to convert order dates to the corresponding quarters. 
-- It also demonstrates how SUM function is used together with CASE statement to get sales for each quarter, where quarters are converted from OrderDate column.

-- 73. Let’s say that data analyst is preparing a presentation and interested in how many orders were placed by every particular employee during each year of operation.
-----------+------------+------+-------
 last_name | first_name | year | count 
-----------+------------+------+-------
 Buchanan  | Steven     | 1996 |    11
 Buchanan  | Steven     | 1997 |    18
 Buchanan  | Steven     | 1998 |    13
 Callahan  | Laura      | 1996 |    19
 Callahan  | Laura      | 1997 |    54
 Callahan  | Laura      | 1998 |    31

-----------+------------+-------+-------+-------
  last_name | first_name | y1996 | y1997 | y1998 
-----------+------------+-------+-------+-------
 Peacock   | Margaret   |    31 |    81 |    44
 King      | Robert     |    11 |    36 |    25
 Davolio   | Nancy      |    26 |    55 |    42
 Callahan  | Laura      |    19 |    54 |    31
 Fuller    | Andrew     |    16 |    41 |    39
 Suyama    | Michael    |    15 |    33 |    19
 Buchanan  | Steven     |    11 |    18 |    13
 Dodsworth | Anne       |     5 |    19 |    19
 Leverling | Janet      |    18 |    71 |    38