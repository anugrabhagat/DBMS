// FOR CREATING TABLE //
CREATE DATABASE college_demo;
USE college_demo;

CREATE TABLE department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE student (
    roll_no INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE,
    aadhar_no VARCHAR(12) UNIQUE,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

CREATE TABLE course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50) NOT NULL,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

CREATE TABLE enrollment (
    roll_no INT,
    course_id INT,
    semester INT CHECK (semester BETWEEN 1 AND 8),
    grade CHAR(2),
    PRIMARY KEY (roll_no, course_id, semester),
    FOREIGN KEY (roll_no) REFERENCES student(roll_no),
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);

// FOR ADDING ELEMENTS INTO THE TABLE //
INSERT INTO department VALUES
(1, 'Computer Science'),
(2, 'Electronics');

INSERT INTO student VALUES
(101, 'Milisha', 'milisha@gmail.com', '123456789012', 1),
(102, 'Rahul', 'rahul@gmail.com', '987654321098', 2);

INSERT INTO course VALUES
(501, 'DBMS', 1),
(502, 'Circuits', 2);

INSERT INTO enrollment VALUES
(101, 501, 3, 'A');

INSERT INTO enrollment VALUES
(101, 502, 3, 'B');

// FOR opening the old table //
SHOW TABLES;
DESCRIBE student;
SHOW CREATE TABLE enrollment;
SELECT * FROM enrollment;

// FOR SHOWING THE CREATED TABLE OUTPUTS //
SELECT * FROM department;
SELECT * FROM student;
SELECT * FROM course;
SELECT * FROM enrollment;

// FOR ADDING FACULTY //
CREATE TABLE faculty (
    faculty_id INT PRIMARY KEY,
    faculty_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE,
    phone_no VARCHAR(15) UNIQUE,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

INSERT INTO faculty VALUES
(201, 'Dr. Sharma', 'sharma@gmail.com', '9876543210', 1),
(202, 'Prof. Mehta', 'mehta@gmail.com', '9876543211', 2);

SELECT * FROM faculty;

CREATE INDEX idx_student_dept ON student(dept_id);
EXPLAIN SELECT * FROM student WHERE dept_id = 1;
