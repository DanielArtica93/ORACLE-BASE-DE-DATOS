/*

Parte 2: Gestión de estudiantes y calificaciones

La enrollments_package que creó en la Parte 1 contiene los siguientes procedimientos públicos:
1. Procedimiento enroll_student_in_class (p_stu_id IN enrollments.stu_id% TYPE, p_class_id IN 
enrollments.class_id% TYPE)
2. Procedimiento drop_student_from_class (p_stu_id IN enrollments.stu_id% TYPE, p_class_id IN 
enrollments.class_id% TYPE)
3. Procedimiento lista_clase_estudiante (p_stu_id IN enrollments.stu_id% TYPE)
La asignación y los entregables:
Modificar el lista_clase_estudiante procedimiento en el paquete, para agregar la siguiente funcionalidad:
1. Utilice la función de sobrecarga del paquete PLSQL para sobrecargar el lista_clase_estudiante
procedimiento de la siguiente manera:
• Cuando se pasa el parámetro STU_ID, el procedimiento debe mostrar una lista de las clases en las 
que se ha matriculado el alumno, en los últimos 6 años.
• Cuando se llama al procedimiento sin un parámetro, el procedimiento debe mostrar una lista de clases para 
todos los estudiantes en los que se han matriculado, dentro de los últimos 6 años.
2. Crea un procedimiento read_external_file, para leer un archivo de texto externo almacenado fuera de la base de datos como un
archivo de texto del sistema operativo. Utilice DBMS_OUTPUT para mostrar el contenido del archivo externo.
El archivo externo se llama „student_class_list.txt ' y se almacena en el directorio del sistema operativo al que hace 
referencia el objeto de directorio de Oracle ''WF_FLAGS '.
Su resultado debería verse así: Informe de inscripción Identificación del estudiante 
Fecha de inscripción Identificación de la clase
101
102
103
104
12 de agosto de 2004
12 de agosto de 2004
12 de agosto de 2004
12 de agosto de 2004
* * * FIN DEL INFORME ***
1
1
1
1
• Sugerencias: las excepciones utilizadas con UTL_FILE.GET_LINE:
• INVALID_FILEHANDLE
• OPERACIÓN INVÁLIDA
• ERROR DE LECTURA
• DATOS NO ENCONTRADOS
• VALUE_ERROR
• El nombre del objeto de directorio es: 'WF_FLAGS' y se debe hacer referencia en letras mayúsculas.

*/
-----------------------------------------------------------------------------------------------
--PACKAGE SPEC
-----------------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE enrollments_package
IS
-- Este procedimiento inscribirá a un estudiante en una clase.
PROCEDURE enroll_student_in_class 
 (p_stu_id IN enrollments.stu_id%TYPE,
 p_class_id IN enrollments.class_id%TYPE ) ;
-- Este procedimiento sacará a un estudiante de una clase.
PROCEDURE drop_student_from_class
 (p_stu_id IN enrollments.stu_id%TYPE,
 p_class_id IN enrollments.class_id%TYPE);
-- El procedimiento sobrecargado mostrará la fecha de inscripción y los identificadores de clase de un estudiante
PROCEDURE student_class_list
 (p_stu_id IN enrollments.stu_id%TYPE);
-- El procedimiento sobrecargado mostrará la fecha de inscripción y los identificadores de clase de todos los estudiantes
PROCEDURE student_class_list;
PROCEDURE read_external_file;
END enrollments_package;

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------



--PACKAGE BODY
CREATE OR REPLACE PACKAGE BODY enrollments_package
IS
-- This procedure will enroll a student in a class.
PROCEDURE enroll_student_in_class 
 (p_stu_id IN enrollments.stu_id%TYPE,
 p_class_id IN enrollments.class_id%TYPE) 
IS
 v_times_enrolled PLS_INTEGER;
 e_already_enrolled EXCEPTION;
BEGIN
 SELECT COUNT(*) INTO v_times_enrolled
 FROM enrollments
 WHERE class_id = p_class_id
 AND stu_id = p_stu_id;
 IF v_times_enrolled <> 0
 THEN RAISE e_already_enrolled;
 END IF;
 INSERT INTO enrollments (enrollment_date, class_id, stu_id,
 status)
 VALUES( SYSDATE, p_class_id, p_stu_id, 'Enrolled');
 COMMIT;
EXCEPTION
WHEN e_already_enrolled THEN
 DBMS_OUTPUT.PUT_LINE('Student ' || p_stu_id || 
' is already enrolled in class '|| p_class_id);
END enroll_student_in_class;
-- This procedure will drop a student from a class
PROCEDURE drop_student_from_class
 (p_stu_id IN enrollments.stu_id%TYPE,
 p_class_id IN enrollments.class_id%TYPE) 
IS
e_not_enrolled EXCEPTION;
BEGIN
DELETE FROM enrollments 
 WHERE class_id = p_class_id AND stu_id = p_stu_id;
IF SQL%ROWCOUNT = 0 THEN RAISE e_not_enrolled; END IF;
COMMIT;
EXCEPTION
WHEN e_not_enrolled THEN
DBMS_OUTPUT.PUT_LINE('Student ' || p_stu_id ||' is not enrolled in class '|| p_class_id);
END drop_student_from_class;
-- This procedure will list a student‟s enrollments
-- Overloaded procedure with one parameter
PROCEDURE student_class_list
 (p_stu_id IN enrollments.stu_id%TYPE)
IS
CURSOR stu_class_cur IS
SELECT enrollment_date, class_id, status
 FROM enrollments
 WHERE stu_id = p_stu_id
 AND enrollment_date 
 BETWEEN ADD_MONTHS (SYSDATE,-72) and SYSDATE;
BEGIN
DBMS_OUTPUT.PUT_LINE('Student ' || p_stu_id || 
 ' is enrolled in the following classes:');
FOR stu_class_rec IN stu_class_cur LOOP
 DBMS_OUTPUT.PUT_LINE('Class: ' ||stu_class_rec.class_id || ' Enrolled on: ' || 
stu_class_rec.enrollment_date || 
' and has a status of: '|| stu_class_rec.status );
END LOOP;
END student_class_list;
-- This procedure will list all students
-- Overloaded procedure with no parameter
PROCEDURE student_class_list
IS
CURSOR stu_class_cur IS
 SELECT enrollment_date, class_id, status, stu_id
 FROM enrollments
 WHERE enrollment_date 
 BETWEEN ADD_MONTHS (SYSDATE,-72) and SYSDATE
 ORDER BY stu_id, enrollment_date ,class_id;
BEGIN
DBMS_OUTPUT.PUT_LINE('Students are enrolled in the following classes:');
FOR stu_class_rec IN stu_class_cur LOOP
 DBMS_OUTPUT.PUT_LINE('Student: ' || stu_class_rec.stu_id || ' Class: ' 
||stu_class_rec.class_id || ' Enrolled on: ' || stu_class_rec.enrollment_date || 
' and has a status of: '|| stu_class_rec.status );
END LOOP;
END student_class_list;
--Procedure read_external_file to read and display an external operating system text file.
--
PROCEDURE read_external_file 
IS 
file UTL_FILE.FILE_TYPE;
v_line varchar2(1024);
BEGIN
--the number of bytes returned will be 1024 or less if a line terminator is seen.
 file := UTL_FILE.FOPEN ('WF_FLAGS', 'student_class_list.txt', 'r');
-- Nested Block to handle end of file errors locally.
 BEGIN
 LOOP
 UTL_FILE.GET_LINE(file , v_line);
 DBMS_OUTPUT.PUT_LINE( v_line );
 END LOOP;
 EXCEPTION
 WHEN NO_DATA_FOUND THEN
 NULL;
 END;
EXCEPTION
--If no text was read due to end of file, the NO_DATA_FOUND exception is raised
WHEN NO_DATA_FOUND THEN
 RAISE_APPLICATION_ERROR(-20005, 'END OF FILE.');
WHEN UTL_FILE.INVALID_FILEHANDLE THEN
 RAISE_APPLICATION_ERROR(-20006,'Invalid File.');
WHEN UTL_FILE.INVALID_OPERATION THEN
 RAISE_APPLICATION_ERROR (-20007, 'Unable to read or operate as requested.');
WHEN UTL_FILE.READ_ERROR THEN
 RAISE_APPLICATION_ERROR (-20008, 'Unable to read the file.');
END read_external_file;
END enrollments_package;
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
