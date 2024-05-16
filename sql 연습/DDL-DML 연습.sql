-- DDL/DML 연습

-- 테이블 생성 
create table member(
	no int not null auto_increment,
	email varchar(200) not null default '',
    password varchar(64) not null,
    name varchar(50) not null,
    department varchar(100),
    primary key(no)
);

-- 테이블 삭제
drop table member;

desc member;

-- 컬럼 추가 
alter table member add column juminbunho char(13) not null;  -- 위치 지정 안하면 가장 끝 컬럼으로 추가 

-- 컬럼 삭제 
alter table member drop juminbunho;

-- email 뒤에 컬럼 추가하기 
alter table member add column juminbunho char(13) not null after email;

-- 컬럼 변경하기
-- 1. 이름 변경
alter table member change column department dept varchar(100) not null ;  -- 변경하고자 하는 컬럼의 이름 및 데이터 타입을 함께 명시해준다. 

alter table member add column self_intro text;

alter table member drop juminbunho;

-- insert 
insert 
into member
values(null, "dudco0040@naver.com", password("1234"), '이영채', '개발팀', null);   -- password() : 암호화 
select * from member;

insert 
into member(no, email, name, dept, password)
values(null, "dudco0040@naver.com", '이영채2', '개발팀2', password("1234"));
select * from member;


-- update 
update member
 set email = 'dudco0040@gmail.com', password = password('4321')
where no = 2; 
select * from member;

-- delete
delete
from member
where no = 2;
select * from member;

-- transaction
select no, email from member;

select @@autocommit;  -- 1
insert into member values(null, "dudco0040@naver.com", password("1234"), '이영채', '개발팀', null); 

-- tx begin
set autocommit = 0;  -- autocommit을 0으로 변경 
select @@autocommit;
insert into member values(null, "dudco00402@naver.com", password("1234"), '이영채2', '개발팀2', null); 

-- tx end
commit;