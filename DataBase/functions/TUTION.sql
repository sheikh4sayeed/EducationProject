CREATE OR REPLACE FUNCTION IS_TUTION_REJECTED(
	s_student_id		Students.user_id%TYPE,
	t_tutor_id 			Tutors.user_id%TYPE
)
return VARCHAR2
AS
o_status Offers.status%TYPE; 
BEGIN
	SELECT status INTO o_status
	FROM Offers
	WHERE student_id = s_student_id
	AND tutor_id = t_tutor_id
	AND status = 'REJECTED';
	return 'YES';
EXCEPTION
	WHEN OTHERS THEN
		return 'NO';
END;
/

CREATE OR REPLACE FUNCTION IS_TUTION_CANCELLED(
	s_student_id		Students.user_id%TYPE,
	t_tutor_id 			Tutors.user_id%TYPE
)
return VARCHAR2
AS
o_status Offers.status%TYPE; 
BEGIN
	SELECT status INTO o_status
	FROM Offers
	WHERE student_id = s_student_id
	AND tutor_id = t_tutor_id
	AND status = 'CANCELLED';
	return 'YES';
EXCEPTION
	WHEN OTHERS THEN
		return 'NO';
END;
/

CREATE OR REPLACE FUNCTION IS_TUTION_ACCEPTED(
	s_student_id		Students.user_id%TYPE,
	t_tutor_id 			Tutors.user_id%TYPE
)
return VARCHAR2
AS
o_status Offers.status%TYPE; 
BEGIN
	SELECT status INTO o_status
	FROM Offers
	WHERE student_id = s_student_id
	AND tutor_id = t_tutor_id
	AND status = 'ACCEPTED';
	return 'YES';
EXCEPTION
	WHEN OTHERS THEN
		return 'NO';
END;
/

CREATE OR REPLACE PROCEDURE POST_TUTION(
	tp_student_id 						Tution_Posts.student_id%TYPE,
	tp_desired_tutor_gender 	Tution_Posts.desired_tutor_gender%TYPE,
	t_subjects 								Tutions.subjects%TYPE,
	t_salary 									Tutions.salary%TYPE,
	t_days_per_week 					Tutions.days_per_week%TYPE,
	t_type										Tutions.type%TYPE
)
AS
BEGIN
	INSERT INTO Tution_Posts (student_id,tution_id,desired_tutor_gender)
	VALUES(tp_student_id,CREATE_TUTION(t_subjects,t_salary,t_days_per_week,NULL,NULL,NULL,NULL,t_type),tp_desired_tutor_gender);
END;
/