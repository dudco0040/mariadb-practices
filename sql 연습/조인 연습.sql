-- inner join
-- 예제1) 현재, 근무하고 있는 직원의 이름과 직책을 모두 출력
select a.first_name, b.title
from employees a, titles b
where a.emp_no = b.emp_no  -- join 조건 (n-1)
and b.to_date = '9999-01-01';		-- row 선택 조건 

-- 예제2) 현재 근무하고 있는 직원의 이름과 직책을 모두 출력하되, 여성 엔지니어(Engineer)만 출력
select employees.first_name, titles.title
from employees, titles
where employees.emp_no = titles.emp_no
and titles.to_date = '9999-01-01'
and employees.gender = 'f'
and titles.title = 'Engineer';


--  ANSI.ISO SQL 1999 Join 표준 문법
-- 현재 직원별 근무 부서를 출력
-- 사번, 직원이름, 부서명으로 출력
select a.emp_no, a.fist_name, b.title
from employees a, departments b, dept_emp c
where b.dept_no = c.emp_no  
and c.to_date = '9999-01-01'
group by a.emp_no;

-- 실습 2
-- 현재 지급되고 있는 경로
-- 사번, 이름, 급여 순으로 


-- 실습 3
-- 현재 직책 별 평균 연봉과 직원 수를 구하되 직책 별 지원 수가 100명 이상인 직책만 출력
-- projection: 직책 평균연봉 직원수
select a.title as '직책', avg(b.salary) as '평균 연봉' , count(*) as '직원 수'
from titles a join salaries b on a.emp_no = b.emp_no
where a.to_date = '9999-01-01'
and b.to_date = '9999-01-01'
group by a.title
having count(*) > 100;


-- 1) natural join 
-- 조인 대상이 되는 두 테이블에 이름이 같은 공통 컬럼이 있으면
-- 조인 조건을 명시하지 않아도 암묵적으로 조인이 된다.
select a.first_name, b.title
from employees a natural join titles b 
where b.to_date = '9999-01-01';

-- 2) join ~ using
-- natural join 문제점
select count(*)
from salaries a join titles b using(emp_no)
where a.to_date = '9999-01-01'
and b.to_date = '9999-01-01';

-- 3) join ~ on
-- 예제) 현재 직책 별 평균 연봉을 큰 순서대로 출력
select title, avg(a.salary) as avg_salary
from salaries a join titles b on a.emp_no = b.emp_no
where a.to_date = '9999-01-01'
and b.to_date = '9999-01-01'
group by b.title
order by avg_salary desc;

-- 실습 문제4)
-- 현재 부서 별로 직책이 Engineer인 직원들에 대해서만 평균 연봉 구하기
-- 부서이름 평균급여 
select c.title, avg(d.salary)
from departments a, dept_emp b, titles c, salaries d  -- departments 를 연결하기 위한 b
where a.dept_no = b.dept_no
	and b.emp_no = c.emp_no
	and c.emp_no = d.emp_no   -- 1. join
	and b.to_date = '9999-01-01'
	and c.to_date = '9999-01-01'
    and d.to_date = '9999-01-01'
	and c.title = 'Engineer'  -- 2. 현재 엔지니어만 추출
group by a.dept_name;

