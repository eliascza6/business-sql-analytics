/* El comodín % se puede utilizar en cualquier parte del patrón y tantas veces como sea necesario.*/

-- INSTRUCCIÓN: Extrae todos los títulos que contengan la palabra Avengers

```sql
SELECT *
FROM comics
WHERE title LIKE '%Avengers%';
```