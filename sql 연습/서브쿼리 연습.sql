-- 1) select 절, insert into t1 values(...)

-- 2) from 절의 서브 쿼리
select now() as n, sysdate() as s, 3+1 as r from dual;

select n, s, r 
from (select now() as n, sysdate() as s, 3+1 as r from dual) a;
-- 메모리에 있는 임시 테이블을 실제 테이블로 사용하는 방식 


-- 3) where 절의 서브 쿼리

-- 예제) 현재 Fai Bale이 근무하는 부서에서 근무하는 다른 직원의 사번과 이름을 출력

-- 서브 쿼리를 사용하지 않는 예시)
select b.dept_no
from employees a, dept_emp b 
where a.emp_no = b.emp_no 
and b.to_date = '9999-01-01' 
and concat(a.first_name, ' ', a.last_name) = 'Fai Bale';
-- dept_no : d004

select a.emp_no as 사번, concat(a.first_name, ' ', a.last_name)
from employees a, dept_emp b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and b.dept_no = 'd004';   -- 앞서 실행한 코드에서 얻은 결과를 조건에 활용 -> 이 부분에 서브쿼리를 사용한다. 


-- 서브 쿼리 사용 예시) 
select a.emp_no as 사번, concat(a.first_name, ' ', a.last_name)
from employees a, dept_emp b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and b.dept_no = (select b.dept_no
from employees a, dept_emp b 
where a.emp_no = b.emp_no 
and b.to_date = '9999-01-01' 
and concat(a.first_name, ' ', a.last_name) = 'Fai Bale');


-- 3-1) 단일행 연산자: =, >, <, >=, <=, <>, !=
-- 실습 문제1) 현재 전체 사원의 평균보다 적은 급여를 받는 사원의 이름과 급여를 출력
select avg(salary)
from salaries
where to_date = '9999-01-01';   -- 7212

select a.first_name, b.salary
from employees a, salaries b
where a.emp_no = b.emp_no
  and b.to_date = '9999-01-01'
  and b.salary < (select avg(salary)
from salaries
where to_date = '9999-01-01')
order by b.salary desc;

-- 실습 문제2) 현재, 직책 별 평균급여 중에 가장 작은 직책과 그 평균 급여를 출력

-- step 1) 
select a.title, avg(b.salary) as 평균급여
from titles a, salaries b
where a.emp_no = b.emp_no
  and a.to_date = '9999-01-01'
  and b.to_date = '9999-01-01'
group by a.title;

-- step 2) 
select min(a2.평균급여)
from (select a.title, avg(b.salary) as 평균급여  -- 57327
		from titles a, salaries b
		where a.emp_no = b.emp_no
		and a.to_date = '9999-01-01'
		and b.to_date = '9999-01-01'
	group by a.title) a2;

-- step 3) 
select a.title, avg(b.salary) as 평균급여
from titles a, salaries b
where a.emp_no = b.emp_no
  and 평균급여 = (select min(a2.평균급여)
				from (select a.title, avg(b.salary) as 평균급여
						from titles a, salaries b
						where a.emp_no = b.emp_no
						and a.to_date = '9999-01-01'
                        and b.to_date = '9999-01-01'
group by a.title) a2);


-- step 3)  최종 
select a.title as 직책, avg(b.salary) as 평균급여
from titles a, salaries b
where a.emp_no = b.emp_no
  and a.to_date = '9999-01-01'
  and b.to_date = '9999-01-01'
group by a.title
having avg(b.salary) = (
						select min(a2.평균급여)
						from (select a.title, avg(b.salary) as 평균급여  -- 57327
								from titles a, salaries b
								where a.emp_no = b.emp_no
								and a.to_date = '9999-01-01'
								and b.to_date = '9999-01-01'
						group by a.title) a2
    );


-- 3-2) 복수행 연산자: in, not in, 비교 연산자 + any, 비교 연산자 + all

-- any 사용법
-- 1. =any: in
-- 2. >any, >=any: 최소값
-- 3. <any, <=any: 최대값
-- 4. <>any, !=any: not in
 
-- all 사용법
-- 1. =all: (x) 
-- 2. >all, >=all: 최대값
-- 3. <all, <=all: 최소값
-- 4. <>all, !=all

-- 실습 문제3) 현재, 급여가 50000 이상인 직원의 이름과 급여를 출력

-- 1) join 사용
select concat(a.first_name, ' ', a.last_name) as 이름, b.salary as 급여
from employees a, salaries b
where a.emp_no = b.emp_no
  and b.to_date = '9999-01-01'
  and b.salary >= 50000;

-- 2) subquery: where(in)
select emp_no, salary
from salaries
where to_date = '9999-01-01'
and salary > 50000;  -- 복수행, 컬럼 반환

select a.first_name, b.salary
from employees a, salaries b
where a.emp_no = b.emp_no
  and b.to_date = '9999-01-01'
  and (a.emp_no, b.salary) in (select emp_no, salary
								from salaries
								where to_date = '9999-01-01'
								and salary > 50000);

-- 3) subquery: where(=any) ****


-- 실습 문제4) 현재, 각 부서 별로 최고 급여를 받고 있는 직원의 이름과 월급을 출력

-- sol 1: where 절 subquery(in)   **** 여기가 더 나은 방법인 것 같다.
select a.dept_no, max(b.salary)
from dept_emp a, salaries b
where a.emp_no = b.emp_no
  and a.to_date = '9999-01-01'
  and b.to_date = '9999-01-01'
group by a.dept_no;

select a.last_name, c.salary
from employees a, dept_emp b, salaries c
where a.emp_no = b.emp_no 
  and a.emp_no = c.emp_no
  and (b.dept_no, c.salary) in (select a.dept_no, max(b.salary)
							  	from dept_emp a, salaries b
								where a.emp_no = b.emp_no
								  and a.to_date = '9999-01-01'
								  and b.to_date = '9999-01-01'
								group by a.dept_no);


-- sol 2: from 절 subquery & join   ****
select a.dept_name, c.first_name, d.salary
from departments a, dept_emp b, employees c, salaries d, 
	 (select a.dept_no, max(b.salary) as max_salary
		from dept_emp a, salaries b
		where a.emp_no = b.emp_no
		and a.to_date = '9999-01-01'
		and b.to_date = '9999-01-01'
	  group by a.dept_no) e
      
where a.dept_no = b.dept_no
  and b.emp_no = b.emp_no
  and c.emp_no = d.emp_no
  and b.dept_no = e.dept_no -- 서브쿼리로 생성된 테이블과 조인 
  and b.to_date = '9999-01-01'
  and d.to_date = '9999-01-01'
  and d.salary = e.max_salary  -- 
  ;


-- 4) ****
select a.title, avg(salary)
from titles a, salaries b
where a.emp_no = b.emp_no
and a.to_date = '9999-01-01'
and b.to_date = '9999-01-01'
group by a.title
order by avg(salary) asc
limit 0,1;   -- 상위 1개만 추출?