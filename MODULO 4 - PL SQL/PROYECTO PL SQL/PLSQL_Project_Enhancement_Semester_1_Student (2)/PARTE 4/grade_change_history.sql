/*

Parte 4: Crear activadores de base de datos
1. Cree el grade_change_history tabla de la siguiente manera:
*/

CREATE TABLE grade_change_history
(time_stamp DATE,
stu_id NUMBER(7,0),
class_id NUMBER(6,0),
enroll_date DATE, 
old_final_grade CHAR(1), 
new_final_grade CHAR(1));