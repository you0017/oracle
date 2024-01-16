--1.�����༶��Ϣ��classes(old int ����,cname varchar2(100) �ǿ� Ψһ,intro varchar2(1000));
drop table classes;
create table classes(
       cid int constraint PK_cid primary key,
       cname varchar2(100) not null unique,
       intro varchar2(1000)
);
select * from classes;

--2.ѧ����Ϣ��,stuInfo(sid int ����,sname varchar2(100) �ǿ�,sex char(2) �л�Ů Ĭ��Ϊ��,
--age int 15��30֮��,address varchar2(200) Ĭ�ϵ�ַ����,old int ���);
drop table stuInfo;
create table stuInfo(
       sid int primary key,
       sname varchar2(100) not null,
       sex char(2) default '��' constraint CK_sex check(sex in('��','Ů')),
       age int constraint CK_age check (age>15 and age<30),
       address varchar2(200) default '����',
       cid int constraint FK_classid references classes(cid)
);
--FK_classid
select * from stuInfo;

--on delete cascade; ����ɾ����ɾ����������ʱ�����ӱ��е�����Ҳɾ��
--on delete set null;ɾ�������е�����ʱ�����ӱ��е�������Ϊ��

--�����û���Ϣ�� ��Լ��  cardId�����֤Ҫ��16λ
drop table users;
create table users(
       usid int primary key,
       uname varchar2(100) not null,
       age int default 10 constraint CK_uage check(age>20 and age<30),
       pwd varchar2(20),
       tel varchar2(20),
       addr varchar2(200),
       cardId varchar2(20) constraint CK_users_cradId check(length(cardId) = 18),
       constraint CK_info check(tel is not null and tel!='' or addr is not null and addr!='')--��Լ��
);
select * from users;

--��������Լ��
--alter table [table_name] add constraint [����Լ����] primary key(����);
create table sales(
       sid int,
       sname varchar2(100)
);
--�޸�ԭ����������Լ��
alter table sales add constraint PK_sid primary key(sid);
alter table sales drop constraint PK_sid;

--�������Լ��
--alter table [table_name] add constraint [���Լ����] foreign key(����) references ����(����)
--ɾ��ԭ�������Լ��
alter table stuInfo drop constraint FK_classid;
--�����´������Լ��
alter table stuInfo add constraint PK_classid foreign key(cid) references classes(cid);


--�������Լ��
alter table stuInfo drop constraint CK_age;
--�����´�������ļ��Լ��
alter table stuInfo add constraint s_age check (age>10 and age<30);

--ɾ���Ա�Լ��
alter table stuInfo drop constraint ck_sex;
--�����´����Ա��Լ��
alter table stuInfo add constraint CK_sex check (sex in('��','Ů'));

--��ӷǿ�Լ��
alter table stuInfo drop constraint sys_c0012972;
--�����´����ǿ�Լ��
alter table stuInfo modify sname not null; --modify �޸�

--���ΨһԼ��
alter table stuInfo constraint CK_stuinfo_cardId add unique(cardId);

--Ĭ��Լ��
--��stuInfo���һ������birth
alter table stuInfo
      add (birth date);
alter table stuInfo modify birth date default sysdate; --sysdate��oracle���ú��������ڻ�ȡϵͳ����

--�鿴Լ��
select * from user_constraints where table_name='STUINFO'; --[where table_name='��д����'];

--���û�����Լ��
alter table stuInfo disable|enable constraint FK_classid;

--ɾ��Լ��
alter table stuInfo drop constraint FK_classid;


--��������
alter table table_name rename to new_table_name;

--��������customers��Ϊcusts
alter table customers rename to custs;

--��������
alter table table_name rename column old_column_name to new_column_name;

--����������:stuInfoΪ���� ��IdΪ���ģ�stuidΪ������
alter table stuInfo rename column Id to stuid;


--�������
alter table table_name add column_name data_type [dafault value][null/not null]...;
alter table sale add sname number(10,2) default 0.0;

--�����е���������
alter table table_name modify column_name data_type [default value][null/not null],..;
alter table sale modify sname decimal(10,8);

--ɾ����
alter table table_name drop column column_name;
alter table sales drop column sname;

--ɾ����
drop table table_name;

--�����ñ��鿴��ṹ
select * from user_tab_columns where table_name='��д����';








--1. ����һ�����ṹΪ��sample1(id int,name varchaar2(50));
create table sample1(
       id int,
       name varchar2(50)
);
drop table sample1;

--2.�ṹsample2(id int ,name varchar2(50)), idΪ�Զ�����
create sequence seq_sample2;
create table sample2(
       id int,
       name varchar2(50)
);


--3.����һ���±�sample3(id int,name varchar2(50)),idΪ�����������У���������Ϊ2
create sequence seq_sample3 increment by 2;
create table sample3(
       id int primary key,
       name varchar2(50)
);


--4.sample4(id int ,name varchar2(50)) idΪ�������Զ������У�name����Ϊnull
create sequence seq_sample4;
create table sample4(
       id int primary key,
       name varchar2(50) not null
);


--5.sample5(id int ,name varchar2(50),sex char(2)) ����idΪ�������Զ�������,name��Ϊnull
--sex��Ĭ��ֵΪ��
create sequence seq_sample5;
create table sample4(
       id int primary key,
       name varchar2(50) not null,
       sex char(2) default '��'
);


--6.sample5(id int ,name varchar2(50),sex char(2),age int) ����idΪ�������Զ�������,name��Ϊnull
--sex��Ĭ��ֵΪ��,age��1-100��
create sequence seq_sample6;
create table sample6(
       id int primary key,
       name varchar2(50) not null,
       sex char(2) default '��',
       age int check(age>=1 and age<=100)
);


--7.������
-- dept(deptid int,deptname varchar2(50)),deptidΪ��������
-- empidΪ����������deptidΪ�����ָ��dept���deptid�ӶΣ�
--empname��Ϊ��

create table dept(
       deptid int primary key,
       deptname varchar2(50) not null
);

create table emp(
       empid int primary key,
       deptid int constraint fk_dept_deptid foreign key references dept(deptid),
       empname varchar2(20) not null
);

-- 8.deptnameΪunique
create table dept(
       deptid int primary key,
       deptname varchar2(50) not null unique
);
