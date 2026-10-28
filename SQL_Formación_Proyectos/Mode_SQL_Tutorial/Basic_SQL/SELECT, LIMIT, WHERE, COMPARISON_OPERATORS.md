LECCIÓN: SELECT

/* 
Practice Problem
Write a query to select all of the columns in tutorial.us_housing_units and rename them so that their first letters are capitalized.
*/ 

COMENTARIO DE "ANÁLISIS DE NEGOCIO" 

/*
PROYECTO: Análisis de Viviendas - Renombrado de Columnas para Mejorar la Legibilidad
OBJETIVO: Seleccionar todas las columnas de la tabla us_housing_units y renombrarlas con la primera letra en mayúscula para mejorar la presentación de los datos
HERRAMIENTAS: SELECT *, AS para renombrar columnas
*/      

```sql
SELECT 
year AS Year,
month AS Month,
month_name AS Month_name,
south AS South_Region,
west AS West_Region,
midwest AS Midwest_Region,
northeast AS Northeast_Region
FROM tutorial.us_housing_units;
```


LECCIÓN: LIMIT      

/* 
Practice Problem
Write a query that uses the LIMIT command to restrict the result set to only 15 rows.
*/

COMENTARIO DE "ANÁLISIS DE NEGOCIO"

/*      
PROYECTO: Análisis de Viviendas - Limitación de Resultados para una Revisión Rápida
OBJETIVO: Restringir el conjunto de resultados a solo 15 filas para una revisión rápida de los datos
HERRAMIENTAS: LIMIT
*/      

```sql
SELECT *
FROM tutorial.us_housing_units      
LIMIT 15;
```

LECCIÓN: WHERE

/*
Practice Problem
Write a query to select all of the columns in tutorial.us_housing_units where the month is equal to 1.
*/  

COMENTARIO DE "ANÁLISIS DE NEGOCIO"

/*  
PROYECTO: Análisis de Viviendas - Filtrado por Mes para Enfocar el Análisis
OBJETIVO: Seleccionar todas las columnas de la tabla us_housing_units donde el mes sea igual a 1 para analizar los datos específicos de ese mes
HERRAMIENTAS: WHERE
*/

```sql
SELECT *
  FROM tutorial.us_housing_units
 WHERE month = 1
```

LECCIÓN: COMPARISON OPERATORS ON NUMERICAL DATA

/* 
Practice Problem    
Did the West Region ever produce more than 50,000 housing units in one month? Write a query to find out.
*/  

COMENTARIO DE "ANÁLISIS DE NEGOCIO"

/*      
PROYECTO: Análisis de Viviendas - Evaluación de la Producción en la Región Oeste
OBJETIVO: Determinar si la Región Oeste alguna vez produjo más de 50,000 unidades de vivienda en un mes para evaluar el rendimiento de esa región
HERRAMIENTAS: WHERE con operadores de comparación
*/  

```sql
SELECT *
  FROM tutorial.us_housing_units
 WHERE west > 50;
```

LECCIÓN: COMPARISON OPERATORS ON NON-NUMERICAL DATA        

/* 
Practice Problem    
Write a query that only shows rows for which the month name is February.
*/

COMENTARIO DE "ANÁLISIS DE NEGOCIO"

/*      
PROYECTO: Análisis de Viviendas - Filtrado por Nombre del Mes para Enfocar el Análisis en Febrero
OBJETIVO: Seleccionar solo las filas donde el nombre del mes sea febrero para analizar los datos específicos de ese mes
HERRAMIENTAS: WHERE con operadores de comparación para datos no numéricos
*/  

```sql
SELECT *
  FROM tutorial.us_housing_units
 WHERE month_name = 'February'
```

LECCIÓN: ARITHMETIC IN SQL

/* 
Practice Problem    
Write a query that calculates the sum of all four regions in a separate column.
*/

COMENTARIO DE "ANÁLISIS DE NEGOCIO"

/*      
PROYECTO: Análisis de Viviendas - Cálculo del Total de Unidades Producidas por Región
OBJETIVO: Calcular la suma de todas las unidades producidas en las cuatro regiones y mostrarlo en una columna separada para obtener una visión general del total de producción
HERRAMIENTAS: Operadores aritméticos en SQL
*/

```sql
SELECT year,
       month,
       west,
       south,
       midwest,
       northeast,
       west + south + midwest +northeast AS usa_total
  FROM tutorial.us_housing_units
```


LECCIÓN: SHARPEN YOUR SKILLS
#1

/* 
Practice Problem
Write a query that returns all rows for which more units were produced in the West region than in the Midwest and Northeast combined.
*/  

COMENTARIO DE "ANÁLISIS DE NEGOCIO"

/*      
PROYECTO: Análisis de Viviendas - Comparación de Producción entre Regiones
OBJETIVO: Seleccionar todas las filas donde se produjeron más unidades en la Región Oeste que en la combinación de las Regiones Midwest y Northeast para evaluar el rendimiento relativo de la Región Oeste
HERRAMIENTAS: WHERE con operadores de comparación y operadores aritméticos
*/  

```sql
SELECT year,
       month,
       west,
       south,
       midwest,
       northeast
  FROM tutorial.us_housing_units
  WHERE west > (midwest + northeast);
```

#2

/* 
Practice Problem
Write a query that calculates the percentage of all houses completed in the United States represented by each region. Only return results from the year 2000 and later.
Hint: There should be four columns of percentages.
*/  

COMENTARIO DE "ANÁLISIS DE NEGOCIO"

/*
PROYECTO: Análisis de Viviendas - Cálculo del Porcentaje de Unidades Producidas por Región
OBJETIVO: Calcular el porcentaje de todas las unidades de vivienda completadas en los Estados Unidos representadas por cada región para evaluar la contribución de cada región a la producción total, filtrando solo los resultados a partir del año 2000
HERRAMIENTAS: Operadores aritméticos para calcular porcentajes y cláusula WHERE para filtrar por año
*/

```sql
SELECT year,
       month,
       west/(west + south + midwest + northeast)*100 AS west_pct,
       south/(west + south + midwest + northeast)*100 AS south_pct,
       midwest/(west + south + midwest + northeast)*100 AS midwest_pct,
       northeast/(west + south + midwest + northeast)*100 AS northeast_pct
  FROM tutorial.us_housing_units
 WHERE year >= 2000;
 ```