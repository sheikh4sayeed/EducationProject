CREATE TABLE Applies (
	tutor_id	NUMBER 	REFERENCES Tutors(user_id)
						ON DELETE CASCADE,
	post_id 	NUMBER 	REFERENCES Tution_Posts(post_id)
						ON DELETE CASCADE
);
