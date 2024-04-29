/*
4. Cree un bloque anónimo para enumerar todas las clases ofrecidas entre un rango de fechas. Guarde su programa en 
un archivo llamadoshow_class_offerings.sql. Acepte una fecha de inicio y una fecha de finalización. Para cada clase 
encontrada, muestre CLASS_ID, START_DATE, instructor FIRST_NAME y LAST_NAME, curso TITLE y SECTION_CODE.
*/
/*
select * from classes 
-- class_id, start_date
select * from instructors 
-- first_name, last_name
select * from courses 
-- title, section_code
*/

SELECT c.class_id, c.start_date, i.first_name, i.last_name, co.title, co.section_code
FROM classes c, instructors i, courses co
WHERE c.start_date >= TO_DATE('09/08/2004', 'DD/MM/YYYY') AND c.start_date <= TO_DATE('31/12/2021', 'DD/MM/YYYY')
ORDER BY c.class_id, c.start_date, i.first_name, i.last_name, co.title, co.section_code;