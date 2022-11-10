CREATE TABLE  Batches(
	batch_id    	NUMBER  PRIMARY KEY,
  course_id  		NUMBER 	REFERENCES Courses(course_id)
								ON DELETE CASCADE,
	start_date		DATE NOT NULL,
	seats					NUMBER NOT NULL,
	students			NUMBER DEFAULT 0,
	class_days		VARCHAR2(100) NOT NULL,	
	start_time		DATE,
	end_time 			DATE
);