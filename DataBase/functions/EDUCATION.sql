CREATE OR REPLACE PROCEDURE ADD_EDUCATION(
	t_tutor_id 	Tutors.user_id%TYPE,
	e_institute 	Educations.institute%TYPE,
	e_field_of_study 	Educations.field_of_study%TYPE,
	e_degree 	Educations.degree%TYPE,
	e_passing_year 	Educations.passing_year%TYPE
)
AS
BEGIN
INSERT INTO Educations(tutor_id,institute,field_of_study,degree,passing_year)
VALUES(t_tutor_id,e_institute,e_field_of_study,e_degree,e_passing_year);
END;
/


CREATE OR REPLACE PROCEDURE UPDATE_EDUCATION(
	e_eq_id						Educations.eq_id%TYPE,
	t_tutor_id 				Tutors.user_id%TYPE,
	e_institute 			Educations.institute%TYPE,
	e_field_of_study 	Educations.field_of_study%TYPE,
	e_degree 					Educations.degree%TYPE,
	e_passing_year 		Educations.passing_year%TYPE
)
AS
BEGIN
UPDATE Educations SET 
tutor_id = t_tutor_id,
institute = e_institute,
field_of_study = e_field_of_study,
degree = e_degree,
passing_year = e_passing_year
WHERE eq_id = e_eq_id;
END;
/


CREATE OR REPLACE PROCEDURE DELETE_EDUCATION(
	e_eq_id 	Educations.eq_id%TYPE
)
AS
BEGIN
DELETE FROM Educations
WHERE eq_id = e_eq_id;
END;
/
