
drop sequence seq_s_sno;
drop sequence seq_c_cno;
drop table S;
drop table SC;
drop table C;
--S (SNO,SNAME）          学生关系。SNO 为学号，SNAME 为姓名
create sequence seq_s_sno start with 1;

create table S(
  SNO int primary key,
  SNAME varchar(30) not null
)SEGMENT CREATION IMMEDIATE;
--C (CNO,CNAME,CTEACHER)  课程关系。CNO 为课程号，CNAME 为课程名，CTEACHER 为任课教师
create sequence seq_c_cno start with 1;

create table C(
  CNO int  primary key,
  CNAME varchar(30) not null ,
  CTEACHER  varchar(30) not null
)SEGMENT CREATION IMMEDIATE;
--SC(SNO,CNO,SCGRADE)     选课关系。SCGRADE 为成绩

create table SC(
  SNO int ,
  CNO int ,
  SCGRADE int not null
)SEGMENT CREATION IMMEDIATE;

alter table sc
    add constraint FK_SC_S# 
          foreign key(sno) references S(SNO);
alter table sc
    add constraint FK_C_C# 
            foreign key(cno) references C(CNO);


select * from S;
select * from sc;
SELECT * FROM C;


insert into S values(seq_s_sno.nextval,'罗路');
insert into S values(seq_s_sno.nextval,'薛迪');
insert into S values(seq_s_sno.nextval,'李水平');
insert into S values(seq_s_sno.nextval,'欧阳进夫');
insert into S values(seq_s_sno.nextval,'屌丝');
insert into S values(seq_s_sno.nextval,'宅男');

insert into C values(seq_c_cno.nextval,'C语言','李明');
insert into C values(seq_c_cno.nextval,'java','张影');
insert into C values(seq_c_cno.nextval,'数据库','曾丽君');
insert into C values(seq_c_cno.nextval,'c++','龅牙妹');


insert into SC values(1,1,75);
insert into SC values(2,2,35);
insert into SC values(1,3,91);
insert into SC values(1,4,18);
insert into SC values(1,2,35);
insert into SC values(6,3,96);
insert into SC values(5,1,87);
insert into SC values(4,1,67);
insert into SC values(6,2,57);
insert into SC values(3,1,34);
insert into SC values(4,2,78);
insert into SC values(5,2,98);

--1. 找出没有选修过“李明”老师讲授课程的所有学生姓名

--2. 列出有二门以上（含两门）不及格课程的学生姓名及其平均成绩


--3. 列出既学过“1”号课程，又学过“2”号课程的所有学生姓名

 
--4. 列出“1”号课成绩比“10002”号同学该门课成绩高的所有学生的学号

--5. 列出“1”号课成绩比“2”号课成绩高的所有学生的学号及其“1”号课和“2”号课的成绩
