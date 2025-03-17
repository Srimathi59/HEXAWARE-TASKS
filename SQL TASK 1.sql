-- 1. Create a database
CREATE DATABASE school_db;
USE school_db;

-- 2. Create the students table
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    age INT NOT NULL,
    grade VARCHAR(10) NOT NULL,
    enrollment_date DATE NOT NULL
);

-- 3. Insert at least 5 records
INSERT INTO students (first_name, last_name, email, age, grade, enrollment_date) VALUES
('John', 'Doe', 'john.doe@example.com', 16, 'A', '2024-02-10'),
('Emma', 'Smith', 'emma.smith@example.com', 14, 'B+', '2023-12-05'),
('Harry', 'Potter', 'harry.potter@example.com', 17, 'A-', '2024-01-15'),
('Olivia', 'Johnson', 'olivia.johnson@example.com', 15, 'B', '2023-08-20'),
('Noah', 'Davis', 'noah.davis@example.com', 18, 'A+', '2024-03-01');

-- 4. Retrieve all student details
SELECT * FROM students;

-- 5. Retrieve students whose age is greater than 15
SELECT * FROM students WHERE age > 15;

-- 6. Update the grade of a student whose id is 3 to 'A+'
UPDATE students SET grade = 'A+' WHERE id = 3;

-- 7. Delete a student record whose id is 5
DELETE FROM students 
WHERE id = 5;

-- 8. Verify changes after each operation
SELECT * FROM students;

-- Retrieve students who enrolled in the last 6 months
SELECT * FROM students 
WHERE enrollment_date >= DATE_SUB('2024-03-17', INTERVAL 6 MONTH);

-- Retrieve students sorted by grade in descending order
SELECT * FROM students ORDER BY FIELD(grade, 'A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D', 'F') DESC;

