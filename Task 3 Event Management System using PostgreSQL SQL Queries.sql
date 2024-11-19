CREATE DATABASE EventsManagement;

CREATE TABLE Events (                           /*  Create the Event table */
    Event_Id INT PRIMARY KEY AUTO_INCREMENT, 
    Event_Name VARCHAR(100),
    Event_Date DATE,
    Event_Location VARCHAR(100),
    Event_Description TEXT
);

CREATE TABLE Attendees (                                   /*  Create the Attendees table */                
    Attendee_Id INT PRIMARY KEY AUTO_INCREMENT,  
    Attendee_Name VARCHAR(100),
    Attendee_Phone VARCHAR(15),
    Attendee_Email VARCHAR(100),
    Attendee_City VARCHAR(100)
);

CREATE TABLE Registrations (                           /*  Create the Registrations table */
Registration_Id INT PRIMARY KEY AUTO_INCREMENT,
Event_Id INT,
Attendee_Id INT,  
Registration_Date DATE,
Registration_Amount DECIMAL(10, 2),
FOREIGN KEY (Event_Id) REFERENCES Events(Event_Id),
FOREIGN KEY (Attendee_Id) REFERENCES Attendees(Attendee_Id)
);

INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)           /*data insertion for events table*/ 
VALUES
('Tech Conference', '2024-12-10', 'Kerala', 'A conference on the latest tech trends'),
('Art Expo', '2024-12-20', 'Karnataka', 'An exhibition showcasing modern art'),
('Music Festival', '2024-12-15', 'Tamilnadu', 'A celebration of music and performances'),
('Business Summit', '2024-11-25', 'Odissa', 'A gathering for business leaders'),
('Science Fair', '2024-12-05', 'Goa', 'A fair to present scientific projects');

INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)             /*data insertion for Attendess table*/ 
VALUES
('Gopika', '1234567890', 'gopika@gmail.com', 'Kerala'),
('Devika', '2345678901', 'devika@gmail.com', 'Karnataka'),
('Aathmika', '3456789012', 'aathmika@gmail.com', 'Tamilnadu'),
('Suresh', '4567890123', 'suresh@gmail.com', 'Odissa'),
('Vishnu', '5678901234', 'Vishnu@gmail.com', 'Goa');

INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount)                /*insert data to registration table*/
VALUES
(1, 1, '2024-11-15', 150.00),
(2, 2, '2024-11-20', 200.00),
(3, 3, '2024-11-25', 100.00),
(4, 4, '2024-11-10', 300.00),
(5, 5, '2024-11-05', 50.00);

INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)                       /*Inserting a new event*/
VALUES ('Startup summit', '2024-12-18', 'Andhra', 'A day for startups to pitch ideas to investors') ;

UPDATE Events                                                                               /*Updating an event's information.*/
SET Event_Location = 'Jammu', Event_Description = 'A major startup meet'
WHERE Event_Id = 6;

DELETE FROM Events                                                                /*Deleting an event.*/
WHERE Event_Id = 6;

INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)     /*Inserting a new attendee.*/
VALUES ('Deepa', '6789012345', 'Deepa@gmail.com', 'Jammu');

INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount)            /*Registering an attendee for an event.*/
VALUES (1, 6, '2024-11-30', 180.00);


SELECT * FROM Events;        /*Retrive event information.*/

SELECT                             /*Retrive Attendee list.*/
    e.Event_Name AS Event_Name,
    e.Event_Location AS Event_Location,
    a.Attendee_Name AS Attendee_Name,
    a.Attendee_Email AS Attendee_Email,
    a.Attendee_City AS Attendee_City,
    r.Registration_Date AS Registration_Date,
    r.Registration_Amount AS Registration_Amount
FROM 
    Registrations r
JOIN 
    Events e ON r.Event_Id = e.Event_Id
JOIN 
    Attendees a ON r.Attendee_Id = a.Attendee_Id
ORDER BY 
    e.Event_Name, r.Registration_Date;
    
    
SELECT e.Event_Name,                     /*calculate event attendance statistics.*/             
COUNT(r.Registration_Id) AS Total_Attendees, SUM(r.Registration_Amount) AS Total_Revenue
FROM Events e
LEFT JOIN Registrations r ON e.Event_Id = r.Event_Id
GROUP BY e.Event_Id, e.Event_Name
ORDER BY Total_Attendees DESC;