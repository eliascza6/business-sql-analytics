LECCIÓN: IDENTIDAD

EJERCICIO DE PRÁCTICA

Añadiendo Datos

/* 
Hay nuevos empleados que necesitan ser añadidos a la tabla Employees.
Aquí están sus datos:
Firstname: Wang
Lastname: Lee
Salary: 1900
Firstname: Greta
Lastname: Wu
Salary: 1200
La tabla Employees tiene una columna de identidad llamada id, que está configurada para AUTO_INCREMENT.
*/

-- INSTRUCCIÓN:Añade los datos a la tabla, luego selecciona las columnas id, firstname, lastname y salary ordenadas por la columna id en orden descendente.

COMENTARIO DE "ANÁLISIS DE NEGOCIO"

/* 
PROYECTO: Gestión de Capital Humano - Actualización de Nómina
OBJETIVO: Inserción de nuevos perfiles y auditoría de registro
HERRAMIENTAS: INSERT INTO, ORDER BY DESC
*/

-- 1. Inserción masiva de nuevos empleados
-- Nota: No incluimos la columna 'id' porque es AUTO_INCREMENT

```sql
INSERT INTO Employees (Firstname, Lastname, Salary)
VALUES 
('Wang', 'Lee', 1900),
('Greta', 'Wu', 1200);
```

-- 2. Verificación de la carga de datos
-- Nota: Ordenamos de forma descendente para ver los registros más recientes primero (Auditoría rápida)

```sql
SELECT id, firstname, lastname, salary 
FROM Employees 
ORDER BY id DESC;
```

LECCIÓN: CLAVES PRIMARIAS Y EXTRANJERAS

-- INSTRUCCIÓN: Rellena los espacios en blanco para crear una clave extranjera en la columna 'number' de la tabla Houses, haciendo referencia a la columna 'id' de la tabla 'Prices'.

COMENTARIO DE "ANÁLISIS DE NEGOCIO"

/*
PROYECTO: Relación de Activos Inmobiliarios
OBJETIVO: Vincular la tabla Houses con sus respectivos precios
COMANDO: FOREIGN KEY
*/

```sql
FOREIGN KEY (number) 
REFERENCES Prices(id);
```

LECCIÓN: ÚNICO

-- INSTRUCCIÓN: Arrastra y suelta para hacer única la columna 'address'.

COMENTARIO DE "ANÁLISIS DE NEGOCIO"

/*
PROYECTO: Registro de Ubicaciones de Inmuebles
OBJETIVO: Evitar registros duplicados para una misma dirección
COMANDO: UNIQUE
*/

```sql
ALTER TABLE Houses
ADD UNIQUE (address);
```

EJERCICIO DEL CUESTIONARIO DEL MÓDULO 2

-- INSTRUCCIÓN: Arrastra & suelta para crear una tabla 'Users' con una clave primaria en la columna id y una columna de clave externa 'account_id', que hace referencia a la columna id de la tabla Accounts.

COMENTARIO DE "ANÁLISIS DE NEGOCIO"

/*
PROYECTO: Gestión de Usuarios y Cuentas
OBJETIVO: Establecer una relación entre usuarios y sus cuentas para mejorar la gestión de datos y la integridad referencial
COMANDOS: PRIMARY KEY, FOREIGN KEY, AUTO_INCREMENT
*/

```sql
CREATE TABLE Users (
id int NOT NULL AUTO_INCREMENT,
name varchar(255) NOT NULL,
account_id int NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (account_id)
REFERENCES Accounts(id)
);
```