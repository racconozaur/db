use [AdventureWorks2012] EXEC sp_changedbowner 'sa'
ALTER AUTHORIZATION ON DATABASE::AdventureWorks2012 TO sa;


select JobTitle, HireDate
from HumanResources.Employee

--2

select *
from Production.Product
where StandardCost between 90 and 100
order by StandardCost desc

--3

select * from Production.Product
select * from production.ProductSubcategory

select * 
from Production.Product pp
join Production.ProductSubcategory pps on pp.ProductSubcategoryID = pps.ProductSubcategoryID
where pps.Name like '%mountain%' and pp.ListPrice between 600 and 900
order by pp.Color desc, pp.Name asc


select p.Name "Product name", p.SellStartDate "Date on sail", c.Name "Suncategory name", 
p.ListPrice, p.Color "Product color" 
from production.Product p  
     join production.ProductSubcategory c on p.ProductSubcategoryID = 
c.ProductSubcategoryID 
where c.Name like '%Mountain%' and p.ListPrice between 600 and 900 
order by p.Color desc , c.Name asc

--4

select * from HumanResources.Employee

--select avg(m.SickLeaveHours) "average SickLeaveHours", COUNT(m.BirthDate)
--from HumanResources.Employee m
--join HumanResources.Employee g on m.MaritalStatus = g.Gender
--where g.BirthDate > '1980-10-10'

select MaritalStatus, Gender, avg(SickLeaveHours)" average SickLeaveHours ", COUNT(BirthDate) "num of emp"
from HumanResources.Employee
where BirthDate > '1980-10-10'
group by MaritalStatus, Gender

--5 

select * from Sales.SalesPerson
select * from Person.Person

select pp.FirstName "first name", pp.LastName "last name ", 
					datediff(month, ssp.ModifiedDate, getdate())"date till now", 
					( select avg(SalesLastYear) from sales.SalesPerson "Sales" )
from Sales.SalesPerson ssp
join Person.Person pp on ssp.BusinessEntityID = pp.BusinessEntityID
where ssp.bonus > 100 and ssp.SalesLastYear > ( select avg(SalesLastYear) from Sales.SalesPerson )
group by pp.FirstName, pp.LastName, ssp.ModifiedDate


select p.FirstName, p.LastName 
    , DATEDIFF(month, sp.ModifiedDate, getdate()) "Months till now" 
  , (select avg(SalesLastYear) from Sales.SalesPerson) "Avg sales last year" 
from Sales.SalesPerson sp join [Person].[Person] p on sp.BusinessEntityID = 
p.BusinessEntityID 
where sp.Bonus > 100 and sp.SalesLastYear > (select avg(SalesLastYear) from 
Sales.SalesPerson) 
order by p.lastname desc

--6
GO

create or replace view some_view as
select * from Sales.Currency
where CurrencyCode like 'a%' and Name like '%m%'


--7
 


select e.ModifiedDate "Business entity date modified" 
       ,ct.Name "Business contact type name" 
     ,concat (a.AddressLine1, ', ', a.PostalCode) "Full address" 
     ,s.Name "Store name" 
from Person.BusinessEntity e 
     join person.BusinessEntityContact ec on ec.BusinessEntityID = e.BusinessEntityID 
   join person.ContactType ct on ct.ContactTypeID = ec.ContactTypeID 
   join person.BusinessEntityAddress ea on ea.BusinessEntityID = e.BusinessEntityID 
   join person.Address a on a.AddressID = ea.AddressID 
   join Sales.Store s on s.BusinessEntityID = e.BusinessEntityID 
where s.Name like '%Toy%' 
order by ct.Name asc, s.Name desc, e.ModifiedDate asc


--------2

--1

select name, SellStartDate
from Production.Product
order by SellStartDate desc


--2

select * 
from HumanResources.Employee
where HireDate > '2011-01-01'

--3
select* from Production.Product
select * from Production.ProductListPriceHistory

select p.name, p.ProductLine, pl.StartDate, pl.EndDate
from Production.Product p
join Production.ProductListPriceHistory pl on p.ProductID = pl.ProductID
where p.ProductLine like 'S%' and (pl.StartDate > '2011-01-01' and pl.EndDate < '2012-06-01')
order by p.Name asc, pl.StartDate desc 


--4

select Product.Class, AVG(Weight)"average weight", COUNT(ProductID)"num of products"
from Production.Product
where Color is null
group by Product.Class

--5

select * from Production.Product
select * from Production.ProductCategory

select p.Name, pc.Name, p.StandardCost, SUBSTRING(p.ProductNumber, 1, 2)"2char prod num", (select AVG(StandardCost) from Production.Product) "avg cost of all prod"
from Production.Product p
join Production.ProductCategory pc on p.ProductSubcategoryID = p.ProductSubcategoryID
where p.StandardCost > (select avg(StandardCost) from Production.Product)

--6

--7

EXEC sp_changedbowner 'sa'
ALTER AUTHORIZATION ON DATABASE::AdventureWorks2012 TO sa;

select * from Production.ProductListPriceHistory
select * from Sales.SpecialOfferProduct
select * from Production.Product

go
select p.*, pr.ReviewDate, ph.StartDate
from Production.Product p 
join Production.ProductReview pr on p.ProductID = pr.ProductID
join Production.ProductListPriceHistory ph on p.ProductID = ph.ProductID
join Sales.SpecialOfferProduct sp on p.ProductID = sp.ProductID
where sp.SpecialOfferID is null --asd


---- mock

--1
select * from HumanResources.Employee

select count(distinct JobTitle) "count od job titles"
from HumanResources.Employee

--2
 
select * from Production.Product
where name not like '%Metal%'

--3

select * from HumanResources.Employee
select * from Person.Person


select e.JobTitle, e.HireDate, p.FirstName, p.LastName
from HumanResources.Employee e
join Person.Person p on e.BusinessEntityID = p.BusinessEntityID
where e.HireDate < '2011-01-01'
order by e.HireDate


--4

select * from Production.Product
select * from Production.ProductModelProductDescriptionCulture
select * from Production.Culture

select distinct p.Name, c.Name
from Production.Product p
join Production.ProductModel pm on p.ProductModelID = pm.ProductModelID
join Production.ProductModelProductDescriptionCulture pc on pm.ProductModelID = pc.ProductModelID
join Production.Culture c on pc.CultureID = c.CultureID


--5

select * from HumanResources.Employee
select * from Person.Person

select  e.JobTitle, e.BirthDate, datediff(year, BirthDate, getdate())"age", p.FirstName, p.LastName
from HumanResources.Employee e
join Person.Person p on e.BusinessEntityID = p.BusinessEntityID
where datediff(year, BirthDate, getdate()) > 60
order by age

--6

select * from HumanResources.EmployeePayHistory
select * from HumanResources.Employee

select e.JobTitle, ep.Rate
from HumanResources.Employee e
join HumanResources.EmployeePayHistory ep on e.BusinessEntityID = ep.BusinessEntityID
where ep.Rate < (select avg(rate) from HumanResources.EmployeePayHistory)


--7

select * from Production.Product 
select * from Production.ProductSubcategory

select ps.Name, count(*) "num of prod"
from Production.Product p
join Production.ProductSubcategory ps on p.ProductSubcategoryID = ps.ProductSubcategoryID
group by ps.Name
having COUNT(*) > 20

--8

--9

WITH 
  cteCandidates (BusinessEntityID)
  AS
  (
    SELECT BusinessEntityID
    FROM HumanResources.Employee
    INTERSECT
    SELECT BusinessEntityID
    FROM HumanResources.JobCandidate
  )
SELECT 
  c.BusinessEntityID,
  e.LoginID,
  e.JobTitle
FROM 
  HumanResources.Employee AS e
  INNER JOIN cteCandidates AS c
    ON e.BusinessEntityID = c.BusinessEntityID
ORDER BY
  c.BusinessEntityID;










