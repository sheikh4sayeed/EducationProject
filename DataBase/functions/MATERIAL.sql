
CREATE OR REPLACE PROCEDURE UPLOAD_MATERIAL(
	t_tutor_id 					NUMBER,
	m_material_type			Materials.material_type%TYPE,
	m_description 			Materials.description%TYPE,
	m_link 							Materials.link%TYPE
)
AS
tutor_row TUTOR;
BEGIN
	tutor_row := GET_TUTOR_DETAILS(t_tutor_id);
	INSERT INTO MATERIALS(material_type,description,link,tutor_id) 
	VALUES(m_material_type,m_description,m_link,t_tutor_id);
END;
/
