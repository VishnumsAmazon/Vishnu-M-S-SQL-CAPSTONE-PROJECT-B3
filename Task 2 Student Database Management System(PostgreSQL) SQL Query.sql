CREATE DATABASE student_database;

CREATE TABLE student_table (         /* Create a table called " student_table " with the Given columns */
    Student_id SERIAL PRIMARY KEY,
    Stu_name TEXT NOT NULL,
    Department TEXT NOT NULL,
    email_id TEXT NOT NULL,
    Phone_no NUMERIC NOT NULL,
    Address TEXT,
    Date_of_birth DATE,
    Gender TEXT CHECK (Gender IN ('Male', 'Female')),
    Major TEXT NOT NULL,
    GPA NUMERIC(3, 2) CHECK (GPA >= 0 AND GPA <= 10),
    Grade TEXT CHECK (Grade IN ('A', 'B', 'C', 'D', 'F'))
);

INSERT INTO student_table            /* Insert 10 sample records into the "student_table" using INSERT command */
(Student_id, Stu_name, Department, email_id, Phone_no, Address, Date_of_birth, Gender, Major, GPA, Grade)
VALUES 
('1','Gopika', 'Engineering', 'Gopika@gmail.com', 9876543210, 'Kollam', '1994-05-12', 'Female', 'Computer Science', '9.2', 'A'),
('2','Bob', 'Engineering', 'Devika@gmail.com', 8765432109, 'Tvm', '2000-08-23', 'Male', 'Electrical', '6.5', 'B'),
('3','Charlie', 'Science', 'charlie@gmail.com', 7654321098, 'Hosur', '2002-03-15', 'Male', 'Physics', '8.0', 'A'),
('4','Diana', 'Arts', 'diana@gmail.com', 6543210987, 'Mumbai', '1999-11-30', 'Female', 'History', '4.8', 'C'),
('5','Aathmika', 'Science', 'Aathmika@gmail.com', 5432109876, 'Bangalore', '2001-12-17', 'Female', 'Chemistry', '5.3', 'B'),
('6','Frank', 'Engineering', 'frank@gmail.com', 4321098765, 'kochi', '2000-01-01', 'Male', 'Mechanical', '7.0', 'B'),
('7','Grace', 'Arts', 'grace@gmail.com', 3210987654, 'Chennai', '2003-04-14', 'Female', 'Philosophy', '6.9', 'C'),
('8','Hank', 'Science', 'hank@gmail.com', 2109876543, 'Coimbatore', '2001-07-20', 'Male', 'Biology', '3.5', 'D'),
('9','Ivy', 'Engineering', 'ivy@gmail.com', 1098765432, 'Hyderabad', '1998-09-12', 'Female', 'Civil', '8.7', 'A'),
('10','Jack', 'Arts', 'jack@gmail.com', 9876543211, 'Jammu', '2002-06-18', 'Male', 'Music', '5.0', 'C');

SELECT *    /* Student Information Retrieval */
FROM student_table 
ORDER BY Grade DESC;

SELECT *  /* Query for Male Students */
FROM student_table 
WHERE Gender = 'Male';

SELECT *     /* Query for Students with GPA less than 5.0 */
FROM student_table 
WHERE GPA < 5.0;

UPDATE student_table   /* Update Student Email and Grade */
SET email_id = 'gopikasuresh@gmail.com', Grade = 'B' 
WHERE Student_id = 1;

SELECT Stu_name, Gender, Department, Major, GPA, Grade         /* Query for Students with Grade "B" */
FROM student_table
WHERE Grade = 'B';

SELECT Department, Gender, AVG(GPA) AS Average_GPA         /* Grouping and Calculation */
FROM student_table
GROUP BY Department, Gender;

ALTER TABLE student_table RENAME TO student_info;      /* Table Renaming */

SELECT Stu_name                   /* Retrieve Student with Highest GPA */
FROM student_info 
WHERE GPA = (SELECT MAX(GPA) FROM student_info);