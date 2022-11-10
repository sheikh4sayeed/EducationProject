CREATE TABLE  EnrolledIn(
	student_id    NUMBER 	REFERENCES Students(user_id)
								ON DELETE CASCADE,
	course_id   	NUMBER REFERENCES Courses(course_id)
								ON DELETE CASCADE,
	batch_id   	  NUMBER REFERENCES Batches(batch_id)
								ON DELETE CASCADE,
	status				VARCHAR2(100) DEFAULT ON NULL 'PENDING',
	PRIMARY KEY (student_id,course_id)
);