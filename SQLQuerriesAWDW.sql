--1-Display all data from DimCustomer
SELECT *
FROM DimCustomer


--2-Display customer's first Name, birth date, marital status And gender from DimCustomer
SELECT FirstName, BirthDate, MaritalStatus, Gender
From DimCustomer

--3-Get customers whose yearly income is more than 60000
SELECT *
FROM DimCustomer
WHERE YearlyIncome >= 60000

--4-Get all customers who have a total children <= 3
SELECT *
FROM DimCustomer
WHERE TotalChildren <=3

--5-List of customers who are married and have yearly income > one lakh
SELECT *
FROM DimCustomer
WHERE MaritalStatus = 'M' 
AND YearlyIncome > 100000

--6-List all male customers whose birthdate is greater than 1st Jan 1970
SELECT *
FROM DimCustomer
WHERE Gender = 'M' 
AND birthdate > '1970-01-01' 

--7-Get customers whose occupation is either professional or management
SELECT *
FROM DimCustomer
WHERE EnglishOccupation IN ('Professional', 'Management')

--8- Display accountkey, parentaccountkey  and account Description from DimAccount 
--where parentaccountkey is not null
SELECT AccountKey, ParentAccountKey, AccountDescription
FROM DimAccount
WHERE ParentAccountKey IS NOT NULL

--9HA- Display product key and product name from DimProduct whose reorder point > 300 and color is black
SELECT ProductKey, EnglishProductName
FROM DimProduct
WHERE ReorderPoint >300
AND Color = 'black'

--10HA- Display all products that are silver in colour
SELECT *
FROM DimProduct
WHERE Color = 'silver'


--11HA- Employees working in departments HumanResources And Sales.
SELECT *
FROM DimEmployee
WHERE DepartmentName IN ('Human Resources', 'sales')

--12-All departments from DimEmployee
SELECT DISTINCT DepartmentName
FROM DimEmployee

--13- Display SalesOrderNumber, Productkey and Freight From FactResellerSales
--Whose Freight > 15 and <100
SELECT SalesOrderNumber, ProductKey, Freight
FROM FactResellerSales
WHERE Freight BETWEEN 15 AND 100

--14-All employees working in HR, Sales, Purchasing, Marketing
SELECT *
FROM DimEmployee
WHERE DepartmentName IN ('Human Resources', 'sales', 'Purchasing', 'Marketing')

--15-Display employeekey, parentEmployeeKey And department of employees whose employee key is 
--1,19,276,105,73
SELECT EmployeeKey, ParentEmployeeKey, DepartmentName
FROM DimEmployee
WHERE EmployeeKey IN (1,19,276,105,73)

--16-All employees who are married and whose base rate is >10 and <25
SELECT *
FROM DimEmployee
WHERE MaritalStatus = 'M' 
AND BaseRate > 10
AND BASERATE < 25

--17-All Married Male employees whose base rate is between 10 and 25
SELECT *
FROM DimEmployee
WHERE MaritalStatus = 'M' 
AND Gender = 'M'
AND BaseRate BETWEEN 10 AND 25

--18-Display all customers whose FirstName starts with J
SELECT *
FROM DimCustomer
WHERE FirstName LIKE 'J%'

--19-Display all customers whose FirstName starts with J, E, C
SELECT *
FROM DimCustomer
WHERE FirstName LIKE '[JEC]%' 

SELECT *
FROM DimCustomer
WHERE FirstName LIKE 'JO%' 
OR FirstName LIKE 'EU%'

SELECT *
FROM DimCustomer
WHERE YearlyIncome > 100000
AND Gender = 'M'
AND EnglishOccupation IN ('MANAGEMENT', 'PROFESSIONAL', 'SKILLED Manual')

--20-Display customers' Name, birthdate, and gender from DimCustomer
-- concat igones NULL
SELECT CONCAT (FirstName,' ',MiddleName) CustomerName, BirthDate, Gender
FROM DimEmployee

--- + returns NULL if any one entry is NULLS
SELECT FirstName + ' ' + MiddleName CustomerName , BirthDate, Gender
FROM DimEmployee

--21--Display all products with their 'SubcategoryName'
SELECT DP.*, DPS.EnglishProductSubcategoryName
FROM DimProduct DP
LEFT JOIN DimProductSubcategory DPS ON DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey


--22- Display all products along with their category name and subcategory name
SELECT DP.*, DPC.EnglishProductCategoryName, DPS.EnglishProductSubcategoryName
FROM DimProduct DP
LEFT JOIN DimProductSubcategory DPS ON DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
LEFT JOIN DimProductCategory DPC ON DPC.ProductCategoryKey = DPS.ProductCategoryKey

--23- Display Departmentwise employee count
SELECT DepartmentName, COUNT(*) EmployeeCount
FROM DimEmployee
GROUP BY DepartmentName

--24-ProductSubcategoryWise number of products from table DimProduct
SELECT DPS.EnglishProductSubcategoryName, COUNT(*) ProductCount
FROM DimProduct DP
LEFT JOIN DimProductSubcategory DPS ON DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
GROUP BY DPS.EnglishProductSubcategoryName

--25HA-ProductSubcategoryWise number of products from table DimProduct whose SubcategoryKey Is Not null
SELECT DPS.EnglishProductSubcategoryName, COUNT(*) ProductCount
FROM DimProduct DP
LEFT JOIN DimProductSubcategory DPS ON DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
WHERE DPS.EnglishProductSubcategoryName IS NOT NULL
GROUP BY DPS.EnglishProductSubcategoryName
	--OR
SELECT DPS.EnglishProductSubcategoryName, COUNT(*) ProductCount
FROM DimProduct DP
JOIN DimProductSubcategory DPS ON DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
GROUP BY DPS.EnglishProductSubcategoryName

--26HA-Display count of married female employees
SELECT COUNT(*) MarriedFemaleEmployees
FROM DimEmployee
WHERE Gender = 'F'
AND MaritalStatus = 'M'

--27HA-Display Departmentwise count of married female employees
SELECT DepartmentName, Count(*)MarriedFemaleEmployees
FROM DimEmployee
WHERE Gender = 'F'
AND MaritalStatus = 'M'
Group BY DepartmentName

--28-CustomersNameWise TotalSale And TotalFreight From FactInternetsales
SELECT DC.CustomerKey, DC.FirstName +' '+Dc.LastName CustomerName,  SUM(FIS.SalesAmount)Sales, SUM(FIS.Freight)Freight 
FROM FactInternetSales FIS
JOIN DimCustomer DC ON FIS.CustomerKey = DC.CustomerKey
Group BY DC.FirstName +' '+Dc.LastName, DC.CustomerKey

--29HA-ProductWise TotalSales From FactInternetSales
SELECT DP.EnglishProductName ,SUM(SalesAmount)
FROM FactInternetSales FIS
JOIN DimProduct DP ON FIS.ProductKey = DP.ProductKey
GROUP BY  DP.EnglishProductName


--30HA-ProductSubcategoryWise AverageSale From FactInternetSales
SELECT DPS.EnglishProductSubcategoryName, AVG(FIS.SalesAmount) AverageSale
FROM FactInternetSales FIS
JOIN DimProduct DP ON FIS.ProductKey = DP.ProductKey
JOIN DimProductSubcategory DPS ON DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
GROUP BY DPS.EnglishProductSubcategoryName

--31- CountryWise TotalSale In Descending  From FactResellerSales
SELECT DG.EnglishCountryRegionName, SUM(FRS.SalesAmount) TotalSale
FROM FactResellerSales FRS
JOIN DimReseller DR ON FRS.ResellerKey = DR.ResellerKey
JOIN DimGeography DG ON DR.GeographyKey = DG.GeographyKey
GROUP BY DG.EnglishCountryRegionName
ORDER BY TotalSale DESC

--32HA-CountryWise StateWise TotalSale From FactResellerSales 
SELECT DG.EnglishCountryRegionName, DG.StateProvinceName, SUM(FRS.SalesAmount) TotalSales
FROM FactResellerSales FRS
JOIN DimReseller DR ON FRS.ResellerKey = DR.ResellerKey
JOIN DimGeography DG ON DR. GeographyKey = DG.GeographyKey
GROUP BY DG.EnglishCountryRegionName, DG.StateProvinceName
ORDER BY 1,3 DESC

--33HA-CountryWise Resellerwise TotalSale From FactResellerSales 
SELECT DG.EnglishCountryRegionName, DR.ResellerName, SUM(FRS.SalesAmount) TotalSales
FROM FactResellerSales FRS
JOIN DimReseller DR ON FRS.ResellerKey = DR.ResellerKey
JOIN DimGeography DG ON DR. GeographyKey = DG.GeographyKey
GROUP BY DG.EnglishCountryRegionName, ResellerName
ORDER BY 1 DESC, 3 DESC

--34-FiscalYearWise EmployeesNameWise AverageSale From FactResellerSales
SELECT DD.FiscalYear, DE.FirstName+ ' '  + DE.LastName EmployeesName, AVG(FRS.SalesAmount) AverageSale
FROM FactResellerSales FRS
JOIN DimEmployee DE ON FRS.EmployeeKey = DE.EmployeeKey
JOIN DimDate DD ON FRS.OrderDateKey = DD.DateKey
GROUP BY DD.FiscalYear, DE.FirstName+ ' '  + DE.LastName
ORDER BY 1 , 3 DESC

--35HA-SalesTerritoryGroupWise EmployeeWise CategoryWise Minimum And Maximum Sale From FactInternetSales
SELECT DST.SalesTerritoryGroup, DE.FirstName +' '+ De.LastName EmployeeName, DPC.EnglishProductCategoryName, MIN(FIS.SalesAmount) MinSale, MAX (FIS.SalesAmount) MaxSale 
FROM FactInternetSales FIS
JOIN DimSalesTerritory DST ON FIS.SalesTerritoryKey = DST.SalesTerritoryKey
JOIN DimEmployee DE ON DST.SalesTerritoryKey = DE.SalesTerritoryKey
JOIN DimProduct DP ON FIS.ProductKey = DP.ProductKey
JOIN DimProductSubcategory DPS ON DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
JOIN DimProductCategory DPC ON DPS.ProductCategoryKey = DPC.ProductCategoryKey
GROUP BY DST.SalesTerritoryGroup, DE.FirstName +' '+ De.LastName, DPC.EnglishProductCategoryName


--36HA-Categorywise SubcategoryWise TotalSale for selected calendar year From FIS
SELECT DPC.EnglishProductCategoryName, DPS.EnglishProductSubcategoryName,SUM(FIS.SalesAmount) TotalSale 
FROM FactInternetSales FIS
JOIN DimProduct DP ON FIS.ProductKey = DP.ProductKey
JOIN DimProductSubcategory DPS ON DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
JOIN DimProductCategory DPC ON DPS.ProductCategoryKey = DPC.ProductCategoryKey
JOIN DimDate DD ON FIS.OrderDateKey = DD.DateKey
WHERE  DD.CalendarYear = '2005' 
GROUP BY DPC.EnglishProductCategoryName, DPS.EnglishProductSubcategoryName
ORDER BY 3 DESC

--37-Display  SalesOrderNumber, SalesOrderLineNumber , AmountDue From FIS
SELECT SalesOrderNumber, SalesOrderLineNumber, SalesAmount+Freight+TaxAmt AmountDue
FROM FactInternetSales

--38-Display EmployeeKey, Employee's FullName, DepartmentName and ManagerName From DimEmployee
SELECT DE.EmployeeKey, DE.FirstName+' '+ DE.LastName, DE.DepartmentName, DEa.FirstName+' ' + DEa.LastName ManagerName
FROM DimEmployee DE
JOIN DimEmployee DEa ON DE.ParentEmployeeKey = DEa.EmployeeKey

--39-Display ManagerName and TotalEmployees Reporting To That Manager 
SELECT DEA.FirstName+' ' + DEA.LastName ManagerName, COUNT(DE.ParentEmployeeKey)TotalEmployeesReporting
FROM DimEmployee DE
JOIN DimEmployee DEA ON DE.ParentEmployeeKey = DEA.EmployeeKey
GROUP BY DEA.FirstName+' ' + DEA.LastName

--40-Find the Name of  customers who have registered more than 25 orders From FIS
SELECT DC.FirstName+' ' + DC.LastName CustomerName, COUNT(DISTINCT FIS.SalesOrderNumber) NumberofOrder
FROM FactInternetSales FIS
JOIN DimCustomer DC ON FIS.CustomerKey = DC.CustomerKey
GROUP BY  DC.FirstName+' ' + DC.LastName
HAVING COUNT (DISTINCT FIS.SalesOrderNumber) >25 


--41HA-Find Name of customers who had placed orders more than one time From FIS
SELECT DC.FirstName+' ' + DC.LastName CustomerName
FROM FactInternetSales FIS
JOIN DimCustomer DC ON FIS.CustomerKey = DC.CustomerKey
GROUP BY  DC.FirstName+' ' + DC.LastName
HAVING COUNT (DISTINCT FIS.SalesOrderNumber) >1


--42HA- Display categorywise Employeewise Total Sales Having Totalsales > 200000 From FIS
SELECT DPC.EnglishProductCategoryName, DE.FirstName+' ' +DE.LastName EmployeeName, 
SUM (FIS.SalesAmount) SaleAmount
FROM FactInternetSales FIS 
JOIN DimProduct DP ON FIS.ProductKey = DP.ProductKey
JOIN DimProductSubcategory DPS ON DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
JOIN DimProductCategory DPC ON DPS.ProductCategoryKey = DPC.ProductCategoryKey
JOIN DimSalesTerritory DST ON FIS.SalesTerritoryKey = DST.SalesTerritoryKey
JOIN DimEmployee DE ON DST.SalesTerritoryKey = DE.SalesTerritoryKey
GROUP BY DPC.EnglishProductCategoryName, DE.FirstName+' ' +DE.LastName
HAVING SUM (FIS.SalesAmount) >200000
ORDER BY 1,3 DESC

--43- Which are the top 10 selling products from FactInternetSales
WITH ProductList AS
(
SELECT DP.EnglishProductName, SUM(FIS.SalesAmount) TotalSales
FROM FactInternetSales FIS
JOIN DimProduct DP ON FIS.ProductKey = DP.ProductKey
GROUP BY DP.EnglishProductName
), SortedProductList AS
(
SELECT PL.EnglishProductName, Pl.TotalSales,
 ROW_NUMBER() OVER (ORDER BY (Pl.TotalSales) DESC ) SerialNumber
 FROM ProductList PL
)
SELECT SPL.SerialNumber, SPL.EnglishProductName, SPL.TotalSales
FROM SortedProductList SPL 
WHERE SPL.SerialNumber <= 10

--OR

WITH ProductList AS
(
SELECT DP.EnglishProductName, SUM(FIS.SalesAmount) TotalSales
FROM FactInternetSales FIS
JOIN DimProduct DP ON FIS.ProductKey = DP.ProductKey
GROUP BY DP.EnglishProductName
)
SELECT TOP 10 PL.EnglishProductName, PL.TotalSales
FROM ProductList PL 
ORDER BY 2 DESC

--44HA-Which are the top 25 selling products in FactResellarSales
WITH ProductList AS
(
SELECT DP.EnglishProductName, SUM(FRS.SalesAmount)TotalSales
FROM FactResellerSales FRS
JOIN DimProduct DP ON FRS.ProductKey = DP.ProductKey
GROUP BY DP.EnglishProductName
), SortedProductList AS
(
SELECT PL.EnglishProductName, PL.TotalSales, ROW_NUMBER() OVER (ORDER BY (Pl.TotalSales) DESC ) SerialNumber
 FROM ProductList PL
)
SELECT TOP 25 SPL.SerialNumber, SPL.EnglishProductName, SPL.TotalSales
FROM SortedProductList SPL 

--45-Create the output which will give me the top 3 products by EmployeeFullName from
--FactResellerSales for fiscal year 2007
GO
WITH EmployeeProdcutList AS
(
SELECT DE.FirstName+' '+DE.LastName EmployeeName, DP.EnglishProductName, SUM(FRS.SalesAmount) TotalSales
FROM FactResellerSales FRS
JOIN DimDate DD ON FRS.OrderDateKey = DD.DateKey
JOIN DimEmployee DE ON FRS.EmployeeKey = DE.EmployeeKey
JOIN DimProduct DP ON FRS.ProductKey = DP.ProductKey
WHERE DD.FiscalYear = 2007
GROUP BY DE.FirstName+' '+DE.LastName, DP.EnglishProductName
), SortedEmployeeProdcutList AS
(
SELECT EPL.EmployeeName, EPL.EnglishProductName,EPL.TotalSales, 
DENSE_RANK() OVER (PARTITION BY EPL.EmployeeName ORDER BY EPL.TotalSales DESC) Rnk
FROM EmployeeProdcutList EPL
)
SELECT SEPL.EmployeeName, SEPL.EnglishProductName,SEPL.TotalSales, SEPL.Rnk
FROM SortedEmployeeProdcutList SEPL
WHERE SEPL.Rnk <4

--46HA-Subcategorywise top 2 Selling  products from FactInternetSales
WITH SubCategoryProductList AS
(
SELECT DPS.EnglishProductSubcategoryName, DP.EnglishProductName ,SUM(FIS.SalesAmount) TotalSales
FROM FactInternetSales FIS
JOIN DimProduct DP ON FIS.ProductKey = DP.ProductKey
JOIN DimProductSubcategory DPS ON DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
GROUP BY DPS.EnglishProductSubcategoryName, DP.EnglishProductName
), SortedSubCategoryProductList AS
(
SELECT SPL.EnglishProductSubcategoryName, SPL.EnglishProductName, SPL.TotalSales,
DENSE_RANK () OVER (PARTITION BY SPL.EnglishProductSubcategoryName ORDER BY SPL.TotalSales DESC) Rnk
FROM SubCategoryProductList SPL
)
SELECT SSPL.EnglishProductSubcategoryName, SSPL.EnglishProductName, SSPL.TotalSales, SSPL.Rnk
FROM SortedSubCategoryProductList SSPL
WHERE SSPL.Rnk < 3
ORDER BY 1 , 4 

--47-create output from FRS to list the Products where Products TotalSale < average sale per product
WITH ProductTotalSaleList AS
(
SELECT DP.EnglishProductName, SUM(FRS.SalesAmount) TotalSale
FROM FactResellerSales FRS
JOIN DimProduct DP ON FRS.ProductKey = DP.ProductKey
GROUP BY DP.EnglishProductName
), ProductAvgSaleList AS
(
SELECT AVG(PTSL.TotalSale) AvgSale
FROM ProductTotalSaleList PTSL
)
SELECT PTSL.EnglishProductName, PTSL.TotalSale, PASL.AvgSale
FROM ProductTotalSaleList PTSL
CROSS JOIN ProductAvgSaleList PASL
WHERE PTSL.TotalSale < PASL.AvgSale
ORDER BY 2 DESC



--48HA-Give me the list of  countries whose sales are greater than the average sale per country from FactResellerSales
WITH CountryTotalSaleList AS
(
SELECT DG.EnglishCountryRegionName, SUM(FRS.SalesAmount) TotalSale
FROM FactResellerSales FRS
JOIN DimReseller DR ON FRS.ResellerKey = DR.ResellerKey
JOIN DimGeography DG ON DR.GeographyKey = DG.GeographyKey
GROUP BY DG.EnglishCountryRegionName
), CountryAvgSaleList AS
(
SELECT AVG(CTSL.TotalSale) AvgSale
FROM CountryTotalSaleList CTSL
)
SELECT CTSL.EnglishCountryRegionName, CTSL.TotalSale, CASL.AvgSale
FROM CountryTotalSaleList CTSL
CROSS JOIN CountryAvgSaleList CASL
WHERE CTSL.TotalSale < CASL.AvgSale
--49- From FactInternetSales, each employee's highest and lowest-selling product for a given year
WITH EmployeeProductList AS
(
SELECT DE.FirstName+' '+ DE.LastName EmployeeName, DP.EnglishProductName, SUM(FIS.SalesAmount)TotalSale
FROM FactInternetSales FIS
JOIN DimSalesTerritory DST ON FIS.SalesTerritoryKey = DST.SalesTerritoryKey
JOIN DimEmployee DE ON DST.SalesTerritoryKey = DE.SalesTerritoryKey
JOIN DimProduct DP ON FIS.ProductKey = DP.ProductKey
JOIN DimDate DD ON FIS.OrderDateKey = DD.DateKey
WHERE DD.CalendarYear = 2007
GROUP BY DE.FirstName+' '+ DE.LastName,  DP.EnglishProductName
), SortedEmployeeProductList AS
(
SELECT EPL.EmployeeName, EPL.EnglishProductName, EPL.TotalSale,
DENSE_RANK () OVER (PARTITION BY EPL.EmployeeName ORDER BY EPL.TotalSale DESC) MaxSaleRank,
DENSE_RANK () OVER (PARTITION BY EPL.EmployeeName ORDER BY EPL.TotalSale ASC) MINSaleRank
FROM EmployeeProductList EPL
)
SELECT SEPL.EmployeeName, SEPL.EnglishProductName, SEPL.TotalSale
FROM SortedEmployeeProductList SEPL
WHERE SEPL.MaxSaleRank = 1
OR SEPL.MINSaleRank = 1
ORDER BY 1, 3 DESC
--------- OR-----------

WITH DescEmployeeProductList AS
(
SELECT de.FirstName +' ' + de.LastName EmployeeName, DP.EnglishProductName, SUM(FIS.SalesAmount) TotalSale,
ROW_NUMBER() over (PARTITION BY de.FirstName+' ' +de.LastName ORDER BY SUM(FIS.SalesAmount) DESC)  SerialNumber
FROM FactInternetSales FIS
JOIN DimDate DD ON FIS.OrderDateKey = DD.DateKey
JOIN DimProduct DP ON FIS. ProductKey = DP.ProductKey
JOIN DimSalesTerritory DST ON FIS.SalesTerritoryKey = DST.SalesTerritoryKey
JOIN DimEmployee DE ON DST.SalesTerritoryKey = DE.SalesTerritoryKey
WHERE DD.CalendarYear = 2007
GROUP BY de.FirstName+' '+ de.LastName,DP.EnglishProductName
), AscEmployeeProductList AS
(
SELECT de.FirstName +' ' + de.LastName EmployeeName, DP.EnglishProductName, SUM(FIS.SalesAmount) TotalSale,
ROW_NUMBER() over (PARTITION BY de.FirstName+' ' +de.LastName ORDER BY SUM(FIS.SalesAmount))  SerialNumber
FROM FactInternetSales FIS
JOIN DimDate DD ON FIS.OrderDateKey = DD.DateKey
JOIN DimProduct DP ON FIS. ProductKey = DP.ProductKey
JOIN DimSalesTerritory DST ON FIS.SalesTerritoryKey = DST.SalesTerritoryKey
JOIN DimEmployee DE ON DST.SalesTerritoryKey = DE.SalesTerritoryKey
WHERE DD.CalendarYear = 2007
GROUP BY de.FirstName+' '+ de.LastName, DP.EnglishProductName
)
SELECT DEPL.EmployeeName, DEPL.EnglishProductName HieghestSellingProdcut, DEPL.TotalSale HeighestSale, AEPL.EnglishProductName LowestSellingProdcut,
AEPL.TotalSale LowestSale
FROM DescEmployeeProductList DEPL
JOIN AscEmployeeProductList AEPL ON DEPL.EmployeeName = AEPL.EmployeeName
where aepl.SerialNumber = 1
and DEPL.SerialNumber =1
ORDER BY 3 DESC

--50HA- From FactInternetSales display only those employees selling the highest and lowest  Product for a selected year

WITH DescEmployeeProductList AS
(
SELECT de.FirstName +' ' + de.LastName EmployeeName, DP.EnglishProductName, SUM(FIS.SalesAmount) TotalSale,
DENSE_RANK() over (ORDER BY SUM(FIS.SalesAmount) DESC)  SerialNumber
FROM FactInternetSales FIS
JOIN DimDate DD ON FIS.OrderDateKey = DD.DateKey
JOIN DimProduct DP ON FIS. ProductKey = DP.ProductKey
JOIN DimSalesTerritory DST ON FIS.SalesTerritoryKey = DST.SalesTerritoryKey
JOIN DimEmployee DE ON DST.SalesTerritoryKey = DE.SalesTerritoryKey
WHERE DD.CalendarYear = 2007
GROUP BY de.FirstName+' '+ de.LastName, DP.EnglishProductName
), AscEmployeeProductList AS
(
SELECT de.FirstName +' ' + de.LastName EmployeeName, DP.EnglishProductName, SUM(FIS.SalesAmount) TotalSale,
DENSE_RANK() over (ORDER BY SUM(FIS.SalesAmount))  SerialNumber
FROM FactInternetSales FIS
JOIN DimDate DD ON FIS.OrderDateKey = DD.DateKey
JOIN DimProduct DP ON FIS. ProductKey = DP.ProductKey
JOIN DimSalesTerritory DST ON FIS.SalesTerritoryKey = DST.SalesTerritoryKey
JOIN DimEmployee DE ON DST.SalesTerritoryKey = DE.SalesTerritoryKey
WHERE DD.CalendarYear = 2007
GROUP BY de.FirstName+' '+ de.LastName, DP.EnglishProductName
)
SELECT DEPL.EmployeeName, DEPL.EnglishProductName, DEPL.TotalSale
FROM DescEmployeeProductList DEPL
where DEPL.SerialNumber = 1
UNION 
SELECT AEPL.EmployeeName, AEPL.EnglishProductName, AEPL.TotalSale
FROM AscEmployeeProductList AEPL
Where AEPL.SerialNumber = 1
ORDER BY 3 DESC



----OR-------
WITH EmployeeList AS
(
SELECT DE.FirstName+' '+ DE.LastName EmployeeName, DP.EnglishProductName, SUM(FIS.SalesAmount)TotalSale
FROM FactInternetSales FIS
JOIN DimSalesTerritory DST ON FIS.SalesTerritoryKey = DST.SalesTerritoryKey
JOIN DimEmployee DE ON DST.SalesTerritoryKey = DE.SalesTerritoryKey
JOIN DimProduct DP ON FIS.ProductKey = DP.ProductKey
JOIN DimDate DD ON FIS.OrderDateKey = DD.DateKey
WHERE DD.CalendarYear = 2007
GROUP BY DE.FirstName+' '+ DE.LastName,  DP.EnglishProductName
)
SELECT EL.EmployeeName, EL.EnglishProductName, EL.TotalSale
FROM EmployeeList EL
WHERE EL.TotalSale = (SELECT MIN(TotalSale) FROM EmployeeList)
OR  EL.TotalSale = (SELECT MAX(TotalSale) FROM EmployeeList)
ORDER BY 3 DESC


--51HA-Display yearwise highest and lowest selling product along with the employee name From FIS

WITH DescEmployeeProductList AS
(
SELECT DD.CalendarYear, de.FirstName +' ' + de.LastName EmployeeName, DP.EnglishProductName, SUM(FIS.SalesAmount) TotalSale,
ROW_NUMBER() over (PARTITION BY DD.CalendarYear ORDER BY SUM(FIS.SalesAmount) DESC)  SerialNumber
FROM FactInternetSales FIS
JOIN DimDate DD ON FIS.OrderDateKey = DD.DateKey
JOIN DimProduct DP ON FIS. ProductKey = DP.ProductKey
JOIN DimSalesTerritory DST ON FIS.SalesTerritoryKey = DST.SalesTerritoryKey
JOIN DimEmployee DE ON DST.SalesTerritoryKey = DE.SalesTerritoryKey
GROUP BY DD.CalendarYear, de.FirstName+' '+ de.LastName, DP.EnglishProductName
), AscEmployeeProductList AS
(
SELECT DD.CalendarYear, de.FirstName +' ' + de.LastName EmployeeName, DP.EnglishProductName, SUM(FIS.SalesAmount) TotalSale,
ROW_NUMBER() over (PARTITION BY DD.CalendarYear ORDER BY SUM(FIS.SalesAmount))  SerialNumber
FROM FactInternetSales FIS
JOIN DimDate DD ON FIS.OrderDateKey = DD.DateKey
JOIN DimProduct DP ON FIS. ProductKey = DP.ProductKey
JOIN DimSalesTerritory DST ON FIS.SalesTerritoryKey = DST.SalesTerritoryKey
JOIN DimEmployee DE ON DST.SalesTerritoryKey = DE.SalesTerritoryKey
GROUP BY DD.CalendarYear, de.FirstName+' '+ de.LastName, DP.EnglishProductName
)
SELECT DEPL.CalendarYear, DEPL.EmployeeName, DEPL.EnglishProductName, DEPL.TotalSale
FROM DescEmployeeProductList DEPL
where DEPL.SerialNumber = 1
UNION 
SELECT AEPL.CalendarYear, AEPL.EmployeeName, AEPL.EnglishProductName, AEPL.TotalSale
FROM AscEmployeeProductList AEPL
Where AEPL.SerialNumber = 1
ORDER BY 1, 3 DESC

-- OR---

WITH EmployeeList AS
(
SELECT DD.CalendarYear, DE.FirstName+' '+ DE.LastName EmployeeName, DP.EnglishProductName, SUM(FIS.SalesAmount)TotalSale,
ROW_NUMBER() over (PARTITION BY DD.CalendarYear ORDER BY SUM(FIS.SalesAmount))  DownSerialNumber,
ROW_NUMBER() over (PARTITION BY DD.CalendarYear ORDER BY SUM(FIS.SalesAmount) DESC)  UPSerialNumber
FROM FactInternetSales FIS
JOIN DimSalesTerritory DST ON FIS.SalesTerritoryKey = DST.SalesTerritoryKey
JOIN DimEmployee DE ON DST.SalesTerritoryKey = DE.SalesTerritoryKey
JOIN DimProduct DP ON FIS.ProductKey = DP.ProductKey
JOIN DimDate DD ON FIS.OrderDateKey = DD.DateKey
GROUP BY DD.CalendarYear, DE.FirstName+' '+ DE.LastName,  DP.EnglishProductName
)
SELECT EL.CalendarYear, EL.EmployeeName, EL.EnglishProductName, EL.TotalSale
FROM EmployeeList EL
WHERE EL.DownSerialNumber = 1
OR EL.UPSerialNumber =1
ORDER BY 1, 3 DESC