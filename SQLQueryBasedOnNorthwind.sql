                         --Queries based on 'NORTHWIND' database
--1- Find the number of orders sent by each shipper.
SELECT Shippers.CompanyName ShipperName, COUNT (Orders.OrderID) NumberOfOrders
FROM Orders
JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID
GROUP BY Shippers.CompanyName

--2- Find the number of orders sent by each shipper, sent by each employee
SELECT Shippers.CompanyName ShipperName, Employees.FirstName+' ' +Employees.LastName EmployeeName ,COUNT (Orders.OrderID) NumberOfOrders
FROM Orders
JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID
JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
GROUP BY Shippers.CompanyName, Employees.FirstName+' ' +Employees.LastName
ORDER BY 3 DESC

--3- Find the names of  employees who have registered more than 100 orders.
SELECT Employees.FirstName+' ' +Employees.LastName EmployeeName, COUNT (Orders.OrderID) NumberOfOrders
FROM Orders
JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
GROUP BY Employees.FirstName+' ' +Employees.LastName
HAVING COUNT (DISTINCT Orders.OrderID) > 99
ORDER BY 2 DESC

--4-Find if the employees "Davolio" or "Fuller" have registered more than 25 orders.
SELECT Employees.FirstName+' ' +Employees.LastName EmployeeName ,COUNT (Orders.OrderID) NumberOfOrders
FROM Orders
JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
WHERE Employees.LastName IN ('Davolio', 'Fuller')
GROUP BY Employees.FirstName+' ' +Employees.LastName
ORDER BY 2 DESC

--5-Find the customer_id and name of customers who had placed orders more than one time and how many times they have placed the order
SELECT Customers.CustomerID , Customers.CompanyName, COUNT (Orders.OrderID) NumberOfOrders
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Customers.CustomerID , Customers.CompanyName
HAVING COUNT (Orders.OrderID) > 1
ORDER BY 3 DESC

--6-Select all the orders where the employee’s city and order’s ship city are same.
SELECT Orders.*
FROM Orders
JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
WHERE Employees.City = Orders.ShipCity

--7-Create a report that shows the order ids and the associated employee names for orders that shipped after the required date.
SELECT Orders.OrderID, Employees.FirstName+' ' +Employees.LastName EmployeeName, DATEDIFF(DAY, Orders.RequiredDate, Orders.ShippedDate) DelayDays
FROM Orders
JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
WHERE Orders.ShippedDate > Orders.RequiredDate
ORDER BY 3 DESC


--8-Create a report that shows the total quantity of products ordered fewer than 200.
SELECT Products.ProductName, COUNT (Orders.OrderID) NumberOfOrders
FROM Orders
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
JOIN Products ON [Order Details].ProductID = Products.ProductID
GROUP BY Products.ProductName
Having COUNT (Orders.OrderID) < 200
ORDER BY 2


--9-Create a report that shows the total number of orders by Customer since December 31, 1996 and the NumOfOrders is greater than 15.
SELECT Customers.CompanyName, COUNT (Orders.OrderID) NumberOfOrders
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Orders.OrderDate > '19961231'
GROUP BY Customers.CompanyName
HAVING COUNT (Orders.OrderID) > 14
ORDER BY 2 DESC

--10-Create a report that shows the company name, order id, and total price of all products of which Northwind
-- has sold more than $10,000 worth.
SELECT Customers.CompanyName, Orders.OrderID, SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount)) PriceOfAllProductsSold, ROUND(SUM((OD.Quantity*OD.UnitPrice)*(1-OD.Discount)) ,2)TotalRevenue
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
JOIN [Order Details] OD ON Orders.OrderID = OD.OrderID
GROUP BY Customers.CompanyName, Orders.OrderID
HAVING SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount)) > 10000
ORDER BY 3 DESC

--11-Create a report showing the Order ID, the name of the company that placed the order,
--and the first and last name of the associated employee. Only show orders placed after January 1, 1998 
--that shipped after they were required. Sort by Company Name.
SELECT Orders.OrderID, Customers.CompanyName, Employees.FirstName+' ' +Employees.LastName EmployeeName
FROM Orders
JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Orders.OrderDate > '19980101'
AND
Orders.ShippedDate > Orders.RequiredDate
ORDER BY 2

--12-Get the phone numbers of all shippers, customers, and suppliers
SELECT Shippers.CompanyName ShipperName, Shippers.Phone
FROM Shippers
UNION
SELECT Customers.CompanyName CustomerName, Customers.Phone
FROM Customers
UNION
SELECT Suppliers.CompanyName SupplierName, Suppliers.Phone
FROM Suppliers


--13-Create a report showing the contact name and phone numbers of all employees,customers, and suppliers.
SELECT E.FirstName+' '+ E.LastName Name, E.HomePhone Phone
FROM Employees E
UNION
SELECT Customers.CompanyName CustomerName, Customers.Phone
FROM Customers
UNION
SELECT Suppliers.CompanyName SupplierName, Suppliers.Phone
FROM Suppliers


--14-Fetch all the orders for a given customer’s phone number 030-0074321.
SELECT Orders.*
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Customers.Phone = '030-0074321'

--15-Fetch all the products that are available under the Category ‘Seafood’.
SELECT Products.*
FROM Products
JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE Categories.CategoryName = 'Seafood'

--16-Fetch all the products which are supplied by a company called ‘Pavlova, Ltd.’
SELECT Products.ProductName
FROM Products
JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
WHERE Suppliers.CompanyName = 'Pavlova, Ltd.'

--17-All orders placed by the customers belong to London city.
SELECT Orders.*
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Customers.City = 'London'

--18-All orders placed by the customers do not belong to London city.
SELECT Orders.*
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Customers.City  != 'London'

--19-All the orders placed for the product Chai.
SELECT Orders.*
FROM Orders
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
JOIN Products ON [Order Details].ProductID = Products.ProductID
WHERE Products.ProductName = 'Chai'

--20-Find the name of the company that placed order 10290.
SELECT Customers.CompanyName
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Orders.OrderID = 10290

--21-Find the Companies that placed orders in 1997
SELECT Orders.OrderDate,Customers.CompanyName
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Year(Orders.OrderDate) = '1997'

--22-Get the product name , count of orders processed 
SELECT Products.ProductName , COUNT(DISTINCT Orders.OrderID) OrderCount
FROM Orders
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
JOIN Products ON [Order Details].ProductID = Products.ProductID
GROUP BY Products.ProductName


--23-Get the top 3 products which has more orders
SELECT TOP 3 Products.ProductName , COUNT(DISTINCT Orders.OrderID) OrderCount
FROM Orders
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
JOIN Products ON [Order Details].ProductID = Products.ProductID
GROUP BY Products.ProductName
ORDER BY 2 DESC

--24-Get the list of employees who processed the order “chai”
SELECT  DISTINCT Employees.FirstName+' '+Employees.LastName EmpployeeName
FROM Orders
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
JOIN Products ON [Order Details].ProductID = Products.ProductID
JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
WHERE Products.ProductName = 'Chai'

--25-Get the shipper company who processed the order categories “Seafood” 
SELECT DISTINCT Shippers.CompanyName
FROM Orders
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
JOIN Products ON [Order Details].ProductID = Products.ProductID
JOIN Categories ON Products.CategoryID = Categories.CategoryID
JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID
WHERE Categories.CategoryName = 'Seafood'

--26-Get category name , count of orders processed by the USA employees
SELECT Categories.CategoryName, COUNT(DISTINCT Orders.OrderID) OrderCount
FROM Orders
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
JOIN Products ON [Order Details].ProductID = Products.ProductID
JOIN Categories ON Products.CategoryID = Categories.CategoryID
JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
WHERE Employees.Country = 'USA'
GROUP BY Categories.CategoryName
ORDER BY 2 DESC
 
--27-Select CategoryName and Description from the Categories table sorted by CategoryName.
SELECT CategoryName, Description
FROM Categories
ORDER BY 1

--28-Select ContactName, CompanyName, ContactTitle, and Phone from the Customers table sorted byPhone.
SELECT ContactName, CompanyName, ContactTitle, Phone
FROM Customers
ORDER BY 4

--29-Create a report showing employees' first and last names and hire dates sorted from newest to oldest employee
SELECT FirstName+' '+ LastName EmployeeName, HireDate
FROM Employees
ORDER BY 2 DESC

--30-Create a report showing Northwind's orders sorted by Freight from most expensive to cheapest. Show OrderID, 
--OrderDate, ShippedDate, CustomerID, and Freight
SELECT OrderID, OrderDate, ShippedDate,CustomerID, Freight
FROM Orders
ORDER BY 5 DESC

--31-Select CompanyName, Fax, Phone, HomePage and Country from the Suppliers table sorted by Country in descending 
--order and then by CompanyName in ascending order
SELECT CompanyName, Fax, Phone, HomePage, Country
FROM Suppliers
ORDER BY 5 DESC, 1

--32-Create a report showing all the company names and contact names of Northwind's customers in Buenos Aires
SELECT CompanyName, ContactName
FROM Customers
WHERE City = 'Buenos Aires'

--33-Create a report showing the product name, unit price and quantity per unit of all products that are out of stock
SELECT ProductName, UnitPrice, QuantityPerUnit
FROM Products
Where UnitsInStock = 0

--34-Create a report showing the order date, shipped date, customer id, and freight of all orders placed on May 19, 1997
SELECT OrderDate, ShippedDate, CustomerID, Freight
FROM Orders
Where OrderDate = '19970519'

--35-Create a report showing the first name, last name, and country of all employees not in the United States.
SELECT FirstName+' ' +LastName EmployeeName, Country
FROM Employees
WHERE Country = 'USA'

--36-Create a report that shows the city, company name, and contact name of all customers who are in cities that begin with "A" or "B."
SELECT City, CompanyName, ContactName
FROM Customers
WHERE City LIKE '[AB]%'

--37-Create a report that shows all orders that have a freight cost of more than $500.00.
SELECT *
FROM Orders
WHERE Freight > 500

--38-Create a report that shows the product name, units in stock, units on order, and reorder level of all
-- products that are up for reorder
SELECT ProductName, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued
FROM Products
WHERE ReorderLevel = 0
AND Discontinued = 1

--39-Create a report that shows the company name, contact name and fax number of all customers that have a fax number.
SELECT CompanyName, ContactName, Fax
FROM Customers
WHERE Fax IS NOT NULL

--40-Create a report that shows the first and last name of all employees who do not report to anybody
SELECT FirstName+' '+LastName EmployeeName
FROM Employees
WHERE ReportsTo IS NULL

--41-Create a report that shows the company name, contact name and fax number of all customers that have a fax number, 
--Sort by company name.
SELECT CompanyName, ContactName, Fax
FROM Customers
WHERE Fax IS NOT NULL
ORDER BY 1

--42-Create a report that shows the city, company name, and contact name of all customers who are in cities 
--that begins with "A" or "B." Sort by contact name in descending order 
SELECT City, CompanyName, ContactName
FROM Customers
WHERE City LIKE '[AB]%'
ORDER BY 3 DESC

--43-Create a report that shows the first and last names and birth date of all employees born in the 1950s
SELECT FirstName+' '+LastName EmployeeName, BirthDate
FROM Employees
WHERE YEAR(BirthDate)  BETWEEN '1950' AND '1959'

--44-Create a report that shows the shipping postal code, order id, and order date for all orders with a ship postal code 
--beginning with "02389".
SELECT ShipPostalCode, OrderID, OrderID
FROM Orders
WHERE ShipPostalCode LIKE '02389%'

--45-Create a report that shows the contact name and title and the company name for all customers whose contact title
-- does not contain the word "Sales".
SELECT ContactName, CompanyName
FROM Customers
WHERE ContactTitle NOT LIKE '%sales%'

--46-Create a report that shows the first and last names and cities of employees from cities other than Seattle
-- in the state of Washington.
SELECT FirstName+' '+LastName EmployeeName, City
FROM Employees
WHERE City != 'Seattle'

--47-Create a report that shows the company name, contact title, city and country of all customers in Mexico 
--or in any city in Spain except Madrid.
SELECT  CompanyName, ContactTitle, City, Country
FROM Customers
WHERE Country IN ('Mexico', 'Spain')
AND City != 'Madrid'

--48-List of Employees along with the Manager
SELECT Employees.FirstName+' '+Employees.LastName EmployeeName, Man.FirstName+' '+Man.LastName ManagerName
FROM Employees
JOIN Employees Man ON Employees.ReportsTo = Man.EmployeeID

--49-List of Employees along with the Manager and his/her title
SELECT E.FirstName+' '+E.LastName EmployeeName, E.Title, Man.FirstName+' '+Man.LastName ManagerName
FROM Employees E
JOIN Employees Man ON E.ReportsTo = Man.EmployeeID

--50-Provide Average Sales per order
SELECT AVG(OD.UnitPrice*OD.Quantity*(1-OD.Discount)) AvarageSalesPerOrder
FROM Orders O
JOIN [Order Details] OD ON O.OrderID = OD.OrderID

--51-Employee wise Average Freight
SELECT E.FirstName +' '+ E.LastName EmployeeName, AVG(O.Freight) AvgFreight
FROM Orders O
JOIN Employees E on O.EmployeeID = E.EmployeeID
GROUP BY E.FirstName +' '+ E.LastName
GO
--52-Average Freight per employee
WITH EmployeeFreight AS 
(
SELECT E.FirstName +' '+ E.LastName EmployeeName, AVG(O.Freight) AvgFreight
FROM Orders O
JOIN Employees E on O.EmployeeID = E.EmployeeID
GROUP BY E.FirstName +' '+ E.LastName
)
SELECT AVG(EF.AvgFreight) "Average Freight per employee"
FROM EmployeeFreight EF
GO
--53-Average no. of orders per customer
WITH CustomerOrders AS (
SELECT C.CompanyName, Count(Distinct O.OrderID) AvgOrderCount
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY C.CompanyName
)
SELECT AVG(CO.AvgOrderCount)
FROM CustomerOrders CO

--54-AverageSales per product within Category
SELECT C.CategoryName, AVG(OD.UnitPrice*OD.Quantity*(1-OD.Discount)) AvarageSalesPerCategory
FROM Orders O
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
JOIN Categories C ON P.CategoryID = C.CategoryID
GROUP BY C.CategoryName

--55-PoductName which have more than 100 no.of UnitsinStock
SELECT P.ProductName, P.UnitsInStock
FROM Products P
WHERE P.UnitsInStock > 100

--56-Query to Provide Product Name and Sales Amount for Category Beverages
SELECT P.ProductName, SUM(OD.UnitPrice*OD.Quantity*(1-OD.Discount)) Sales
FROM Orders O
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
JOIN Categories C ON P.CategoryID = C.CategoryID
WHERE C.CategoryName = 'Beverages'
GROUP BY P.ProductName


--57-Query That Will Give  CategoryWise Yearwise number of Orders
SELECT C.CategoryName, YEAR(O.OrderDate) Year, COUNT(DISTINCT O.OrderID) OrderCount
FROM Orders O
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
JOIN Categories C ON P.CategoryID = C.CategoryID
GROUP BY C.CategoryName, YEAR(O.OrderDate)
ORDER BY 1,2,3 DESC

--58-Query to Get ShipperWise employeewise Total Freight for shipped year 1997
SELECT S.CompanyName, E.FirstName+' ' +E.LastName EmployeeName, SUM(O.Freight) TotalFreight
FROM Orders O
JOIN Employees E on O.EmployeeID = E.EmployeeID
JOIN Shippers S ON O.ShipVia = S.ShipperID
WHERE YEAR(O.OrderDate) = '1997'
GROUP BY S.CompanyName, E.FirstName+' ' +E.LastName
ORDER BY 1, 2, 3 DESC

--59-Query That Gives Employee Full Name, Territory Description and Region Description
SELECT DISTINCT E.FirstName+' ' +E.LastName EmployeeName, T.TerritoryDescription, R.RegionDescription
FROM Employees E
JOIN EmployeeTerritories ET on E.EmployeeID = ET.EmployeeID
JOIN Territories T ON ET.TerritoryID = T.TerritoryID
JOIN Region R on T.RegionID = R.RegionID
ORDER BY 1, 2, 3

--60-Query That Will Give Managerwise Total Sales for each year 
SELECT Man.FirstName+' '+Man.LastName ManagerName, SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount)) TotalSales
FROM Orders O
JOIN Employees E ON O.EmployeeID = E.EmployeeID
JOIN Employees Man ON E.ReportsTo = Man.EmployeeID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY Man.FirstName+' '+Man.LastName

GO
--61-Names of customers to whom we are selling less than average sales per customer
WITH AverageSale AS 
(
SELECT SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount))/COUNT (DISTINCT C.CustomerID) AvgSale
FROM Orders O
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
JOIN Customers C ON O.CustomerID = C.CustomerID
)
SELECT C.CompanyName, SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount)) TotalSales
FROM Orders O
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
JOIN Customers C ON O.CustomerID = C.CustomerID
CROSS JOIN AverageSale 
GROUP BY  C.CompanyName, AverageSale.AvgSale
HAVING SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount))  < AverageSale.AvgSale


--62-Query That Gives Average Freight Per Employee and Average Freight Per Customer
WITH AvgFreightEmp AS (
SELECT SUM(O.Freight)/ COUNT(DISTINCT O.EmployeeID) AvgFreight
FROM Orders O
),
AvgFreightCust AS (
SELECT SUM(O.Freight)/ COUNT(DISTINCT O.CustomerID) AvgFreight
FROM Orders O
)
SELECT AE.AvgFreight AvgFreightEmp, AC.AvgFreight AvgFreightCust
FROM AvgFreightEmp AE
CROSS JOIN  AvgFreightCust AC

GO

--63-Query That Gives Category Wise Total Sale Where Category Total Sale < the Average Sale Per Category
WITH AvgSaleCat AS (
SELECT SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount))/COUNT(DISTINCT C.CategoryID) AvgSaleCat
FROM Orders O
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
JOIN Categories C ON P.CategoryID = C.CategoryID
)
SELECT C.CategoryName, SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount)) Sale
FROM Orders O
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
JOIN Categories C ON P.CategoryID = C.CategoryID
CROSS JOIN AvgSaleCat
GROUP BY C.CategoryName, AvgSaleCat.AvgSaleCat
HAVING SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount)) < AvgSaleCat.AvgSaleCat

--64-Query That Provides Month No and Month's Total Sales < Average Sale for Month for Year 1997
WITH AvgSaleMonth AS
(
SELECT SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount))/12 AvgSale
FROM Orders O
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE YEAR(O.OrderDate) = '1997'
)
SELECT MONTH(O.OrderDate) Month, SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount)) Sale
FROM Orders O
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
CROSS JOIN AvgSaleMonth
WHERE YEAR(O.OrderDate) = '1997'
GROUP BY MONTH(O.OrderDate), AvgSaleMonth.AvgSale
HAVING SUM(OD.Quantity*OD.UnitPrice) < AvgSaleMonth.AvgSale

--65-Find out the contribution of each employee towards the total sales done by Northwind for a selected year
SELECT E.FirstName+' '+E.LastName EmployeeName, SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount)) TotalSales
FROM Orders O
JOIN Employees E ON O.EmployeeID = E.EmployeeID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE YEAR(O.OrderDate) = '1997'
GROUP BY  E.FirstName+' '+E.LastName

GO
--66-Give the Customer names that contribute 80% of the total sale done by Northwind for a given year
WITH ParetoSale AS 
(
SELECT C.CompanyName, 
SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount)) TotalSales,
SUM(SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount))) OVER (Order BY SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount)) DESC) CumSale,
SUM(SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount))) OVER (Order BY SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount)) DESC)/ SUM(SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount))) OVER () *100 AS "%CumSale"
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY C.CompanyName
)
SELECT PS.CompanyName, PS.TotalSales
FROM ParetoSale PS
WHERE PS.[%CumSale] < 80

--67-Top 3 performing employees by freight cost for a given year
SELECT TOP 3  E.FirstName+' '+E.LastName EmployeeName, SUM(O.Freight) Freight
FROM Orders O
JOIN Employees E ON O.EmployeeID = E.EmployeeID
GROUP BY E.FirstName+' '+E.LastName 
ORDER BY 2 DESC

--68-Find the bottom 5 customers per product based on Sales Amount
WITH CustomerProductList AS (
SELECT C.CompanyName, P.ProductName, SUM(OD.Quantity*OD.UnitPrice)Sales,
ROW_NUMBER() OVER (PARTITION BY  P.ProductName ORDER BY SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount))) CustomerRank
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY  C.CompanyName, P.ProductName
)
SELECT CPL.CompanyName, CPL.ProductName, CPL.Sales
FROM CustomerProductList CPL
WHERE CPL.CustomerRank <6

--69-Display first and the last row of the table
SELECT *
FROM Orders O
WHERE OrderID = ( SELECT MIN(OrderID) FROM Orders)
OR OrderID = ( SELECT MAX(OrderID) FROM Orders)


--70-Display employee doing the highest sale and the lowest sale in each year
WITH EmployeeSale AS (
SELECT E.FirstName+' '+E.LastName EmployeeName, SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount)) TotalSales
FROM Orders O
JOIN Employees E ON O.EmployeeID = E.EmployeeID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE YEAR(O.OrderDate) = '1997'
GROUP BY  E.FirstName+' '+E.LastName
)
SELECT * 
FROM EmployeeSale ES
WHERE ES.TotalSales = ( SELECT MIN(EmployeeSale.TotalSales) FROM EmployeeSale)
OR ES.TotalSales = ( SELECT MAX(EmployeeSale.TotalSales) FROM EmployeeSale)


--71-Top 3 products of each employee by sales for a given year
WITH CustomerProductList AS (
SELECT E.FirstName+' ' +E.LastName EmployeeName, P.ProductName, SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount))Sales,
ROW_NUMBER() OVER (PARTITION BY  E.FirstName+' ' +E.LastName ORDER BY SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount)) DESC) CustomerRank
FROM Orders O
JOIN Employees E ON O.EmployeeID = E.EmployeeID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
WHERE YEAR(O.Orderdate) = '1997'
GROUP BY E.FirstName+' ' +E.LastName, P.ProductName
)
SELECT CPL.EmployeeName, CPL.ProductName, CPL.Sales
FROM CustomerProductList CPL
WHERE CPL.CustomerRank < 4

--72-Query That Will Give territorywise number of Orders for a given region for a given year
SELECT T.TerritoryDescription, COUNT (DISTINCT O.OrderID) OrderCount
FROM Orders O
JOIN Employees E ON O.EmployeeID = E.EmployeeID
JOIN EmployeeTerritories ET ON E.EmployeeID = ET.EmployeeID
JOIN Territories T on ET.TerritoryID = T.TerritoryID
JOIN Region R on T.RegionID = R.RegionID
WHERE R.RegionDescription ='Eastern'
AND YEAR(O.OrderDate) = '1997'
GROUP BY  T.TerritoryDescription

--73-Display sales amount by category for a given year
SELECT C.CategoryName, SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount)) Sale
FROM Orders O
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
JOIN Categories C ON P.CategoryID = C.CategoryID
WHERE YEAR(O.OrderDate) = '1997'
GROUP BY C.CategoryName

--74-Find  name  of customers who has registered orders less than 10 times.
SELECT C.CompanyName
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY C.CompanyName
HAVING COUNT(DISTINCT O.OrderID) < 10

--75-Regions with the Sale in the range of +/- 30% of average sale per Region for year 1997...
WITH RegionSale AS (
SELECT R.RegionDescription, 
SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount)) Sale,
SUM(SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount))) OVER () /4 AvgSale,
SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount))/SUM(SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount))) OVER () * 100 AS "%Sale"
FROM Orders O
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
JOIN Employees E ON O.EmployeeID = E.EmployeeID
JOIN EmployeeTerritories ET ON E.EmployeeID = ET.EmployeeID
JOIN Territories T on ET.TerritoryID = T.TerritoryID
JOIN Region R on T.RegionID = R.RegionID
WHERE YEAR(O.OrderDate) = '1997'
GROUP BY R.RegionDescription
)
SELECT RS.RegionDescription, RS.Sale, RS.AvgSale,
(RS.Sale)/RS.AvgSale AS "% Sale Contri"
FROM RegionSale RS
WHERE (RS.Sale)/RS.AvgSale < 1.3
AND (RS.Sale)/RS.AvgSale > 0.7

--76-Top 5 countries based on Order Count for year 1998...
SELECT TOP  5 C.Country, COUNT (DISTINCT O.OrderID) OrdreCount
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY C.Country
ORDER BY 2 DESC

--77-Category-wise Sale along with deviation % wrt average sale per category for year 1996...
WITH CategorySale AS (
SELECT C.CategoryName, SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount)) Sale
FROM Orders O
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
JOIN Categories C ON P.CategoryID = C.CategoryID
WHERE YEAR(O.OrderDate) = '1996'
GROUP BY C.CategoryName
), CategoryAvgSale AS 
(
SELECT SUM(CS.Sale)/COUNT(CS.CategoryName) AvgSale
FROM CategorySale CS
)
SELECT CS.CategoryName, CS.Sale, (CS.Sale-CAS.AvgSale)/CAS.AvgSale*100 AS "% Deviation From Average Sale"
FROM CategorySale CS
CROSS JOIN CategoryAvgSale CAS

--78-Count of orders by Customers that are shipped in the same month as ordered...
SELECT C.CompanyName, COUNT (DISTINCT O.OrderID) OrdreCount
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE MONTH(O.OrderDate) = MONTH (O.ShippedDate)
GROUP BY C.CompanyName

GO
--79-Average Demand Days per Order per country for year 1997...
WITH OrderDDay AS 
(
SELECT C.Country, DAY(O.OrderDate-O.RequiredDate) DemandDays
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
)
SELECT ODD.Country, AVG(ODD.DemandDays) "Average Demand Days"
FROM OrderDDay ODD
GROUP BY ODD.Country
ORDER BY 2 DESC

--80-Create the report as Country, Classification, Product Count, Average Sale per Product, Threshold... 
--Classification will be based on Sales and as follows -
--Top if the sale is 1.5 times the average sale per product...
--Excellent if the sale is between 1.2 and 1.5 times the average sale per product...
--Acceptable if the sale is between 0.8 to 1.2 times the average sale per product...
--Need Improvement if the sale is 0.5 to 0.8 times the average sale per product...
--Discontinue for the remaining products...
--Produce this report for year 1998..
GO
WITH CountryProductList AS
(
SELECT C.Country,  P.ProductName,  SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount)) Sale,
AVG(SUM(OD.Quantity * OD.UnitPrice * (1 - OD.Discount))) OVER (PARTITION BY C.Country) AS AvgSaleInCountry
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
WHERE YEAR (O.OrderDate) = '1998'
GROUP BY C.Country, P.ProductName
)
SELECT PL.Country, PL.ProductName, PL.Sale, PL.AvgSaleInCountry,
CASE 
WHEN PL.Sale > 1.5 *PL.AvgSaleInCountry THEN 'Top' 
WHEN PL.Sale > 1.2 *PL.AvgSaleInCountry THEN 'Excellent' 
WHEN PL.Sale > 0.8 *PL.AvgSaleInCountry THEN 'Acceptable'
WHEN PL.Sale > 0.5 *PL.AvgSaleInCountry THEN 'Needs Improvement' 
ELSE 'Discountinue'
END AS Classification
FROM CountryProductList PL
ORDER BY 1,3 DESC

GO

--81-Top 30% products in each Category by their Sale for year 1997...
WITH ProductList AS (
SELECT Ca.CategoryName, P.ProductName, SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount))Sale,
ROW_NUMBER() OVER (PARTITION BY  Ca.CategoryName ORDER BY SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount)) DESC) ProductRank,
COUNT(P.ProductName) OVER (PARTITION BY Ca.CategoryName) AS TotalProducts
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
JOIN Categories Ca ON P.CategoryID = Ca.CategoryID
WHERE YEAR (O.OrderDate) = '1997'
GROUP BY Ca.CategoryName, P.ProductName
)
SELECT PL.CategoryName, PL.ProductName, PL.Sale, PL.ProductRank
FROM ProductList PL
WHERE
ProductRank <= CEILING(0.3 * TotalProducts)

--82-Bottom 40% countries by the Freight for year 1997 along with the Freight to Sale ratio in %...
WITH CountryList AS (
SELECT C.Country, O.Freight,
ROW_NUMBER() OVER (ORDER BY O.Freight) CountryRank,
COUNT(C.Country) OVER () AS TotalCountries
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE YEAR (O.OrderDate) = '1997'
GROUP BY C.Country, O.Freight
)
SELECT CL.Country, CL.Freight
FROM CountryList CL
WHERE
CountryRank <= CEILING(0.4 * TotalCountries)

--83-Countries contributing to 50% of the total sale for the year 1997...
WITH CountrySale AS (
SELECT C.Country, SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount))Sale,
SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount))/SUM(SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount))) OVER () *100 AS "%ContriSale",
SUM(SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount))) OVER (ORDER BY SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount)) DESC)/ 
SUM(SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount))) OVER () *100 AS "% CumSale"
FROM Orders O
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE YEAR (O.OrderDate) = '1997'
GROUP BY C.Country
)
SELECT CS.Country, CS.Sale, CS.[%ContriSale],  CS.[% CumSale]
FROM CountrySale CS
WHERE CS.[% CumSale] < 50
ORDER BY 3 DESC




--84-Top 5 repeat customers for each country in year 1997...
WITH CountryCustomerList AS (
SELECT C.Country, C.CompanyName, COUNT (DISTINCT O.OrderID) OrderCount,
ROW_NUMBER() OVER (PARTITION BY C.Country ORDER BY COUNT (DISTINCT O.OrderID) DESC) CutomerRank
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID 
WHERE YEAR(O.OrderDate) = '1997'
GROUP BY C.Country, C.CompanyName
)
SELECT CCL.Country, CCL.CompanyName, CCL.OrderCount, CCL.CutomerRank
FROM CountryCustomerList CCL
WHERE CCL.CutomerRank < 6
AND CCL.OrderCount > 1
ORDER BY 1, 3 DESC


--85- Week over Week Order Count and change % over previous week for year 1997 as Week Number,
-- Week Start Date, Week End Date, Order Count, Change %
WITH WeekOrders AS (
SELECT O.OrderDate, DATEPART (week, O.OrderDate) WeekNumber, COUNT (DISTINCT O.OrderID) OrderCount,
LAG (COUNT (DISTINCT O.OrderID)) OVER  (ORDER BY DATEPART (week, O.OrderDate)) LastWeekOrders
FROM Orders O
WHERE YEAR(O.OrderDate) = '1997'
GROUP BY O.OrderDate, DATEPART (week, O.OrderDate)
)
SELECT WO.WeekNumber, CAST (DATEADD(WEEK, DATEDIFF(WEEK, 0, WO.OrderDate),0) AS Date) StartOfWeek,
CAST (DATEADD(week, DATEDIFF(week, 0, WO.OrderDate),0)+4 AS DATE) EndOfWeek,
WO.OrderCount, WO.LastWeekOrders,(WO.OrderCount-WO.LastWeekOrders)*100/WO.LastWeekOrders "Change %"
FROM WeekOrders WO


---BONUS
--1.Find all tables containing column with specified name
select * from INFORMATION_SCHEMA.COLUMNS 
where COLUMN_NAME like '%country%' 
order by TABLE_NAME