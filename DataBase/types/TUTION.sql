CREATE OR REPLACE TYPE TUTION AS OBJECT (
	status 					VARCHAR2(100),
	subjects 				VARCHAR2(1024),
	salary 					NUMBER,
	days_per_week 	NUMBER,
	type 						VARCHAR2(100),
	rating					NUMBER,
	class_days			VARCHAR2(100),	
	start_time			VARCHAR2(100),
	end_time				VARCHAR2(100),
	review					VARCHAR2(1024),
	start_date 			DATE
);
/

CREATE OR REPLACE TYPE TUTION_ARRAY AS TABLE OF TUTION;
/
