-- 수학 함수

-- abs
select abs(1), abs(-1) from dual;

-- ceil: 올림 
select ceil(3.14), ceiling(3.14) from dual;

-- floor: 내림
select floor(3.14) from dual;

-- mod
select mod(10, 3), 10%3 from dual;

-- round(x): x의 가장 근접한 정수(반올림)  == round(x,0)
-- round(x,d): x 값 중에 소수점 d 자리에 가장 근접한 실수 
select round(1.498), round(1.511) from dual;
select round(1.498, 1) from dual;

-- power(x,y), pow(x,y): x의 y승
select power(2,10), pow(2,10) from dual;

-- sign(x): 양수면 1, 음수면 -1, 0이면 1 출력
select sign(20), sign(-100), sign(0) from dual;

-- greates(x, y, ...) least(x, y, ...)
select greatest(10, 40, 20, 50), least(10, 40, 20, 50) from dual;
select greatest('b', 'A', 'C', 'D'), least('hello', 'hela', 'hell') from dual;

