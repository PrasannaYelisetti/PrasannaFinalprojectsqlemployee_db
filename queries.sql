SELECT emp_id, strftime('%Y-%m', Logins_DATE) AS month,
       COUNT(*) AS total_days_present
FROM Attendance
GROUP BY emp_id, month;

-- Monthly Late Arrival Summary
SELECT emp_id, strftime('%Y-%m', Logins_DATE) AS month,
       SUM(CASE WHEN am_late = 'YES' THEN 1 ELSE 0 END +
           CASE WHEN pm_late = 'YES' THEN 1 ELSE 0 END) AS total_late_sessions
FROM Attendance
GROUP BY emp_id, month;

-- Total Work Hours
SELECT emp_id,
       printf('%02d:%02d:%02d',
              SUM(strftime('%s', work_hour)) / 3600,
              (SUM(strftime('%s', work_hour)) % 3600) / 60,
              SUM(strftime('%s', work_hour)) % 60) AS total_work_time
FROM Attendance
GROUP BY emp_id;