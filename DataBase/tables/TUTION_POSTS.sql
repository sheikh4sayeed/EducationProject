CREATE TABLE Tution_Posts (
	post_id 							NUMBER Primary Key,
	student_id 						NUMBER REFERENCES Students(user_id)
												ON DELETE CASCADE,
	tution_id 						NUMBER REFERENCES Tutions(tution_id)
												ON DELETE CASCADE,
	timestamp 						DATE DEFAULT sysdate NOT NULL,
	desired_tutor_gender 	VARCHAR2(10) NOT NULL,
	booking_status 				VARCHAR2(10),
	selected_tutor 				NUMBER REFERENCES Tutors(user_id)
												ON DELETE SET NULL
);
