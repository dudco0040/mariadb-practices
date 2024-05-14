-- 날짜 함수

-- curdate(), current_date : 날짜
select curdate(), current_date from dual;

-- curtime(), current_time : 시간
select curtime(), current_time() from dual; 

-- now() vs sysdate()
select now(), sysdate() from dual;
select now(), sleep(2), now() from dual;    	-- 차이 없음(query가 실행된 시간)
select now(), sleep(2), sysdate() from dual;	-- 차이 있음(함수가 호출된 시간)

-- date_format
-- defualt format: %Y-%m-%d %h:%i:%s
select date_format(now(), '%Y년 %m월 %d일 %h시 %i분 %s초') from dual;
select date_format(now(), '%d %b') from dual;

-- period_diff: 시간의 차이
-- 예제) 근무 개월 
--      formatting: YYMM, YYYYMM
select first_name, hire_date,
	period_diff(date_format(curdate(), "%y%m"), date_format(hire_date, "%y%m")) as month   -- format을 맞춰야 diff가 가능하다.
from employees;

-- date_add(=adddate), data_sub(=subdate)
-- 날짜를 date 타입의 컬럼이이나 값에 type(year, month, day)의 표현식으로 더하거나 뺄 수 있다.
-- 예제) 각 사원의 근속 연수가 5년이 되는 날에 휴가를 보내준다면 각 사원의 5년 근속 휴가 날짜는?
select first_name, hire_date, 
date_add(hire_date, interval 5 year)
from employees;

-- cast
select '12345' + 10, cast('12345' as int) + 10 from dual;   -- 문자열을 숫자로 자동 casting 해줘서 연산이 가능함 
select date_format(cast('2013-01-09' as date), '%Y년 %m월 %d일') from dual;  -- 문자열을 date 형식으로 casting해서 포멧팅을 해줌 
select cast(cast(1-2 as unsigned) as signed) from dual;  -- unsigned의 범위??
select cast(cast(1-2 as unsigned) as int) from dual;
select cast(cast(1-2 as unsigned) as integer) from dual;

-- type
-- 문자: varchar, char, text, CLOB(Character Large OBject)
-- 정수: medium int, int(signed, integer), unsigned, big int
-- 실수: float, double
-- 시간: date, datetime
-- LOB: CLOB, BLOB(Binary Large OBject) 