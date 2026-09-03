DROP TABLE IF EXISTS List;
CREATE TABLE Marksheet (
  Roll_no INT,
Name VARCHAR(20),
  Maths INT,
  Science INT,
  English INT
);
INSERT INTO Marksheet (Roll_no, Name, Maths, Science, English)
VALUES
(1, 'Anugra', 94, 96, 97),
(2, 'Pranay', 84, 88,96),
(3, 'Hardik', 88, 86, 99);
SELECT * FROM Marksheet;
