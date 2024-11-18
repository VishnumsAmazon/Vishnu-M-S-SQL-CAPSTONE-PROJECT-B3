CREATE TABLE StudentInfo (       /* Create the StudentInfo table */ 
STU_ID INT PRIMARY KEY,
STU_NAME VARCHAR(50),
DOB DATE,
PHONE_NO VARCHAR(15),
EMAIL_ID VARCHAR(50),
ADDRESS VARCHAR(100)
);

CREATE TABLE CoursesInfo (             /* Create the CoursesInfo table */ 
    COURSE_ID INT PRIMARY KEY,
    COURSE_NAME VARCHAR(50),
    COURSE_INSTRUCTOR_NAME VARCHAR(50)
);

CREATE TABLE EnrollmentInfo (            /* Create the EnrollmentInfo table */   
ENROLLMENT_ID INT PRIMARY KEY,
STU_ID INT,
COURSE_ID INT,
ENROLL_STATUS VARCHAR(15) CHECK (ENROLL_STATUS IN ('Enrolled', 'Not Enrolled')),
FOREIGN KEY (STU_ID) REFERENCES StudentInfo(STU_ID),
FOREIGN KEY (COURSE_ID) REFERENCES CoursesInfo(COURSE_ID)
);

INSERT INTO StudentInfo VALUES       /* Insert some sample data for StudentInfo table */ 
(1, 'Gopika', '1994-11-26', '1234567890', 'Gopika@gmail.com', '505 kollam'),
(2, 'Devika', '2000-08-23', '0987654321', 'Devika@gmil.com', '707 Tvm'),
(3, 'Vishnu', '1992-06-19', '1112233445', 'Vishnu@gmail.com', '606 Bangalore'),
(4, 'Aathmika', '2001-11-30', '5556677889', 'Aaathmika@gmail.com', '404 Kochi'),
(5, 'Suresh', '2002-12-17', '6667788990', 'Suresh@gmil.com', '303 Mumbai');

INSERT INTO CoursesInfo VALUES         /* Insert some sample data for CourseInfo table */
(101, 'Mathematics', 'Dr. Subham'),
(102, 'Physics', 'Dr. Sasikala'),
(103, 'Chemistry', 'Dr. Madhupal'),
(104, 'Biology', 'Dr. Cris'),
(105, 'Computer Science', 'Dr. Dalton');

INSERT INTO EnrollmentInfo VALUES      /* Insert some sample data for EnrollmentInfo table */ 
(1, 1, 101, 'Enrolled'),
(2, 1, 105, 'Enrolled'),
(3, 2, 102, 'Enrolled'),
(4, 3, 103, 'Not Enrolled'),
(5, 4, 101, 'Enrolled');

SELECT        /*  Retrieve student name, contact informations, and Enrollment status. */ 
S.STU_NAME, 
S.PHONE_NO, 
S.EMAIL_ID, 
E.ENROLL_STATUS
FROM 
StudentInfo S
JOIN 
EnrollmentInfo E ON S.STU_ID = E.STU_ID;

SELECT       /*  Retrieve a list of courses in which a specific student is enrolled */ 
C.COURSE_NAME
FROM 
CoursesInfo C
JOIN 
EnrollmentInfo E ON C.COURSE_ID = E.COURSE_ID
WHERE 
E.STU_ID = 1 AND E.ENROLL_STATUS = 'Enrolled';

SELECT COURSE_NAME, COURSE_INSTRUCTOR_NAME        /*  Retrieve course information, including course name, instructor information */ 
FROM CoursesInfo;

SELECT *                       /* retrieve course information for a specific course */
FROM CoursesInfo
WHERE COURSE_ID = 101;

SELECT *                    /* retrieve course information for multiple courses */
FROM CoursesInfo
WHERE COURSE_ID IN (101, 102);

SELECT c.COURSE_NAME,            /* retrieve the number of students enrolled in each course */
COUNT(e.STU_ID) AS ENROLLED_STUDENTS
FROM EnrollmentInfo e
JOIN CoursesInfo c ON e.COURSE_ID = c.COURSE_ID
WHERE e.ENROLL_STATUS = 'Enrolled'
GROUP BY c.COURSE_NAME;

SELECT s.STU_NAME                  /* retrieve the list of students enrolled in a specific course */
FROM EnrollmentInfo e
JOIN StudentInfo s ON e.STU_ID = s.STU_ID
WHERE e.COURSE_ID = 101 AND e.ENROLL_STATUS = 'Enrolled';

SELECT c.COURSE_INSTRUCTOR_NAME,          /* retrieve the count of enrolled students for each instructor */
COUNT(e.STU_ID) AS ENROLLED_STUDENTS
FROM EnrollmentInfo e
JOIN CoursesInfo c ON e.COURSE_ID = c.COURSE_ID
WHERE e.ENROLL_STATUS = 'Enrolled'
GROUP BY c.COURSE_INSTRUCTOR_NAME;

SELECT e.STU_ID, s.STU_NAME                 /* retrieve the list of students who are enrolled in multiple courses */
FROM EnrollmentInfo e
JOIN StudentInfo s ON e.STU_ID = s.STU_ID
WHERE e.ENROLL_STATUS = 'Enrolled'
GROUP BY e.STU_ID, s.STU_NAME
HAVING COUNT(e.COURSE_ID) > 1;

SELECT c.COURSE_NAME,              /* retrieve the courses that have the highest number of enrolled students */
COUNT(e.STU_ID) AS ENROLLED_STUDENTS
FROM EnrollmentInfo e
JOIN CoursesInfo c ON e.COURSE_ID = c.COURSE_ID
WHERE e.ENROLL_STATUS = 'Enrolled'
GROUP BY c.COURSE_NAME
ORDER BY ENROLLED_STUDENTS DESC;