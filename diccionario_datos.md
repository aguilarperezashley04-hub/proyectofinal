Tabla | Columna | Tipo de Dato | Longitud | Restricciones | Valor por Defecto
departments | dept_no | character | 4 | PK, NOT NULL | Ninguno
departments | dept_name | character varying | 40 | NOT NULL | Ninguno
dept_emp | emp_no | bigint | - | PK, NOT NULL | Ninguno
dept_emp | emp_no | bigint | - | FK, NOT NULL | Ninguno
dept_emp | dept_no | character | 4 | FK, NOT NULL | Ninguno
dept_emp | dept_no | character | 4 | PK, NOT NULL | Ninguno
dept_emp | from_date | date | - | NOT NULL | Ninguno
dept_emp | to_date | date | - | NOT NULL | Ninguno
dept_manager | emp_no | bigint | - | FK, NOT NULL | Ninguno
dept_manager | emp_no | bigint | - | PK, NOT NULL | Ninguno
dept_manager | dept_no | character | 4 | FK, NOT NULL | Ninguno
dept_manager | dept_no | character | 4 | PK, NOT NULL | Ninguno
dept_manager | from_date | date | - | NOT NULL | Ninguno
dept_manager | to_date | date | - | NOT NULL | Ninguno
employees | emp_no | bigint | - | PK, NOT NULL | Ninguno
employees | birth_date | date | - | NOT NULL | Ninguno
employees | first_name | character varying | 14 | NOT NULL | Ninguno
employees | last_name | character varying | 16 | NOT NULL | Ninguno
employees | gender | text | - | NOT NULL | Ninguno
employees | hire_date | date | - | NOT NULL | Ninguno
salaries | emp_no | bigint | - | PK, NOT NULL | Ninguno
salaries | emp_no | bigint | - | FK, NOT NULL | Ninguno
salaries | salary | bigint | - | NOT NULL | Ninguno
salaries | from_date | date | - | PK, NOT NULL | Ninguno
salaries | to_date | date | - | NOT NULL | Ninguno
titles | emp_no | bigint | - | FK, NOT NULL | Ninguno
titles | emp_no | bigint | - | PK, NOT NULL | Ninguno
titles | title | character varying | 50 | PK, NOT NULL | Ninguno
titles | from_date | date | - | PK, NOT NULL | Ninguno
titles | to_date | date | - | NULL | Ninguno
(30 filas)
