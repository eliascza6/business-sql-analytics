/*
PROYECTO: Fundamentos de SQL - SQLZoo
SESIÓN: 0 - SELECT basics
AUTOR: [Elías Cruz Álvarez]
OBJETIVO: Dominar las cláusulas SELECT, WHERE y IN para filtrado de datos.
CONTEXTO PROFESIONAL: Estas consultas sientan las bases para la segmentación 
de bases de datos en Marketing Digital y la auditoría de activos en Administración.
*/

-- 1. Filtrar por un país específico (población de Alemania):
```sql
SELECT population 
FROM world 
WHERE name = 'Germany';
```

-- 2. Uso de la cláusula IN para segmentación (países escandinavos):
```sql
SELECT name, population 
FROM world 
WHERE name IN ('Sweden', 'Norway', 'Denmark');
```

-- 3. Uso de BETWEEN para rangos de área:

```sql
SELECT name, area 
FROM world 
WHERE area BETWEEN 200000 AND 250000;
```