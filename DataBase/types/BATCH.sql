CREATE OR REPLACE TYPE BATCH AS OBJECT (
	batch_id    	NUMBER,
	start_date		VARCHAR2(100),
	seats					NUMBER,
	students			NUMBER,
	class_days		VARCHAR2(100),	
	start_time		VARCHAR2(100),
	end_time			VARCHAR2(100),
	student_count	NUMBER,
	status				VARCHAR2(100)
);
/
CREATE OR REPLACE TYPE BATCH_ARRAY AS TABLE OF BATCH;
/
