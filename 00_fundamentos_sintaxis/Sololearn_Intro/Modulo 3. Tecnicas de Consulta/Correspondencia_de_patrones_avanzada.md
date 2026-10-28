-- INSTRUCCIÓN: Completa la consulta para realizar una búsqueda de patrones que no distinga entre mayúsculas y minúsculas

```sql
SELECT title
FROM books
WHERE LOWER(title) LIKE '%robots%';
```