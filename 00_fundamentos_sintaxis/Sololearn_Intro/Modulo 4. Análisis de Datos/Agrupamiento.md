-- INSTRUCCIÓN: Completa la consulta para contar los productos en cada grupo de categorías

```sql
SELECT category, COUNT(product)
FROM products
GROUP BY category;
```