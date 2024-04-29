/*
9. Busque el programa guardado en el archivo. create_assignment.sql. Vuelva a escribirlo como un procedimiento que acepta la descripción
de la asignación como parámetro de entrada.
*/

CREATE OR REPLACE PROCEDURE create_assignment (p_assign_descrip IN assessments.description%TYPE) IS
    v_assessment_id assessments.assessment_id%TYPE;
    BEGIN
        SELECT MAX(assessment_id) INTO v_assessment_id FROM assessments;
        INSERT INTO assessments (assessment_id, description) VALUES (v_assessment_id+1, p_assign_descrip);
        COMMIT;
    END create_assignment;

BEGIN
create_assignment('Prueba');
END;

SELECT * FROM assessments;