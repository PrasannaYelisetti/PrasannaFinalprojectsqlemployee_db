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
CREATE TABLE LeaveRequests (
    LeaveID SERIAL PRIMARY KEY,
    EmpID INT,
    StartDate DATE,
    EndDate DATE,
    Reason TEXT,
    Status VARCHAR(20) DEFAULT 'Pending', -- Approved, Rejected, Pending
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID)
);
ALTER TABLE Logins

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
);
RENAME TO Attendance;
drop table Attendance;