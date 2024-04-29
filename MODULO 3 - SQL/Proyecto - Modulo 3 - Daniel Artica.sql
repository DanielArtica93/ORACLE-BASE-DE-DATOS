--Eliminar tablas

DROP TABLE rental_history;
DROP TABLE star_billings;
DROP TABLE customers;
DROP TABLE media;
DROP TABLE movies;
DROP TABLE actors;
DROP SEQUENCE d_customers_seq;
DROP SEQUENCE d_movies_seq;
DROP SEQUENCE d_media_seq;
DROP SEQUENCE d_actors_seq;
DROP SYNONYM tu;

--Fin de script eliminar tablas

------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

--Creación de todas las tablas, crear constraints(restricciones) y las respectivas vistas

--Tabla 1 (CUSTOMERS)

CREATE TABLE customers(
    CUSTOMER_ID NUMBER(10),
    LAST_NAME VARCHAR2(25),
    FIRST_NAME VARCHAR2(25),
    HOME_PHONE VARCHAR2(12),
    ADDRESS VARCHAR2(100),
    CITY VARCHAR2(30),
    STATE VARCHAR2(2),
    EMAIL VARCHAR2(25),
    CELL_PHONE VARCHAR2(12)
);

desc customers;

INSERT INTO customers(CUSTOMER_ID, LAST_NAME, FIRST_NAME, HOME_PHONE, ADDRESS, CITY, STATE, EMAIL, CELL_PHONE)
VALUES(101, 'Palombo', 'Lisa', '716-270-2669', '123 Main St', 'Buffalo', 'NY', 'palombo@ecc.edu', '716-555-1212');

SELECT * 
FROM customers;

--fin creación de tabla 1 customers

--Inicia creación de constraint Tabla customers
--Agregar restriccion de llave primaria a la tabla customers

ALTER TABLE customers
ADD CONSTRAINT customer_id_pk PRIMARY KEY (CUSTOMER_ID);

desc customers;

--Agregar restriccion NOT NULL a la tabla 1 customers

ALTER TABLE customers
MODIFY (CUSTOMER_ID NUMBER(10) NOT NULL, LAST_NAME VARCHAR2(25) NOT NULL, 
FIRST_NAME VARCHAR2(25) NOT NULL, HOME_PHONE VARCHAR2(12) NOT NULL, 
ADDRESS VARCHAR2(100) NOT NULL, CITY VARCHAR2(30) NOT NULL, 
STATE VARCHAR2(2) NOT NULL);

desc customers;

SELECT * 
FROM customers
ORDER BY customer_id ASC;

--Fin de la tabla 1 (customers)
-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
-----------------------------------------------

--Inicia la tabla 2 (movies)

CREATE TABLE movies(
    TITLE_ID NUMBER(10),
    TITLE VARCHAR2(60),
    DESCRIPTION VARCHAR2(400),
    RATING VARCHAR2(4),
    CATEGORY VARCHAR2(20),
    RELEASE_DATE DATE
);

desc movies;

INSERT INTO movies(TITLE_ID, TITLE, DESCRIPTION, RATING, CATEGORY, RELEASE_DATE)
VALUES(1, 'Remember the Titans', 'The true story of a newly appointed African-American 
coach and his high school team on their first season as a racially integrated unit.', 
'PG', 'DRAMA', TO_DATE('29/08/2000', 'DD/MM/YYYY'));

INSERT INTO movies(TITLE_ID, TITLE, DESCRIPTION, RATING, CATEGORY, RELEASE_DATE)
VALUES(2, 'Hacking', 'Brief summary of ethical hacking', 
'PG13', 'DOCUMENTARY', TO_DATE('31/08/2021', 'DD/MM/YYYY'));

INSERT INTO movies(TITLE_ID, TITLE, DESCRIPTION, RATING, CATEGORY, RELEASE_DATE)
VALUES(3, 'Fast and Furious', 'Movie about car competition', 
'R', 'ACTION', TO_DATE('01/09/2021', 'DD/MM/YYYY'));

INSERT INTO movies(TITLE_ID, TITLE, DESCRIPTION, RATING, CATEGORY, RELEASE_DATE)
VALUES(4, 'Goku', 'Goku animated dibujo series', 
'G', 'DOCUMENTARY', TO_DATE('02/09/2021', 'DD/MM/YYYY'));

SELECT * 
FROM movies
ORDER BY TITLE_ID ASC;

--fin creación de tabla 2 movies

--Inicia creación de constraint Tabla movies
--Agregar restriccion de llave primaria a la tabla MOVIES

ALTER TABLE movies
ADD CONSTRAINT title_id_pk PRIMARY KEY (TITLE_ID);

desc movies;

--Agregar restriccion NOT NULL a la tabla 2 MOVIES

ALTER TABLE movies
MODIFY (TITLE_ID NUMBER(10) NOT NULL, TITLE VARCHAR2(60) NOT NULL, 
DESCRIPTION VARCHAR2(400) NOT NULL, 
RELEASE_DATE DATE NOT NULL);

desc movies;

--Agregar restriccion de CHECK a la tabla 2 MOVIES

ALTER TABLE movies
ADD CONSTRAINT movies_ck CHECK(RATING = 'G' OR RATING = 'PG' 
OR RATING = 'PG13' OR RATING = 'R');

ALTER TABLE movies
ADD CONSTRAINT movies_ck2 CHECK(CATEGORY = 'DRAMA' OR CATEGORY = 'COMEDY' 
OR CATEGORY = 'ACTION' OR CATEGORY = 'CHILD' OR CATEGORY = 'SCIFI'
OR CATEGORY = 'DOCUMENTARY');

desc movies;

SELECT * 
FROM movies
ORDER BY title_id ASC;

--fin de la tabla 2 (movies)
--------------------------------
--------------------------------
--------------------------------
--------------------------------
--------------------------------
-- Inicia tabla 3 (media)

CREATE TABLE media(
    MEDIA_ID NUMBER(10),
    FORMAT VARCHAR2(3),
    TITLE_ID NUMBER(10)
);

desc media;

INSERT INTO media(MEDIA_ID, FORMAT, TITLE_ID)
VALUES(92, 'DVD', 1);

INSERT INTO media(MEDIA_ID, FORMAT, TITLE_ID)
VALUES(93, 'VHS', 1);

SELECT * 
FROM media
ORDER BY media_id ASC;

--fin creación de tabla 3 media

--Inicia creación de constraint Tabla MEDIA
--Agregar restriccion de llave primaria a la tabla MEDIA

ALTER TABLE media
ADD CONSTRAINT media_id_pk PRIMARY KEY (MEDIA_ID);

desc media;

--Agregar restriccion NOT NULL a la tabla 3 MEDIA

ALTER TABLE media
MODIFY (MEDIA_ID NUMBER(10) NOT NULL, FORMAT VARCHAR2(3) NOT NULL, 
TITLE_ID NUMBER(10) NOT NULL);

desc media;

--Agregar restricciones de llave foranea (FOREIGN KEY) tabla (media)

ALTER TABLE media
ADD CONSTRAINT media_title_fk FOREIGN KEY (TITLE_ID) REFERENCES movies(TITLE_ID);

SELECT * 
FROM media
ORDER BY media_id ASC;

--Fin de tabla 3 (MEDIA)
----------------------------------------------------
----------------------------------------------------
----------------------------------------------------
----------------------------------------------------
----------------------------------------------------

-- Inicia tabla 4 (RENTAL_HISTORY)

CREATE TABLE rental_history(
    MEDIA_ID NUMBER(10),
    RENTAL_DATE DATE,
    CUSTOMER_ID NUMBER(10),
    RETURN_DATE DATE
);

desc rental_history;

INSERT INTO rental_history(MEDIA_ID, RENTAL_DATE, CUSTOMER_ID, RETURN_DATE)
VALUES(92, SYSDATE, 101, TO_DATE(SYSDATE+1));

SELECT * 
FROM rental_history
ORDER BY media_id ASC;

--fin creación de tabla 4 rental_history

--Inicia creación de constraint Tabla rental_history
--Agregar restriccion de llave primaria

ALTER TABLE rental_history
ADD CONSTRAINT rental_history_pk PRIMARY KEY (MEDIA_ID);

desc rental_history;

--Agregar restricción 1 de llave foranea (FOREIGN KEY) a RENTAL_HISTORY

--Agregar restricciones 2 de llave foranea (FOREIGN KEY) a RENTAL_HISTORY

ALTER TABLE rental_history
ADD CONSTRAINT rental_history_media_fk FOREIGN KEY (MEDIA_ID) REFERENCES media(MEDIA_ID);

--Agregar restricción 2 de llave foranea (FOREIGN KEY) 2

ALTER TABLE rental_history
ADD CONSTRAINT rental_history_customers_fk FOREIGN KEY (CUSTOMER_ID) REFERENCES customers(CUSTOMER_ID);

SELECT * 
FROM rental_history
ORDER BY media_id ASC;

--Fin de tabla 4 (rental_history)
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------

--Inicia tabla 5 (Actors)

CREATE TABLE actors(
    ACTOR_ID NUMBER(10),
    STAGE_NAME VARCHAR2(40),
    FIRST_NAME VARCHAR2(25),
    LAST_NAME VARCHAR2(25),
    BIRTH_DATE DATE
);

desc actors;

INSERT INTO actors(ACTOR_ID, STAGE_NAME, FIRST_NAME, LAST_NAME, BIRTH_DATE)
VALUES(1001, 'Brad Pitt', 'William', 'Pitt', TO_DATE('18/12/1963', 'DD/MM/YYYY'));

INSERT INTO actors(ACTOR_ID, STAGE_NAME, FIRST_NAME, LAST_NAME, BIRTH_DATE)
VALUES(1002, 'Daniel Artica', 'Antonio', 'Artica', TO_DATE('16/07/1993', 'DD/MM/YYYY'));

INSERT INTO actors(ACTOR_ID, STAGE_NAME, FIRST_NAME, LAST_NAME, BIRTH_DATE)
VALUES(1003, 'Marco', 'Amaya', 'Antonio', TO_DATE('21/08/2000', 'DD/MM/YYYY'));

INSERT INTO actors(ACTOR_ID, STAGE_NAME, FIRST_NAME, LAST_NAME, BIRTH_DATE)
VALUES(1004, 'Danilo', 'Amaya', 'Josué', TO_DATE('22/08/1990', 'DD/MM/YYYY'));

SELECT * 
FROM actors
ORDER BY actor_id ASC;

--fin creación de tabla 5 actors

--Inicia creación de constraint Tabla 5 actors
--Agregar restriccion de llave primaria a la tabla 5 actors

ALTER TABLE actors
ADD CONSTRAINT actors_id_pk PRIMARY KEY (ACTOR_ID);

desc actors;

--Agregar restriccion NOT NULL a la tabla 5 actors

ALTER TABLE actors
MODIFY (ACTOR_ID NUMBER(10) NOT NULL, STAGE_NAME VARCHAR2(40) NOT NULL, 
FIRST_NAME VARCHAR2(25) NOT NULL, LAST_NAME VARCHAR2(25) NOT NULL, 
BIRTH_DATE DATE NOT NULL);

desc actors;

SELECT * 
FROM actors
ORDER BY actor_id ASC;

--Fin de tabla 5 (actors)
--
--
--
--
--
--
--Tabla 6(STAR_BILLINGS)

CREATE TABLE star_billings(
    ACTOR_ID NUMBER(10),
    TITLE_ID NUMBER(10),
    COMMENTS VARCHAR2(40)
);

desc star_billings;

--Agregar restriccion NOT NULL a star_billings

ALTER TABLE star_billings
MODIFY (ACTOR_ID NUMBER(10) NOT NULL, TITLE_ID NUMBER(10) NOT NULL);

desc star_billings;

--Agregar restriccion de llave primaria a la tabla 6 star_billings

ALTER TABLE star_billings
ADD CONSTRAINT star_billings_pk PRIMARY KEY (ACTOR_ID, TITLE_ID);

---    CONSTRAINT star_billings_actor_id_pk FOREIGN KEY (ACTOR_ID, TITLE_ID)

ALTER TABLE star_billings
ADD CONSTRAINT star_billings_actors_fk FOREIGN KEY (ACTOR_ID) REFERENCES actors(ACTOR_ID);

ALTER TABLE star_billings
ADD CONSTRAINT star_billings_movies_fk FOREIGN KEY (TITLE_ID) REFERENCES movies(TITLE_ID);

--Insertar tabla 6 (start_billings)

INSERT INTO star_billings(ACTOR_ID, TITLE_ID, COMMENTS) 
VALUES(1001, 2, 'Romantic Lead');

INSERT INTO star_billings(ACTOR_ID, TITLE_ID, COMMENTS) 
VALUES(1002, 1, 'Hacking');

INSERT INTO star_billings(ACTOR_ID, TITLE_ID, COMMENTS) 
VALUES(1003, 3, 'Fast and Furious');

INSERT INTO star_billings(ACTOR_ID, TITLE_ID, COMMENTS) 
VALUES(1004, 4, 'Goku');

SELECT * 
FROM movies
ORDER BY title_id ASC;

SELECT * 
FROM actors
ORDER BY actor_id ASC;

SELECT * 
FROM star_billings
ORDER BY actor_id ASC;

--fin creación de tabla 6 (star_billings)

--Fin tabla 6 (star_billings)

---Creación de vista solicitada dónde el TITLE_ID DEBE SER MAYOR O IGUAL A 1

CREATE OR REPLACE FORCE VIEW view_title_unavail
AS SELECT mov.TITLE_ID AS "ID TITULO", mov.TITLE AS "TITULO", 
med.MEDIA_ID AS "ID MEDIA", med.FORMAT AS "ALMACENAMIENTO FISICO"
FROM media med, movies mov 
WHERE mov.TITLE_ID >= 1
ORDER BY mov.TITLE_ID, mov.TITLE, med.MEDIA_ID, med.FORMAT
WITH READ ONLY;

SELECT *
FROM view_title_unavail;

--DROP VIEW view_title_unavail;

--SELECT * FROM movies;

--SELECT * FROM media;


--Sección 16: Trabajar con Secuencias (Índices y Sinónimos)

--4  y 5 Cree las siguientes secuencias que se van a utilizar para los valores de clave primaria:
--Utilice una secuencia para generar claves primarias para CUSTOMER_ID en la tabla CUSTOMERS, Empiece por 101 con incrementos de 1

CREATE SEQUENCE d_customers_seq
    INCREMENT BY 1
    START WITH 102
    MAXVALUE 100000
    MINVALUE 102
    NOCYCLE
    NOCACHE;

desc d_customers_seq;

-- DROP SEQUENCE d_customers_seq;

INSERT INTO customers(customer_id, last_name, first_name, home_phone, address, city, state, email, cell_phone)
VALUES (d_customers_seq.NEXTVAL, 'Daniel', 'Artica', '224-065-2389', 'Teupasenti', 'El Paraíso', 'HN','danielart@yahoo.com', '985-623-2314');

INSERT INTO customers (customer_id, last_name, first_name, home_phone, address, city, state, email, cell_phone)
VALUES (d_customers_seq.NEXTVAL, 'Adilia', 'Amaya', '23564873', 'Teupasenti', 'El Paraíso', 'HN', 'amayaadilia@yahoo.com', '96532145');

SELECT * 
FROM customers
ORDER BY customer_id ASC;

-- Utilice una secuencia para generar claves primarias para TITLE_ID en la tabla MOVIES o Empiece por 1 con incrementos de 1

CREATE SEQUENCE d_movies_seq
    INCREMENT BY 1
    START WITH 5
    MAXVALUE 100000
    MINVALUE 5
    NOCYCLE
    NOCACHE;

desc d_movies_seq;

--DROP SEQUENCE d_movies_seq;

INSERT INTO movies(title_id, title, description, rating, category, release_date)
VALUES (d_movies_seq.NEXTVAL, 'Desarrollador web', 'Historia de un desarrollador web 2021', 'G', 'DOCUMENTARY', TO_DATE('05/09/2021', 'DD/MM/YYYY'));

INSERT INTO movies(title_id, title, description, rating, category, release_date)
VALUES (d_movies_seq.NEXTVAL, 'Comedia 504', 'Comedia hondureña', 'R', 'COMEDY', TO_DATE('05/09/2021', 'DD/MM/YYYY'));

INSERT INTO movies(title_id, title, description, rating, category, release_date)
VALUES (d_movies_seq.NEXTVAL, 'Pichingos', 'Pichingos para niños menores de 12 años', 'PG', 'CHILD', TO_DATE('05/09/2021', 'DD/MM/YYYY'));

SELECT * 
FROM movies
ORDER BY title_id ASC;

 -- Utilice una secuencia para generar claves primarias para MEDIA_ID en la tabla MEDIA o Empiece por 92 con incrementos de 1

CREATE SEQUENCE d_media_seq
    INCREMENT BY 1
    START WITH 94
    MAXVALUE 100000
    MINVALUE 94
    NOCYCLE
    NOCACHE;

desc d_media_seq;

-- DROP SEQUENCE d_media_seq;

INSERT INTO media(media_id, format, title_id)
VALUES (d_media_seq.NEXTVAL, 'VHS', 2);

INSERT INTO media(media_id, format, title_id)
VALUES (d_media_seq.NEXTVAL, 'DVD', 2);

INSERT INTO media(media_id, format, title_id)
VALUES (d_media_seq.NEXTVAL, 'VHS', 3);

SELECT * 
FROM media
ORDER BY media_id ASC;

-- Utilice una secuencia para generar claves primarias para ACTOR_ID en la tabla ACTORS o Empiece por 1001 con incrementos de 1

CREATE SEQUENCE d_actors_seq
    INCREMENT BY 1
    START WITH 1005
    MAXVALUE 100000
    MINVALUE 1005
    NOCYCLE
    NOCACHE;

desc d_actors_seq;

-- DROP TABLE actors;

--DROP SEQUENCE d_actors_seq;

INSERT INTO actors(actor_id, stage_name, first_name, last_name, birth_date)
VALUES (d_actors_seq.NEXTVAL, 'Danilo', 'Josué', 'Amaya', TO_DATE('05/09/2021', 'DD/MM/YYYY'));

INSERT INTO actors(actor_id, stage_name, first_name, last_name, birth_date)
VALUES (d_actors_seq.NEXTVAL, 'José', 'María', 'Perez', TO_DATE('05/09/2021', 'DD/MM/YYYY'));

INSERT INTO actors(actor_id, stage_name, first_name, last_name, birth_date)
VALUES (d_actors_seq.NEXTVAL, 'Raúl', 'Antonio', 'García', TO_DATE('05/09/2021', 'DD/MM/YYYY'));

SELECT * 
FROM actors
ORDER BY actor_id ASC;

-- 5. Agregue los datos a las tablas. Asegúrese de utilizar las secuencias para las claves primarias.
-- Ejecute consultas en los diccionarios de datos sobre las secuencias anteriores.

-- Vistas para consultar objetos de tipo secuencia en la base de datos

SELECT *
FROM user_sequences;

-- Vistas para consultar todo tipo de objetos en la base de datos

SELECT *
FROM user_objects;

--Vista para consultar los indices de la base de datos

SELECT *
FROM user_indexes;

--Uso de las vistas de diccionario

DESCRIBE dictionary;

SELECT * 
FROM  dictionary 
WHERE table_name = 'USER_OBJECTS'; 

SELECT table_name 
FROM  dictionary
WHERE LOWER(comments) LIKE '%columns%';

-- Puede utilizar la vista USER_TABLES para obtener los nombres de todas las tablas. La vista USER_TABLES 
-- contiene información sobre las tablas. Además de proporcionar el nombre de la tabla, contiene información 
--detallada sobre el almacenamiento. 

DESCRIBE user_tables;

SELECT table_name 
FROM  user_tables;

SELECT table_name
FROM  tabs;

-- Puede consultar la vista USER_OBJECTS para ver los nombres y los tipos de todos los objetos del esquema. Hay varias columnas en esta vista: 

DESCRIBE user_objects;

SELECT object_name, object_type, created, status
FROM  user_objects
ORDER BY object_type;

-- Puede consultar la vista USER_TAB_COLUMNS para buscar información detallada sobre las columnas de las tablas.

SELECT column_name, data_type, data_default, 
       data_precision, data_scale, nullable 
FROM user_tab_columns 
WHERE table_name in ('CUSTOMERS','MOVIES','MEDIA', 'RENTAL_HISTORY', 'ACTORS', 'STAR_BILLINGS');

-- Vista de restricción de todas las tablas del proyecto

SELECT CC.constraint_name, C.constraint_type, CC.table_name,
       CC.column_name, C.delete_rule, C.status, C.last_change
FROM user_cons_columns CC, user_constraints C
WHERE CC.constraint_name = C.constraint_name
AND CC.table_name in ('CUSTOMERS','MOVIES','MEDIA', 'RENTAL_HISTORY', 'ACTORS', 'STAR_BILLINGS');

-- vista de diccionario de datos columnas utiles

SELECT text 
FROM user_views 
WHERE view_name = 'VIEW_TITLE_UNAVAIL';

--Vista para consultar los sinonimos de la base de datos

SELECT *
FROM user_synonyms;

-- La vista USER_SEQUENCES describe todas las secuencias que son de su propiedad

SELECT sequence_name, min_value, max_value, 
        increment_by, last_number 
FROM user_sequences;

-- 6. Cree un índice basado en la columna last_name de la tabla Customers. 
-- Ejecute una consulta en el diccionario de datos sobre los índices que muestran este índice.

CREATE INDEX d_cust_last_name_idx
ON customers(last_name);

SELECT *
FROM customers
WHERE last_name = 'Daniel';

-- 7. Cree un sinónimo denominado TU para la vista TITLE_UNAVAIL.
-- Ejecute una consulta en el diccionario de datos sobre los sinónimos que muestran este sinónimo.
-- Imprima una sentencia SELECT * a partir del sinónimo

CREATE SYNONYM tu
FOR view_title_unavail;

-- DROP SYNONYM tu;

SELECT *
FROM tu;