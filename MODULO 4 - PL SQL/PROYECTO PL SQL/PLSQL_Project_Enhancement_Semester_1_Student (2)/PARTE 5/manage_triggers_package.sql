/*

Parte 5: Crear manage_triggers_package 
La asignación y los entregables:
1. Crea un paquete manage_triggers_package que contiene dos funciones sobrecargadas llamadas
manage_triggers. Las funciones se invocan para deshabilitar / habilitar todos los disparadores de una tabla o para compilar un 
disparador.
• Utilice SQL dinámico nativo para ejecutar los comandos DDL mediante programación.
• Codifique un bloque de manejo de excepciones para mostrar un mensaje si falla el comando DDL.
Utilice las siguientes pautas:
• Cuando se llama a la función con dos parámetros: manage_triggers (p_tablename, p_action)
• Pase un nombre de tabla al parámetro P_TABLENAME.
• Pase la cadena 'deshabilitar' o 'habilitar' al parámetro P_ACTION.
• Cuando se llama a la función con un solo parámetro manage_triggers (p_trigger_name)
• Pase un nombre de activador al parámetro P_TRIGGER_NAME.
Sugerencias:
• Utilice el comando ALTER TABLE para deshabilitar / habilitar todos los disparadores de una tabla 
mediante programación.
• Utilice el comando ALTER TRIGGER para compilar el desencadenador mediante programación.

*/
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------

--Create a new package to manage the database triggers.
--PACKAGE SPEC
CREATE OR REPLACE PACKAGE manage_triggers_package
IS
PROCEDURE manage_triggers(p_tablename IN VARCHAR2, p_mode IN
 VARCHAR2);
PROCEDURE manage_triggers(p_trigger_name IN VARCHAR2);
END manage_triggers_package;

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------


--PACKAGE BODY
CREATE OR REPLACE PACKAGE BODY manage_triggers_package
IS
--Overloaded Procedure manage triggers
------------------------------
PROCEDURE manage_triggers(p_tablename IN VARCHAR2, p_mode IN
 VARCHAR2)
IS
BEGIN
 EXECUTE IMMEDIATE 'ALTER TABLE '||p_tablename||' '|| p_mode || ' All TRIGGERS';
 DBMS_OUTPUT.PUT_LINE(p_tablename || ' Altered.');
EXCEPTION
 WHEN OTHERS THEN
 RAISE_APPLICATION_ERROR(-20001,'DDL Command Failed.');
END;
--Overloaded Procedure manage triggers
------------------------------
PROCEDURE manage_triggers(p_trigger_name IN VARCHAR2)
IS
 BEGIN
 EXECUTE IMMEDIATE 'ALTER TRIGGER '||p_trigger_name|| ' 
COMPILE';
 DBMS_OUTPUT.PUT_LINE(p_trigger_name|| ' Trigger Compiled. ');
 EXCEPTION
 WHEN OTHERS THEN
RAISE_APPLICATION_ERROR(-20001,'DDL Command Failed.');
 END;
END manage_triggers_package;

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------

BEGIN
 manage_triggers_package.manage_triggers('ENROLLMENTS', 'ENABLE');
END;

---------------------------------------------------------------------------------------------

BEGIN
 manage_triggers_package.manage_triggers('audit_grade_change');
END;

---------------------------------------------------------------------------------------------