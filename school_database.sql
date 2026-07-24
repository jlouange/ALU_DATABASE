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
('201', 'Building B', 40),
('202', 'Building B', 35),
('301', 'Building C', 20);

UPDATE Classroom 
SET capacity = 32
WHERE room_number = '101';

DELETE FROM Classroom
WHERE room_number = '301';

SELECT *
FROM Classroom
WHERE building = 'Building A';

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
-- Verified: all 5 rows inserted correctly,
-- UPDATE/DELETE/SELECT confirmed against
-- current Faculty table state.
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
-- Member C - additional verification query
SELECT faculty_id, name, department
FROM Faculty
WHERE department IN ('Computer Science', 'Health');

-- ============================================
-- Member D - Courses
-- ============================================

CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100),
    credits INT,
    faculty_id INT,
    classroom_id INT,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(faculty_id),
    FOREIGN KEY (classroom_id) REFERENCES Classroom(classroom_id)
);

INSERT INTO Courses (course_name, credits, faculty_id, classroom_id)
VALUES
('Introduction to Programming', 3, 1, 1),
('Calculus I', 4, 2, 2),
('World History', 3, 1, 3),
('Database Systems', 3, 2, 1),
('English Composition', 3, 1, 2),
('Physics I', 4, 2, 3);

UPDATE Courses
SET credits = 4
WHERE course_name = 'World History';

DELETE FROM Courses
WHERE course_name = 'Physics I';

SELECT *
FROM Courses
WHERE credits >= 4;

-- ============================================
-- Member E - Extra_Curricular_Activities
-- ============================================

CREATE TABLE Extra_Curricular_Activities (
    activity_id INT PRIMARY KEY AUTO_INCREMENT,
    activity_name VARCHAR(100),
    category VARCHAR(50),
    faculty_advisor_id INT,
    FOREIGN KEY (faculty_advisor_id) REFERENCES Faculty(faculty_id)
);

INSERT INTO Extra_Curricular_Activities
(activity_name, category, faculty_advisor_id)
VALUES
('Football Club', 'Sports', 1),
('Drama Club', 'Arts', 2),
('Coding Club', 'Technology', 4),
('Debate Club', 'Academic', 2),
('Health Awareness Club', 'Health', 5);

UPDATE Extra_Curricular_Activities
SET category = 'STEM'
WHERE activity_name = 'Coding Club';

DELETE FROM Extra_Curricular_Activities
WHERE activity_id = 5;

SELECT *
FROM Extra_Curricular_Activities
WHERE category = 'Sports';


-- =========================================
-- Member E - Student_Courses (junction table)
-- =========================================
CREATE TABLE Student_Courses (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

INSERT INTO Student_Courses
VALUES
(1,1),
(1,2),
(2,1),
(3,3),
(4,4);

-- =========================================
-- Member E - Student_Activities (junction table)
-- =========================================
CREATE TABLE Student_Activities (
    student_id INT,
    activity_id INT,
    PRIMARY KEY (student_id, activity_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (activity_id) REFERENCES Extra_Curricular_Activities(activity_id)
);

INSERT INTO Student_Activities
VALUES
(1,1),
(1,3),
(2,2),
(3,4),
(4,1);



-- =========================================
-- GROUP TASK 1: Relationships check
-- Confirms every foreign key points to a valid
-- primary key in another table. Each query should
-- return zero rows if the data is clean.
-- =========================================
SELECT s.student_id, s.classroom_id
FROM Students s
LEFT JOIN Classroom c ON s.classroom_id = c.classroom_id
WHERE c.classroom_id IS NULL;

SELECT co.course_id, co.faculty_id
FROM Courses co
LEFT JOIN Faculty f ON co.faculty_id = f.faculty_id
WHERE f.faculty_id IS NULL;

SELECT co.course_id, co.classroom_id
FROM Courses co
LEFT JOIN Classroom c ON co.classroom_id = c.classroom_id
WHERE c.classroom_id IS NULL;

SELECT a.activity_id, a.faculty_advisor_id
FROM Extra_Curricular_Activities a
LEFT JOIN Faculty f ON a.faculty_advisor_id = f.faculty_id
WHERE f.faculty_id IS NULL;

SELECT sc.student_id, sc.course_id
FROM Student_Courses sc
LEFT JOIN Students s ON sc.student_id = s.student_id
LEFT JOIN Courses c ON sc.course_id = c.course_id
WHERE s.student_id IS NULL OR c.course_id IS NULL;

SELECT sa.student_id, sa.activity_id
FROM Student_Activities sa
LEFT JOIN Students s ON sa.student_id = s.student_id
LEFT JOIN Extra_Curricular_Activities a ON sa.activity_id = a.activity_id
WHERE s.student_id IS NULL OR a.activity_id IS NULL;

/*
GROUP TASK 2: Normalization check
No table repeats data that belongs elsewhere. Students, Courses, and
Extra_Curricular_Activities reference Classroom and Faculty by ID rather
than duplicating room or professor details inline, so a change to a
classroom or faculty member only needs to happen in one place. The
many-to-many relationships between students and courses, and between
students and activities, are handled through Student_Courses and
Student_Activities junction tables, each using a composite primary key
of the two foreign keys, rather than repeating full student records
once per enrollment or flattening the relationship into repeating
columns on the Students table.
*/

-- =========================================
-- GROUP TASK 3: Join queries
-- =========================================

-- "Student X is enrolled in Course Y, taught by Faculty Z, in Classroom W"
SELECT
    s.name AS Student,
    c.course_name AS Course,
    f.name AS Faculty,
    cl.room_number AS Classroom
FROM Students s
JOIN Student_Courses sc ON s.student_id = sc.student_id
JOIN Courses c ON sc.course_id = c.course_id
JOIN Faculty f ON c.faculty_id = f.faculty_id
JOIN Classroom cl ON c.classroom_id = cl.classroom_id;

-- "Student X participates in Activity Y, advised by Faculty Z"
SELECT
    s.name AS Student,
    a.activity_name AS Activity,
    f.name AS Faculty_Advisor
FROM Students s
JOIN Student_Activities sa ON s.student_id = sa.student_id
JOIN Extra_Curricular_Activities a ON sa.activity_id = a.activity_id
JOIN Faculty f ON a.faculty_advisor_id = f.faculty_id;


-- Last join query: student, classroom/building, and enrolled course together
SELECT
    s.name AS Student,
    cl.building,
    cl.room_number,
    c.course_name AS Course
FROM Students s
JOIN Classroom cl ON s.classroom_id = cl.classroom_id
JOIN Student_Courses sc ON s.student_id = sc.student_id
JOIN Courses c ON sc.course_id = c.course_id;

-- =========================================
-- GROUP TASK 4: Aggregate query
-- =========================================
SELECT
    c.course_name,
    COUNT(sc.student_id) AS Number_of_Students
FROM Courses c
LEFT JOIN Student_Courses sc ON c.course_id = sc.course_id
GROUP BY c.course_name;