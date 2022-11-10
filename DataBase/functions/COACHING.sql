CREATE OR REPLACE PROCEDURE MAKE_ADMIN(
	t_tutor_id			Tutors.user_id%TYPE,
	c_coaching_id		Coachings.coaching_id%TYPE
)
AS 
BEGIN
	INSERT INTO MemberOf
  VALUES(t_tutor_id,c_coaching_id,'ADMIN');
END;
/CREATE OR REPLACE FUNCTION IS_OFFER_EXISTS(
	t_tutor_id Tutors.user_id%TYPE,
	s_student_id	Students.user_id%TYPE
)
return VARCHAR2
AS
o_status Offers.status%TYPE;
BEGIN
	SELECT status INTO o_status
	FROM Offers 
	WHERE student_id = s_student_id
	AND tutor_id = t_tutor_id
	AND (status = 'ACCEPTED' OR status = 'PENDING');
	return 'YES';
EXCEPTION
	WHEN OTHERS THEN
		return 'NO';
END;
/

