- Create Employees Table
DROP TABLE IF EXISTS employees;
-- Create table for employees
CREATE TABLE employees(
	emp_no INT PRIMARY KEY NOT NULL, 
	birth_date DATE NOT NULL,
	first_name VARCHAR  NOT NULL,
	last_name VARCHAR  NOT NULL,
	gender CHAR  NOT NULL,
	hire_date DATE  NOT NULL
	);
SELECT * FROM employees
--Drop Table if it already exists
DROP TABLE departments;
-- Create table for departments
CREATE TABLE departments(
	dept_no VARCHAR(4) PRIMARY KEY NOT NULL,
	dept_name VARCHAR NOT NULL
	);
SELECT*
FROM departments
--Drop Table if it already exists
DROP TABLE IF EXISTS dept_emp;
-- Create table for departments
CREATE TABLE dept_emp
(
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	dept_no VARCHAR(4) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	from_date VARCHAR(30) NOT NULL,
	to_date VARCHAR(30) NOT NULL
);
SELECT*
FROM dept_emp
--Drop Table if it already exists
DROP TABLE IF EXISTS dept_manager;
-- Create table for dept_manager
CREATE TABLE dept_manager
(
	dept_no VARCHAR(4) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	from_date VARCHAR(30) NOT NULL,
	to_date VARCHAR(30) NOT NULL
);
SELECT*
FROM dept_manager
--Drop Table if it already exists
DROP TABLE IF EXISTS salaries;
-- Create table for salaries
CREATE TABLE salaries
(
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	salary INT NOT NULL,
	from_date VARCHAR(30) NOT NULL,
	to_date VARCHAR(30) NOT NULL
);
SELECT*
FROM salaries
--Drop Table if it already exists
DROP TABLE IF EXISTS titles;
-- Create table for titles
CREATE TABLE titles
(
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	title VARCHAR(30) NOT NULL,
	from_date VARCHAR(30) NOT NULL,
	to_date VARCHAR(30) NOT NULL
);
SELECT*
FROM  titles

--1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT 
e.emp_no,
e.last_name,
e.first_name,
e.gender,
s.salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no;
--2. List employees who were hired in 1986.
SELECT e.emp_no, e.first_name, e.last_name, e.hire_date
FROM employees e
WHERE extract(year from hire_date) = '1986'; 
--3. List the manager of each department with: 
--department number, department name, the manager's employee number, 
--last name, first name, and start and end employment date
SELECT d.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name, m.from_date, m.to_date
FROM departments AS d
INNER JOIN dept_manager AS m ON
m.dept_no = d.dept_no
JOIN employees AS e ON
e.emp_no = m.emp_no;

--4. List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
INNER JOIN dept_emp AS dp ON
e.emp_no = dp.emp_no
INNER JOIN departments AS d ON
d.dept_no = dp.dept_no;

--5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM employees
WHERE first_name LIKE 'Hercules'
AND last_name LIKE 'B%';

--6. List all employees in the Sales department, 
--including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
INNER JOIN dept_emp AS dp ON
e.emp_no = dp.emp_no
INNER JOIN departments AS d ON
d.dept_no = dp.dept_no
WHERE d.dept_name LIKE 'Sales';
--7. List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
INNER JOIN dept_emp AS dp ON
e.emp_no = dp.emp_no
INNER JOIN departments AS d ON
d.dept_no = dp.dept_no
WHERE d.dept_name LIKE 'Sales'
OR d.dept_name LIKE 'Development';
--8. In descending order, list the frequency count of employee last names,
--i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;


