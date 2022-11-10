CREATE TABLE Tutions (
	tution_id 		NUMBER Primary Key,
	subjects 			VARCHAR2(1024) NOT NULL,
	salary 				NUMBER NOT NULL,
	days_per_week NUMBER,
	type 					VARCHAR2(100) NOT NULL,
	class_days		VARCHAR2(100),	
	start_time		DATE,	
	end_time			DATE,	
	start_date		DATE
);
