insert into user values(null, '관리자', 'admin@mysite.com', password('1234'), 'male', current_date());

-- current_date(): 현재 날짜(시간 X)

-- login
select no, name from  user where email = ? and password = password