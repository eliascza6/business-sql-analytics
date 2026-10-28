-- INSTRUCCIÓN: Completa para seleccionar los 10 productos más caros

```sql
SELECT *
FROM products
ORDER BY price DESC
LIMIT 10;
```