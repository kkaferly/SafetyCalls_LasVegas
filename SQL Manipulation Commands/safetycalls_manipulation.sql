--Confirm db was imported
SELECT * 
	FROM calls c 
	LIMIT 10;
	
--Determine columns for new table
SELECT ID, Date_Time, Location, City, State, Disposition, LAT, LONG
	FROM calls;

--Create new table with desired columns
CREATE TABLE calls_clean AS
	SELECT ID, Date_Time, Location, City, State, Disposition, LAT, LONG
		FROM calls;
	
--Delete from calls_clean data without date and Date_Time 
DELETE FROM calls_clean 
	WHERE date_time = 'None';
	
--Seperate Date & Time into two columns
SELECT SUBSTRING(date_time, -8) AS 'time', SUBSTRING(date_time, 0, 12) AS 'date'
	FROM calls_clean;

ALTER TABLE calls_clean 
	ADD COLUMN times;

ALTER TABLE calls_clean 	
	ADD COLUMN dates;

UPDATE calls_clean 
	SET times = SUBSTRING(date_time,-8), dates = SUBSTRING(date_time, 0, 12);

ALTER TABLE calls_clean 
	RENAME COLUMN times TO Times;

ALTER TABLE calls_clean 	
	RENAME COLUMN dates TO Dates;

SELECT * 
	FROM calls_clean;

--Drop old date_time column
ALTER TABLE calls_clean
	DROP COLUMN date_time;

SELECT * 
	FROM calls_clean;

--Number of distinct Dispositions
SELECT Disposition, COUNT(*) AS Dis_Num
	FROM calls_clean cc 
	GROUP BY disposition
	ORDER BY Dis_Num DESC;

CREATE table dist_dis AS
	SELECT Disposition, COUNT(*) AS Dis_Num
		FROM calls_clean cc 
		GROUP BY disposition
		ORDER BY Dis_Num DESC;

--Number of calls per disposition for each location
SELECT Disposition, Location, COUNT(location) AS per_loc 
	FROM calls_clean cc 
	GROUP BY location, Disposition 
	ORDER BY location DESC;

CREATE TABLE dist_disp_loc AS
	SELECT Disposition, Location, COUNT(location) AS per_loc 
	FROM calls_clean cc 
	GROUP BY location, Disposition 
	ORDER BY location DESC;

--Export completed tables to CSV files using DBeaver export functions

