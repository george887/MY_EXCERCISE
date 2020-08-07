
-- 2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.
use `employees`;
-- need department name and manager name
select dept_name, concat(first_name, " ", last_name) as full_name
from `employees` as e
join dept_manager as dep on dep.emp_no = e.emp_no
join departments as d on d.dept_no = dep.dept_no
where dep.to_date > curdate();

-- 3. Find the name of all departments currently managed by women.
select dept_name, concat(first_name, " ", last_name) as full_name
from `employees` as e
join dept_manager as dep on dep.emp_no = e.emp_no
join departments as d on d.dept_no = dep.dept_no
where dep.to_date > curdate()
and e.gender = 'f'
order by dept_name;

-- 4. Find the current titles of employees currently working in the Customer Service department.
-- need current titles, employees name working in customer service dept
select t.title, d.dept_name, count(*)
from titles as t
join dept_emp as de on de.emp_no = t.emp_no
join departments as d on d.dept_no = de.dept_no
where de.to_date > curdate()
and t.to_date > curdate()
and `dept_name` = "Customer Service"
group by t.title;

-- 5. Find the current salary of all current managers.
use employees;
select d.dept_name, concat(first_name, ' ', last_name) as full_name, salary
from salaries as s
join dept_manager as dep on dep.emp_no = s.emp_no
join employees as e on e.emp_no = s.emp_no
join departments as d on d.dept_no = dep.dept_no
where s.to_date > curdate()
and dep.to_date > curdate()
order by dept_name;

-- 6.Find the number of employees in each department.
select d.dept_no, d.dept_name, count(*)
from employees as e
join dept_emp as dept on dept.emp_no = e.emp_no
join departments as d on d.dept_no = dept.dept_no
where dept.to_date > curdate()
group by d.dept_no;

-- 7. Which department has the highest average salary? Hint: Use current not historic information.
select d.dept_name, avg(salary)
from employees as e
join dept_emp as dept on dept.emp_no = e.emp_no
join departments as d on d.dept_no = dept.dept_no
join salaries as s on s.emp_no = e.emp_no
where dept.to_date > curdate()
group by d.dept_name
order by avg(salary) desc
limit 1;

-- 8.Who is the highest paid employee in the Marketing department?
select first_name, last_name
from employees as e
join dept_emp as dept on dept.emp_no = e.emp_no
join departments as d on d.dept_no = dept.dept_no
join salaries as s on s.emp_no = e.emp_no
where dept.to_date > curdate()
and d.dept_name = "Marketing"
order by salary desc
limit 1;

-- 9. Which current department manager has the highest salary?
select first_name, last_name, salary, dept_name
from employees as e
join dept_manager as dept on dept.emp_no = e.emp_no
join departments as d on d.dept_no = dept.dept_no
join salaries as s on s.emp_no = e.emp_no
where dept.to_date > curdate()
order by salary desc
limit 1;
