CREATE OR REPLACE TYPE COURSE AS OBJECT (
	course_id    	NUMBER,
	coaching_name	VARCHAR2(100),
	class        	VARCHAR2(100),
	subject				VARCHAR2(100),
	start_date		VARCHAR2(100),
	seats					NUMBER,
	students			NUMBER,
	class_days		VARCHAR2(100),	
	start_time		VARCHAR2(100),
	end_time			VARCHAR2(100),
	batch_count		NUMBER,
	student_count	NUMBER,
	status 				VARCHAR2(100)
);
/

CREATE OR REPLACE TYPE COURSE_ARRAY AS TABLE OF COURSE;
/