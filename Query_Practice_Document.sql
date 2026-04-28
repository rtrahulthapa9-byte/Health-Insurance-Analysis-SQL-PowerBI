--SET OPERATORs--

CREATE TABLE Table_A(
ID INT,
Name VARCHAR(50),
City VARCHAR(50),
Age INT,
Department VARCHAR(50),
Salary NUMERIC(20,2),
JoinYear INT,
Rating NUMERIC(2,1),
Project VARCHAR(20),
Status VARCHAR(20)
)

CREATE TABLE Table_B(
ID INT,
Name VARCHAR(50),
City VARCHAR(50),
Age INT,
Department VARCHAR(50),
Salary NUMERIC(20,2),
JoinYear INT,
Rating NUMERIC(2,1),
Project VARCHAR(20),
Status VARCHAR(20)
)


SELECT * FROM Table_A
SELECT * FROM Table_B

SELECT * FROM Table_A
UNION
SELECT * FROM Table_B
ORDER BY empl_id ;

SELECT * FROM Table_A
UNION ALL
SELECT * FROM Table_B
ORDER BY ID;

SELECT * FROM Table_A
INTERSECT
SELECT * FROM Table_B
ORDER BY ID ;

SELECT * FROM Table_A
EXCEPT
SELECT * FROM Table_B
ORDER BY ID ;


---UPDATE,ALTER,DROP,ADD,RENAME---

UPDATE Table_A
SET Department='IT'
WHERE Name = 'Rahul';


UPDATE Table_A
SET Salary= Salary+(Salary*5/100)
WHERE Salary<50000;

ALTER TABLE Table_A
ADD Salary_New NUMERIC(20,2) NOT NULL DEFAULT 0;



ALTER TABLE Table_A
RENAME COLUMN id to Empl_id;

ALTER TABLE Table_A
DROP COLUMN Salary_New;

SELECT CURRENT_DATE;
SELECT CURRENT_TIME;
SELECT CURRENT_TIMESTAMP;

SELECT CURRENT_TIMESTAMP::TIME;
SELECT CURRENT_TIMESTAMP::DATE;




SELECT EXTRACT(DAY FROM Date) from Sales;

SELECT Date, EXTRACT(DAY FROM Date) as Day, EXTRACT(Month FROM Date) as Month, EXTRACT(Year FROM Date) AS Year from Sales;

SELECT EXTRACT(minute FROM TIME '10:30:25');
SELECT EXTRACT(SECOND FROM TIME '10:30:25');

--DATE DIFFERENCE
SELECT '2025-10-12'::DATE - '2025-10-01'::DATE AS Diff;
SELECT '12:30:02'::TIME - '12:45:06'::TIME AS Diff;

--DATE ADDED--
SELECT DATE '2025-10-12' + INTERVAL '1 month' AS BEW;

SELECT Date,( Date + INTERVAL '1 month')::Date AS month_added FROM Sales;



--DATE SUBSTRACT
SELECT DATE '2025-10-12'-INTERVAL '1 month' AS BEW;

--DATE FORMAT--
SELECT Date, To_Char(Date, 'DD Month YYYY')as New FROM Sales;
SELECT Date, To_Char(Date, 'DD MM YYYY')as New FROM Sales;
SELECT Date, To_Char(Date, 'Mon')as New FROM Sales;

SELECT TO_CHAR(TIME '10:40:21', 'HH12:MI AM') AS dkd;

----------------------------------------------------------------------------------------------
--TYPE OF JOINs--

CREATE TABLE Customers (
    customer_id INT,
    customer_name VARCHAR(50),
    city VARCHAR(50),
    signup_date DATE
);

INSERT INTO Customers VALUES
(1, 'Rahul', 'Kolkata', '2024-01-10'),
(2, 'Amit', 'Delhi', '2024-02-15'),
(3, 'Sneha', 'Mumbai', '2024-03-20'),
(4, 'Priya', 'Chennai', '2024-04-25'),
(5, 'Arjun', 'Bangalore', '2024-05-30'),
(6, 'Neha', 'Pune', '2024-06-10'),
(7, 'Vikas', 'Hyderabad', '2024-07-12'),
(8, 'Anjali', 'Jaipur', '2024-08-18');


CREATE TABLE Orders (
    order_id INT,
    customer_id INT,
    order_date DATE,
    amount NUMERIC(10,2)
);
INSERT INTO Orders VALUES
(101, 1, '2024-09-01', 500.00),
(102, 2, '2024-09-05', 1200.50),
(103, 3, '2024-09-10', 750.00),
(104, 4, '2024-09-15', 300.00),
(105, 2, '2024-09-20', 950.00),
(106, 9, '2024-09-25', 1100.00), -- no matching customer
(107, 10, '2024-09-28', 450.00), -- no matching customer
(108, 5, '2024-10-01', 2000.00);

CREATE TABLE Payments (
    payment_id INT,
    order_id INT,
    payment_date DATE,
    payment_method VARCHAR(20)
);

INSERT INTO Payments VALUES
(201, 101, '2024-09-02', 'UPI'),
(202, 102, '2024-09-06', 'Card'),
(203, 103, '2024-09-11', 'Cash'),
(204, 104, '2024-09-16', 'UPI'),
(205, 109, '2024-09-18', 'Card'), -- no matching order
(206, 110, '2024-09-20', 'Cash'), -- no matching order
(207, 105, '2024-09-21', 'UPI'),
(208, 108, '2024-10-02', 'Card');


SELECT Customer_Name, City, Customers.Customer_id, Orders.Amount FROM Customers
INNER JOIN Orders 
ON Customers.Customer_id=Orders.Customer_id

SELECT Customers.Customer_Name, Orders.Amount FROM Customers
INNER JOIN Orders 
ON Customers.Customer_id=Orders.Customer_id
WHERE Orders.Amount<1000

SELECT Customers.Customer_Name,Customers.City,Orders.Order_id,Orders.Amount FROM Customers
INNER JOIN Orders 
ON Customers.Customer_id=Orders.Customer_id
WHERE Customers.City !='Kolkata'


SELECT Customer_Name, City, Customer_id, Amount, Order_Date FROM Customers
NATURAL JOIN Orders 
WHERE Customers.City !='Kolkata'

SELECT * FROM Customers
NATURAL JOIN Orders 

SELECT * FROM Customers
INNER JOIN Orders 
ON Customers.Customer_id=Orders.Customer_id

SELECT * FROM Customers
INNER JOIN Orders 
ON Customers.Customer_id=Orders.Customer_id
WHERE Orders.Amount between 500 AND 1200;

SELECT * FROM Customers
INNER JOIN Orders 
ON Customers.Customer_id=Orders.Customer_id
WHERE Orders.Amount>500 AND  Orders.Amount<1200;


SELECT * FROM Customers
INNER JOIN Orders 
ON Customers.Customer_id=Orders.Customer_id
INNER JOIN Payments
ON Orders.Order_id=Payments.Order_id
WHERE Payment_Method = 'UPI'
ORDER BY Orders.Customer_id;


SELECT * FROM Customers
INNER JOIN Orders 
ON Customers.Customer_id=Orders.Customer_id
INNER JOIN Payments
ON Orders.Order_id=Payments.Order_id
ORDER BY Orders.Amount DESC;


SELECT * FROM Customers
SELECT * FROM Orders
SELECT * FROM Payments

SELECT Payment_method, Sum(Amount) as Total_Sum FROM Payments
INNER JOIN Orders 
ON Orders.Order_id=Payments.Order_id
GROUP BY Payment_Method
ORDER BY  Total_Sum  DESC;

SELECT * FROM Customers
LEFT JOIN Orders 
ON Customers.Customer_id=Orders.Customer_id


SELECT * FROM Customers
RIGHT JOIN Orders 
ON Customers.Customer_id=Orders.Customer_id


SELECT * FROM Customers
FULL JOIN Orders 
ON Customers.Customer_id=Orders.Customer_id

SELECT * FROM Customers
CROSS JOIN Orders 


SELECT * FROM Orders
CROSS JOIN Customers 
Where Orders.Order_id IN (102,103)
ORDER BY Orders.Order_id


SELECT * FROM Orders
CROSS JOIN Customers CROSS JOIN Payments

--Subsquery--

SELECT Order_id from Orders
WHERE Amount<(Select avg(Amount) From Orders);

---HAVING CLAUSE----

Select * from Sales

SELECT Product_Category, Sum(Total_Revenue) as Totals FROM Sales
Group by  Product_Category
Having Sum(Total_Revenue)>10000;

SELECT Product_Category, Sum(Total_Revenue) as Totals FROM Sales
Where Total_Revenue>500
Group by  Product_Category
Having Sum(Total_Revenue)>10000;








