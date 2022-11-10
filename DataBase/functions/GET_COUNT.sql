

CREATE OR REPLACE FUNCTION GET_BATCH_STUDENT_COUNT(
	b_batch_id	Batches.batch_id%TYPE
)
return NUMBER
AS
student_count	NUMBER;
BEGIN
	SELECT COUNT(*) INTO student_count
	FROM EnrolledIn 
	WHERE batch_id = b_batch_id;
	return student_count;
END;
/

CREATE OR REPLACE FUNCTION GET_BATCH_COUNT(
	c_course_id	Courses.course_id%TYPE
)
return NUMBER
AS
batch_count	NUMBER;
BEGIN
	SELECT COUNT(*) INTO batch_count
	FROM Batches
	WHERE course_id = c_course_id;
	return batch_count;
END;
/

CREATE OR REPLACE FUNCTION GET_COURSE_STUDENT_COUNT(
	c_course_id	Courses.course_id%TYPE
)
return NUMBER
AS
student_count	NUMBER;
BEGIN
	SELECT COUNT(*) INTO student_count
	FROM EnrolledIn 
	WHERE course_id = c_course_id;
	return student_count;
END;
/

CREATE OR REPLACE FUNCTION GET_SEAT_COUNT(
	b_batch_id	Batches.batch_id%TYPE
)
return NUMBER
AS
seat_count	NUMBER;
BEGIN
	SELECT seats INTO seat_count
	FROM Batches 
	WHERE batch_id = b_batch_id;
	return seat_count;
END;
/