-- Asked to open onecompiler.com and add the below schema to the init.sql file

-- Create departments table 
CREATE TABLE departments ( 
id INT AUTO_INCREMENT PRIMARY KEY, 
name VARCHAR(100) 
); 

-- Insert sample data into departments table 
INSERT INTO departments (name) VALUES 
('IT'), 
('HR'), 
('Finance'), 
('Marketing'), 
('Operations'); 

-- Create employees table 
CREATE TABLE employees ( 
id INT AUTO_INCREMENT PRIMARY KEY, 
name VARCHAR(100), 
age INT, 
department_id INT, 
joining_date DATE, 
FOREIGN KEY (department_id) REFERENCES departments(id) 
); 

-- Insert sample data into employees table with 10000 employees 
INSERT INTO employees (name, age, department_id, joining_date) 
SELECT 
CONCAT('Employee', numbers.number), 
25 + MOD((tens.a-1) * 10 + (hundreds.a-1) * 100 + numbers.number*numbers.number, 30), -- age between 25 and 54 
1 + MOD((tens.a-1) * 10 + (hundreds.a-1) * 100 + numbers.number, 5), -- department_id between 1 and 5 
DATE_SUB(CURDATE(), INTERVAL (tens.a-1) * 10 + (hundreds.a-1) * 100 + numbers.number DAY) -- joining_date within the last year 
FROM 
(SELECT 1 AS number 
UNION ALL SELECT 2 
UNION ALL SELECT 3 
UNION ALL SELECT 4 
UNION ALL SELECT 5 
UNION ALL SELECT 6 
UNION ALL SELECT 7 
UNION ALL SELECT 8 
UNION ALL SELECT 9 
UNION ALL SELECT 10) AS numbers 
CROSS JOIN 
(SELECT 1 AS a 
UNION ALL SELECT 2 
UNION ALL SELECT 3 
UNION ALL SELECT 4 
UNION ALL SELECT 5 
UNION ALL SELECT 6 
UNION ALL SELECT 7 
UNION ALL SELECT 8 
UNION ALL SELECT 9 
UNION ALL SELECT 10) AS tens 
CROSS JOIN 
(SELECT 1 AS a 
UNION ALL SELECT 2 
UNION ALL SELECT 3 
UNION ALL SELECT 4 
UNION ALL SELECT 5 
UNION ALL SELECT 6 
UNION ALL SELECT 7 
UNION ALL SELECT 8 
UNION ALL SELECT 9 
UNION ALL SELECT 10) AS hundreds; 

---------------------------------------------------------------------------------------------------------------------------------------------

--Questions: 


-- Write a query to calculate the average age of employees in each department.


SELECT distinct(dpt.name) as department_name, AVG(emp.age) OVER(PARTITION BY dpt.name) as avg_age
FROM employees emp 
JOIN departments dpt 
ON emp.department_id = dpt.id;


-- Write a query to find the department with the highest number of employees whose age is
-- above 40.


SELECT dpt.name, count(emp.age) as emp_age
FROM employees emp 
JOIN departments dpt 
ON emp.department_id = dpt.id
WHERE emp.age > 40
GROUP BY dpt.name;


-- Write a query to retrieve the count of employees who have in joined in last 100 days.

SELECT DISTINCT name, department_id
FROM employees
WHERE DATEDIFF(CURRENT_DATE, joining_date) <= 100;


-- Write a query to update the joining date of all employees in the HR department to the
-- yesterday.


UPDATE employees e
JOIN departments d ON e.department_id = d.id
SET e.joining_date = CURRENT_DATE - INTERVAL 1 DAY
WHERE d.name = 'HR';


-- Write a query to retrieve the count of employees who have in joined in last 100 days.

SELECT DISTINCT name, department_id
FROM employees
WHERE DATEDIFF(CURRENT_DATE, joining_date) <= 100

