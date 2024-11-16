--1. ������� VIEW, ������� ���������� 5 ����� ������� ������� �� ����� ��������� �� 1996, 1997, 1998 ����

--2. ������� �������� ���������, ������� ���������� 5 ����� ������� ������� �� ����� ��������� �� ������������ ���.
--��� ������ ������������ ��� ������� ��������

--3. ������� VIEW, ������� ���������� 5 ���������� (CompanyName), ������� ������ ���� �������� � 1997 ���� �� ���������� �������

--4. ������� �������� ���������, ������� ���������� 5 ���������� (CompanyName), 
-- ������� ������ ���� �������� �� ������������ ������ �� ���������� �������
-- ���� ������ � ���� ��������� ������ ������������ ��� ������� ���������

CREATE VIEW V5MostCheepOrder
AS
SELECT TOP 5 p.ProductName, SUM(od.Quantity * od.UnitPrice * (1 - ISNULL(od.Discount, 0))) AS total_revenue
FROM [dbo].[Orders] o
JOIN [dbo].[Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE YEAR(o.OrderDate) BETWEEN 1996 AND 1998
GROUP BY p.ProductName
ORDER BY total_revenue ASC;

CREATE PROC P5MostCheepOrderFix
@Year varchar(100)
AS 
SELECT TOP 5 p.ProductName, SUM(od.Quantity * od.UnitPrice * (1 - ISNULL(od.Discount, 0))) AS total_revenue
FROM [dbo].[Orders] o
JOIN [dbo].[Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE o.OrderDate = @Year
GROUP BY p.ProductName
ORDER BY total_revenue ASC;
GO

EXEC P5MostCheepOrderFix '1996-07-04 00:00:00.000'

CREATE VIEW V5MostBigOrderCompany
AS
SELECT TOP 5 c.CompanyName, SUM(od.Quantity * od.UnitPrice * (1 - ISNULL(od.Discount, 0))) AS total_revenue
FROM [dbo].[Orders] o
JOIN [dbo].[Customers] c ON o.CustomerID = c.CustomerID
JOIN [dbo].[Order Details] od ON o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) BETWEEN 1996 AND 1998
GROUP BY c.CompanyName

CREATE VIEW P5MostBigOrderCompany
@Year varchar(100)
AS
SELECT TOP 5 c.CompanyName, SUM(od.Quantity * od.UnitPrice * (1 - ISNULL(od.Discount, 0))) AS total_revenue
FROM [dbo].[Orders] o
JOIN [dbo].[Customers] c ON o.CustomerID = c.CustomerID
JOIN [dbo].[Order Details] od ON o.OrderID = od.OrderID
WHERE o.OrderDate = @Year
GROUP BY c.CompanyName
GO
EXEC P5MostBigOrderCompany '1996-07-04 00:00:00.000'