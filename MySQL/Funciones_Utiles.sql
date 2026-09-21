-----------------------------------
-----------------------------------
-- SENTENCIAS O FUNCIONES UTILES --
-----------------------------------
-----------------------------------


---------------------------------
-- ACTUALIZAR CAMPOS DESDE CSV --
-- Este ejemplo actualiza el campo observaciones desde un csv que tiene ARTICULO;OBSERVACIONES
---------------------------------

-- Crear la tabla auxiliar en MySQL
CREATE TABLE tmp_observaciones (
    articulo cHAR(50) NOT NULL,
    observacion CHAR(254)
);

-- Cargar del csv a la tabla temporal 
LOAD DATA LOCAL INFILE 'C:/temp/articulos_observaciones.csv'
INTO TABLE tmp_observaciones
CHARACTER SET utf8
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'

-- Controlar que se haya cargado bien
SELECT
    a.articulo,
    a.observa AS actual,
    t.observacion AS nueva
FROM articulos a
INNER JOIN tmp_observaciones t 
    ON t.articulo = a.articulo;
	
-- Actualizar
UPDATE articulos a
INNER JOIN tmp_observaciones t
    ON t.articulo = a.articulo
SET a.observa = t.observacion;

