CREATE TABLE MemberOf(
	user_id        	NUMBER  REFERENCES Users(user_id)
									ON DELETE CASCADE,
	coaching_id    	NUMBER  REFERENCES Coachings(coaching_id)
									ON DELETE CASCADE,
	type           	VARCHAR2(100) DEFAULT ON NULL 'PENDING',
	PRIMARY KEY   	(user_id,coaching_id)
);
