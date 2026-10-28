-- INSTRUCCIÓN: Completa la consulta para obtener el usuario con el nombre de usuario ann88 o el número de teléfono 854930340

```sql
SELECT *
FROM users
WHERE p_number = 854930340
OR username = 'ann88';
```