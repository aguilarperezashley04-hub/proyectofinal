# 

# ![](./Pictures/100000010000012C0000012C5D8E37869E7637D1.png){width="7.938cm" height="7.938cm"}

# 

# 

# 

# 

# 

# 

# 

# 

# Entregable Final - Tecnología de Base de Datos I

ESTUDIANTE: ASHLEY ARIANNE AGUILAR PEREZ

DOCENTE: JARED LOPEZ LEAÑOS

Punto 1: Migración de Tablas (15 pts)

-   Comandos utilizados para exportar e importar.

**Creación del archivo de configuración *****migracion.load***

***cat \<\< \'EOF\' \> migracion.load***

*LOAD DATABASE*

* FROM mysql://root:13778892@127.0.0.1:3306/employees*

* INTO postgresql://ashley:13778892@127.0.0.1:5432/employees*

* WITH include drop, create tables, create indexes, reset sequences*

* CAST type datetime to timestamptz,*

* type date drop not null drop default using zero-dates-to-null;*

*EOF*

****Ejecución de la migración con *****pgloader***

***pgloader migracion.load***

-   Salida de los comandos (logs de pgloader, mensajes de COPY, etc.).

ashley@aguilar\]─\[\~\]

└──╼ \$ pgloader migracion.load

2026-09-29T14:57:22.008000Z LOG pgloader version \"3.6.10\~devel\"

2026-09-29T14:57:22.188001Z LOG Migrating from #\<MYSQL-CONNECTION
mysql://root@127.0.0.1:3306/employees {1006A7AB33}\>

2026-09-29T14:57:22.192001Z LOG Migrating into #\<PGSQL-CONNECTION
pgsql://ashley@127.0.0.1:5432/employees {1006A7ACD3}\>

2026-09-29T14:57:31.824027Z LOG report summary reset

table name errors rows bytes total time

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-- \-\-\-\-\-\-\-\--
\-\-\-\-\-\-\-\-- \-\-\-\-\-\-\-\-- \-\-\-\-\-\-\-\-\-\-\-\-\--

fetch meta data 0 21 0.224s

Create Schemas 0 0 0.004s

Create SQL Types 0 1 0.012s

Create tables 0 12 0.028s

Set Table OIDs 0 6 0.008s

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-- \-\-\-\-\-\-\-\--
\-\-\-\-\-\-\-\-- \-\-\-\-\-\-\-\-- \-\-\-\-\-\-\-\-\-\-\-\-\--

employees.salaries 0 2844047 94.2 MB 6.208s

employees.titles 0 443308 16.9 MB 1.960s

employees.dept_emp 0 331603 10.7 MB 5.968s

employees.employees 0 300024 13.2 MB 2.040s

employees.dept_manager 0 24 0.8 kB 0.632s

employees.departments 0 9 0.1 kB 0.040s

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-- \-\-\-\-\-\-\-\--
\-\-\-\-\-\-\-\-- \-\-\-\-\-\-\-\-- \-\-\-\-\-\-\-\-\-\-\-\-\--

COPY Threads Completion 0 4 8.248s

Create Indexes 0 9 2.460s

Index Build Completion 0 9 0.228s

Reset Sequences 0 0 0.072s

Primary Keys 0 6 0.224s

Create Foreign Keys 0 6 0.424s

Create Triggers 0 0 0.000s

Install Comments 0 0 0.000s

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-- \-\-\-\-\-\-\-\--
\-\-\-\-\-\-\-\-- \-\-\-\-\-\-\-\-- \-\-\-\-\-\-\-\-\-\-\-\-\--

Total import time ✓ 3919015 134.9 MB 11.656s\

-   Conteo de filas en MariaDB y PostgreSQL para cada tabla.

ashley@aguilar\]─\[\~\]

└──╼ \$ docker exec -it mariadb mysql -u root -p\'13778892\' -e \"

SELECT \'employees\' AS tabla, COUNT(\*) AS total FROM
employees.employees

UNION ALL SELECT \'departments\', COUNT(\*) FROM employees.departments

UNION ALL SELECT \'dept_emp\', COUNT(\*) FROM employees.dept_emp

UNION ALL SELECT \'dept_manager\', COUNT(\*) FROM employees.dept_manager

UNION ALL SELECT \'titles\', COUNT(\*) FROM employees.titles

UNION ALL SELECT \'salaries\', COUNT(\*) FROM employees.salaries;\"

mysql: Deprecated program name. It will be removed in a future release,
use \'/usr/bin/mariadb\' instead

+\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\--+

\| tabla \| total \|

+\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\--+

\| employees \| 300024 \|

\| departments \| 9 \|

\| dept_emp \| 331603 \|

\| dept_manager \| 24 \|

\| titles \| 443308 \|

\| salaries \| 2844047 \|

+\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\--+

\[ashley@aguilar\]─\[\~\]

└──╼ \$ docker exec -it postgresql psql -U ashley -d employees -c \"

SELECT \'employees\' AS tabla, COUNT(\*) AS total FROM employees

UNION ALL SELECT \'departments\', COUNT(\*) FROM departments

UNION ALL SELECT \'dept_emp\', COUNT(\*) FROM dept_emp

UNION ALL SELECT \'dept_manager\', COUNT(\*) FROM dept_manager

UNION ALL SELECT \'titles\', COUNT(\*) FROM titles

UNION ALL SELECT \'salaries\', COUNT(\*) FROM salaries;\"

tabla \| total

\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\--

employees \| 300024

departments \| 9

dept_emp \| 331603

dept_manager \| 24

titles \| 443308

salaries \| 2844047

(6 rows)

Punto 2: Migración de Vistas (10 pts)

-   Definiciones de vistas originales y adaptadas.

\[ashley@aguilar\]─\[\~\]

└──╼ \$ docker exec -it mariadb mysql -u root -p\'13778892\' -e \"

SELECT table_name, view_definition

FROM information_schema.views

WHERE table_schema = \'employees\';\"

mysql: Deprecated program name. It will be removed in a future release,
use \'/usr/bin/mariadb\' instead

+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+

\| table_name \| view_definition \|

+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+

\| current_dept_emp \| select \`l\`.\`emp_no\` AS
\`emp_no\`,\`d\`.\`dept_no\` AS \`dept_no\`,\`l\`.\`from_date\` AS
\`from_date\`,\`l\`.\`to_date\` AS \`to_date\` from
(\`employees\`.\`dept_emp\` \`d\` join
\`employees\`.\`dept_emp_latest_date\` \`l\` on(\`d\`.\`emp_no\` =
\`l\`.\`emp_no\` and \`d\`.\`from_date\` = \`l\`.\`from_date\` and
\`l\`.\`to_date\` = \`d\`.\`to_date\`)) \|

\| dept_emp_latest_date \| select \`employees\`.\`dept_emp\`.\`emp_no\`
AS \`emp_no\`,max(\`employees\`.\`dept_emp\`.\`from_date\`) AS
\`from_date\`,max(\`employees\`.\`dept_emp\`.\`to_date\`) AS \`to_date\`
from \`employees\`.\`dept_emp\` group by
\`employees\`.\`dept_emp\`.\`emp_no\` \|

+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+,

**Definición original extraída de MariaDB (*****v_full_departments*****
y *****v_current_salaries*****):**

SQL

*\-- Vista 1: v_full_departments*

*CREATE VIEW v_full_departments AS*

*SELECT d.dept_no, d.dept_name, COUNT(de.emp_no) AS total_employees*

*FROM departments d*

*LEFT JOIN dept_emp de ON d.dept_no = de.dept_no*

*GROUP BY d.dept_no, d.dept_name;*

*\-- Vista 2: v_current_salaries*

*CREATE VIEW v_current_salaries AS*

*SELECT e.emp_no, CONCAT(e.first_name, \' \', e.last_name) AS full_name,
s.salary*

*FROM employees e*

*JOIN salaries s ON e.emp_no = s.emp_no*

*WHERE s.to_date = \'9999-01-01\';*

### Definiciones Adaptadas y Comandos de Creación en PostgreSQL

Comando en terminal para crear las vistas adaptadas en PostgreSQL:

\[ashley@aguilar\]─\[\~/tecBD1\]

└──╼ \$ docker exec -i postgresql psql -U ashley -d employees \<\<
\'EOF\'

CREATE OR REPLACE VIEW v_full_departments AS

SELECT d.dept_no, d.dept_name, COUNT(de.emp_no) AS total_employees

FROM departments d

LEFT JOIN dept_emp de ON d.dept_no = de.dept_no

GROUP BY d.dept_no, d.dept_name;

CREATE OR REPLACE VIEW v_current_salaries AS

SELECT e.emp_no, (e.first_name \|\| \' \' \|\| e.last_name) AS
full_name, s.salary

FROM employees e

JOIN salaries s ON e.emp_no = s.emp_no

WHERE s.to_date = \'9999-01-01\';

EOF

CREATE VIEW

CREATE VIEW

### Consultas de Prueba sobre las Vistas Migradas

**Comando de prueba 1 (*****v_full_departments*****):**

─\[ashley@aguilar\]─\[\~/tecBD1\]

└──╼ \$ docker exec -it postgresql psql -U ashley -d employees -c
\"SELECT \* FROM v_full_departments LIMIT 5;\"

dept_no \| dept_name \| total_employees

\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

d002 \| Finance \| 17346

d007 \| Sales \| 52245

d006 \| Quality Management \| 20117

d009 \| Customer Service \| 23580

d005 \| Development \| 85707

(5 rows)

**Comando de prueba 2 (*****v_current_salaries*****):**

┌─\[ashley@aguilar\]─\[\~/tecBD1\]

└──╼ \$ docker exec -it postgresql psql -U ashley -d employees -c
\"SELECT \* FROM v_current_salaries LIMIT 5;\"

emp_no \| full_name \| salary

\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\--

494071 \| Dzung Werthner \| 94458

494072 \| Yurij Rothe \| 54205

494073 \| Shakhar Hennebert \| 95892

494075 \| Hairong Paludetto \| 65273

494076 \| Kazuhiko Raczkowsky \| 58720

(5 rows)

Punto 3: Consultas de Verificación (25 pts)

Consultas SQL utilizadas para la verificación.

─\[✗\]─\[ashley@aguilar\]─\[\~/tecBD1\]

└──╼ \$ docker exec -it mariadb mysql -u root -p\'13778892\' -e \"

SELECT

COUNT(\*) AS total_registros,

SUM(salary) AS suma_salarios,

AVG(salary) AS promedio_salarios,

MIN(salary) AS salario_min,

MAX(salary) AS salario_max

FROM employees.salaries;\"

mysql: Deprecated program name. It will be removed in a future release,
use \'/usr/bin/mariadb\' instead

+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\--+

\| total_registros \| suma_salarios \| promedio_salarios \| salario_min
\| salario_max \|

+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\--+

\| 2844047 \| 181480757419 \| 63810.7448 \| 38623 \| 158220 \|

*+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\--+\-\-\-\-\-\-\-\-\-\-\-\--+*\
Salida de las consultas en ambos SGBD.

*+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+*

*\| huerfanos_dept_emp \|*

*+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+*

*\| 0 \|*

*+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+*

*+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+*

*\| huerfanos_salaries \|*

*+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+*

*\| 0 \|*

*+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+*

* huerfanos_dept_emp *

*\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--*

* 0*

*(1 row)*

* huerfanos_salaries *

*\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--*

* 0*

*(1 row)*

**\
Análisis de resultados (coincidencias, diferencias, problemas
encontrados).**

Tabla Comparativa

  ------------------------------------------ ------------------ ------------------ --------
  **Total Registros (*****salaries*****)**   2,844,047          2,844,047          Exacta
  **Suma Total (*****SUM*****)**             181,480,757,419    181,480,757,419    Exacta
  **Promedio (*****AVG*****)**               63,810.7448        63,810.7448        Exacta
  Salario Mínimo / Máximo                    38,623 / 158,220   38,623 / 158,220   Exacta
  **Huérfanos en *****dept_emp***            0                  0                  Exacta
  **Huérfanos en *****salaries***            0                  0                  Exacta
  ------------------------------------------ ------------------ ------------------ --------
