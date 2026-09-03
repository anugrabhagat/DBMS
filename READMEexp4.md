// FOR CREATING TABLE //

CREATE DATABASE hospital_demo;
USE hospital_demo;

CREATE TABLE department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE doctor (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE,
    phone_no VARCHAR(15) UNIQUE,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

CREATE TABLE patient (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(50) NOT NULL,
    age INT CHECK (age > 0),
    gender VARCHAR(10),
    phone_no VARCHAR(15) UNIQUE
);

CREATE TABLE room (
    room_id INT PRIMARY KEY,
    room_type VARCHAR(30) NOT NULL,
    room_no INT UNIQUE,
    patient_id INT,
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

CREATE TABLE appointment (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    reason VARCHAR(100),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id)
);

// FOR ADDING ELEMENTS INTO THE TABLE //

INSERT INTO department VALUES
(1, 'Cardiology'),
(2, 'Neurology'),
(3, 'Orthopedics');

INSERT INTO doctor VALUES
(201, 'Dr. Sarthak', 'sarthak@hospital.com', '9876543210', 1),
(202, 'Dr. Tiwari', 'tiwari@hospital.com', '9876543211', 2),
(203, 'Dr. Rai', 'rai@hospital.com', '9876543212', 3);

INSERT INTO patient VALUES
(101, 'Rahul', 25, 'Male', '9123456780'),
(102, 'Priya', 30, 'Female', '9123456781'),
(103, 'Amit', 40, 'Male', '9123456782');

INSERT INTO room VALUES
(301, 'General', 101, 101),
(302, 'Private', 102, 102),
(303, 'ICU', 103, 103);

INSERT INTO appointment VALUES
(401, 101, 201, '2026-08-20', 'Chest pain'),
(402, 102, 202, '2026-08-21', 'Headache'),
(403, 103, 203, '2026-08-22', 'Knee pain');

// FOR OPENING THE OLD TABLE //

SHOW TABLES;
DESCRIBE doctor;
SHOW CREATE TABLE appointment;
SELECT * FROM appointment;

// FOR SHOWING THE CREATED TABLE OUTPUTS //
  
SELECT * FROM department;
SELECT * FROM doctor;
SELECT * FROM patient;
SELECT * FROM room;

SELECT * FROM appointment;
NORMALIZATION USED IN THIS HOSPITAL DATABASE
OVERALL NORMALIZATION LEVEL: 3NF

DEPARTMENT TABLE
CODE:

CREATE TABLE department ( dept_id INT PRIMARY KEY, dept_name VARCHAR(50) UNIQUE NOT NULL );

NORMALIZATION:

1NF ✅

dept_id and dept_name contain atomic values.
There are no repeating groups.
Each department has a unique dept_id.
2NF ✅

The primary key is dept_id.
dept_name depends completely on dept_id.
3NF ✅

dept_name depends directly on dept_id.
There is no transitive dependency.
Therefore: Department table → 1NF ✅ 2NF ✅ 3NF ✅

DOCTOR TABLE
CODE:

CREATE TABLE doctor ( doctor_id INT PRIMARY KEY, doctor_name VARCHAR(50) NOT NULL, email VARCHAR(50) UNIQUE, phone_no VARCHAR(15) UNIQUE, dept_id INT, FOREIGN KEY (dept_id) REFERENCES department(dept_id) );

NORMALIZATION:

1NF ✅

All values are atomic.
Each doctor has a unique doctor_id.
2NF ✅

The primary key is doctor_id.
All other attributes depend completely on doctor_id.
3NF ✅

Doctor details depend directly on doctor_id.
Department information is not repeated in the doctor table.
dept_id is used as a foreign key to reference the department table.
Therefore: Doctor table → 1NF ✅ 2NF ✅ 3NF ✅

PATIENT TABLE
CODE:

CREATE TABLE patient ( patient_id INT PRIMARY KEY, patient_name VARCHAR(50) NOT NULL, age INT CHECK (age > 0), gender VARCHAR(10), phone_no VARCHAR(15) UNIQUE );

NORMALIZATION:

1NF ✅

All values are atomic.
Each patient has a unique patient_id.
There are no repeating groups.
2NF ✅

The primary key is patient_id.
All patient attributes depend completely on patient_id.
3NF ✅

Patient name, age, gender, and phone number depend directly on patient_id.
There are no transitive dependencies.
Therefore: Patient table → 1NF ✅ 2NF ✅ 3NF ✅

ROOM TABLE
CODE:

CREATE TABLE room ( room_id INT PRIMARY KEY, room_type VARCHAR(30) NOT NULL, room_no INT UNIQUE, patient_id INT, FOREIGN KEY (patient_id) REFERENCES patient(patient_id) );

NORMALIZATION:

1NF ✅

All values are atomic.
Each room has a unique room_id.
There are no repeating groups.
2NF ✅

The primary key is room_id.
room_type, room_no, and patient_id depend completely on room_id.
3NF ✅

Patient information is not stored inside the room table.
patient_id is used as a foreign key to reference the Patient table.
There are no transitive dependencies.
Therefore: Room table → 1NF ✅ 2NF ✅ 3NF ✅

APPOINTMENT TABLE
CODE:

CREATE TABLE appointment ( appointment_id INT PRIMARY KEY, patient_id INT, doctor_id INT, appointment_date DATE, reason VARCHAR(100), FOREIGN KEY (patient_id) REFERENCES patient(patient_id), FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id) );

NORMALIZATION:

1NF ✅

All values are atomic.
Each appointment has a unique appointment_id.
There are no repeating groups.
2NF ✅

The primary key is appointment_id.
patient_id, doctor_id, appointment_date, and reason depend completely on appointment_id.
3NF ✅

Patient details are not stored repeatedly in the appointment table.
Doctor details are not stored repeatedly in the appointment table.
patient_id and doctor_id are used as foreign keys.
There are no transitive dependencies.
Therefore: Appointment table → 1NF ✅ 2NF ✅ 3NF ✅

WHY 3NF IS USED
Without normalization, the appointment table could contain repeated information such as:

Appointment: 401 | Rahul | Dr. Sharma | Cardiology | 2026-08-20 | Chest pain 402 | Priya | Dr. Mehta | Neurology | 2026-08-21 | Headache

Instead, this database separates the information:

PATIENT TABLE patient_id | patient_name | age | gender | phone_no

DOCTOR TABLE doctor_id | doctor_name | email | phone_no | dept_id

DEPARTMENT TABLE dept_id | dept_name

APPOINTMENT TABLE appointment_id | patient_id | doctor_id | appointment_date | reason

The appointment table only stores patient_id and doctor_id as foreign keys.

This reduces data redundancy and helps maintain data consistency.

RELATIONSHIPS SUPPORTING NORMALIZATION
Department │ └── Doctor

Patient │ ├── Room │ └── Appointment │ └── Doctor

Foreign Keys:

doctor.dept_id ↓ department.dept_id

room.patient_id ↓ patient.patient_id

appointment.patient_id ↓ patient.patient_id

appointment.doctor_id ↓ doctor.doctor_id

NORMALIZATION SUMMARY
Table 1NF 2NF 3NF
Department ✅ ✅ ✅ Doctor ✅ ✅ ✅ Patient ✅ ✅ ✅ Room ✅ ✅ ✅ Appointment ✅ ✅ ✅

FINAL RESULT
1NF → USED ✅ 2NF → USED ✅ 3NF → USED ✅

4NF → NOT SPECIFICALLY REQUIRED 5NF → NOT SPECIFICALLY REQUIRED

Overall Normalization Level → 3NF
