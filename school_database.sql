-- Temporary Classroom table, for local testing only.
-- Delete this block once Member B's real Classroom table is merged in.
CREATE TABLE Classroom (
    classroom_id INT PRIMARY KEY AUTO_INCREMENT,
    room_number  VARCHAR(10),
    building     VARCHAR(50),
    capacity     INT
);

INSERT INTO Classroom (room_number, building, capacity) VALUES
('101', 'Building A', 30),
('102', 'Building A', 25),
('201', 'Building B', 40);

-- Member A's table: Students
CREATE TABLE Students (
    student_id      INT PRIMARY KEY AUTO_INCREMENT,
    name            VARCHAR(100),
    email           VARCHAR(100),
    classroom_id    INT,
    enrollment_date DATE,
    FOREIGN KEY (classroom_id) REFERENCES Classroom(classroom_id)
);

INSERT INTO Students (name, email, classroom_id, enrollment_date) VALUES
('A. Umugwanez', 'a.umugwanez@alustudent.com', 1, '2026-01-15'),
('M. Isaac',      'm.isaac@alustudent.com',     1, '2026-01-15'),
('J. Mushumba',   'j.mushumba@alustudent.com',  2, '2026-01-16'),
('I. Gatete',     'i.gatete@alustudent.com',    2, '2026-01-16'),
('Zakhio',        'zakhio2007@gmail.com',       3, '2026-01-17');

-- Required individual queries
UPDATE Students SET email = 'a.umugwanez.new@alustudent.com' WHERE student_id = 1;

DELETE FROM Students WHERE student_id = 5;

SELECT * FROM Students WHERE classroom_id = 1;
