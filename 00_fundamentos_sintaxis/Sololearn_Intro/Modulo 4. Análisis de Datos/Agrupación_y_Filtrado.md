-- INSTRUCCIÓN: Completa la consulta para calcular el salario promedio por departamento primero y luego mostrar los departamentos con un promedio mayor a 5000

```sql
SELECT department, AVG(salary)
FROM employees
GROUP BY department
HAVING AVG(salary) > 5000;
```