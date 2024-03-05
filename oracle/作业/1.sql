--1.创建班级信息表：classes(old int 主键,cname varchar2(100) 非空 唯一,intro varchar2(1000));
drop table classes;
create table classes(
       cid int constraint PK_cid primary key,
       cname varchar2(100) not null unique,
       intro varchar2(1000)
);
select * from classes;

--2.学生信息表,stuInfo(sid int 主键,sname varchar2(100) 非空,sex char(2) 男或女 默认为男,
--age int 15到30之间,address varchar2(200) 默认地址不详,old int 外键);
drop table stuInfo;
create table stuInfo(
       sid int primary key,
       sname varchar2(100) not null,
       sex char(2) default '男' constraint CK_sex check(sex in('男','女')),
       age int constraint CK_age check (age>15 and age<30),
       address varchar2(200) default '不详',
       cid int constraint FK_classid references classes(cid)
);
--FK_classid
select * from stuInfo;

--on delete cascade; 级联删除，删除主表数据时，将从表中的数据也删除
--on delete set null;删除主表中的数据时，将从表中的数据置为空

--创建用户信息表 表级约束  cardId是身份证要求16位
drop table users;
create table users(
       usid int primary key,
       uname varchar2(100) not null,
       age int default 10 constraint CK_uage check(age>20 and age<30),
       pwd varchar2(20),
       tel varchar2(20),
       addr varchar2(200),
       cardId varchar2(20) constraint CK_users_cradId check(length(cardId) = 18),
       constraint CK_info check(tel is not null and tel!='' or addr is not null and addr!='')--表级约束
);
select * from users;

--创建主键约束
--alter table [table_name] add constraint [主键约束名] primary key(列名);
create table sales(
       sid int,
       sname varchar2(100)
);
--修改原表，增加主键约束
alter table sales add constraint PK_sid primary key(sid);
alter table sales drop constraint PK_sid;

--创建外键约束
--alter table [table_name] add constraint [外键约束名] foreign key(列名) references 表名(列名)
--删除原来的外键约束
alter table stuInfo drop constraint FK_classid;
--再重新创建外键约束
alter table stuInfo add constraint PK_classid foreign key(cid) references classes(cid);


--创建检查约束
alter table stuInfo drop constraint CK_age;
--再重新创建年龄的检查约束
alter table stuInfo add constraint s_age check (age>10 and age<30);

--删除性别约束
alter table stuInfo drop constraint ck_sex;
--再重新创建性别的约束
alter table stuInfo add constraint CK_sex check (sex in('男','女'));

--添加非空约束
alter table stuInfo drop constraint sys_c0012972;
--再重新创建非空约束
alter table stuInfo modify sname not null; --modify 修改

--添加唯一约束
alter table stuInfo constraint CK_stuinfo_cardId add unique(cardId);

--默认约束
--给stuInfo添加一个新列birth
alter table stuInfo
      add (birth date);
alter table stuInfo modify birth date default sysdate; --sysdate是oracle内置函数，用于获取系统日期

--查看约束
select * from user_constraints where table_name='STUINFO'; --[where table_name='大写表名'];

--禁用或启动约束
alter table stuInfo disable|enable constraint FK_classid;

--删除约束
alter table stuInfo drop constraint FK_classid;


--重命名表
alter table table_name rename to new_table_name;

--重命名表：customers改为custs
alter table customers rename to custs;

--重命名列
alter table table_name rename column old_column_name to new_column_name;

--重命名列名:stuInfo为表名 ，Id为被改，stuid为新列名
alter table stuInfo rename column Id to stuid;


--添加新列
alter table table_name add column_name data_type [dafault value][null/not null]...;
alter table sale add sname number(10,2) default 0.0;

--更改列的数据类型
alter table table_name modify column_name data_type [default value][null/not null],..;
alter table sale modify sname decimal(10,8);

--删除列
alter table table_name drop column column_name;
alter table sales drop column sname;

--删除表
drop table table_name;

--创建好表：查看表结构
select * from user_tab_columns where table_name='大写表名';








--1. 创建一个表，结构为：sample1(id int,name varchaar2(50));
create table sample1(
       id int,
       name varchar2(50)
);
drop table sample1;

--2.结构sample2(id int ,name varchar2(50)), id为自动增长
create sequence seq_sample2;
create table sample2(
       id int,
       name varchar2(50)
);


--3.创建一个新表：sample3(id int,name varchar2(50)),id为主键和自增列，增长步长为2
create sequence seq_sample3 increment by 2;
create table sample3(
       id int primary key,
       name varchar2(50)
);


--4.sample4(id int ,name varchar2(50)) id为主键和自动增长列，name不能为null
create sequence seq_sample4;
create table sample4(
       id int primary key,
       name varchar2(50) not null
);


--5.sample5(id int ,name varchar2(50),sex char(2)) 其中id为主键和自动增长列,name不为null
--sex的默认值为男
create sequence seq_sample5;
create table sample4(
       id int primary key,
       name varchar2(50) not null,
       sex char(2) default '男'
);


--6.sample5(id int ,name varchar2(50),sex char(2),age int) 其中id为主键和自动增长列,name不为null
--sex的默认值为男,age在1-100间
create sequence seq_sample6;
create table sample6(
       id int primary key,
       name varchar2(50) not null,
       sex char(2) default '男',
       age int check(age>=1 and age<=100)
);


--7.两个表
-- dept(deptid int,deptname varchar2(50)),deptid为自增主键
-- empid为自增主键，deptid为外键，指向dept表的deptid子段，
--empname不为空

create table dept(
       deptid int primary key,
       deptname varchar2(50) not null
);

create table emp(
       empid int primary key,
       deptid int constraint fk_dept_deptid foreign key references dept(deptid),
       empname varchar2(20) not null
);

-- 8.deptname为unique
create table dept(
       deptid int primary key,
       deptname varchar2(50) not null unique
);
