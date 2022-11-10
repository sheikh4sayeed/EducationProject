CREATE OR REPLACE FUNCTION GET_MEMBER_NOTICES(
	s_student_id	Students.user_id%TYPE
)
return NOTICE_ARRAY
AS
notice_list NOTICE_ARRAY := NOTICE_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Notices
		ORDER BY notice_id DESC
	)LOOP
	IF IS_MEMBER_INCLUDED(s_student_id,r.admin_id,r.coaching_id,r.class,r.subject,r.batch_id) = 'YES' THEN
		notice_list.EXTEND;
		notice_list(notice_list.LAST) := GET_NOTICE_DETAILS(r.notice_id);
	END IF;
	END LOOP;
	return notice_list;
END;
/

CREATE OR REPLACE FUNCTION GET_STUDENT_SCHEDULE(
	s_student_id	Students.user_id%TYPE
)
return SCHEDULE_ARRAY
AS
schedule_list SCHEDULE_ARRAY := SCHEDULE_ARRAY();
BEGIN
	FOR r IN (
		SELECT start_date, class_days, start_time, end_time, tutor_id as entity_id, name, image, subjects
		FROM Offers NATURAL JOIN Tutions 
		JOIN Users ON tutor_id = user_id
		WHERE student_id = s_student_id
		AND status = 'ACCEPTED'
		UNION
		SELECT start_date, class_days, start_time, end_time, -1 as entity_id, name, image, subject AS subjects
		FROM EnrolledIn 
		NATURAL JOIN Coachings
		NATURAL JOIN Courses
		NATURAL JOIN Batches 
		WHERE student_id = s_student_id
		AND status = 'APPROVED'
		ORDER BY start_time ASC
	)LOOP
	schedule_list.EXTEND;
	schedule_list(schedule_list.LAST) := SCHEDULE(TO_CHAR(r.start_date,'DD/MON/YYYY'),r.class_days,TO_CHAR(r.start_time,'DD/MON/YYYY HH24:MI:SS'),TO_CHAR(r.end_time,'DD/MON/YYYY HH24:MI:SS'),r.entity_id, r.name,r.image,r.subjects);
	END LOOP;
	return schedule_list;
END;
/

CREATE OR REPLACE FUNCTION GET_STUDENT_ALL_SCHEDULE(
	s_student_id	Students.user_id%TYPE
)
return SCHEDULE_ARRAY
AS
schedule_list SCHEDULE_ARRAY := SCHEDULE_ARRAY();
BEGIN
	FOR r IN (
		SELECT start_date, class_days, start_time, end_time, tutor_id as entity_id, name, image, subjects
		FROM Offers NATURAL JOIN Tutions 
		JOIN Users ON tutor_id = user_id
		WHERE student_id = s_student_id
		AND (status <> 'CANCELLED' AND status <> 'REJECTED')
		UNION
		SELECT start_date, class_days, start_time, end_time, -1 as entity_id, name, image, subject AS subjects
		FROM EnrolledIn 
		NATURAL JOIN Coachings
		NATURAL JOIN Courses
		NATURAL JOIN Batches 
		WHERE student_id = s_student_id
		ORDER BY start_time ASC
	)LOOP
	schedule_list.EXTEND;
	schedule_list(schedule_list.LAST) := SCHEDULE(TO_CHAR(r.start_date,'DD/MON/YYYY'),r.class_days,TO_CHAR(r.start_time,'DD/MON/YYYY HH24:MI:SS'),TO_CHAR(r.end_time,'DD/MON/YYYY HH24:MI:SS'),r.entity_id, r.name,r.image,r.subjects);
	END LOOP;
	return schedule_list;
END;
/

CREATE OR REPLACE FUNCTION GET_TUTOR_SCHEDULE(
	t_tutor_id	Tutors.user_id%TYPE
)
return SCHEDULE_ARRAY
AS
schedule_list SCHEDULE_ARRAY := SCHEDULE_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Offers NATURAL JOIN Tutions 
		JOIN Users ON student_id = user_id
		WHERE tutor_id = t_tutor_id
		AND status = 'ACCEPTED'
		ORDER BY start_time ASC
	)LOOP
	schedule_list.EXTEND;
	schedule_list(schedule_list.LAST) := SCHEDULE(TO_CHAR(r.start_date,'DD/MON/YYYY'),r.class_days,TO_CHAR(r.start_time,'DD/MON/YYYY HH24:MI:SS'),TO_CHAR(r.end_time,'DD/MON/YYYY HH24:MI:SS'),r.student_id, r.name,r.image,r.subjects);
	END LOOP;
	return schedule_list;
END;
/

CREATE OR REPLACE FUNCTION GET_ALL_MATERIALS
	return MATERIAL_ARRAY
AS
material_list MATERIAL_ARRAY := MATERIAL_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Materials
		ORDER BY material_id DESC
	)LOOP
	material_list.EXTEND;
	material_list(material_list.LAST) := GET_MATERIAL_DETAILS(r.material_id);
	END LOOP;
	return material_list;
END;
/


CREATE OR REPLACE FUNCTION GET_ADMIN_COURSES(
	t_tutor_id	Tutors.user_id%TYPE
)
return COURSE_ARRAY
AS
course_list COURSE_ARRAY := COURSE_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM MemberOf NATURAL JOIN Courses
		WHERE user_id = t_tutor_id AND type = 'ADMIN'
		ORDER BY course_id ASC
	)LOOP
		course_list.EXTEND;
		course_list(course_list.LAST) := GET_COURSE_DETAILS(r.course_id, NULL);
	END LOOP;
	return course_list;
END;
/

CREATE OR REPLACE FUNCTION GET_COACHING_COURSES(
	c_coaching_id	Coachings.coaching_id%TYPE
)
return COURSE_ARRAY
AS
course_list COURSE_ARRAY := COURSE_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Courses
		WHERE coaching_id = c_coaching_id
		ORDER BY course_id ASC
	)LOOP
		course_list.EXTEND;
		course_list(course_list.LAST) := GET_COURSE_DETAILS(r.course_id, NULL);
	END LOOP;
	return course_list;
END;
/

CREATE OR REPLACE FUNCTION GET_MEMBER_COURSES(
	s_student_id	Students.user_id%TYPE
)
return COURSE_ARRAY
AS
course_list COURSE_ARRAY := COURSE_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM EnrolledIn
		WHERE student_id = s_student_id
		ORDER BY course_id ASC
	)LOOP
		course_list.EXTEND;
		course_list(course_list.LAST) := GET_COURSE_DETAILS(r.course_id,r.batch_id);
		course_list(course_list.LAST).status := r.status;
	END LOOP;
	return course_list;
END;
/


CREATE OR REPLACE FUNCTION GET_FEEDBACKS(
	t_tutor_id 		Tutors.user_id%TYPE
)
return FEEDBACK_ARRAY
AS
feedback_list FEEDBACK_ARRAY := FEEDBACK_ARRAY();
BEGIN
	FOR r IN(
		SELECT feedback_id
		FROM Offers
		WHERE tutor_id = t_tutor_id AND status = 'ACCEPTED'
		AND feedback_id IS NOT NULL
		ORDER BY feedback_id ASC
	)LOOP
	feedback_list.EXTEND;
	feedback_list(feedback_list.LAST) := GET_FEEDBACK_DETAILS(r.feedback_id);
	END LOOP;
	return feedback_list;
END;
/


CREATE OR REPLACE FUNCTION GET_TUTOR_ALL_SCHEDULE(
	t_tutor_id	Tutors.user_id%TYPE
)
return SCHEDULE_ARRAY
AS
schedule_list SCHEDULE_ARRAY := SCHEDULE_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Offers NATURAL JOIN Tutions 
		JOIN Users ON student_id = user_id
		WHERE tutor_id = t_tutor_id
		AND status = 'ACCEPTED'
		ORDER BY start_time ASC
	)LOOP
	schedule_list.EXTEND;
	schedule_list(schedule_list.LAST) := SCHEDULE(TO_CHAR(r.start_date,'DD/MON/YYYY'),r.class_days,TO_CHAR(r.start_time,'DD/MON/YYYY HH24:MI:SS'),TO_CHAR(r.end_time,'DD/MON/YYYY HH24:MI:SS'),r.student_id, r.name,r.image,r.subjects);
	END LOOP;
	return schedule_list;
END;
/


CREATE OR REPLACE FUNCTION GET_ADMIN_NOTICES(
	n_admin_id	Notices.admin_id%TYPE
)
return NOTICE_ARRAY
AS
notice_list NOTICE_ARRAY := NOTICE_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Notices
		WHERE admin_id = n_admin_id
		ORDER BY notice_id DESC
	)LOOP
	notice_list.EXTEND;
	notice_list(notice_list.LAST) := GET_NOTICE_DETAILS(r.notice_id);
	END LOOP;
	return notice_list;
END;
/


CREATE OR REPLACE FUNCTION GET_NOTIFICATIONS(
	u_user_id		Users.user_id%TYPE
)
return NOTIFICATION_ARRAY
AS
notification_list NOTIFICATION_ARRAY := NOTIFICATION_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Notifications
		WHERE user_id = u_user_id
		ORDER BY notification_id DESC
	)LOOP
	notification_list.EXTEND;
	notification_list(notification_list.LAST) := GET_NOTIFICATION_DETAILS(r.notification_id);
	END LOOP;
	return notification_list;
END;
/

CREATE OR REPLACE FUNCTION GET_ALL_TUTION_POSTS(
	t_tutor_id Tutors.user_id%TYPE
)
return TUTION_POST_ARRAY
AS
tution_post_list TUTION_POST_ARRAY := TUTION_POST_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Tution_Posts
		WHERE booking_status IS NULL OR booking_status = 'PENDING'
		ORDER BY post_id DESC
	)LOOP
		IF IS_OFFER_EXISTS(t_tutor_id,r.student_id) = 'NO' THEN
			tution_post_list.EXTEND;
			tution_post_list(tution_post_list.LAST) := GET_TUTION_POST_DETAILS(r.post_id);
		END IF;
	END LOOP;
	return tution_post_list;
END;
/

CREATE OR REPLACE FUNCTION GET_FILTERED_TUTION_POSTS(
	t_tutor_id 			Tutors.user_id%TYPE,
	u_gender				Users.gender%TYPE,
	t_start					Tutions.salary%TYPE,
	t_end						Tutions.salary%TYPE,
	t_days_per_week	Tutions.days_per_week%TYPE,
	s_version				Students.version%TYPE,
	t_type					Tutions.type%TYPE,
	s_class					Students.class%TYPE
)
return TUTION_POST_ARRAY
AS
tution_post_list TUTION_POST_ARRAY := TUTION_POST_ARRAY();
BEGIN
	FOR r IN (
		SELECT post_id,student_id
		FROM Tution_Posts Natural Join Tutions
		JOIN Students 
		ON student_id = user_id
		NATURAL JOIN Users
		WHERE salary >= t_start AND salary <= t_end
		AND days_per_week <= t_days_per_week
		AND (u_gender = 'Any' OR gender = u_gender)
		AND (s_version = 'Any' OR version = s_version)
		AND (t_type = 'Any' OR type = t_type)
		AND (s_class = 'Any' OR class = s_class)
		AND (booking_status IS NULL OR booking_status = 'PENDING')
		ORDER BY post_id DESC
	)LOOP
	IF IS_OFFER_EXISTS(t_tutor_id,r.student_id) = 'NO' THEN
		tution_post_list.EXTEND;
		tution_post_list(tution_post_list.LAST) := GET_TUTION_POST_DETAILS(r.post_id);
	END IF;
	END LOOP;
	return tution_post_list;
END;
/


CREATE OR REPLACE FUNCTION IS_APPLIED_FILTERED(
	t_tutor_id 			Tutors.user_id%TYPE,
	u_gender				Users.gender%TYPE,
	t_start					Tutions.salary%TYPE,
	t_end						Tutions.salary%TYPE,
	t_days_per_week	Tutions.days_per_week%TYPE,
	s_version				Students.version%TYPE,
	t_type					Tutions.type%TYPE,
	s_class					Students.class%TYPE
)
return STRING_ARRAY 
AS
apply_list STRING_ARRAY := STRING_ARRAY();
BEGIN	
	FOR r IN (
	SELECT tutor_id,student_id
	FROM Tution_Posts T
	Natural Join Tutions
	JOIN Students 
	ON student_id = user_id
	NATURAL JOIN Users
	LEFT OUTER JOIN Applies A
	ON A.post_id = T.post_id AND tutor_id = t_tutor_id
	WHERE salary >= t_start AND salary <= t_end
	AND days_per_week <= t_days_per_week
	AND (u_gender = 'Any' OR gender = u_gender)
	AND (s_version = 'Any' OR version = s_version)
	AND (t_type = 'Any' OR type = t_type)
	AND (s_class = 'Any' OR class = s_class)
	AND (booking_status IS NULL OR booking_status = 'PENDING')
	ORDER BY T.post_id DESC
	)LOOP
	IF IS_OFFER_EXISTS(t_tutor_id,r.student_id) = 'NO' THEN
		apply_list.EXTEND;
		IF r.tutor_id IS NULL  THEN
			apply_list(apply_list.LAST) := 'NO';
		ELSE 
			apply_list(apply_list.LAST) := 'YES';
		END IF;
	END IF;
	END LOOP;
	return apply_list;
END;
/

CREATE OR REPLACE FUNCTION IS_APPLIED(
	t_tutor_id Tutors.user_id%TYPE
)
return STRING_ARRAY 
AS
apply_list STRING_ARRAY := STRING_ARRAY();
BEGIN	
	FOR r IN (
	SELECT tutor_id,student_id
	FROM Tution_Posts T
	LEFT OUTER JOIN Applies A
	ON A.post_id = T.post_id AND tutor_id = t_tutor_id
	WHERE (booking_status IS NULL OR booking_status = 'PENDING')
	ORDER BY T.post_id DESC
	)LOOP
	IF IS_OFFER_EXISTS(t_tutor_id,r.student_id) = 'NO' THEN
		apply_list.EXTEND;
		IF r.tutor_id IS NULL  THEN
			apply_list(apply_list.LAST) := 'NO';
		ELSE 
			apply_list(apply_list.LAST) := 'YES';
		END IF;
	END IF;
	END LOOP;
	return apply_list;
END;
/

CREATE OR REPLACE FUNCTION IS_JOINED(
	s_student_id	Students.user_id%TYPE
)
return STRING_ARRAY 
AS
join_list STRING_ARRAY := STRING_ARRAY();
BEGIN	
	FOR r IN (
	SELECT user_id
	FROM Coachings C
	LEFT OUTER JOIN MemberOf M
	ON C.coaching_id = M.coaching_id AND user_id = s_student_id
	ORDER BY C.coaching_id ASC
	)LOOP
	join_list.EXTEND;
	IF r.user_id IS NULL  THEN
		join_list(join_list.LAST) := 'NO';
	ELSE 
		join_list(join_list.LAST) := 'YES';
	END IF;
	END LOOP;
	return join_list;
END;
/

CREATE OR REPLACE FUNCTION GET_MY_TUTION_POSTS(
	s_student_id	Students.user_id%TYPE
)
return TUTION_POST_ARRAY
AS
tution_post_list TUTION_POST_ARRAY := TUTION_POST_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Tution_Posts
		WHERE student_id = s_student_id
		ORDER BY post_id DESC
	)LOOP
		tution_post_list.EXTEND;
		tution_post_list(tution_post_list.LAST) := GET_TUTION_POST_DETAILS(r.post_id);
	END LOOP;
	return tution_post_list;
END;
/

CREATE OR REPLACE FUNCTION GET_ALL_STUDENTS
return STUDENT_ARRAY
AS
	student_list		STUDENT_ARRAY := STUDENT_ARRAY();
BEGIN
	FOR r IN (
		SELECT * 	 	
		FROM Students
		ORDER BY user_id ASC
	)LOOP
		student_list.EXTEND;
		student_list(student_list.LAST) := GET_STUDENT_DETAILS(r.user_id);
	END LOOP;
	return student_list;
END;	
/


CREATE OR REPLACE FUNCTION GET_MY_STUDENTS(
	t_tutor_id Tutors.user_id%TYPE
)
return STUDENT_ARRAY
AS
	student_list		STUDENT_ARRAY := STUDENT_ARRAY();
BEGIN
	FOR r IN (
		SELECT * 	 	
		FROM Offers 
		WHERE tutor_id = t_tutor_id AND status = 'ACCEPTED'
		ORDER BY student_id ASC
	)LOOP
		student_list.EXTEND;
		student_list(student_list.LAST) := GET_STUDENT_DETAILS(r.student_id);
	END LOOP;
	return student_list;
END;	
/


CREATE OR REPLACE FUNCTION GET_PENDING_STUDENTS(
	t_tutor_id Tutors.user_id%TYPE
)
return STUDENT_ARRAY
AS
	student_list		STUDENT_ARRAY := STUDENT_ARRAY();
BEGIN
	FOR r IN (
		SELECT * 	 	
		FROM Offers 
		WHERE tutor_id = t_tutor_id 
		AND (status = 'PENDING' OR status = 'UPDATE')
		ORDER BY student_id ASC
	)LOOP
		student_list.EXTEND;
		student_list(student_list.LAST) := GET_STUDENT_DETAILS(r.student_id);
	END LOOP;
	return student_list;
END;	
/




CREATE OR REPLACE FUNCTION GET_PENDING_TUTIONS(
	t_tutor_id Tutors.user_id%TYPE
)
return TUTION_ARRAY
AS
	tution_list TUTION_ARRAY := TUTION_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Offers
		WHERE tutor_id = t_tutor_id 
		AND (status = 'PENDING' OR status = 'UPDATE')
		ORDER BY student_id ASC 
	)LOOP
		tution_list.EXTEND;
		tution_list(tution_list.LAST) := GET_TUTION_DETAILS(t_tutor_id,r.student_id);
	END LOOP;
	return tution_list;
END;
/

CREATE OR REPLACE FUNCTION GET_COACHING_STUDENTS(
	c_coaching_id	Coachings.coaching_id%TYPE
)
return STUDENT_ARRAY
AS
	student_list		STUDENT_ARRAY := STUDENT_ARRAY();
BEGIN
	FOR r IN (
		SELECT user_id 	 	
		FROM MemberOf
		WHERE coaching_id = c_coaching_id
		AND type = 'MEMBER'
		ORDER BY user_id ASC
	)LOOP
		student_list.EXTEND;
		student_list(student_list.LAST) := GET_STUDENT_DETAILS(r.user_id);
	END LOOP;
	return student_list;
END;	
/

CREATE OR REPLACE FUNCTION GET_JOIN_REQUESTS(
	c_coaching_id	Coachings.coaching_id%TYPE
)
return STUDENT_ARRAY
AS
	student_list		STUDENT_ARRAY := STUDENT_ARRAY();
BEGIN
	FOR r IN (
		SELECT user_id 	 	
		FROM MemberOf
		WHERE coaching_id = c_coaching_id
		AND type = 'PENDING'
		ORDER BY user_id ASC
	)LOOP
		student_list.EXTEND;
		student_list(student_list.LAST) := GET_STUDENT_DETAILS(r.user_id);
	END LOOP;
	return student_list;
END;	
/

CREATE OR REPLACE FUNCTION GET_COURSE_STUDENTS(
	c_coaching_id	Coachings.coaching_id%TYPE,
	c_class				Courses.class%TYPE,
	c_subject			Courses.subject%TYPE,
	b_batch_id		Batches.batch_id%TYPE
)
return STUDENT_ARRAY
AS
	student_list		STUDENT_ARRAY := STUDENT_ARRAY();
BEGIN
	FOR r IN (
		SELECT student_id
    FROM EnrolledIn NATURAL JOIN Courses NATURAL JOIN Batches 
    WHERE coaching_id = c_coaching_id
    AND (c_class IS NULL OR class = c_class)
    AND (c_subject IS NULL OR subject = c_subject)
    AND (b_batch_id IS NULL OR batch_id = b_batch_id)
		AND status = 'APPROVED'
		ORDER BY student_id ASC
	)LOOP
		student_list.EXTEND;
		student_list(student_list.LAST) := GET_STUDENT_DETAILS(r.student_id);
	END LOOP;
	return student_list;
END;	
/

CREATE OR REPLACE FUNCTION GET_PENDING_ENROLLMENTS(
	c_coaching_id	Coachings.coaching_id%TYPE,
	c_class				Courses.class%TYPE,
	c_subject			Courses.subject%TYPE,
	b_batch_id		Batches.batch_id%TYPE
)
return STUDENT_ARRAY
AS
	student_list		STUDENT_ARRAY := STUDENT_ARRAY();
BEGIN
	FOR r IN (
		SELECT student_id
    FROM EnrolledIn NATURAL JOIN Courses NATURAL JOIN Batches 
    WHERE coaching_id = c_coaching_id
    AND (c_class IS NULL OR class = c_class)
    AND (c_subject IS NULL OR subject = c_subject)
    AND (b_batch_id IS NULL OR batch_id = b_batch_id)
		AND status = 'PENDING'
		ORDER BY student_id ASC
	)LOOP
		student_list.EXTEND;
		student_list(student_list.LAST) := GET_STUDENT_DETAILS(r.student_id);
	END LOOP;
	return student_list;
END;	
/


CREATE OR REPLACE FUNCTION GET_ALL_TUTORS
return TUTOR_ARRAY
AS
	tutor_list TUTOR_ARRAY := TUTOR_ARRAY();
BEGIN
	FOR r IN (
		SELECT * 	 	
		FROM Tutors
		ORDER BY user_id ASC
	)LOOP
		tutor_list.EXTEND;
		tutor_list(tutor_list.LAST) := GET_TUTOR_DETAILS(r.user_id);
	END LOOP;
	return tutor_list;
END;	
/

CREATE OR REPLACE FUNCTION GET_FILTERED_TUTORS(
	u_gender			Users.gender%TYPE,
	t_start				Tutions.salary%TYPE,
	t_end					Tutions.salary%TYPE,
	t_status			Tutors.availability%TYPE,
	t_experience	Tutors.years_of_experience%TYPE
)
return TUTOR_ARRAY
AS
	tutor_list TUTOR_ARRAY := TUTOR_ARRAY();
BEGIN
	FOR r IN (
		SELECT * 	 	
		FROM Tutors NATURAL JOIN Users
		WHERE (u_gender = 'Any' OR gender = u_gender)
		AND	preffered_salary >= t_start AND preffered_salary <= t_end
		AND (t_status = 'Any' OR availability = t_status)
		AND years_of_experience >= t_experience
		ORDER BY user_id ASC
	)LOOP
		tutor_list.EXTEND;
		tutor_list(tutor_list.LAST) := GET_TUTOR_DETAILS(r.user_id);
	END LOOP;
	return tutor_list;
END;	
/

CREATE OR REPLACE FUNCTION GET_MY_TUTORS(
	s_student_id 	Students.user_id%TYPE
)
return TUTOR_ARRAY
AS
	tutor_list TUTOR_ARRAY := TUTOR_ARRAY();
BEGIN
	FOR r IN (
		SELECT * 	 	
		FROM Offers
		WHERE student_id = s_student_id AND status = 'ACCEPTED'
		ORDER BY tutor_id ASC
	)LOOP
		tutor_list.EXTEND;
		tutor_list(tutor_list.LAST) := GET_TUTOR_DETAILS(r.tutor_id);
	END LOOP;
	return tutor_list;
END;	
/

CREATE OR REPLACE FUNCTION GET_ALL_COACHINGS(
	s_student_id	Students.user_id%TYPE
)
return COACHING_ARRAY
AS
	coaching_list COACHING_ARRAY := COACHING_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
    FROM Coachings
		ORDER BY coaching_id ASC
	)LOOP
		coaching_list.EXTEND;
		coaching_list(coaching_list.LAST) := GET_COACHING_DETAILS(r.coaching_id);
		FOR r2 IN(
			SELECT type
			FROM MemberOf
			WHERE user_id = s_student_id AND coaching_id = r.coaching_id
		)LOOP
			coaching_list(coaching_list.LAST).type := r2.type;
		END LOOP;
	END LOOP;
	return coaching_list;
END;	
/



CREATE OR REPLACE FUNCTION GET_MY_COACHINGS(
	id	Users.user_id%TYPE
)
return COACHING_ARRAY
AS
	coaching_list COACHING_ARRAY := COACHING_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM MemberOf
		WHERE user_id = id AND (type = 'MEMBER'  OR type = 'ADMIN')
		ORDER BY coaching_id ASC
	)LOOP
		coaching_list.EXTEND;
		coaching_list(coaching_list.LAST) := GET_COACHING_DETAILS(r.coaching_id);
		coaching_list(coaching_list.LAST).type := r.type;
	END LOOP;
	return coaching_list;
END;	
/

CREATE OR REPLACE FUNCTION GET_ALL_APPLICANTS(
	tp_post_id Tution_Posts.post_id%TYPE
)
return TUTOR_ARRAY
AS
	tutor_list TUTOR_ARRAY := TUTOR_ARRAY();
BEGIN
	FOR r IN (
		SELECT A.tutor_id 	 	
		FROM Tution_Posts T NATURAL JOIN APPLIES A
		LEFT OUTER JOIN Offers O
		ON T.student_id = O.student_id
		AND A.tutor_id 	= O.tutor_id
		WHERE (status <> 'ACCEPTED' OR status IS NULL)
		AND post_id = tp_post_id
		ORDER BY tutor_id ASC
	)LOOP
		tutor_list.EXTEND;
		tutor_list(tutor_list.LAST) := GET_TUTOR_DETAILS(r.tutor_id);
	END LOOP;
	return tutor_list;
END;	
/

CREATE OR REPLACE FUNCTION GET_EDUCATIONS(
	t_tutor_id Tutors.user_id%TYPE
)
return EDUCATION_ARRAY
AS
	education_list EDUCATION_ARRAY := EDUCATION_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Educations
		WHERE tutor_id = t_tutor_id
		ORDER BY passing_year DESC
	)LOOP
		education_list.EXTEND;
		education_list(education_list.LAST) := GET_EDUCATION_DETAILS(r.eq_id);
	END LOOP;
	return education_list;
END;
/

CREATE OR REPLACE FUNCTION GET_APPLICANTS_TUTION_DETAILS(
	tp_post_id Tution_Posts.post_id%TYPE,
	s_student_id Students.user_id%TYPE
)
return TUTION_ARRAY
AS
tution_list TUTION_ARRAY := TUTION_ARRAY();
BEGIN
	FOR r IN (
		SELECT A.tutor_id, O.status
		FROM Tution_Posts T NATURAL JOIN Applies A
		LEFT OUTER JOIN Offers O
		ON T.student_id = O.student_id 
		AND A.tutor_id = O.tutor_id
		WHERE (status <> 'ACCEPTED' OR status IS NULL)
		AND post_id = tp_post_id
		ORDER BY A.tutor_id ASC
	)LOOP
		tution_list.EXTEND;
		IF r.status IS NULL THEN
			tution_list(tution_list.LAST) := GET_TUTION_DETAILS_FROM_POST(tp_post_id);
		ELSE 
			tution_list(tution_list.LAST) := GET_TUTION_DETAILS(r.tutor_id,s_student_id);
		END IF;
	END LOOP;
	return tution_list;
END;
/


CREATE OR REPLACE FUNCTION GET_ALL_TUTIONS(
	s_student_id Students.user_id%TYPE
)
return TUTION_ARRAY
AS
	tution_list TUTION_ARRAY := TUTION_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Tutors
		ORDER BY user_id ASC 
	)LOOP
		tution_list.EXTEND;
		tution_list(tution_list.LAST) := GET_TUTION_DETAILS(r.user_id,s_student_id);
	END LOOP;
	return tution_list;
END;
/

CREATE OR REPLACE FUNCTION GET_FILTERED_TUTIONS(
	s_student_id 	Students.user_id%TYPE,
	u_gender			Users.gender%TYPE,
	t_start				Tutions.salary%TYPE,
	t_end					Tutions.salary%TYPE,
	t_status			Tutors.availability%TYPE,
	t_experience	Tutors.years_of_experience%TYPE
)
return TUTION_ARRAY
AS
	tution_list TUTION_ARRAY := TUTION_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Tutors NATURAL JOIN Users
		WHERE (u_gender = 'Any' OR gender = u_gender)
		AND	preffered_salary >= t_start AND preffered_salary <= t_end
		AND (t_status = 'Any' OR availability = t_status)
		AND years_of_experience >= t_experience
		ORDER BY user_id ASC 
	)LOOP
		tution_list.EXTEND;
		tution_list(tution_list.LAST) := GET_TUTION_DETAILS(r.user_id,s_student_id);
	END LOOP;
	return tution_list;
END;
/

CREATE OR REPLACE FUNCTION GET_MY_TUTIONS_BY_STUDENT(
	s_student_id Students.user_id%TYPE
)
return TUTION_ARRAY
AS
	tution_list TUTION_ARRAY := TUTION_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Offers
		WHERE student_id = s_student_id 
		AND status = 'ACCEPTED'
		ORDER BY tutor_id ASC 
	)LOOP
		tution_list.EXTEND;
		tution_list(tution_list.LAST) := GET_ACCEPTED_TUTION_DETAILS(r.tutor_id,s_student_id);
	END LOOP;
	return tution_list;
END;
/

CREATE OR REPLACE FUNCTION GET_MY_TUTIONS_BY_TUTOR(
	t_tutor_id Tutors.user_id%TYPE
)
return TUTION_ARRAY
AS
	tution_list TUTION_ARRAY := TUTION_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Offers
		WHERE tutor_id = t_tutor_id 
		AND status = 'ACCEPTED'
		ORDER BY student_id ASC 
	)LOOP
		tution_list.EXTEND;
		tution_list(tution_list.LAST) := GET_TUTION_DETAILS(t_tutor_id,r.student_id);
	END LOOP;
	return tution_list;
END;
/

CREATE OR REPLACE FUNCTION  GET_BATCHES(
	c_course_id	Courses.course_id%TYPE
)
return BATCH_ARRAY
AS
batch_list BATCH_ARRAY := BATCH_ARRAY();
BEGIN
	FOR r IN (
			SELECT *
      FROM Batches 
      WHERE course_id = c_course_id
			ORDER BY batch_id ASC
	)LOOP
		batch_list.EXTEND;
		batch_list(batch_list.LAST) := GET_BATCH_DETAILS(r.batch_id);
	END LOOP;
	return batch_list;
END;
/

CREATE OR REPLACE FUNCTION  GET_BATCH_OPTIONS(
	s_student_id 	Students.user_id%TYPE,
	c_coaching_id	Coachings.coaching_id%TYPE,
	c_class				Courses.class%TYPE,
	c_subject			Courses.subject%TYPE
)
return BATCH_ARRAY
AS
batch_list BATCH_ARRAY := BATCH_ARRAY();
batch_row BATCH;
BEGIN
	batch_row := GET_ALREADY_SELECTED_BATCH(s_student_id,c_coaching_id,c_class,c_subject);
	IF batch_row.batch_id IS NOT NULL THEN
		batch_list.EXTEND;
		batch_list(batch_list.LAST) := batch_row;
		return batch_list;
	END IF;
	FOR r IN (
			SELECT *
      FROM Courses NATURAL JOIN Batches 
      WHERE coaching_id = c_coaching_id
      AND class = c_class
      AND subject = c_subject
			ORDER BY batch_id ASC
	)LOOP
		batch_list.EXTEND;
		batch_list(batch_list.LAST) := GET_BATCH_DETAILS(r.batch_id);
		FOR r2 IN(
			SELECT status 
			FROM EnrolledIn
			WHERE student_id = s_student_id
			AND batch_id = r.batch_id
		)LOOP
			batch_list(batch_list.LAST).status := r2.status;
		END LOOP;
	END LOOP;
	return batch_list;
END;
/


CREATE OR REPLACE FUNCTION  GET_SUBJECT_OPTIONS(
	c_coaching_id	Coachings.coaching_id%TYPE,
	c_class				Courses.class%TYPE
)
return STRING_ARRAY
AS
subject_list STRING_ARRAY := STRING_ARRAY();
BEGIN
	FOR r IN (
			SELECT DISTINCT subject
      FROM Courses 
      WHERE coaching_id = c_coaching_id
      AND class = c_class
	)LOOP
		subject_list.EXTEND;
		subject_list(subject_list.LAST) := r.subject;
	END LOOP;
	return subject_list;
END;
/


CREATE OR REPLACE FUNCTION  GET_CLASS_OPTIONS(
	c_coaching_id	Coachings.coaching_id%TYPE
)
return STRING_ARRAY
AS
class_list STRING_ARRAY := STRING_ARRAY();
BEGIN
	FOR r IN (
			SELECT DISTINCT class
      FROM Courses 
      WHERE coaching_id = c_coaching_id
	)LOOP
		class_list.EXTEND;
		class_list(class_list.LAST) := r.class;
	END LOOP;
	return class_list;
END;
/


CREATE OR REPLACE FUNCTION GET_TUTOR_MATERIALS(
	t_tutor_id 		Tutors.user_id%TYPE
)
return MATERIAL_ARRAY
AS
material_list MATERIAL_ARRAY := MATERIAL_ARRAY();
BEGIN
	FOR r IN (
		SELECT *
		FROM Materials
		WHERE tutor_id = t_tutor_id
		ORDER BY material_id	 DESC
	)LOOP
	material_list.EXTEND;
	material_list(material_list.LAST) := GET_MATERIAL_DETAILS(r.material_id);
	END LOOP;
	return material_list;
END;
/
