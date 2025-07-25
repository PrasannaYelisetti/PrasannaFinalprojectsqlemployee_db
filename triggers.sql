-- triggers.sql

CREATE TRIGGER update_Attendance_timestamp
AFTER UPDATE ON Attendance
FOR EACH ROW
BEGIN
  UPDATE Attendance
  SET updated_at = CURRENT_TIMESTAMP
  WHERE id = OLD.id;
END;

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