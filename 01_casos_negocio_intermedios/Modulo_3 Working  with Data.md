LECCIÓN: TABLAS MÚLTIPLES

/* Estás trabajando con las tablas Productos y Pedidos. Cada producto tiene un id, mientras que la tabla Pedidos tiene un product_id de referencia.
*/

-- Arrastra y suelta para seleccionar el nombre de la tabla de productos y el precio correspondiente de la tabla de pedidos.

COMENTARIO DE "ANÁLISIS DE NEGOCIO"

/*
PROYECTO: Análisis de Ventas - Relación de Productos y Pedidos
OBJETIVO: Combinar datos de productos y pedidos para obtener información sobre ventas
HERRAMIENTAS: JOIN implícito (WHERE) y Selección de columnas específicas
*/

```sql
SELECT name, price
FROM Products, Orders
WHERE Products.id = Orders.product_id
```

LECCIÓN: JOINS

-- INSTRUCCIÓN: Arrastra y suelta para crear una consulta váilda.

COMENTARIO DE "ANÁLISIS DE NEGOCIO"

/*
PROYECTO: Análisis de Transacciones - Relación de Usuarios y Transacciones
OBJETIVO: Combinar datos de usuarios y transacciones para obtener información sobre el comportamiento de compra
HERRAMIENTAS: JOIN explícito (INNER JOIN) y Alias de tabla
*/

```sql
SELECT U.name, T.amount
FROM Users AS U
JOIN Transactions AS T
ON U.id = T.userid
```

LECCIÓN: UNIÓN

-- INSTRUCCIÓN:Arrastra y suelta para combinar las filas de Usuarios y Clientes, pero solo para aquellos que tienen un saldo mayor a 1000.

COMENTARIO DE "ANÁLISIS DE NEGOCIO"

/*
PROYECTO: Análisis de Clientes - Combinación de Usuarios y Clientes con Saldo Alto
OBJETIVO: Unificar datos de usuarios y clientes para identificar aquellos con un saldo significativo      
HERRAMIENTAS: UNION y Condición de filtrado (WHERE)
*/

```sql
SELECT * FROM Users
WHERE balance > 1000
UNION
SELECT * FROM Clients
WHERE balance > 1000
```

LECCIÓN: ENCUENTRA EL PROMEDIO

-- INSTRUCCIÓN: Arrastra & suelta para seleccionar todos los nombres de los productos de la tabla Productos con sus registros de categorías correspondientes en la tabla Categorías de Productos. Los productos que no tienen ningún registro de categoría correspondiente también deben estar en el resultado.

COMENTARIO DE "ANÁLISIS DE NEGOCIO"
/*          
PROYECTO: Análisis de Productos - Relación de Productos y Categorías
OBJETIVO: Combinar datos de productos y categorías para obtener información sobre la clasificación de productos y su diversidad
HERRAMIENTAS: LEFT JOIN y Alias de tabla
*/  

```sql
SELECT P.name, PC.category
FROM Products AS P
LEFT JOIN ProductCategories AS PC
ON P.id = PC.product_id
```


EXAMEN DEL MÓDULO 3

/* La clave foránea prod_id de la tabla Orders se refiere a la columna id de la tabla Products.
*/

-- INSTRUCCIÓN: Arrastra y suelta para crear una consulta que selecciona las columnas de nombre y cantidad de los Orders con los nombres de Product correspondientes.

COMENTARIO DE "ANÁLISIS DE NEGOCIO"

/*
PROYECTO: Análisis de Pedidos - Relación de Pedidos y Productos
OBJETIVO: Combinar datos de pedidos y productos para obtener información sobre las ventas y la popularidad de los productos 
HERRAMIENTAS: JOIN explícito (INNER JOIN) y Selección de columnas específicas
*/                 

```sql
SELECT Orders.name, Orders.amount, Products.name
FROM Orders
JOIN Products ON Orders.prod_id = Products.id;
```