CREATE OR REPLACE FUNCTION GET_STUDENT_DETAILS(
	s_student_id Students.user_id%TYPE
)
return STUDENT
AS 
	student_row STUDENT := STUDENT(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
BEGIN
	FOR r IN (
		SELECT * 	 	
		FROM Users NATURAL JOIN Students
		WHERE user_id = s_student_id
	)LOOP
		student_row := Student(
			r.user_id,
			r.name,
			r.image,
			r.gender,
			r.phone_number,
			TO_CHAR(r.date_of_birth,'MM/DD/YYYY'),
			r.institution,
			r.version,
			r.class,
			r.address
	);
	END LOOP;
	return student_row;
END;
/


CREATE OR REPLACE FUNCTION GET_TUTOR_DETAILS(
	t_tutor_id Tutors.user_id%TYPE
)
return TUTOR
AS 
	tutor_row TUTOR := TUTOR(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
BEGIN
	FOR r IN (
		SELECT * 	 	
		FROM Users NATURAL JOIN Tutors
		WHERE user_id = t_tutor_id
	)LOOP
		tutor_row := TUTOR(
			r.user_id,
			r.name,
			r.image,
			r.gender,
			r.phone_number,
			TO_CHAR(r.date_of_birth,'MM/DD/YYYY'),
			r.expertise,
			r.availability,
			r.years_of_experience,
			r.preffered_salary,
			NULL
	);
	END LOOP;
	tutor_row.rating := GET_AVG_RATING(t_tutor_id);
	return tutor_row;
END;
/

CREATE OR REPLACE FUNCTION GET_TUTION_POST_DETAILS(
	tp_post_id	Tution_Posts.post_id%TYPE
)
return TUTION_POST
AS
tution_post_row TUTION_POST;
BEGIN
	FOR r IN (
		SELECT *
		FROM Tution_Posts NATURAL JOIN Tutions 
		JOIN Students ON student_id = user_id
		NATURAL JOIN Users
		WHERE post_id = tp_post_id
	)LOOP
		tution_post_row := TUTION_POST(
				r.gender,
				r.version,
				r.class,
				r.address,
				r.post_id, 
				r.desired_tutor_gender, 
				r.subjects, 
				r.salary,
				r.days_per_week,
				r.type,
				TO_CHAR(r.timestamp,'DD/MON/YYYY HH24:MI:SS'),
				0,
				r.booking_status,
				r.selected_tutor);
	END LOOP;
	SELECT COUNT(*) INTO tution_post_row.applicant_count
	FROM Applies
	WHERE post_id = tp_post_id;
	return tution_post_row;
END;
/

CREATE OR REPLACE FUNCTION GET_NOTICE_DETAILS(
	n_notice_id Notices.notice_id%TYPE
)
return NOTICE
AS 
	notice_row NOTICE := NOTICE(NULL,NULL,NULL,NULL,NULL,NULL);
BEGIN
	FOR r IN (
		SELECT * 	 	
		FROM Notices NATURAL JOIN Coachings
		WHERE notice_id = n_notice_id
	)LOOP
		notice_row := NOTICE(
				r.name,
				r.image,
				r.class,
				r.subject,
				r.text,
				TO_CHAR(r.timestamp,'DD/MON/YYYY HH24:MI:SS')
		);
	END LOOP;
	return notice_row;
END;
/

CREATE OR REPLACE FUNCTION GET_NOTIFICATION_DETAILS(
	n_notification_id Notifications.notification_id%TYPE
)
return NOTIFICATION
AS 
	notification_row NOTIFICATION := NOTIFICATION(NULL,NULL,NULL,NULL,NULL);
BEGIN
	FOR r IN (
		SELECT * 	 	
		FROM Notifications 
		WHERE notification_id = n_notification_id
	)LOOP
		notification_row := NOTIFICATION(
				r.image,
				r.text,
				r.url,
				TO_CHAR(r.timestamp,'DD/MON/YYYY HH24:MI:SS'),
				r.seen
		);
	END LOOP;
	return notification_row;
END;
/

CREATE OR REPLACE FUNCTION GET_COACHING_DETAILS(
	c_coaching_id Coachings.coaching_id%TYPE
)
return COACHING
AS 
	coaching_row COACHING := COACHING(NULL,NULL,NULL,NULL,NULL,NULL);
BEGIN
	FOR r IN (
		SELECT * 	 	
		FROM Coachings
		WHERE coaching_id = c_coaching_id
	)LOOP
		coaching_row := COACHING(
				r.coaching_id,
				r.image,
				r.name,
				r.address,
				r.phone_number,
				NULL
		);
	END LOOP;
	return coaching_row;
END;
/

CREATE OR REPLACE FUNCTION GET_TUTION_DETAILS(
	t_tutor_id Tutors.user_id%TYPE,
	s_student_id Students.user_id%TYPE
)
return TUTION
AS
tution_row TUTION := TUTION(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
BEGIN
	FOR r IN (
		SELECT *
		FROM Offers O NATURAL JOIN Tutions LEFT OUTER JOIN Feedbacks F
		ON O.feedback_id = F.feedback_id
		WHERE tutor_id = t_tutor_id
		AND student_id = s_student_id
	)LOOP
		IF r.status = 'UPDATE' THEN
			tution_row := TUTION(r.status, r.subjects, r.salary, r.days_per_week, r.type,r.rating,r.class_days,TO_CHAR(r.start_time,'DD/MON/YYYY HH24:MI:SS'),TO_CHAR(r.end_time,'DD/MON/YYYY HH24:MI:SS'),r.review,TO_CHAR(r.start_date,'DD/MON/YYYY'));
		ELSIF tution_row.status IS NULL THEN
			tution_row := TUTION(r.status, r.subjects, r.salary, r.days_per_week, r.type,r.rating,r.class_days,TO_CHAR(r.start_time,'DD/MON/YYYY HH24:MI:SS'),TO_CHAR(r.end_time,'DD/MON/YYYY HH24:MI:SS'),r.review,TO_CHAR(r.start_date,'DD/MON/YYYY'));
		END IF;
	END LOOP;
	return tution_row;
END;
/

CREATE OR REPLACE FUNCTION GET_ACCEPTED_TUTION_DETAILS(
	t_tutor_id Tutors.user_id%TYPE,
	s_student_id Students.user_id%TYPE
)
return TUTION
AS
tution_row TUTION := TUTION(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
BEGIN
	FOR r IN (
		SELECT *
		FROM Offers O NATURAL JOIN Tutions LEFT OUTER JOIN Feedbacks F
		ON O.feedback_id = F.feedback_id
		WHERE tutor_id = t_tutor_id
		AND student_id = s_student_id
	)LOOP
		IF r.status = 'ACCEPTED' THEN
			tution_row := TUTION(r.status, r.subjects, r.salary, r.days_per_week, r.type,r.rating,r.class_days,TO_CHAR(r.start_time,'DD/MON/YYYY HH24:MI:SS'),TO_CHAR(r.end_time,'DD/MON/YYYY HH24:MI:SS'),r.review,TO_CHAR(r.start_date,'DD/MON/YYYY'));
		END IF;
	END LOOP;
	return tution_row;
END;
/

CREATE OR REPLACE FUNCTION GET_EDUCATION_DETAILS(
	e_eq_id Educations.eq_id%TYPE
)
return EDUCATION
AS
education_row EDUCATION := EDUCATION(NULL,NULL,NULL,NULL,NULL);
BEGIN
	FOR r IN (
		SELECT *
		FROM Educations
		WHERE eq_id = e_eq_id
	)LOOP
		education_row := EDUCATION(r.eq_id, r.institute, r.field_of_study, r.degree, r.passing_year);
	END LOOP;
	return education_row;
END;
/

CREATE OR REPLACE FUNCTION GET_TUTION_DETAILS_FROM_POST(
	tp_post_id Tution_Posts.post_id%TYPE
)
return TUTION
AS
tution_row TUTION := TUTION(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
BEGIN
	FOR r IN (
		SELECT *
		FROM Tution_Posts NATURAL JOIN Tutions
		WHERE post_id = tp_post_id
	)LOOP
		tution_row := TUTION(NULL, r.subjects, r.salary, r.days_per_week, r.type,NULL,NULL,NULL,NULL,NULL,NULL);
	END LOOP;
	return tution_row;
END;
/

CREATE OR REPLACE FUNCTION  GET_BATCH_DETAILS(
	b_batch_id	Batches.batch_id%TYPE
)
return BATCH
AS 
	batch_row BATCH := BATCH(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
BEGIN
	FOR r IN (
		SELECT * 	 	
		FROM Batches
		WHERE batch_id = b_batch_id
	)LOOP
		batch_row := BATCH(
				r.batch_id,
				TO_CHAR(r.start_date,'DD/MON/YYYY'),
				r.seats,
				r.students,
				r.class_days,
				TO_CHAR(r.start_time,'DD/MON/YYYY HH24:MI:SS'),
				TO_CHAR(r.end_time,'DD/MON/YYYY HH24:MI:SS'),
				0,
				NULL
		);
	END LOOP;
	batch_row.student_count := GET_BATCH_STUDENT_COUNT(b_batch_id);
	return batch_row;
END;
/

CREATE OR REPLACE FUNCTION  GET_COURSE_DETAILS(
	c_course_id	Courses.course_id%TYPE,
	b_batch_id  Batches.batch_id%TYPE
)
return COURSE
AS 
	course_row COURSE := COURSE(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
BEGIN
	FOR r IN (
		SELECT C.course_id,name,class,subject,start_date,seats,students,class_days,start_time,end_time
		FROM Courses C NATURAL JOIN Coachings
		LEFT OUTER JOIN Batches B
		ON B.course_id = C.course_id
		WHERE C.course_id = c_course_id 
		AND (b_batch_id IS NULL OR B.batch_id = b_batch_id)
	)LOOP
		course_row := COURSE(
				r.course_id,
				r.name,
				r.class,
				r.subject,
				TO_CHAR(r.start_date,'DD/MON/YYYY'),
				r.seats,
				r.students,
				r.class_days,
				TO_CHAR(r.start_time,'DD/MON/YYYY HH24:MI:SS'),
				TO_CHAR(r.end_time,'DD/MON/YYYY HH24:MI:SS'),
				0,
				0,
				NULL
		);
		course_row.batch_count := GET_BATCH_COUNT(c_course_id);
		course_row.student_count := GET_COURSE_STUDENT_COUNT(c_course_id);
	END LOOP;
	return course_row;
END;
/

CREATE OR REPLACE FUNCTION GET_MATERIAL_DETAILS(
	m_material_id Materials.material_id%TYPE
)
return MATERIAL
AS 
	material_row MATERIAL := MATERIAL(NULL,NULL,NULL,NULL,NULL,NULL);
BEGIN
	FOR r IN (
		SELECT * 	 	
		FROM Materials JOIN Users
		ON tutor_id = user_id
		WHERE material_id = m_material_id
	)LOOP
		material_row := MATERIAL(
				r.material_type,
				r.description,
				r.link,
				r.name,
				r.image,
				TO_CHAR(r.timestamp,'DD/MON/YYYY HH24:MI:SS')
		);
	END LOOP;
	return material_row;
END;
/

CREATE OR REPLACE FUNCTION GET_FEEDBACK_DETAILS(
	f_feedback_id 		Feedbacks.feedback_id%TYPE
)
return FEEDBACK
AS
feedback_row FEEDBACK := FEEDBACK(NULL,NULL,NULL);
BEGIN
	FOR r IN(
		SELECT *
		FROM Feedbacks
		WHERE feedback_id = f_feedback_id
	)LOOP
		feedback_row := FEEDBACK(r.feedback_id,r.rating,r.review);
	END LOOP;
	return feedback_row;
END;
/


CREATE OR REPLACE FUNCTION GET_ALREADY_SELECTED_BATCH(
	s_student_id 	Students.user_id%TYPE,
	c_coaching_id	Coachings.coaching_id%TYPE,
	c_class				Courses.class%TYPE,
	c_subject			Courses.subject%TYPE
)
return BATCH
AS
batch_row BATCH := BATCH(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
BEGIN
	FOR r IN(
		SELECT batch_id,status
		FROM EnrolledIn NATURAL JOIN Courses
		WHERE coaching_id = c_coaching_id
		AND  class = c_class
		AND subject = c_subject
		AND student_id = s_student_id
	)LOOP
		batch_row := GET_BATCH_DETAILS(r.batch_id);
		batch_row.status := r.status;
	END LOOP;
	return batch_row;
END;
/
