SQL - LOGICAL OPERATORS

- LIKE allows you to match similar values, instead of exact values.
- IN allows you to specify a list of values you'd like to include.
- BETWEEN allows you to select only rows within a certain range.
- IS NULL allows you to select rows that contain no data in a given column.
- AND allows you to select only rows that satisfy two conditions.
- OR allows you to select rows that satisfy either of two conditions.
- NOT allows you to select rows that do not match a certain condition.

The SQL LIKE operator

/*
Practice Problem
Write a query that returns all rows for which Ludacris was a member of the group.
*/

COMENTARIO DE "ANÁLISIS DE NEGOCIO"

/*
PROYECTO: Consulta de miembros de grupos musicales
OBJETIVO: Obtener todas las filas de la tabla que correspondan a grupos musicales en los cuales Ludacris fue miembro "Ludacris".
HERRAMIENTAS: "GROUP", ILIKE '%ludacris%' para buscar coincidencias sin importar mayúsculas o minúsculas.
*/

```sql
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE "group" ILIKE '%ludacris%'
```

/*
Practice Problem
Write a query that returns all rows for which the first artist listed in the group has a name that begins with "DJ".
*/


Commentario de "ANÁLISIS DE NEGOCIO"  

/*
PROYECTO: Consulta de artistas con nombre que comienza con "DJ" 
OBJETIVO: Obtener todas las filas de la tabla que correspondan a grupos musicales en los cuales el primer artista listado tiene un nombre que comienza con "DJ".
HERRAMIENTAS: "GROUP", LIKE 'DJ%' para buscar coincidencias que comiencen con "DJ".
*/  

```sql
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE "group" LIKE 'DJ%'
```

The SQL IN operator

/*
Practice Problem
Write a query that shows all of the entries for Elvis and M.C. Hammer.

Hint: M.C. Hammer is actually on the list under multiple names, so you may need to first write a query to figure out exactly how M.C. Hammer is listed. You're likely to face similar problems that require some exploration in many real-life scenarios.
*/

Comentario de "ANÁLISIS DE NEGOCIO"

/*
PROYECTO: Consulta de artistas específicos en la tabla de Billboard Top 100 Year End

OBJETIVO: Obtener todas las filas de la tabla que correspondan a los artistas Elvis Presley y M.C. Hammer.

HERRAMIENTAS: "GROUP", IN ('M.C. Hammer', 'Hammer', 'Elvis Presley') para buscar coincidencias específicas de artistas.
*/  

#1 Primero, identificamos cómo se listan los artistas en la tabla:

```sql
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE artist LIKE '%Hammer%';
```

#2 Luego, escribimos la consulta final para obtener todas las entradas de Elvis Presley y M.C. Hammer:

```sql
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE "group" IN ('M.C. Hammer', 'Hammer', 'Elvis Presley')
```

The SQL BETWEEN operator

/*
Practice Problem
Write a query that shows all top 100 songs from January 1, 1985 through December 31, 1990.
*/

Comentario de "ANÁLISIS DE NEGOCIO"

/*
PROYECTO: Consulta de canciones top 100 entre 1985 y 1990
OBJETIVO: Obtener todas las filas de la tabla que correspondan a canciones que estuvieron en el top 100 entre el 1 de enero de 1985 y el 31 de diciembre de 1990.
HERRAMIENTAS: "year", BETWEEN 1985 AND 1990 para filtrar las filas por el rango de años especificado.
*/

```sql
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year BETWEEN 1985 AND 1990
```

The IS NULL operator

/*
Practice Problem
Write a query that shows all of the rows for which song_name is null.
*/

Comentario de "ANÁLISIS DE NEGOCIO"

/*
PROYECTO: Consulta de filas con song_name nulo
OBJETIVO: Obtener todas las filas de la tabla que correspondan a registros donde el nombre de la canción (song_name) es nulo.
HERRAMIENTAS: "song_name", IS NULL para filtrar las filas donde el nombre de la canción no está presente.
*/

```sql
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE song_name IS NULL
```

The SQL AND operator

/*
Practice Problem
Write a query that surfaces all rows for top-10 hits for which Ludacris is part of the Group.
*/

Comentario de "ANÁLISIS DE NEGOCIO"

/*
PROYECTO: Consulta de top-10 hits con Ludacris como parte del grupo

OBJETIVO: Obtener todas las filas de la tabla que correspondan a canciones que estuvieron en el top 10 y en las cuales Ludacris fue parte del grupo.

HERRAMIENTAS: "year_rank" <= 10 para filtrar las filas por el rango de rank, y "group" ILIKE '%ludacris%' para buscar coincidencias de Ludacris en el grupo sin importar mayúsculas o minúsculas.
*/

```sql
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year_rank <= 10
   AND "group" ILIKE '%ludacris%'
```

/*
Practice Problem
Write a query that surfaces the top-ranked records in 1990, 2000, and 2010.
*/

Comentario de "ANÁLISIS DE NEGOCIO"

/*
PROYECTO: Consulta de los registros mejor clasificados en los años 1990, 2000 y 2010

OBJETIVO: Obtener todas las filas de la tabla que correspondan a las canciones que ocuparon el primer lugar (year_rank = 1) en los años 1990, 2000 y 2010.

HERRAMIENTAS: "year_rank" = 1 para filtrar las filas por el primer lugar, y "year" IN (1990, 2000, 2010) para seleccionar las filas correspondientes a los años específicos.
*/

```sql
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year_rank = 1
   AND year IN (1990, 2000, 2010)
```

/*
Practice Problem
Write a query that lists all songs from the 1960s with "love" in the title.
*/

Comentario de "ANÁLISIS DE NEGOCIO"

/*
PROYECTO: Consulta de canciones de los años 1960 con "love" en el título

OBJETIVO: Obtener todas las filas de la tabla que correspondan a canciones de los años 1960 a 1969 que tengan la palabra "love" en el título de la canción.

HERRAMIENTAS: "year" BETWEEN 1960 AND 1969 para filtrar las filas por el rango de años de la década de 1960, y "song_name" ILIKE '%love%' para buscar coincidencias de la palabra "love" en el título de la canción sin importar mayúsculas o minúsculas.
*/

```sql
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year BETWEEN 1960 AND 1969
   AND song_name ilike '%love%'
```


The SQL OR operator

/*
Practice Problem
Write a query that returns all rows for top-10 songs that featured either Katy Perry or Bon Jovi.
*/

```sql
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year_rank <= 10
AND ("group" ILIKE '%katy perry%' OR "group" ILIKE '%bon jovi%')
```

/*
Practice Problem
Write a query that returns all songs with titles that contain the word "California" in either the 1970s or 1990s.
*/

Comentario de "ANÁLISIS DE NEGOCIO"

/*
PROYECTO: Consulta de canciones con "California" en el título en los años 1970s o 1990s

OBJETIVO: Obtener todas las filas de la tabla que correspondan a canciones que tengan la palabra "California" en el título y que hayan estado en el top 100 durante los años 1970 a 1979 o 1990 a 1999.

HERRAMIENTAS: "song_name" ILIKE '%California%' para buscar coincidencias de la palabra "California" en el título de la canción sin importar mayúsculas o minúsculas, y "year" BETWEEN 1970 AND 1979 OR "year" BETWEEN 1990 AND 1999 para filtrar las filas por los rangos de años especificados.
*/

```sql
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE song_name LIKE '%California%'
   AND (year BETWEEN 1970 AND 1979 OR year BETWEEN 1990 AND 1999)
```

/*
Practice Problem
Write a query that lists all top-100 recordings that feature Dr. Dre before 2001 or after 2009.
*/

Comentario de "ANÁLISIS DE NEGOCIO"

/*
PROYECTO: Consulta de grabaciones top-100 con Dr. Dre antes de 2001 o después de 2009

OBJETIVO: Obtener todas las filas de la tabla que correspondan a grabaciones que hayan estado en el top 100 y que tengan a Dr. Dre como parte del grupo, siempre y cuando estas grabaciones hayan sido lanzadas antes del año 2001 o después del año 2009.

HERRAMIENTAS: "group" ILIKE '%dr. dre%' para buscar coincidencias de Dr. Dre en el grupo sin importar mayúsculas o minúsculas, y "year" <= 2000 OR "year" >= 2010 para filtrar las filas por los años especificados.
*/

```sql
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE "group" ILIKE '%dr. dre%'
   AND (year <= 2000 OR year >= 2010)
```

The SQL NOT operator

/*
Practice Problem
Write a query that returns all rows for songs that were on the charts in 2013 and do not contain the letter "a".
*/


Comentario de "ANÁLISIS DE NEGOCIO"

/*
PROYECTO: Consulta de canciones en las listas de 2013 sin la letra "a"

OBJETIVO: Obtener todas las filas de la tabla que correspondan a canciones que estuvieron en las listas de éxitos en el año 2013 y que no contengan la letra "a" en el título de la canción.

HERRAMIENTAS: "year" = 2013 para filtrar las filas por el año específico, y "song_name" NOT ILIKE '%a%' para buscar canciones cuyo título no contenga la letra "a", sin importar mayúsculas o minúsculas.
*/

```sql
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE song_name NOT ILIKE '%a%'
AND year = 2013
```


Sorting data with SQL ORDER BY

/*
Practice Problem
Write a query that returns all rows from 2012, ordered by song title from Z to A.
*/

Comentario de "ANÁLISIS DE NEGOCIO"

/*
PROYECTO: Consulta de canciones de 2012 ordenadas por título de la canción de Z a A

OBJETIVO: Obtener todas las filas de la tabla que correspondan a canciones del año 2012 y ordenarlas por el título de la canción en orden descendente (de Z a A).

HERRAMIENTAS: "year" = 2012 para filtrar las filas por el año específico, y "ORDER BY song_name DESC" para ordenar los resultados por el título de la canción en orden descendente.
*/

```sql
SELECT *
 FROM tutorial.billboard_top_100_year_end
 WHERE year = 2012
 ORDER BY song_name DESC
```

Ordering data by multiple columns

/*
Practice Problem
Write a query that returns all rows from 2010 ordered by rank, with artists ordered alphabetically for each song.
*/

Comentario de "ANÁLISIS DE NEGOCIO"

/*
PROYECTO: Consulta de canciones de 2010 ordenadas por rank y artista

OBJETIVO: Obtener todas las filas de la tabla que correspondan a canciones del año 2010 y ordenarlas primero por el rank en las listas (de menor a mayor) y luego por el nombre del artista en orden alfabético para cada canción.

HERRAMIENTAS: "year" = 2010 para filtrar las filas por el año específico, "ORDER BY year_rank, artist" los resultados se ordenarán automáticamente, primero por el rank en orden ascendente y luego por el nombre del artista en orden alfabético.
*/

```sql
SELECT *
 FROM tutorial.billboard_top_100_year_end
 WHERE year = 2010
 ORDER BY year_rank, artist
```


Using comments

/*
Practice Problem
Write a query that shows all rows for which T-Pain was a group member, ordered by rank on the charts, from lowest to highest rank (from 100 to 1).
*/

Comentario de "ANÁLISIS DE NEGOCIO"

/*
PROYECTO: Consulta de canciones con T-Pain como miembro del grupo ordenadas por rank

OBJETIVO: Obtener todas las filas de la tabla que correspondan a canciones en las cuales T-Pain fue miembro del grupo, y ordenarlas por el rank en las listas de menor a mayor (de 100 a 1).

HERRAMIENTAS: "group" ILIKE '%t-pain%' para buscar coincidencias de T-Pain en el grupo sin importar mayúsculas o minúsculas, y "ORDER BY year_rank DESC" para ordenar los resultados por el rank en orden descendente (de 100 a 1).
*/  

```sql
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE "group" ILIKE '%t-pain%'
ORDER BY year_rank DESC
```

/*
Practice Problem
Write a query that returns songs that ranked between 10 and 20 (inclusive) in 1993, 2003, or 2013. Order the results by year and rank, and leave a comment on each line of the WHERE clause to indicate what that line does
*/

Comentario de "ANÁLISIS DE NEGOCIO"

/*
PROYECTO: Consulta de canciones con rank entre 10 y 20 en los años 1993, 2003 y 2013

OBJETIVO: Obtener todas las filas de la tabla que correspondan a canciones que estuvieron clasificadas entre el puesto 10 y el 20 (inclusive) en los años 1993, 2003 o 2013, y ordenarlas por año y rank.

HERRAMIENTAS: "year_rank" BETWEEN 10 AND 20 para filtrar las filas por el rango de rank especificado, "year" IN (1993, 2003, 2013) para seleccionar las filas correspondientes a los años específicos, y "ORDER BY year, year_rank" para ordenar los resultados primero por año y luego por rank.
*/

```sql
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year IN (2013, 2003, 1993)  --Seleccionar los años relevantes
AND year_rank BETWEEN 10 AND 20  --Limitar el rank de 10-20
ORDER BY year, year_rank;
```