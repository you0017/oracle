--sql
--DDL数据定义语言：create对象名，drop 对象名，alter对象名，truncate

-- 任务一：truncate,drop,delete

--1.truncate 截断，删除数据而不删除结构
drop table product;

create table product(
       pid int primary key,
       pname varchar2(20)
);

insert into product values(1,'apple');
insert into product values(2,'pear');

select * from product;

--drop与truncate区别
--1.表格数据被清空，存储空间被释放
--2.drop,truncate运行后会自动提交事务，包括之前为提交的会话，因此一旦清空无法回退
--3.只有表格的创建者或者其他拥有删除任意表格权限的用户 才能清空表格

drop table product;
select * from product;--表或视图都不存在


--truncate后表结构还在（清空数据
truncate table product;
select * from product; --表结构在，数据没了







--dual表，是oracle自带的空的测试表，用于测试函数
select * from dual;
--create table table_name as select语句;
--rownum行编号
select sysdate from dual; --sysdate是系统当前时间  as设置别名
-- to_char(日期时间,'yyyy-MM-dd hh24:mi:ss')将日期时间转为这种格式的字符串，dateformater一样
select dbms_random.value(0,100) from dual; --生成0-100的随机数
select trunc(3.4) from dual;  --截断，去掉小数位
select trunc(dbms_random.value(0,100)) as a from dual;
select dbms_random.string('x',20) as random_string from dual; --随机字符,20位


--创建表插入数据
drop table testtable;

create table testtable as 
select rownum as id,
              to_char(sysdate + rownum/24/3600,'yyyy-MM-dd hh24:mi:ss') as inc_datetime,
              trunc(dbms_random.value(0,100)) as random_id,
              dbms_random.string('x',20) as random_string
           from dual
           connect by level <=100000;--生成十万条
           
select * from testtable;

--用truncate删除
truncate table testtable;

--用drop
drop table testtable;

--用delete
delete from testtable;

--为什么 truncate 比 delete 在删除上快
--delete删除要对每条记录做一次日志
--truncate不生成日志，直接提交修改，所以无法回滚事务








--任务二: DML基础：数据操作语言  insert，delete，update，select

--insert into 表名 values();

drop table product;
create table product(
       pid int primary key,
       pname varchar2(20)
);
insert into product values(1,'apple');
insert into product values(2,'pear');

--select 语法：select列名from表名
select * from product;
select pid,pname from product;
select pid as 编号,pname as 名称 from product;
select pid as 编号,pname as 名称 from product where pid=1;


--update语法：update 表名 set 列名=新值,列名2=新值2 where 条件
update product set pname='蛇果' where pid=1;

--delete语法: delete from 表名 [where 条件]
delete from product where pid=2;






--sql中的运算符  =等于     <>不等于
drop table product;
create table product(
       pid int primary key,
       pname varchar2(20)
);
insert into product values(1,'apple');
insert into product values(2,'pear');
insert into product values(3,'snake pear');
insert into product values(4,'snow pear');

select * from product where pid=1;
select * from product where pid<>1;
select * from product where 1=1;   --特殊用法  全部数据
select * from product where 1<>1;  --特殊用法  空的

/*
       for(i  in  product){
              if(i == pid){
              --提取当前循环的这条语句
              }
              if(i != pid){
              }
              if(1 == 1){
              }
              if(1 != 1){
              }
       }
*/

--1.复制一张表test141，结构与emp一样
select * from emp;

create table test141 as select * from emp where 1=1;

select * from test141;


--2.复制一张表test141_2，只要结构不要数据
select * from emp;

create table test141_2 as select * from emp where 1<>1;

select * from test141_2;





--扩展：为什么 查询语句后面要加1=1
--java来凭借复杂的查询语句
select * from product;
select * from product where pid=1;
select * from product where pname='pear';
select * from product where pid=1 and pname='pear';

--只要写一条原始语句然后根据业务来拼接其他条件
select * from product where 1=1
         and pid=1
         and pname = 'pear';
--如果没有1=1
select * from product where 
          pid=1
         and pname = 'pear';

/*
       字符串  相当于正则表达式 通配符 _  % 要和like一起用
*/

drop table product;
create table product(
       pid int primary key,
       pname varchar2(20)
);
insert into product values(1,'apple');
insert into product values(2,'pear');
insert into product values(3,'snake pear');
insert into product values(4,'snow pear');
insert into product values(5,'火龙果');
insert into product values(6,'桃子');
insert into product values(7,'火了');

select * from product;

select * from product where 1=1 and pname like '火%';
select * from product where 1=1 and pname like '火_';
select * from product where 1=1 and pname = '火_';
select * from product where 1=1 and pname = '火%';
select * from product where 1=1 and pname like '%果';







/*
       扩及表达式案例
       A and B
       A or B
       not A 取反
*/
--支付信息表
drop table payinfo;
-- userid用户编号   paytype支付类型   creaditcard信用卡
create table payinfo(
       pid int primary key,
       userid int,
       paytype varchar2(10),
       creaditcard varchar2(20)
);

insert into payinfo values(1,1,'信用卡','龙卡');
insert into payinfo values(2,2,'信用卡','长城卡');
insert into payinfo values(3,2,'现金','');
insert into payinfo values(4,2,'微信','');

select * from payinfo;

select * from payinfo where paytype='信用卡';
select * from payinfo where not(paytype='信用卡');

select * from payinfo where not(paytype='信用卡') or creaditcard<>'龙卡';






/*
       日期与时间
       dual表：测试表，空表  相当于linux中的 NULL
*/

select * from dual;
--dual是一个空表，用于测试和学习
select sysdate from dual;       --系统时间(oracle时间
select systimestamp from dual;  --当前系统时间戳
select current_timestamp from dual;            --与时区设置有关，返回的秒是系统的，返回的日期和时间是根据时区转换过的
select current_date from dual;                 --是对current_timestamp准确到秒的四舍五入
select sysdate,systimestamp,current_timestamp,current_date from dual;


/*
       日期时间与字符串的转换
       java: new SimpleDateFormat("yyyy年MM月dd HH:mm:ss");
         .format(new Date());
*/

--将字符串2018-08-23 00:00:00转时间类型 date类型 ***
select to_date('2018-08-23 00:00:00','yyyy-mm-dd hh24:mi:ss') from dual;

--将时间类型转字符串
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') from dual;
select to_char(sysdate,'yyyy-mm-dd') from dual;




/*
   随机生成一些序号
   序列 sequence 对象：用于表示列
   create sequence 序列名
   [increment by n]
   [start with n]
   [{maxvalue/minvalue n| nomaxvalue}]
   [{cycle|nocycle}]
   [{cache n|nocache}];
*/
drop sequence seq_test1;

create sequence seq_test1
start with 100 --初始值
minvalue 90  --最小
maxvalue 105 --最大
cycle        --到达最大再循环
cache 2;--提前生成两个

select seq_test1.nextval from dual;

drop sequence seq_1;
create sequence seq_1;

drop table product;
create table product(
       pid int primary key,
       pname varchar2(20)
);
insert into product values(seq_1.nextval,'apple');
insert into product values(seq_1.nextval,'apple2');
insert into product values(seq_1.nextval,'applexxx');

select * from product;

delete from product where pid=3;

--利用dual表来查看序列对象的属性  nextval生成下一个值，currval 当前值
select seq_1.currval from dual;
select seq_1.nextval from dual;

delete from product where pid=7;

insert into product values(seq_1.nextval,'appleyyy');

select * from product;





/*
  insert into 表名 [(列名,..)]  values(值,...)
       insert 语句得特殊用法：
         非全部列插入
         数据类型，数据顺序要注意
         非空列必须插入数据及默认值用法
         日期时间的插入
         标识列的插入(sequence的用法)
*/

drop table student141;

create table student141(
  sid int primary key,
  sname varchar(20) not null unique,
  sex char(4) default '男'  check( sex in('男','女')),
  age int check(age>18 and age<25),
  birthday date,
  rolldate varchar2(30)
);


create sequence seq_student141
 increment by 1
 start with 1000;

select * from student141; 
insert into student141(sid,sname,age) values(seq_student141.nextval,'张三',20);
insert into student141(sid,sname,age,sex) values(seq_student141.nextval,'李四',20,default);
insert into student141(sid,sname,age,sex,birthday) values(seq_student141.nextval,'王五',20,default,sysdate);
insert into student141(sid,sname,age,sex,birthday,rolldate) values(seq_student141.nextval,'赵六',20,default,
                                                                        to_date('1980/1/1','YYYY/MM/DD'),to_char(sysdate,'YYYY/MM/DD'));
                                                                        
--数据顺序不一致导致类型一直，所以下面语句出错
/*
insert into student141
  values(seq_student.nextval,'张三丰',20,default,to_date('1/1/1980','YYYY/MM/DD'),to_char(sysdate,'YYYY/MM/DD');
*/




/*
   特殊场景用以下语句
*/
--1.从已知的表创建新表（原来表中的数据是否还要）
create table newemp141
as
select * from emp;

select * from newemp141;



--只取几个列，且可以对某些列赋新值
create sequence seq_emp141;

create table newemp141_2
as
select seq_emp141.nextval,ename,job from emp;

select * from newemp141_2;
drop sequence seq_emp141;


--创建时列名用心的名字，别名
create table newemp141_3
as
select seq_emp141.nextval as id,ename as 名字,job as 岗位 from emp;

select * from newemp141_3;


--只复制结构，不复制数据
create table newemp141_4
as
select * from emp where 1<>1;
select * from newemp141_4;




/*
   上面情况适用于  新表不存在的清空
   另一种情况：将一张表的数据插入到一张已存在的表中
*/


--将emp表中的数据导入两次到一张已经存在的表
--1.先导一次
create sequence seq_141;

create table newemp141_5
as
select seq_141.nextval as id,ename as 姓名,job as 工作 from emp;

drop table newemp141_5;
--
select * from newemp141_5;

--newemp141_4已经存在
insert into newemp141_4
select * from emp;

--检查结果
select * from newemp141_4;

--结构不一样
insert into newemp141_5
select empno,ename,job from emp;

select * from newemp141_5;






/*
  使用场景：目标表存在(用insert
            数据来源于业务系统(java从文件a.txt读取数据),要求将这些数据存到目标表中
*/
--将一些新数据存到newemp141_5
insert into newemp141_5(id,姓名,工作)
select seq_141.nextval,'张三','clerk' from dual union
select seq_141.nextval,'李四','saleman' from dual union
select seq_141.nextval,'王五','saleman' from dual;

--以上语句不能执行，因为union插入不能生成序列号，因为union下插入当成一次操作
insert into newemp141_5(id,姓名,工作)
select 200,'张三','clerk' from dual union
select 201,'李四','saleman' from dual union
select 202,'王五','saleman' from dual;

select * from newemp141_5;







/*
    事务
*/
create table pay(
       id int primary key,
       balance int
);

--dml语句，plsql是手动事务提交
insert into pay values(1,10);

commit;

update pay set balance=5 where id=1;
rollback;

select * from pay;--10元

savepoint p0;
update pay set balance=balance+1 where id=1;
savepoint p1;
update pay set balance=balance+1 where id=1;
savepoint p2;
update pay set balance=balance+1 where id=1;
savepoint p3;

rollback to p0;











