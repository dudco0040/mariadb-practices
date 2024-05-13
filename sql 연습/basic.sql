select version(), now() from dual;

-- 주석인 이렇게
-- 수학함수, 사칙연산
select sin(pi()/4), 1+2*2 from dual;

-- 대소문자 구분이 없음
sElecT version(), CURRENT_DATE(), now() From dual;

-- table 생성: DDL
create table pet(
	name varchar(100),
    owner varchar(50),
    species varchar(20),
    getder char(1),
    birth date,
    death date
);

-- schema 확인
describe pet;
desc pet;

-- table 삭제
drop table pet;
show tables;

-- insert: DML(C)
insert into pet values('popy','이영채','dog','m','2015-07-08', null);

-- select: DML(R)
select * from pet;

-- update: DML(U)
update pet set name ='boby' where name ='popy';

-- delete: DML(D)
delete from pet where name='boby';

-- load data: mysql(CLI 전용)
load data local infile '/root/pet.txt' into table pet;

-- select 연습 
select name, species
from pet 
where name = 'boswer';

select name, species, birth
from pet 
where birth > '1998-01-01';

select name, species, gender
from pet 
where species ='dog';
