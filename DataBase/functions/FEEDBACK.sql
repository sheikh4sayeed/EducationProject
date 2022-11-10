CREATE OR REPLACE PROCEDURE RATE_TUTOR(
	s_student_id 	Students.user_id%TYPE,
	t_tutor_id 		Tutors.user_id%TYPE,
	f_rating			Feedbacks.rating%TYPE,
	f_review			Feedbacks.review%TYPE
)
AS
f_id	Feedbacks.feedback_id%TYPE;
BEGIN
	SELECT feedback_id INTO f_id
	FROM Offers
	WHERE tutor_id = t_tutor_id AND student_id = s_student_id AND status = 'ACCEPTED';
	
	IF f_id IS NULL THEN 
		INSERT INTO Feedbacks(rating,review) 
		VALUES(f_rating,f_review)
		RETURNING feedback_id INTO f_id;
		UPDATE Offers SET feedback_id = f_id
		WHERE tutor_id = t_tutor_id AND student_id = s_student_id AND status = 'ACCEPTED';
	ELSE 
		UPDATE Feedbacks SET rating = f_rating, review = f_review
		WHERE feedback_id = f_id;
	END IF;
END;
/

CREATE OR REPLACE FUNCTION GET_AVG_RATING(
	t_tutor_id Tutors.user_id%TYPE
)
return NUMBER
AS
	avg_rating		Feedbacks.rating%TYPE;
	total_rating 	Feedbacks.rating%TYPE;
	count					NUMBER;
BEGIN
	SELECT SUM(rating)/COUNT(*) INTO avg_rating
	FROM Offers NATURAL JOIN Feedbacks
	WHERE tutor_id = t_tutor_id AND rating IS NOT NULL
	GROUP BY tutor_id;
	return avg_rating;
EXCEPTION
	WHEN NO_DATA_FOUND THEN	
		return -1;
END;
/