
CREATE OR REPLACE PROCEDURE MAKE_OFFER(
	s_student_id		Students.user_id%TYPE,
	t_tutor_id 			Tutors.user_id%TYPE,
	t_subjects 			Tutions.subjects%TYPE,
	t_salary 				Tutions.salary%TYPE,
	t_start_date 		VARCHAR2,
	t_class_days 		Tutions.class_days%TYPE,
	t_start_time		VARCHAR2,
	t_end_time			VARCHAR2,
	t_type					Tutions.type%TYPE
)
AS
BEGIN
		IF IS_TUTION_ACCEPTED(s_student_id,t_tutor_id) = 'YES' THEN
			INSERT INTO Offers (student_id, tutor_id, tution_id, status)
			VALUES(s_student_id,t_tutor_id,CREATE_TUTION(t_subjects,t_salary,NULL,t_start_date,t_class_days,t_start_time,t_end_time,t_type),'UPDATE');
		ELSIF IS_TUTION_REJECTED(s_student_id,t_tutor_id) = 'YES' OR IS_TUTION_CANCELLED(s_student_id,t_tutor_id) = 'YES' THEN
			UPDATE Offers
			SET status = 'PENDING',
			tution_id = CREATE_TUTION(t_subjects,t_salary,NULL,t_start_date,t_class_days,t_start_time,t_end_time,t_type)
			WHERE student_id = s_student_id AND tutor_id = t_tutor_id;
		ELSE 
			INSERT INTO Offers (student_id, tutor_id, tution_id, status)
			VALUES(s_student_id,t_tutor_id,CREATE_TUTION(t_subjects,t_salary,NULL,t_start_date,t_class_days,t_start_time,t_end_time,t_type),'PENDING');
	 END IF;
END;
/

CREATE OR REPLACE PROCEDURE MAKE_OFFER_FOR_POST(
	p_post_id 			Tution_Posts.post_id%TYPE,
	s_student_id		Students.user_id%TYPE,
	t_tutor_id 			Tutors.user_id%TYPE,
	t_subjects 			Tutions.subjects%TYPE,
	t_salary 				Tutions.salary%TYPE,
	t_start_date 		VARCHAR2,
	t_class_days 		Tutions.class_days%TYPE,
	t_start_time		VARCHAR2,
	t_end_time			VARCHAR2,
	t_type					Tutions.type%TYPE
)
AS
BEGIN
	UPDATE Tution_Posts SET booking_status = 'PENDING', selected_tutor = t_tutor_id
	WHERE post_id = p_post_id;
	
	MAKE_OFFER(s_student_id,t_tutor_id,t_subjects,t_salary,t_start_date,t_class_days,t_start_time,t_end_time,t_type);
END;
/

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


CREATE OR REPLACE PROCEDURE CANCEL_OFFER(
	t_tutor_id 		Tutors.user_id%TYPE,
	s_student_id 	Students.user_id%TYPE
)
AS
BEGIN
	UPDATE Tution_Posts SET booking_status = NULL, selected_tutor = NULL
	WHERE student_id = s_student_id AND booking_status = 'PENDING' AND selected_tutor = t_tutor_id;
	IF IS_TUTION_ACCEPTED(s_student_id,t_tutor_id) = 'YES' THEN
		DELETE FROM Offers
		WHERE tutor_id = t_tutor_id AND student_id = s_student_id
		AND status = 'UPDATE';
	ELSE 	 
		UPDATE Offers
		SET status = 'CANCELLED'
		WHERE tutor_id = t_tutor_id AND student_id = s_student_id 
		AND status = 'PENDING';
	END IF;
END;
/

CREATE OR REPLACE PROCEDURE REJECT_OFFER(
	t_tutor_id 		Tutors.user_id%TYPE,
	s_student_id 	Students.user_id%TYPE,
	reason 				Feedbacks.review%TYPE
)
AS
f_id Feedbacks.feedback_id%TYPE;
BEGIN
	UPDATE Tution_Posts SET booking_status = NULL, selected_tutor = NULL
	WHERE student_id = s_student_id AND booking_status = 'PENDING' AND selected_tutor = t_tutor_id;
	
	IF IS_TUTION_ACCEPTED(s_student_id,t_tutor_id) = 'YES' THEN
		DELETE FROM Offers
		WHERE tutor_id = t_tutor_id AND student_id = s_student_id 
		AND status = 'UPDATE';
	ELSE
		INSERT INTO Feedbacks(review) 
		VALUES(reason)
		RETURNING feedback_id INTO f_id;

		UPDATE Offers
		SET status = 'REJECTED',feedback_id = f_id
		WHERE tutor_id = t_tutor_id AND student_id = s_student_id AND status = 'PENDING';
	END IF;
END;
/

