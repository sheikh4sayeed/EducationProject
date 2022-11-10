CREATE TABLE Offers (
	student_id 	NUMBER 	REFERENCES Students(user_id) 
							ON DELETE CASCADE,
	tutor_id 		NUMBER 	REFERENCES Tutors(user_id) 
							ON DELETE CASCADE,
	tution_id 	NUMBER 	REFERENCES Tutions(tution_id)
							ON DELETE SET NULL,
	status 			VARCHAR2(100) DEFAULT ON NULL 'PENDING',
	feedback_id REFERENCES Feedbacks(feedback_id),
	PRIMARY KEY(student_id,tutor_id,status)
);
