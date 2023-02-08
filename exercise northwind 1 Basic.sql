-- Northwind Database Exercise Soluations
-- Consider the Northwind database whose schema is given in Figure 1. This database contains information of orders placed by customerS. For every order the detail is given of what products were sold, for what unit price and in what quantity. The employee that secured the order is recorded as well as the date in which the order was inserted. For customers the city they live in etC. is recorded, and for employees their salesdistrict. For this database, create queries to generate the following reports:


-- 1. Create a report that shows the CategoryName and Description from the categories table sorted by CategoryName.

-- 2. Create a report that shows the ContactName, CompanyName, ContactTitle and Phone number from the customers table sorted by Phone.

-- 3. Create a report that shows the capitalized FirstName and capitalized LastName renamed as FirstName and Lastname respectively and HireDate from the employees table sorted from the newest to the oldest employee.

-- 4. Create a report that shows the top 10 OrderID, OrderDate, ShippedDate, CustomerID, Freight from the orders table sorted by Freight in descending order.

-- 5. Create a report that shows all the CustomerID in lowercase letter and renamed as ID from the customers table.

-- 6. Create a report that shows the CompanyName, Fax, Phone, Country, HomePage from the suppliers table sorted by the Country in descending order then by CompanyName in ascending order.

-- 7. Create a report that shows CompanyName, ContactName of all customers from ‘Buenos Aires' only.

-- 8. Create a report showing ProductName, UnitPrice, QuantityPerUnit of products that are out of stock.

-- 9. Create a report showing all the ContactName, Address, City of all customers not from Germany, Mexico, Spain.

-- 10. Create a report showing OrderDate, ShippedDate, CustomerID, Freight of all orders placed on 21 May 1996.

-- 11. Create a report showing FirstName, LastName, Country from the employees not from United States.

-- 12. Create a report that shows the EmployeeID, OrderID, CustomerID, RequiredDate, ShippedDate from all orders shipped later than the required date.

-- 13. Create a report that shows the City, CompanyName, ContactName of customers from cities starting with A or B.

-- 14. Create a report showing all the even numbers of OrderID from the orders table.

-- 15. Create a report that shows all the orders where the freight cost more than $500.

-- 16. Create a report that shows the ProductName, UnitsInStock, UnitsOnOrder, ReorderLevel of all products that are up for reorder.

-- 17. Create a report that shows the CompanyName, ContactName number of all customer that have no fax number.

-- 18. Create a report that shows the FirstName, LastName of all employees that do not report to anybody.

-- 19. Create a report showing all the odd numbers of OrderID from the orders table.

-- 20. Create a report that shows the CompanyName, ContactName, Fax of all customers that do not have Fax number and sorted by ContactName.

-- 21. Create a report that shows the City, CompanyName, ContactName of customers from cities that has letter L in the name sorted by ContactName.

-- 22. Create a report that shows the FirstName, LastName, BirthDate of employees born in the 1950s.

-- 23. Create a report that shows the FirstName, LastName, the year of Birthdate as birth year from the employees table.

-- 24. Create a report showing OrderID, total number of Order ID as NumberofOrders from the orderdetails table grouped by OrderID and sorted by NumberofOrders in   descending order. 
-- HINT: you will need to use a Groupby statement.

-- 25. Create a report that shows the SupplierID, ProductName, CompanyName from all product Supplied by Exotic Liquids, Specialty Biscuits, Ltd., Escargots Nouveaux sorted by the supplier ID

-- 26. Create a report that shows the ShipPostalCode, OrderID, OrderDate, RequiredDate, ShippedDate, ShipAddress of all orders with ShipPostalCode beginning with "98124".

-- 27. Create a report that shows the ContactName, ContactTitle, CompanyName of customers that the has no "Sales" in their ContactTitle.

-- 28. Create a report that shows the LastName, FirstName, City of employees in cities other "Seattle";

-- 29. Create a report that shows the CompanyName, ContactTitle, City, Country of all customers in any city in Mexico or other cities in Spain other than Madrid.

-- 30. Create a select statement that outputs the following:
-- +----------------------------------------------------+
-- |first_name last_name can be reached at x extension  |
-- +----------------------------------------------------+

-- 31. Create a report that shows the ContactName of all customers that do not have letter A as the second alphabet in their Contactname.

-- 32. Create a report that shows the average UnitPrice rounded to the next whole number, total price of UnitsInStock and maximum number of orders from the products table. All saved as AveragePrice, TotalStock and MaxOrder respectively.

-- 33. Create a report that shows the SupplierID, CompanyName, CategoryName, ProductName and UnitPrice from the products, suppliers and categories table.

-- 34. Create a report that shows the CustomerID, sum of Freight, from the orders table with sum of freight greater $200, grouped by CustomerID. 
-- HINT: you will need to use a Groupby and a Having statement.

-- 35. Create a report that shows the OrderID ContactName, UnitPrice, Quantity, Discount from the order details, orders and customers table with discount given on  every purchase.

-- 36. Create a report that shows the EmployeeID, the LastName and FirstName as employee, and the LastName and FirstName of who they report to as manager from the  employees table sorted by Employee ID. 
-- HINT: This is a SelfJoin.

-- 37. Create a report that shows the average, minimum and maximum UnitPrice of all products as AveragePrice, MinimumPrice and MaximumPrice respectively.

-- 38. Create a view named CustomerInfo that shows the CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Country, Phone, OrderDate, RequiredDate,  ShippedDate from the customers and orders table. 
-- HINT: Create a View.

-- 39. Change the name of the view you created from customerinfo to customer details.

-- 40. Create a view named ProductDetails that shows the ProductID, CompanyName, ProductName, CategoryName, Description, QuantityPerUnit, UnitPrice, UnitsInStock,  UnitsOnOrder, ReorderLevel, Discontinued from the supplier, products and categories tables. 
-- HINT: Create a View

-- 41. Drop the customer details view.

-- 42. Create a report that fetch the first 5 character of categoryName from the category tables and renamed as ShortInfo

-- 43. Create a copy of the shipper table as shippers_duplicate. Then insert a copy of shippers data into the new table 
-- HINT: Create a Table, use the LIKE Statement and INSERT INTO statement.

-- 44. Create a select statement that outputs the following from the shippers_duplicate Table: 
-- Create a report that shows the CompanyName and ProductName from all  product in the Seafood category.
-- +-----------------------------------------|----------------------------------------------------------+
-- |"shipper_id" | "company_name"	         |"phone"	                 |"email"                       |
-- |1	         |"Speedy Express"	         |"(503) 555-9831"	         |"speedyexpress@gmail.com"     |
-- |2	         |"United Package"	         |"(503) 555-3199"	         |"unitedpackage@gmail.com"     |
-- |3	         |"Federal Shipping"	     |"(503) 555-9931"	         |"federalshipping@gmail.com"   |
-- +-----------------------------------------|----------------------------------------------------------+

-- 45. Create a report that shows the CompanyName and ProductName from all product in the Seafood category.

-- 46. Create a report that shows the CategoryID, CompanyName and ProductName from all product in the categoryID 5.

-- 47. Delete the shippers_duplicate table.

-- 48. Create a select statement that ouputs the following from the employees table.
-- +--------------------------------------+
-- | last_name | first_name | title | age |
-- +--------------------------------------+
-- NB: The age might differ depending on the year you are attempting this query.

-- 49. Create a report that the CompanyName and total number of orders by customer renamed as number of orders since Decemeber 31, 1994. Show number of Orders greater than 10.

-- 50. Create a select statement that ouputs the following from the product table
-- +-------------------------------------------------------------------------+
-- |                            "productinfo"                                |
-- +-------------------------------------------------------------------------+
-- | "Chai weighs/is 10 boxes x 30 bags and cost $18"                        |
-- | "Chang weighs/is 24 - 12 oz bottles and cost $19"                       |
-- + "Aniseed Syrup weighs/is 12 - 550 ml bottles and cost $10"              |
-- +-------------------------------------------------------------------------+

