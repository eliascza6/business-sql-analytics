--INSTRUCCIÓN: Completa para verificar duplicados en los campos de id y title

```sql
SELECT id, title
FROM movies
GROUP BY id, title
HAVING COUNT(id) > 1;
```