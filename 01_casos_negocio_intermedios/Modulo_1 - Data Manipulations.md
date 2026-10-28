-- INTRODUCCIÓN

COMENTARIO DE "ANÁLISIS DE NEGOCIO"

/* 
PROYECTO: Auditoría de Niveles Salariales
OBJETIVO: Extraer el segundo bloque de empleados con mayores ingresos (posiciones 3 a 5) para análisis de competitividad interna, excluyendo a la alta dirección.
CONCEPTO TÉCNICO: Cláusulas elementales: ORDER BY, LIMIT, OFFSET y palabra clave: DESC 
*/

/* 
INSTRUCCIÓN: Arrastra & suelta para construir una consulta que selecciona las filas 3ras a 5tas de la tabla Empleados, ordenadas por la columna salario en orden descendente.
*/

```sql
SELECT * FROM Empleados
ORDER BY salario DESC
LIMIT 3 OFFSET 2;
```


FUNCIONES DE CADENA

COMENTARIO DE "ANÁLISIS DE NEGOCIO"

/* 
PROYECTO: Normalización de Catálogo de Biblioteca/Inventario
OBJETIVO: Estandarizar la columna 'descripción' reemplazando puntuación informal por formal para mejorar la calidad de los reportes impresos.
CONCEPTO TÉCNICO: Manipulación de Strings (REPLACE) y Ordenamiento Cronológico.
*/

/*
INSTRUCCIÓN: Arrastra y suelta para reemplazar todos los caracteres '!' con un punto '.' en la columna descripción de la tabla Libros. Ordena el resultado por la columna año.
*/

```sql
SELECT REPLACE (description, '!', '.')
FROM Books
ORDER BY year;
```

FUNCIONES DE MATEMÁTICAS & AGREGACIÓN

COMENTARIO DE "ANÁLISIS DE NEGOCIO"

/* 
PROYECTO: Identificación de Liderazgo de Mercado
OBJETIVO: Extraer el perfil completo de la organización con el mayor volumen 
de ingresos para realizar un análisis de benchmark y establecer objetivos de ventas.
CONCEPTO TÉCNICO: Subconsultas (Subqueries) y Funciones de Agregación (MAX).
*/

-- INSTRUCCIÓN: Arrastra & suelta para seleccionar todas las columnas de la empresa con el número máximo de ingresos.

```sql
SELECT * 
FROM Companies
WHERE revenue = (
SELECT MAX
(revenue)
FROM Companies)
```

CASO

COMENTARIO DE "ANÁLISIS DE NEGOCIO"

/* 
PROYECTO: Clasificación de Experiencia del Cliente
OBJETIVO: Crear una dimensión cualitativa ('experience') basada en métricas 
cuantitativas para facilitar la segmentación del catálogo y la toma de decisiones gerenciales.
CONCEPTO TÉCNICO: Lógica condicional (CASE WHEN) y Alias de columna.
*/

-- INSTRUCCIÓN: Rellena los espacios en blanco para crear una columna personalizada llamada 'experience', que está definida por la columna de calificación.

```sql
SELECT CASE
    WHEN rating < 3 THEN 'Bad'
    WHEN rating >= 3 AND rating < 8 THEN 'OK'
    ELSE 'Great'
END AS experience
FROM Hotels;
```

CUESTIONARIO DEL MÓDULO 1

COMENTARIO DE "ANÁLISIS DE NEGOCIO"

/* PROYECTO: Traducción de Códigos de Transmisión
OBJETIVO: Convertir códigos numéricos de transmisión en texto legible para mejorar la comprensión de los datos en informes y análisis.
CONCEPTO TÉCNICO: Lógica condicional (CASE) y Alias de columna.
*/      

-- Tienes una tabla Coches con una columna transmisión, que es numérica: 1 para Manual y 2 para Automática. 

--Arrastra y suelta para crear una consulta que seleccione el valor de texto correspondiente de la columna transmisión.

```sql
SELECT name,
CASE
    WHEN transmission = 1 THEN 'Manual'
    ELSE 'Automático'
END AS transmission
FROM Cars;
```