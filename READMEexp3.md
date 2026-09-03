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

NORMALIZATION USED IN THIS DATABASE
OVERALL NORMALIZATION LEVEL: 3NF

DEPARTMENT TABLE
CODE:

CREATE TABLE department ( dept_id INT PRIMARY KEY, dept_name VARCHAR(50) UNIQUE NOT NULL );

NORMALIZATION:

1NF ✅

dept_id and dept_name contain atomic values.
There are no repeating groups.
2NF ✅

The primary key is dept_id.
All non-key attributes depend completely on dept_id.
3NF ✅

dept_name depends directly on dept_id.
There is no transitive dependency.
Therefore: Department table → 1NF ✅ 2NF ✅ 3NF ✅

STUDENT TABLE
CODE:

CREATE TABLE student ( roll_no INT PRIMARY KEY, name VARCHAR(50) NOT NULL, email VARCHAR(50) UNIQUE, aadhar_no VARCHAR(12) UNIQUE, dept_id INT, FOREIGN KEY (dept_id) REFERENCES department(dept_id) );

NORMALIZATION:

1NF ✅

All values are atomic.
Each student has a unique roll_no.
2NF ✅

The primary key is roll_no.
All other attributes depend completely on roll_no.
3NF ✅

Student details depend directly on roll_no.
Department information is not stored repeatedly.
dept_id is used as a foreign key to reference the department table.
Therefore: Student table → 1NF ✅ 2NF ✅ 3NF ✅

COURSE TABLE
CODE:

CREATE TABLE course ( course_id INT PRIMARY KEY, course_name VARCHAR(50) NOT NULL, dept_id INT, FOREIGN KEY (dept_id) REFERENCES department(dept_id) );

NORMALIZATION:

1NF ✅

All values are atomic.
Each course has a unique course_id.
2NF ✅

The primary key is course_id.
course_name and dept_id depend completely on course_id.
3NF ✅

Department information is stored separately.
dept_id references the Department table instead of storing dept_name repeatedly.
Therefore: Course table → 1NF ✅ 2NF ✅ 3NF ✅

ENROLLMENT TABLE
CODE:

CREATE TABLE enrollment ( roll_no INT, course_id INT, semester INT CHECK (semester BETWEEN 1 AND 8), grade CHAR(2),

PRIMARY KEY (roll_no, course_id, semester),

FOREIGN KEY (roll_no) REFERENCES student(roll_no),
FOREIGN KEY (course_id) REFERENCES course(course_id)
);

NORMALIZATION:

1NF ✅

All values are atomic.
There are no repeating groups.
2NF ✅

The table has a composite primary key:

(roll_no, course_id, semester)

grade depends on the complete combination of: roll_no + course_id + semester.

There is no partial dependency.

3NF ✅

grade depends directly on the complete primary key.
There are no non-key attributes depending on another non-key attribute.
Therefore: Enrollment table → 1NF ✅ 2NF ✅ 3NF ✅

IMPORTANT: The Enrollment table is the main example of 2NF because it uses a composite primary key.

FACULTY TABLE
CODE:

CREATE TABLE faculty ( faculty_id INT PRIMARY KEY, faculty_name VARCHAR(50) NOT NULL, email VARCHAR(50) UNIQUE, phone_no VARCHAR(15) UNIQUE, dept_id INT, FOREIGN KEY (dept_id) REFERENCES department(dept_id) );

NORMALIZATION:

1NF ✅

All values are atomic.
Each faculty member has a unique faculty_id.
2NF ✅

The primary key is faculty_id.
All non-key attributes depend completely on faculty_id.
3NF ✅

Faculty details depend directly on faculty_id.
Department details are stored in the Department table.
dept_id is used as a foreign key.
Therefore: Faculty table → 1NF ✅ 2NF ✅ 3NF ✅

WHY 3NF IS USED
Instead of storing department information repeatedly:

Student: 101 | Milisha | Computer Science

Course: 501 | DBMS | Computer Science

Faculty: 201 | Dr. Sharma | Computer Science

The database stores the department only once:

Department: 1 | Computer Science

And other tables store:

dept_id = 1

This reduces data redundancy and prevents update anomalies.

NORMALIZATION SUMMARY
Table 1NF 2NF 3NF
Department ✅ ✅ ✅ Student ✅ ✅ ✅ Course ✅ ✅ ✅ Enrollment ✅ ✅ ✅ Faculty ✅ ✅ ✅

FINAL RESULT
1NF → USED ✅ 2NF → USED ✅ 3NF → USED ✅

4NF → NOT SPECIFICALLY REQUIRED ❌ 5NF → NOT SPECIFICALLY REQUIRED ❌

Overall Normalization Level → 3NF

DATABASE INDEXING AND B+TREE TRAVERSAL

Traversal

Traversal is the process of visiting or searching elements in a data structure according to a specific path or order. In database systems, traversal is important when searching indexed data because the database can navigate through a tree structure instead of checking every record sequentially.

For example, without an appropriate index, searching for a particular department may require scanning multiple rows of the "student4" table. With an index, the database can navigate through the index structure to locate the required values more efficiently.

B-Tree and B+Tree

A B-Tree (Balanced Tree) is a tree-based data structure designed to keep data balanced and support efficient searching, insertion, and deletion.

A B+Tree is a variation of the B-Tree that is widely used for database indexes. Internal nodes primarily guide the search, while the leaf nodes contain the indexed entries. The leaf nodes are linked, making sequential and range-based traversal efficient.

Conceptually:

             Root
          [30 | 60 | 90]
         /    |    |    \
        ↓     ↓    ↓     ↓
    [10 20] [30 40] [60 70] [90 100]
         ↔       ↔       ↔
The tree remains balanced, allowing the database to reach the required indexed value using a relatively small number of tree levels.

Indexing Used in This Project

The project creates an index on the "dept_id" column of the "student4" table:

CREATE INDEX idx_student_dept ON student4(dept_id);

Here:

"idx_student_dept" is the name of the index.
"student4" is the table on which the index is created.
"dept_id" is the column being indexed.
The index creates a tree-based structure for the "dept_id" values. When a query searches or filters using "dept_id", MySQL can use the index to efficiently locate the relevant records.

For example:

SELECT * FROM student4 WHERE dept_id = 2;

The conceptual process is:

SQL Query ↓ B+Tree Index ↓ Index Traversal ↓ Locate dept_id = 2 ↓ Locate corresponding student record ↓ Return Result

Why Indexing is Used

The main purpose of indexing is to improve the efficiency of data retrieval.

Without an index:

Table Scan ↓ Check records one by one ↓ Find matching record

With an index:

B+Tree Index ↓ Navigate through tree ↓ Find indexed value ↓ Access required record

This becomes especially beneficial when a table contains a large number of records.

Index Verification

The created index can be verified using:

SHOW INDEX FROM student4;

The output should contain the index:

idx_student_dept

Techniques Demonstrated

This project demonstrates the following database concepts:

Database Creation – Creating the "college_demo" database.
Relational Table Design – Creating department, student, faculty, course, and enrollment tables.
Primary Keys – Uniquely identifying records.
Foreign Keys – Establishing relationships between tables.
Unique Constraints – Preventing duplicate values.
NOT NULL Constraints – Ensuring required fields contain values.
CHECK Constraints – Restricting semester values from 1 to 8.
Composite Primary Key – Using "(roll_no, course_id, semester)" in the enrollment table.
Database Indexing – Creating an index on "student4.dept_id".
B+Tree-Based Index Traversal – Using the tree-based index structure for efficient searching.
SQL Data Retrieval – Using "SELECT" statements to retrieve table data.
Conclusion

The project demonstrates how a relational college database can be enhanced using indexing. The "idx_student_dept" index on "student4(dept_id)" demonstrates the concept of tree-based index traversal, where the database can navigate an organized B+Tree-style index to locate matching values efficiently. Indexing becomes increasingly useful as the number of records in a database grows.
