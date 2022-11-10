CREATE OR REPLACE PROCEDURE ENROLL_COURSE(
	u_user_id		Users.user_id%TYPE,
	b_batch_id	Batches.batch_id%TYPE
)
AS
BEGIN
INSERT INTO EnrolledIn
VALUES(u_user_id,GET_COURSE_ID(b_batch_id),b_batch_id,'PENDING');
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
		RAISE_APPLICATION_ERROR(-20999,'Already enrolled in this course');
END;
/

CREATE OR REPLACE PROCEDURE APPROVE_ENROLLMENT(
	s_student_id 	Students.user_id%TYPE,
	b_batch_id		Batches.batch_id%TYPE
)
AS
BEGIN
	UPDATE EnrolledIn
	SET status = 'APPROVED'
	WHERE student_id = s_student_id AND batch_id = b_batch_id;
END;
/

CREATE OR REPLACE PROCEDURE DECLINE_ENROLLMENT(
	s_student_id 	Students.user_id%TYPE,
	b_batch_id		Batches.batch_id%TYPE
)
AS
BEGIN
	CANCEL_ENROLLMENT(s_student_id,b_batch_id);
	DECLINE_ENROLL_NOTIFICATION(s_student_id,b_batch_id);
END;
/

CREATE OR REPLACE PROCEDURE CANCEL_ENROLLMENT(
	s_student_id 	Students.user_id%TYPE,
	b_batch_id		Batches.batch_id%TYPE
)
AS
BEGIN
	DELETE FROM EnrolledIn
	WHERE student_id = s_student_id AND batch_id = b_batch_id;
END;
/
