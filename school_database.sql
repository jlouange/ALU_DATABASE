-- =========================================
-- Create Database
-- =========================================

CREATE DATABASE IF NOT EXISTS alu_school_db;
USE alu_school_db;

-- =========================================
-- Development Reset
-- Drops existing tables to avoid
-- duplicate data and "table already exists"
-- =========================================
DROP TABLE IF EXISTS Student_Activities;
DROP TABLE IF EXISTS Student_Courses;
DROP TABLE IF EXISTS Extra_Curricular_Activities;
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Faculty;
DROP TABLE IF EXISTS Classroom;

-- =========================================
-- Member B - Classroom
-- =========================================

CREATE TABLE Classroom (
    classroom_id INT PRIMARY KEY AUTO_INCREMENT,
    room_number VARCHAR(10),
    building VARCHAR(50),
    capacity INT
);

INSERT INTO Classroom (room_number, building, capacity)
VALUES
('101', 'Building A', 30),
('102', 'Building A', 25),
('201', 'Building B', 40);

-- =========================================
-- Member A - Students
-- =========================================

CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    classroom_id INT,
    enrollment_date DATE,
    FOREIGN KEY (classroom_id) REFERENCES Classroom(classroom_id)
);

INSERT INTO Students (name, email, classroom_id, enrollment_date)
VALUES
('Alice Uwase', 'alice.uwase@gmail.com', 1, '2026-01-15'),
('Brian Mugisha', 'brian.mugisha@gmail.com', 1, '2026-01-15'),
('Chantal Ingabire', 'chantal.ingabire@gmail.com', 2, '2026-01-16'),
('David Niyonzima', 'david.niyonzima@gmail.com', 2, '2026-01-16'),
('Esther Umutoni', 'esther.umutoni@gmail.com', 3, '2026-01-17');

-- Member A - UPDATE
UPDATE Students
SET email = 'alice.uwase@alustudent.com'
WHERE student_id = 1;

-- Member A - DELETE
DELETE FROM Students
WHERE student_id = 5;

-- Member A - SELECT
SELECT *
FROM Students
WHERE classroom_id = 1;

-- =========================================
-- Member C - Faculty
-- =========================================

CREATE TABLE Faculty (
    faculty_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    department VARCHAR(50)
);

INSERT INTO Faculty (name, email, department)
VALUES
('King James', 'kingjames@yahoo.com', 'Musical Arts'),
('Jackie Chan', 'jackiechan@sony.com', 'Cinematography'),
('JP Morgan', 'jpmorgan@business.org', 'Finance'),
('Joma Tech', 'jomatech@linux.com', 'Computer Science'),
('Lukuzu Lokozo', 'lukux@health.to', 'Health');

UPDATE Faculty
SET email = 'lukuzu2019@gmail.com'
WHERE name = 'Lukuzu Lokozo';

DELETE FROM Faculty
WHERE faculty_id = 3;

SELECT *
FROM Faculty
WHERE faculty_id = 2;