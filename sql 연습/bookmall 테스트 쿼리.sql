select * from user;
select * from category;
select * from book;
select * from cart;
select * from orders;
select * from order_book;

desc cart;

delete from user;


delete from user where no = 54;

select user_no, book_no, quantity from cart where user_no = 1;

select a.user_no, b.book_no, c.title, b.quantity, b.price
from orders a, order_book b, book c
where a.no = b.order_no 
  and b.book_no = c.no
  and a.no = ?
  and a.user_no =? ;

select a.book_no, b.title, a.user_no, a.order_no, a.quantity, a.price
from ( select b.book_no, a.user_no, b.order_no, b.quantity, b.price from orders a, order_book b where a.no = b.order_no and a.no = ? and a.user_no =? ) a, book b
where a.book_no = b.no;


select b.book_no, a.user_no, b.order_no, b.quantity, b.price from orders a, order_book b where a.no = b.order_no and a.no = ? and a.user_no =?;

select b.book_no, a.user_no, b.order_no, b.quantity, b.price from orders a, order_book b where a.no = b.order_no ;

select * -- a.user_no, b.book_no, c.title, b.quantity, b.price
from orders a, order_book b, book c
where a.no = b.order_no
  and b.book_no = c.no
;


select a.user_no, b.book_no, c.title, b.quantity, b.price
from orders a, order_book b, book c
where a.no = b.order_no
  and b.book_no = c.no
  and a.no = ? and a.user_no =?
;