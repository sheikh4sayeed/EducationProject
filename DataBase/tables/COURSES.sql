CREATE TABLE  Courses(
	course_id    	NUMBER  PRIMARY KEY,
	coaching_id  	NUMBER 	REFERENCES Coachings(coaching_id)
								ON DELETE CASCADE,
	class        	VARCHAR2(100) NOT NULL,
	subject				VARCHAR2(100) NOT NULL,
	UNIQUE (coaching_id,class,subject)
);

