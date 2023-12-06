-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

CREATE TABLE "departments" (
    "dept_no" char(5)   NOT NULL,
    "dept_name" varchar(40)   NOT NULL,
    "last_updated" timestamp default localtimestamp  NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);
copy departments (dept_no, dept_name)
from 'D:departments.csv' delimiter','CSV header;

CREATE TABLE "dept_manager" (
    "dept_manager_id" serial   NOT NULL,
    "dept_no" char(5)   NOT NULL,
    "emp_no" int   NOT NULL,
    "last_updated" timestamp default localtimestamp  NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "dept_manager_id"
     )
);
copy dept_manager (dept_no, emp_no)
from 'D:dept_manager.csv' delimiter','CSV header;

CREATE TABLE "dept_emp" (
    "dept_emp_id" serial   NOT NULL,
    "emp_no" int   NOT NULL,
    "dept_no" char(5)   NOT NULL,
    "last_updated" timestamp default localtimestamp  NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "dept_emp_id"
     )
);
copy dept_emp (emp_no, dept_no)
from 'D:dept_emp.csv' delimiter','CSV header;

CREATE TABLE "employees" (
    "emp_no" integer   NOT NULL,
    "emp_title_id" char(5)   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(20)   NOT NULL,
    "last_name" varchar(20)   NOT NULL,
    "sex" char(1)   NOT NULL,
    "hire_date" date   NOT NULL,
    "last_updated" timestamp default localtimestamp  NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);
copy employees (emp_no,emp_title_id, birth_date,first_name,last_name,sex,hire_date)
from 'D:employees.csv' delimiter','CSV header;

CREATE TABLE "salaries" (
    "salary_id" serial   NOT NULL,
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    "last_updated" timestamp default localtimestamp  NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "salary_id"
     )
);
copy salaries (emp_no,salary)
from 'D:salaries.csv' delimiter','CSV header;

CREATE TABLE "titles" (
    "title_id" char(5)   NOT NULL,
    "title" varchar(50)   NOT NULL,
    "last_updated" timestamp default localtimestamp  NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);
copy titles (title_id,title)
from 'D:titles.csv' delimiter','CSV header;

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

UPDATE departments SET last_updated = CURRENT_TIMESTAMP;
UPDATE dept_manager SET last_updated = CURRENT_TIMESTAMP;
UPDATE dept_emp SET last_updated = CURRENT_TIMESTAMP;
UPDATE employees SET last_updated = CURRENT_TIMESTAMP;
UPDATE salaries SET last_updated = CURRENT_TIMESTAMP;
UPDATE titles SET last_updated = CURRENT_TIMESTAMP;

