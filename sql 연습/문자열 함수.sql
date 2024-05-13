-- 문자열 함수

-- upper: 대문자로
select upper('seoul'), ucase('SeouL') from dual;
select upper(first_name) from employees;

-- lower: 소문자로
select lower('SEOUL'), lcase('SeouL') from dual;
select lower(first_name) from employees;

-- substring(문자열, index, length)
select substring('Hello World', 3, 2);

-- 예제: 1989년에 입사한 직원들의 이름, 입사일을 출력
select first_name, hire_date
from employees
where substring(hire_date, 1,4) = '1989';

-- lpad(left padding), rpad(right_padding)
select lpad('1234', 10, '-'), rpad('1234', 10, '-') from dual;  -- 나머지 정렬에 '-'로 채우기 

-- 예제) 직원들의 월급을 오른쪽 정렬(빈공간은 *으로 출력)
select lpad(salary, 10, '*') from salaries;

-- trim, ltrim, rtrim
select
	concat('---', ltrim('   hello   '), '---'),
	concat('---', rtrim('   hello   '), '---'),
    concat('---', trim(leading 'x' from 'xxxhellxxx'), '---'), 
    concat('---', trim(trailing 'x' from 'xxxhellxxx'), '---'),
    concat('---', trim(both 'x' from 'xxxhellxxx'), '---'),
    concat('---', trim(both ' ' from '   hell   '), '---')
from dual;

-- length
select length("Hello World") from dual;

