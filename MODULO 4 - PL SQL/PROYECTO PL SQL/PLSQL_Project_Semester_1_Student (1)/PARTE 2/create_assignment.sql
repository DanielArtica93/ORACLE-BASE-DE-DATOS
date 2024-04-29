/*
4. Cree un bloque anónimo que un profesor pueda ejecutar para insertar una nueva tarea 
(EVALUACIÓN) que incluya una DESCRIPCIÓN. Guarde el programa en un archivo llamado
create_assignment.sql. Utilice la secuencia ASSESSMENT_ID_SEQ para generar el 
class_assessment_id.
*/

--Create sequence for assessments PK				
CREATE SEQUENCE "ASSESSMENT_ID_SEQ"  
	MINVALUE 1 
	MAXVALUE 9990 
	INCREMENT BY 1 
	START WITH 2 
	NOCACHE  NOORDER  NOCYCLE;

--
CREATE OR REPLACE PROCEDURE homework (v_assessment_id assessments.assessment_id%TYPE, v_description assessments.description%TYPE, v_grading_criteria assessments.grading_criteria%TYPE) AS
BEGIN
  INSERT INTO ASSESSMENTS(ASSESSMENT_ID, DESCRIPTION, GRADING_CRITERIA) VALUES (v_assessment_id, v_description, v_grading_criteria);
END;
----------
DECLARE
v_description assessments.description%TYPE := :Description; 
v_grading_criteria assessments.grading_criteria%TYPE := :Grading_Criteria;
BEGIN
    homework(assessment_id_seq.NEXTVAL, v_description, v_grading_criteria);
END;
------------------------------------------------------
select * from assessments
ORDER BY assessment_id asc;
------------------------------------------------------
