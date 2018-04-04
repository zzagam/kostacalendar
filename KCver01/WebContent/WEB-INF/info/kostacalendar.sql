drop sequence todo_seq;
 drop table todo_list;
 drop table category;
 drop table kc_user;


 
 
create table kc_user(
 	id varchar2(100) primary key,
 	password varchar2(100) not null,
 	name varchar2(100) not null,
 	grade number default 0 not null
 );
 
 select name, grade from kc_user where id='aaaa' and password='1111';
 
 

 create table category(
 	category_no number primary key,
 	category_name varchar2(100) not null
 );
 
 create table todo_list(
 	todo_no number,
 	id varchar2(100),
 	category_no number,
 	title varchar2(100) not null,
 	content clob not null,
 	start_date date not null,
 	end_date date not null,
 	constraint fk_kc_id foreign key(id) references kc_user,
 	constraint fk_category_no foreign key(category_no) references category,
 	constraint pk_todo_list primary key(id, category_no, todo_no)
 )
 
 create sequence todo_seq;
 
 commit
 
 insert into kc_user(id,password,name) values('aaaa','1111','정진표');
 insert into kc_user(id,password,name) values('bbbb','1111','김지은');
 insert into kc_user(id,password,name) values('cccc','1111','한샘');
 insert into kc_user(id,password,name) values('dddd','1111','유바롬');
 insert into kc_user(id,password,name) values('eeee','1111','김영호');
 

 insert into category(category_no, category_name) values(1,'공부');
insert into category(category_no, category_name) values(2,'업무');
insert into category(category_no, category_name) values(3,'약속');

 
 insert into todo_list(todo_no, id, category_no, title, content, start_date, end_date)
 values (todo_seq.nextval, 'eeee',1,'공부입니다','오늘은공부할겁니다',to_date('2018-04-05','YYYY-MM-DD'),to_date('2018-04-05','YYYY-MM-DD'));
 
  insert into todo_list(todo_no, id, category_no, title, content, start_date, end_date)
 values (todo_seq.nextval, 'eeee',1,'공부일까요?','ㅋㅋㅋㅋㅋㅋㅋ',to_date('2018-04-12','YYYY-MM-DD'),to_date('2018-04-12','YYYY-MM-DD'));
 
  insert into todo_list(todo_no, id, category_no, title, content, start_date, end_date)
 values (todo_seq.nextval, 'eeee',1,'공부맞음??','맞음!!',to_date('2018-04-28','YYYY-MM-DD'),to_date('2018-04-28','YYYY-MM-DD'));
 
 insert into todo_list(todo_no, id, category_no, title, content, start_date, end_date)
 values (todo_seq.nextval, 'eeee',2,'업무입니다','업무입니다',to_date('2018-04-05','YYYY-MM-DD'),to_date('2018-04-05','YYYY-MM-DD'));
 
 insert into todo_list(todo_no, id, category_no, title, content, start_date, end_date)
 values (todo_seq.nextval, 'eeee',3,'약속이있음','맞음!!',to_date('2018-04-05','YYYY-MM-DD'),to_date('2018-04-05','YYYY-MM-DD'));
 
 insert into todo_list(todo_no, id, category_no, title, content, start_date, end_date)
 values (todo_seq.nextval, 'eeee',3,'약속이있음','맞음!!',to_date('2018-03-28','YYYY-MM-DD'),to_date('2018-04-05','YYYY-MM-DD'));
 
 insert into todo_list(todo_no, id, category_no, title, content, start_date, end_date)
 values (todo_seq.nextval, 'eeee',2,'업무이있음','맞음!!',to_date('2018-03-29','YYYY-MM-DD'),to_date('2018-04-05','YYYY-MM-DD'));
 
insert into todo_list(todo_no, id, category_no, title, content, start_date, end_date)
 values (todo_seq.nextval, 'eeee',1,'공부가있음','맞음!!',to_date('2018-03-30','YYYY-MM-DD'),to_date('2018-04-05','YYYY-MM-DD'));

 
 
 
 
 select t.todo_no,t.title,to_char(t.start_date,'YYYYMMDD'),to_char(t.end_date,'YYYYMMDD')
 from todo_list t, kc_user k
 where t.id=k.id and t.id='eeee';
 
 
 
 SELECT b.no,b.title,b.hits,
to_char(time_posted,'YYYY.MM.DD') as time_posted,m.id,m.name 
FROM board_inst b , board_member m
WHERE b.id=m.id
order by no desc
 
select category_no, title, to_char(start_date,'YYYY-MM-DD'), to_char(end_date,'YYYY-MM-DD'), content
from todo_list
where id='eeee';

delete from todo_list where todo_no=19;

select category_no, title, to_char(start_date,'YYYY-MM-DD'), to_char(end_date,'YYYY-MM-DD'), content
from todo_list 
where id='eeee' and start_date <= sysdate and end_date >= sysdate;
 
select * from todo_list 

 select * from todo_list;
 
select * from category
 



select category_no,category_name,count(category_name) 
from (select c.category_no,c.category_name from todo_list t, category c
where t.id='eeee' and c.category_no=t.category_no)
group by category_name,category_no order by category_no;

select c.category_no,c.category_name from todo_list t, category c
where t.id='eeee' and c.category_no=t.category_no;

select category_no from todo_list where id='eeee';



select t.todo_no, c.category_no, c.category_name, t.title, to_char(t.start_date,'YYYY-MM-DD'), to_char(t.end_date,'YYYY-MM-DD'), t.content 
from todo_list t, category c 
where t.id='eeee' and t.category_no=c.category_no and start_date <= sysdate and end_date >= sysdate;`

