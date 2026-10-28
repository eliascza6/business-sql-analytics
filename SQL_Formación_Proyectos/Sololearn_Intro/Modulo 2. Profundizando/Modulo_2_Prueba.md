-- INSTRUCCIÓN: Completa la consulta para extraer los 5 productos más caros

```sql
SELECT *
FROM products
ORDER BY price DESC
LIMIT 5;
```