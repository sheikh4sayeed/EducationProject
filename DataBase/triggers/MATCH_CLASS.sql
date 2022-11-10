CREATE OR REPLACE TRIGGER MATCH_CLASS
	BEFORE INSERT
	ON EnrolledIn
	FOR EACH ROW
DECLARE	
student_row	STUDENT;
course_row	COURSE;
BEGIN
	student_row := GET_STUDENT_DETAILS(:NEW.student_id);
	course_row	:= GET_COURSE_DETAILS(:NEW.course_id,:NEW.batch_id);
	IF student_row.class <> course_row.class THEN
		RAISE_APPLICATION_ERROR(-20999, 'Your class doesn`t match with the course');
	END IF;
END;
/
