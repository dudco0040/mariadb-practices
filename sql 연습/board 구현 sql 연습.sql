-- test
select * from board;

-- insert
insert into board(title, contents, hit, reg_date, g_no, o_no, depth, user_no) 
values("내 두번째의 제목이야", "이건 본문 내용이야", 0, now(), 2, 1, 0, 10);

insert into board(title, contents, hit, reg_date, g_no, o_no, depth, user_no) 
values("내 두번째의 제목이야", "이건 본문 내용이야", 0, now(), (select max(g_no) from board)+1, 1, 0, 10);
select max(g_no) from board;

-- subquery 
INSERT INTO board (title, contents, hit, reg_date, g_no, o_no, depth, user_no)
SELECT "내 두번째의 제목이야", "이건 본문 내용이야", 0, NOW(), IFNULL(MAX(g_no), 0) + 1, 1, 0, 10
FROM board;



select * from user;

-- list
select a.no, a.title, b.name, a.hit, date_format(a.reg_date, '%Y/%m/%d %H:%i:%s') as reg_date
from board a, user b 
where a.user_no = b.no;

-- view
select * from board;
select * from board where no = 17;

-- 글 하나 넣어주기 
select a.title, a.contents 
from board a, user b
where a.user_no = b.no
and a.title = "내 첫글의 제목이야" 
and a.user_no = 8;
 

-- reply
select * from board;
-- 순서 변경
update board set o_no = o_no+1
where g_no = 2
and o_no > 0;
-- 값 추가
insert into board(title, contents, hit, reg_date, g_no, o_no, depth, user_no) 
values("답글", "답글이다", 0, now(), 2, 1, 1, 12);