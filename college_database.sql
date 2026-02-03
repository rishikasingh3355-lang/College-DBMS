-- ===========================================
-- College Database Management System
-- Author: Rishika Singh
-- ===========================================

-- 1️⃣ Create Department Table
CREATE DATABASE college_db;
USE college_db;
CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL,
    hod VARCHAR(50)
);

-- 2️⃣ Create Teacher Table
CREATE TABLE Teacher (
    teacher_id INT PRIMARY KEY,
    teacher_name VARCHAR(50) NOT NULL,
    dept_id INT,
    email VARCHAR(50),
    phone VARCHAR(15),
    FOREIGN KEY (dept_id)
        REFERENCES Department(dept_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- 3️⃣ Create Course Table
CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50) NOT NULL,
    dept_id INT,
    teacher_id INT,
    credits INT,
    FOREIGN KEY (dept_id)
        REFERENCES Department(dept_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (teacher_id)
        REFERENCES Teacher(teacher_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- 4️⃣ Create Student Table
CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    dept_id INT,
    email VARCHAR(50),
    phone VARCHAR(15),
    year INT,
    FOREIGN KEY (dept_id)
        REFERENCES Department(dept_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- 5️⃣ Create Payment Table
CREATE TABLE Payment (
    payment_id INT PRIMARY KEY,
    student_id INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    payment_mode VARCHAR(20),
    FOREIGN KEY (student_id)
        REFERENCES Student(student_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- ===========================================
-- Insert Sample Data
-- ===========================================

-- Department Data
INSERT INTO Department VALUES
(1, 'Computer Science', 'Dr. A. Sharma'),
(2, 'Mechanical', 'Dr. B. Verma'),
(3, 'Electrical', 'Dr. C. Singh');

-- Teacher Data
INSERT INTO Teacher VALUES
(101, 'Mr. Raj', 1, 'raj@college.com', '9876543210'),
(102, 'Ms. Priya', 2, 'priya@college.com', '9876543211'),
(103, 'Dr. Kiran', 3, 'kiran@college.com', '9876543212');

-- Course Data
INSERT INTO Course VALUES
(201, 'Data Structures', 1, 101, 4),
(202, 'Thermodynamics', 2, 102, 3),
(203, 'Electrical Circuits', 3, 103, 3);

-- Student Data
INSERT INTO Student VALUES
(301, 'Rishika Singh', 1, 'rishika@college.com', '9000000001', 2),
(302, 'Amit Kumar', 2, 'amit@college.com', '9000000002', 3),
(303, 'Sneha Sharma', 3, 'sneha@college.com', '9000000003', 1);

-- Payment Data
INSERT INTO Payment VALUES
(401, 301, 50000, '2026-01-10', 'Online'),
(402, 302, 45000, '2026-01-12', 'Card'),
(403, 303, 40000, '2026-01-15', 'Cash');

-- ===========================================
-- Sample Queries to Test Database
-- ===========================================

-- 1. List all students with department names
SELECT s.student_name, d.dept_name
FROM Student s
JOIN Department d ON s.dept_id = d.dept_id;

-- 2. List all courses with teacher names
SELECT c.course_name, t.teacher_name
FROM Course c
JOIN Teacher t ON c.teacher_id = t.teacher_id;

-- 3. Find total payments collected
SELECT SUM(amount) AS total_fees FROM Payment;

-- 4. Count students per department
SELECT d.dept_name, COUNT(s.student_id) AS total_students
FROM Department d
LEFT JOIN Student s ON d.dept_id = s.dept_id
GROUP BY d.dept_name;

-- 5. Students who paid more than 45000
SELECT s.student_name, p.amount
FROM Student s
JOIN Payment p ON s.student_id = p.student_id
WHERE p.amount > 45000;
