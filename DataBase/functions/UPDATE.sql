
 
CREATE OR REPLACE PROCEDURE UPDATE_USER_PROFILE(
	u_id 						Users.user_id%TYPE,
	u_name 					Users.name%TYPE,
	u_phone_number 	Users.phone_number%TYPE,
	u_date_of_birth VARCHAR2,
	u_gender 				Users.gender%TYPE
)
IS
BEGIN
	UPDATE Users 
  SET name = u_name, phone_number = u_phone_number, date_of_birth = TO_DATE(u_date_of_birth,'MM/DD/YYYY'), gender = u_gender
  WHERE user_id = u_id;
END;
/

CREATE OR REPLACE PROCEDURE UPDATE_STUDENT_PROFILE(
	u_id 						Users.user_id%TYPE,
	u_name 					Users.name%TYPE,
	u_phone_number 	Users.phone_number%TYPE,
	u_date_of_birth VARCHAR2,
	u_gender 				Users.gender%TYPE,
	s_institution		Students.institution%TYPE,
	s_version				Students.version%TYPE,
	s_class					Students.class%TYPE,
	s_address				Students.address%TYPE
)
IS
BEGIN
	UPDATE Students 
	SET institution = s_institution, version = s_version, class = s_class, address = s_address
	WHERE user_id = u_id;
	UPDATE_USER_PROFILE(u_id, u_name, u_phone_number, u_date_of_birth, u_gender);
END;
/

CREATE OR REPLACE PROCEDURE UPDATE_TUTOR_PROFILE(
	u_id 									Users.user_id%TYPE,
	u_name 								Users.name%TYPE,
	u_phone_number 				Users.phone_number%TYPE,
	u_date_of_birth 			VARCHAR2,
	u_gender 							Users.gender%TYPE,
	t_availability				Tutors.availability%TYPE,
	t_years_of_experience	Tutors.years_of_experience%TYPE,
	t_preffered_salary		Tutors.preffered_salary%TYPE,
	t_expertise						Tutors.expertise%TYPE
)
IS
BEGIN
	UPDATE Tutors 
	SET availability = t_availability, years_of_experience = t_years_of_experience, preffered_salary = t_preffered_salary, expertise = t_expertise
	WHERE user_id = u_id;
	UPDATE_USER_PROFILE(u_id, u_name, u_phone_number, u_date_of_birth, u_gender);
END;
/
