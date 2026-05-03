
TRUNCATE TABLE Health_Records;
DROP TABLE Health_Records
--------------------------
CREATE TABLE Customers_Details(
person_id INTEGER primary key,
age integer,
gender varchar(10),
region varchar(50),
urban_rural varchar(50),
income numeric(10,2),
education varchar(50),
marital_status varchar(50)
);


---------------------
CREATE TABLE Health_Records(
person_id INTEGER primary key,
bmi numeric(10,2),
smoker varchar(10),
chronic_count numeric,
hypertension  Varchar(10),
diabetes  Varchar(10)
);


-------------------------------
CREATE TABLE Policy_Details(
person_id Integer primary key,
plan_type  Varchar(10),
network_tier  Varchar(10),
annual_medical_cost numeric(10,2),
annual_premium numeric(10,2),
total_claims_paid numeric(10,2)
);


-------------------------------

SELECT * FROM  Policy_Details;
SELECT * FROM  Health_Records;
SELECT * FROM  Customers_Details;
--------------------------------------------------------------------------------------------
--Top-selling plan in each region with total sales.

SELECT region, plan_type, total_s
FROM (
    SELECT 
        c.region,
        p.plan_type,
        COUNT(*) AS total_s,
        RANK() OVER (
            PARTITION BY c.region
            ORDER BY COUNT(*) DESC
        ) AS rnk
    FROM Customers_Details c
    INNER JOIN Policy_Details p
        ON c.person_id = p.person_id
    GROUP BY c.region, p.plan_type
) t
WHERE rnk = 1;
--------------------------------------------------------------------------------------------
--Find average medical cost per plan_type.

SELECT plan_type, Round(avg(annual_medical_cost) ) AS Avg_Medical_cost
from Policy_Details
GROUP BY plan_type
ORDER BY Avg_Medical_cost
-----------------------------------------------------------------------------------------------
--Which region is most profitable (premium – claims)?

SELECT 
    c.region,
    SUM(p.annual_premium) AS total_premium,
    SUM(p.total_claims_paid) AS total_claim,
    SUM(p.annual_premium) - SUM(p.total_claims_paid) AS total_profit
FROM Policy_Details p
JOIN customers_details c
    ON p.person_id = c.person_id
GROUP BY c.region
ORDER BY total_profit DESC
LIMIT 1;
---------------------------------------------------------------------------------------------------
--Calculate average income per region using window function.

SELECT 
    region,
    income,
    ROUND(AVG(income) OVER (PARTITION BY region), 2) AS avg_income_per_region
FROM Customers_Details;


------------------------------------------------------------
--Find users where:
--income is low (<30k) but
--medical cost is high (>50k)
	 
SELECT 
     c.person_id,
	 c.income,
	 p.annual_medical_cost
FROM Customers_Details c
INNER JOIN Policy_Details p
ON p.person_id=c.person_id
     WHERE c.income<30000 AND p.annual_medical_cost>50000
-------------------------------------------------------------
SELECT * FROM  Policy_Details;
SELECT * FROM  Health_Records;
SELECT * FROM  Customers_Details;

--Which demographic group:

--Pays highest premium?
SELECT 
      c.region,
	  SUM(p.annual_premium) as total_premium
FROM Customers_Details c
INNER JOIN Policy_Details p  
ON p.person_id=c.person_id
GROUP BY c.region
order by total_premium
limit 1;

--Has highest claims?

SELECT 
      c.region,
	  SUM(p.total_claims_paid) as total_pre
FROM Customers_Details c
INNER JOIN Policy_Details p  
ON p.person_id=c.person_id
GROUP BY c.region
order by total_pre
limit 1;
-------------------------------------------------


