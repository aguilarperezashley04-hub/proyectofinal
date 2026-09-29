cat << 'EOF' > estructura_postgres.sql
-- =============================================================================
-- SCRIPT DDL: Estructura de la Base de Datos pdb_employees para PostgreSQL
-- =============================================================================

CREATE SCHEMA IF NOT EXISTS employees;
SET search_path TO employees, public;

-- 1. Crear Tipos Personalizados (ENUMs)
CREATE TYPE employees.gender_enum AS ENUM ('M', 'F');

-- 2. Tabla: employees
CREATE TABLE employees.employees (
    emp_no      INTEGER     NOT NULL,
    birth_date  DATE        NOT NULL,
    first_name  VARCHAR(14) NOT NULL,
    last_name   VARCHAR(16) NOT NULL,
    gender      employees.gender_enum NOT NULL,
    hire_date   DATE        NOT NULL,
    CONSTRAINT pk_employees PRIMARY KEY (emp_no)
);

-- 3. Tabla: departments
CREATE TABLE employees.departments (
    dept_no   CHAR(4)     NOT NULL,
    dept_name VARCHAR(40) NOT NULL,
    CONSTRAINT pk_departments PRIMARY KEY (dept_no),
    CONSTRAINT uk_departments_dept_name UNIQUE (dept_name)
);

-- 4. Tabla: dept_emp
CREATE TABLE employees.dept_emp (
    emp_no    INTEGER NOT NULL,
    dept_no   CHAR(4) NOT NULL,
    from_date DATE    NOT NULL,
    to_date   DATE    NOT NULL,
    CONSTRAINT pk_dept_emp PRIMARY KEY (emp_no, dept_no),
    CONSTRAINT fk_dept_emp_employees FOREIGN KEY (emp_no) 
        REFERENCES employees.employees (emp_no) ON DELETE CASCADE,
    CONSTRAINT fk_dept_emp_departments FOREIGN KEY (dept_no) 
        REFERENCES employees.departments (dept_no) ON DELETE CASCADE
);

-- 5. Tabla: dept_manager
CREATE TABLE employees.dept_manager (
    emp_no    INTEGER NOT NULL,
    dept_no   CHAR(4) NOT NULL,
    from_date DATE    NOT NULL,
    to_date   DATE    NOT NULL,
    CONSTRAINT pk_dept_manager PRIMARY KEY (emp_no, dept_no),
    CONSTRAINT fk_dept_manager_employees FOREIGN KEY (emp_no) 
        REFERENCES employees.employees (emp_no) ON DELETE CASCADE,
    CONSTRAINT fk_dept_manager_departments FOREIGN KEY (dept_no) 
        REFERENCES employees.departments (dept_no) ON DELETE CASCADE
);

-- 6. Tabla: titles
CREATE TABLE employees.titles (
    emp_no    INTEGER     NOT NULL,
    title     VARCHAR(50) NOT NULL,
    from_date DATE        NOT NULL,
    to_date   DATE,
    CONSTRAINT pk_titles PRIMARY KEY (emp_no, title, from_date),
    CONSTRAINT fk_titles_employees FOREIGN KEY (emp_no) 
        REFERENCES employees.employees (emp_no) ON DELETE CASCADE
);

-- 7. Tabla: salaries
CREATE TABLE employees.salaries (
    emp_no    INTEGER NOT NULL,
    salary    INTEGER NOT NULL,
    from_date DATE    NOT NULL,
    to_date   DATE    NOT NULL,
    CONSTRAINT pk_salaries PRIMARY KEY (emp_no, from_date),
    CONSTRAINT fk_salaries_employees FOREIGN KEY (emp_no) 
        REFERENCES employees.employees (emp_no) ON DELETE CASCADE
);
EOF