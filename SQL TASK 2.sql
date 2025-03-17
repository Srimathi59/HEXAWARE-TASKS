CREATE DATABASE company_db;
USE company_db;

CREATE TABLE departments (
    dept_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    dept_id INT,
    join_date DATE NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id) ON DELETE CASCADE
);

select * from departments;
select * from employees;

INSERT INTO departments (dept_name) VALUES 
('HR'),
('Finance'),
('IT'),
('Marketing'),
('Operations');

INSERT INTO employees (first_name, last_name, email, salary, dept_id, join_date) VALUES
('Amit', 'Sharma', 'amit.sharma@example.com', 75000, 1, '2023-06-15'),
('Priya', 'Verma', 'priya.verma@example.com', 88000, 2, '2021-09-20'),
('Rajesh', 'Gupta', 'rajesh.gupta@example.com', 96000, 3, '2022-12-05'),
('Neha', 'Reddy', 'neha.reddy@example.com', 73000, 4, '2020-08-10'),
('Vikram', 'Patel', 'vikram.patel@example.com', 99000, 5, '2021-11-25'),
('Kiran', 'Joshi', 'kiran.joshi@example.com', 81000, 3, '2023-04-12'),
('Arjun', 'Singh', 'arjun.singh@example.com', 89000, 4, '2019-05-18');

-- SUBQUERY TASKS
-- 1. Find employees who earn more than the average salary in their department.
SELECT first_name, last_name, salary, dept_id
FROM employees
WHERE salary > (
    SELECT AVG(salary) FROM employees WHERE dept_id = employees.dept_id
);

-- 2. Find employees who work in the same department as 'Rajesh Gupta'
SELECT first_name, last_name, dept_id
FROM employees
WHERE dept_id = (
    SELECT dept_id FROM employees WHERE first_name = 'Rajesh' AND last_name = 'Gupta'
);

-- 3. Find employees who joined after the earliest join date in the IT department.
SELECT first_name, last_name, join_date
FROM employees
WHERE join_date > (
    SELECT MIN(join_date) FROM employees WHERE dept_id = (
        SELECT dept_id FROM departments WHERE dept_name = 'IT'
    )
);

-- 4. Find the department with the highest average salary.
SELECT dept_name 
FROM departments d
WHERE d.dept_id = (
    SELECT dept_id
    FROM employees
    GROUP BY dept_id
    ORDER BY AVG(salary) DESC
    LIMIT 1
);

-- 5. Retrieve the employee(s) with the second-highest salary.
SELECT * FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE salary < (SELECT MAX(salary) FROM employees)
);

-- INLINE QUERY TASKS

-- 6. Get a list of employees along with their department names.
SELECT e.*, d.dept_name 
FROM employees e 
JOIN departments d ON e.dept_id = d.dept_id;


-- 7. Display each employee's salary and show whether it is above or below the company's average salary.
SELECT e.*, 
       CASE WHEN e.salary > (SELECT AVG(salary) FROM employees) 
            THEN 'Above Average' 
            ELSE 'Below Average' 
       END AS salary_status 
FROM employees e;

-- 8. Show employee details along with the count of employees in their department.
SELECT e.*, 
       (SELECT COUNT(*) FROM employees WHERE dept_id = e.dept_id) AS dept_employee_count 
FROM employees e;

-- 9. Retrieve employees sorted by their department's total salary expenditure.
SELECT e.*, 
       (SELECT SUM(salary) FROM employees WHERE dept_id = e.dept_id) AS total_dept_salary 
FROM employees e 
ORDER BY total_dept_salary DESC;


-- 10. Find the top 3 highest-paid employees in each department.
SELECT * FROM (
    SELECT e.*, 
           RANK() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS rank_in_dept 
    FROM employees e
) ranked 
WHERE rank_in_dept <= 3;