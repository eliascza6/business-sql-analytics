-- INSTRUCCIÓN: Encuentra el salario más alto en el departamento de 'Engineering'

```sql
SELECT MAX(salary)
FROM employees
WHERE department = 'Engineering';
```