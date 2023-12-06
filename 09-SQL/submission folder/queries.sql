--1 List the employee number, last name, first name, sex, and salary of each employee

select employees.emp_no, employees.last_name,employees.first_name,employees.sex,salaries.salary
from employees
inner join salaries on
salaries.emp_no = employees.emp_no;

--2 List the first name, last name, and hire date for the employees who were hired in 1986
select first_name,last_name, hire_date
from employees
where hire_date between '1986-01-01' and '1987-01-01';

--3 List the manager of each department along with their department number, department name, employee number, last name, and first name
select departments.dept_no,departments.dept_name,dept_manager.emp_no,employees.last_name,employees.first_name
from departments
join dept_manager
on departments.dept_no=dept_manager.dept_no 
join employees
on dept_manager.emp_no=employees.emp_no;

--4 List the department number for each employee along with that employee’s employee number, last name, first name, and department name
select dept_emp.dept_no, dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
from dept_emp
join employees
on dept_emp.emp_no=employees.emp_no
join departments
on dept_emp.dept_no=departments.dept_no;

--5 List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B
select employees.first_name, employees.last_name, employees.sex
from employees
where first_name='Hercules'and last_name like'B%';

--6 List each employee in the Sales department, including their employee number, last name, and first name
select departments.dept_name,dept_emp.emp_no,employees.last_name, employees.first_name
from dept_emp
join employees
on dept_emp.emp_no=employees.emp_no
join departments
on dept_emp.dept_no=departments.dept_no
where departments.dept_name='Sales';

--7 List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name
select dept_emp.emp_no,employees.last_name, employees.first_name,departments.dept_name
from dept_emp
join employees
on dept_emp.emp_no=employees.emp_no
join departments
on dept_emp.dept_no=departments.dept_no
where departments.dept_name='Sales'
or departments.dept_name='Development';

--8 List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name)
select last_name, count(last_name)
from employees
group by last_name
order by count(last_name)desc;

  



