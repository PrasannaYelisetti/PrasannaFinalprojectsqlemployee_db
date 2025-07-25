📄 README: Employee Management and Attendance Tracker (SQL Project)

📁 Project Title:
employee_db

🧾 Description:
This project is a SQL-based Employee Management and Attendance system that allows you to:
- Maintain employee records
- Track daily attendance
- Automatically manage timestamps
- Generate reports on work hours and late arrivals
- Use triggers for automation

🏗️ Database Tables:

1. Employee Table:
-------------------
CREATE TABLE `employee` (
  `emp_id` int(11) NOT NULL,
  `password` varchar(30) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `zip` varchar(4) DEFAULT NULL,
  `contact_number` varchar(11) DEFAULT NULL,
  `email_address` varchar(50) DEFAULT NULL,
  `contract` varchar(50) NOT NULL,
  `shift` varchar(25) NOT NULL
);

2. Attendance Table:
--------------------
CREATE TABLE `Logins` (
  `Logins_id` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `Logins_DATE` date DEFAULT NULL,
  `am_in` time DEFAULT NULL,
  `am_out` time DEFAULT NULL,
  `pm_in` time DEFAULT NULL,
  `pm_out` time DEFAULT NULL,
  `am_late` varchar(3) DEFAULT NULL,
  `am_underTIME` varchar(3) DEFAULT NULL,
  `pm_late` varchar(3) DEFAULT NULL,
  `pm_underTIME` varchar(3) DEFAULT NULL,
  `overtime` time DEFAULT NULL,
  `work_hour` time NOT NULL,
  `status` varchar(255) DEFAULT NULL
)   
ALTER TABLE Logins
RENAME TO Attendance;
CREATE TABLE Departments (
    DeptID SERIAL PRIMARY KEY,
    DeptName VARCHAR(100) NOT NULL
);
CREATE TABLE Salary (
    SalaryID SERIAL PRIMARY KEY,
    EmpID INT,
    MonthYear VARCHAR(7), -- Format: YYYY-MM
    BaseSalary DECIMAL(10,2),
    Deductions DECIMAL(10,2),
    Bonus DECIMAL(10,2),
    NetSalary DECIMAL(10,2),
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID)
);

 select*from Salary;

INSERT INTO LeaveRequests (EmpID, StartDate, EndDate, Reason)
VALUES
(2, '2025-07-19', '2025-07-20', 'Medical Leave');

Query to Know all tables created in a db
-----------------------------------
SELECT name FROM sqlite_master WHERE type='table';

⚙️ Features:
------------
- Insert and update employee data
- Record check-in/check-out times
- Calculate total work hours
- Track AM/PM late arrivals
- Set attendance status via triggers
- Auto-update timestamps

🔁 SQL Triggers:
----------------

1. Trigger to auto-update `updated_at` on any update:
-----------------------------------------------------
CREATE TRIGGER update_Attendance_timestamp
AFTER UPDATE ON Attendance
FOR EACH ROW
BEGIN
  UPDATE Attendance
  SET updated_at = CURRENT_TIMESTAMP
  WHERE id = OLD.id;
END;

2. Trigger to set `status` as 'Present' or 'Absent' based on work hours:
------------------------------------------------------------------------
CREATE TRIGGER set_Attendance_status
AFTER INSERT ON Attendance
FOR EACH ROW
BEGIN
  UPDATE Attendance
  SET status = 
    CASE 
      WHEN NEW.work_hour IS NOT NULL THEN 'Present'
      ELSE 'Absent'
    END
  WHERE id = NEW.id;
END;

📊 Reporting Queries:
----------------------

1. Monthly Attendance Summary:
-------------------------------
SELECT emp_id, strftime('%Y-%m', Logins_DATE) AS month,
       COUNT(*) AS total_days_present
FROM Attendance
GROUP BY emp_id, month;

2. Monthly Late Arrival Summary:
--------------------------------
SELECT emp_id, strftime('%Y-%m', Logins_DATE) AS month,
       SUM(CASE WHEN am_late = 'YES' THEN 1 ELSE 0 END +
           CASE WHEN pm_late = 'YES' THEN 1 ELSE 0 END) AS total_late_sessions
FROM Attendance
GROUP BY emp_id, month;

3. Total Work Hours (optional formatting):
------------------------------------------
SELECT emp_id,
       printf('%02d:%02d:%02d',
              SUM(strftime('%s', work_hour)) / 3600,
              (SUM(strftime('%s', work_hour)) % 3600) / 60,
              SUM(strftime('%s', work_hour)) % 60) AS total_work_time
FROM Attendance
GROUP BY emp_id;

🛠 Requirements:
----------------
- SQLite (tested on SQLite)
- Any SQL editor like DBeaver / DB Browser for SQLite

👨‍💻 Author:
------------
Prasanna Yelisetti