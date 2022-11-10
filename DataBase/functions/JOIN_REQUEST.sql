CREATE OR REPLACE PROCEDURE ACCEPT_OFFER(
	t_tutor_id 		Tutors.user_id%TYPE,
	s_student_id 	Students.user_id%TYPE
)
AS
new_tution_id Tutions.tution_id%TYPE;
BEGIN
	UPDATE Tution_Posts SET booking_status = 'BOOKED'
	WHERE student_id = s_student_id AND booking_status = 'PENDING' AND selected_tutor = t_tutor_id;
		
	IF IS_TUTION_ACCEPTED(s_student_id,t_tutor_id) = 'YES' THEN
		--- Replace old tution id with new one.
		SELECT tution_id INTO new_tution_id
		FROM Offers
		WHERE tutor_id = t_tutor_id AND student_id = s_student_id AND status = 'UPDATE';
		
		DELETE FROM Offers
		WHERE tutor_id = t_tutor_id AND student_id = s_student_id AND status = 'UPDATE';
		
		UPDATE Offers
		SET tution_id = new_tution_id
		WHERE tutor_id = t_tutor_id AND student_id = s_student_id AND status = 'ACCEPTED';
	ELSE 
		--- Update offer status
		UPDATE Offers
		SET status = 'ACCEPTED', feedback_id = NULL
		WHERE tutor_id = t_tutor_id AND student_id = s_student_id AND status = 'PENDING';
	END IF;
	
END;
/

CREATE OR REPLACE PROCEDURE DECLINE_JOIN_REQUEST(
	c_coaching_id 		Coachings.coaching_id%TYPE,
	s_student_id 			Students.user_id%TYPE
)
AS
BEGIN
	CANCEL_JOIN_REQUEST(c_coaching_id,s_student_id);
	DECLINE_JOIN_NOTIFICATION(c_coaching_id,s_student_id);
END;
/

CREATE OR REPLACE PROCEDURE CANCEL_JOIN_REQUEST(
	c_coaching_id 		Coachings.coaching_id%TYPE,
	s_student_id 			Students.user_id%TYPE
)
AS
BEGIN
	DELETE FROM MemberOf
	WHERE coaching_id = c_coaching_id AND user_id = s_student_id;
	
	CANCEL_JOIN_NOTIFICATION(c_coaching_id,s_student_id);
END;
/



CREATE OR REPLACE PROCEDURE APPROVE_JOIN_REQUEST(
	c_coaching_id 		Coachings.coaching_id%TYPE,
	s_student_id 			Students.user_id%TYPE
)
AS
BEGIN
	UPDATE MemberOf
	SET type = 'MEMBER'
	WHERE coaching_id = c_coaching_id AND user_id = s_student_id;
	
	APPROVE_JOIN_NOTIFICATION(c_coaching_id,s_student_id);
END;
/