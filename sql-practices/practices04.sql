-- 서브쿼리(SUBQUERY) SQL 문제입니다.

-- 문제1.
-- 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
select avg(salary)
from salaries
where to_date = '9999-01-01';  -- 72012

-- where 문에 사용
select count(*)
from salaries
where salary > (select avg(salary)
				from salaries
				where to_date = '9999-01-01')
and to_date = '9999-01-01';  -- *** 

-- 문제2.  (X)
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 연봉을 조회하세요. 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. 
select a.dept_no, max(b.salary) as 최고급여
from dept_emp a, salaries b
where a.emp_no = b.emp_no
  and a.to_date = '9999-01-01'
  and b.to_date = '9999-01-01'
group by a.dept_no;


-- from 절에서 사용
select a.emp_no, concat(a.first_name, ' ', a.last_name), c.최고급여
from employees a, dept_emp b, (
								select a.dept_no, max(b.salary) as 최고급여
								from dept_emp a, salaries b
								where a.emp_no = b.emp_no
								  and a.to_date = '9999-01-01'
								  and b.to_date = '9999-01-01'
								group by a.dept_no
								) c
where a.emp_no = b.emp_no
  and b.dept_no = c.dept_no
;


-- where 절에 사용  *** 이게 답! 
select a.emp_no, a.last_name, b.salary
from employees a, salaries b
where a.emp_no = b.emp_no
  and b.salary in (
					select max(b.salary) as 최고급여
					from dept_emp a, salaries b
					where a.emp_no = b.emp_no
					  and a.to_date = '9999-01-01'
					  and b.to_date = '9999-01-01'
					group by a.dept_no
                    );


-- 문제3.  **자신의 부서 
-- 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요 
-- 부서에 따라 평균 연봉을 매치해서 비교 해야한다. 

select a.dept_no as 부서, avg(b.salary) as 평균급여
from dept_emp a, salaries b
where a.emp_no = b.emp_no
  and a.to_date = '9999-01-01'
  and b.to_date = '9999-01-01'
group by 부서;

-- *** 답 확인 필요 
select a.emp_no, concat(a.first_name, ' ', a.last_name), c.salary
from employees a, dept_emp b, salaries c, (
											select a.dept_no as dept, avg(b.salary) as avg_salary
											from dept_emp a, salaries b
											where a.emp_no = b.emp_no
											  and a.to_date = '9999-01-01'
											  and b.to_date = '9999-01-01'
											group by dept
                                            ) d
where a.emp_no = b.emp_no
  and a.emp_no = c.emp_no
  and b.dept_no = d.dept
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01'
  and b.dept_no = d.dept  -- 부서가 같으면서 
  and c.salary > d.avg_salary  -- 부서 별 평균연봉 보다 큰 경우 
  ;
  



-- 문제4.
-- 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.
-- 사원 , 매니저 
select a.emp_no as 사번, concat(a.first_name, ' ', a.last_name) as 이름, concat(e.first_name, ' ', e.last_name) as 매니저이름, d.dept_name as 부서이름
from employees a, dept_emp b, dept_manager c, departments d, employees e
where a.emp_no = b.emp_no
  and b.emp_no = c.emp_no
  and c.dept_no = d.dept_no
  and c.emp_no = e.emp_no
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01'
;


select a.emp_no as 사번, concat(c.first_name, ' ', c.last_name) as 이름, c.dept_name as 부서이름 
from employees a, dept_manager b, departments c
where a.emp_no = b.emp_no
  and b.dept_no = c.dept_no
  and b.to_date = '9999-01-01'
;


-- 문제5.
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.

select b.dept_no, avg(a.salary) as 평균연봉
from salaries a, dept_emp b
where a.emp_no = b.emp_no
  and a.to_date = '9999-01-01'
  and b.to_date = '9999-01-01'
group by b.dept_no   -- 'd007', '88852.9695'
order by 평균연봉 desc
limit 0,1
;

select a.emp_no as 사번, concat(a.first_name, ' ', a.last_name) as 이름, b.title as 직책, d.salary as 연봉
from employees a, titles b, dept_emp c, salaries d
where a.emp_no = b.emp_no
  and a.emp_no = c.emp_no
  and a.emp_no = d.emp_no
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01'
  and d.to_date = '9999-01-01'
  and c.dept_no = (
					select b.dept_no
					from salaries a, dept_emp b
					where a.emp_no = b.emp_no
					  and a.to_date = '9999-01-01'
					  and b.to_date = '9999-01-01'
					group by b.dept_no   -- 'd007', '88852.9695'
					order by avg(a.salary) desc
					limit 0,1
                    )
order by 연봉 desc;

-- 직책 
select b.title
from salaries a, titles b
where a.emp_no = b.emp_no
  and a.to_date = '9999-01-01'
  and b.to_date = '9999-01-01'
group by b.title
order by avg(a.salary) desc
limit 0,1 ;    -- 가장 높은 부서(80706)


select a.emp_no, concat(a.first_name, ' ', a.last_name), b.title, c.salary
from employees a, titles b, salaries c
where a.emp_no = b.emp_no
  and a.emp_no = c.emp_no
  and b.to_date = '9999-01-01'
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01'
  and b.title = (
					select b.title
					from salaries a, titles b
					where a.emp_no = b.emp_no
					and a.to_date = '9999-01-01'
					and b.to_date = '9999-01-01'
					group by b.title
					order by avg(a.salary) desc
					limit 0,1
					)
order by c.salary desc;
                    
                    

-- 문제6.
-- 평균 연봉이 가장 높은 부서는? 
select b.dept_name, avg(c.salary) as 평균연봉
from dept_emp a, departments b, salaries c
where a.dept_no = b.dept_no
  and a.emp_no = c.emp_no
  -- and a.to_date = '9999-01-01'
  -- and c.to_date = '9999-01-01'
group by b.dept_name
order by 평균연봉 desc  -- 'Sales', '80667.6058' 
limit 0,1 ;



-- 문제7.
-- 평균 연봉이 가장 높은 직책?
select a.title, avg(b.salary) as 평균연봉
from titles a, salaries b
where a.emp_no = b.emp_no
  -- and a.to_date = '9999-01-01'
  -- and b.to_date = '9999-01-01'
group by a.title
order by 평균연봉 desc  -- 'Senior Staff', '70470.8353'
limit 0,1;


-- 문제8.
-- 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.
select a.dept_no, avg(b.salary)
from dept_manager a, salaries b
where a.emp_no = b.emp_no
  and a.to_date = '9999-01-01'
  and b.to_date = '9999-01-01'
group by a.dept_no;

select concat(a.first_name + ' ' + a.last_name) 
from employees a, salaries b, dept_manager c, (
	select a.dept_no, avg(b.salary)
	from dept_manager a, salaries b
	where a.emp_no = b.emp_no
      and a.to_date = '9999-01-01'
	  and b.to_date = '9999-01-01'
	group by a.dept_no
    ) b
where a.emp_no = b.emp_no
  and a.emp_no = c.emp_no
  and c.dept_no = b.dept_no
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01'
;
  
