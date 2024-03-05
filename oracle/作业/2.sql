--sql
--DDL���ݶ������ԣ�create��������drop ��������alter��������truncate

-- ����һ��truncate,drop,delete

--1.truncate �ضϣ�ɾ�����ݶ���ɾ���ṹ
drop table product;

create table product(
       pid int primary key,
       pname varchar2(20)
);

insert into product values(1,'apple');
insert into product values(2,'pear');

select * from product;

--drop��truncate����
--1.������ݱ���գ��洢�ռ䱻�ͷ�
--2.drop,truncate���к���Զ��ύ���񣬰���֮ǰΪ�ύ�ĻỰ�����һ������޷�����
--3.ֻ�б��Ĵ����߻�������ӵ��ɾ��������Ȩ�޵��û� ������ձ��

drop table product;
select * from product;--�����ͼ��������


--truncate���ṹ���ڣ��������
truncate table product;
select * from product; --��ṹ�ڣ�����û��







--dual����oracle�Դ��ĿյĲ��Ա����ڲ��Ժ���
select * from dual;
--create table table_name as select���;
--rownum�б��
select sysdate from dual; --sysdate��ϵͳ��ǰʱ��  as���ñ���
-- to_char(����ʱ��,'yyyy-MM-dd hh24:mi:ss')������ʱ��תΪ���ָ�ʽ���ַ�����dateformaterһ��
select dbms_random.value(0,100) from dual; --����0-100�������
select trunc(3.4) from dual;  --�ضϣ�ȥ��С��λ
select trunc(dbms_random.value(0,100)) as a from dual;
select dbms_random.string('x',20) as random_string from dual; --����ַ�,20λ


--�������������
drop table testtable;

create table testtable as 
select rownum as id,
              to_char(sysdate + rownum/24/3600,'yyyy-MM-dd hh24:mi:ss') as inc_datetime,
              trunc(dbms_random.value(0,100)) as random_id,
              dbms_random.string('x',20) as random_string
           from dual
           connect by level <=100000;--����ʮ����
           
select * from testtable;

--��truncateɾ��
truncate table testtable;

--��drop
drop table testtable;

--��delete
delete from testtable;

--Ϊʲô truncate �� delete ��ɾ���Ͽ�
--deleteɾ��Ҫ��ÿ����¼��һ����־
--truncate��������־��ֱ���ύ�޸ģ������޷��ع�����








--�����: DML���������ݲ�������  insert��delete��update��select

--insert into ���� values();

drop table product;
create table product(
       pid int primary key,
       pname varchar2(20)
);
insert into product values(1,'apple');
insert into product values(2,'pear');

--select �﷨��select����from����
select * from product;
select pid,pname from product;
select pid as ���,pname as ���� from product;
select pid as ���,pname as ���� from product where pid=1;


--update�﷨��update ���� set ����=��ֵ,����2=��ֵ2 where ����
update product set pname='�߹�' where pid=1;

--delete�﷨: delete from ���� [where ����]
delete from product where pid=2;






--sql�е������  =����     <>������
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
select * from product where 1=1;   --�����÷�  ȫ������
select * from product where 1<>1;  --�����÷�  �յ�

/*
       for(i  in  product){
              if(i == pid){
              --��ȡ��ǰѭ�����������
              }
              if(i != pid){
              }
              if(1 == 1){
              }
              if(1 != 1){
              }
       }
*/

--1.����һ�ű�test141���ṹ��empһ��
select * from emp;

create table test141 as select * from emp where 1=1;

select * from test141;


--2.����һ�ű�test141_2��ֻҪ�ṹ��Ҫ����
select * from emp;

create table test141_2 as select * from emp where 1<>1;

select * from test141_2;





--��չ��Ϊʲô ��ѯ������Ҫ��1=1
--java��ƾ�踴�ӵĲ�ѯ���
select * from product;
select * from product where pid=1;
select * from product where pname='pear';
select * from product where pid=1 and pname='pear';

--ֻҪдһ��ԭʼ���Ȼ�����ҵ����ƴ����������
select * from product where 1=1
         and pid=1
         and pname = 'pear';
--���û��1=1
select * from product where 
          pid=1
         and pname = 'pear';

/*
       �ַ���  �൱��������ʽ ͨ��� _  % Ҫ��likeһ����
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
insert into product values(5,'������');
insert into product values(6,'����');
insert into product values(7,'����');

select * from product;

select * from product where 1=1 and pname like '��%';
select * from product where 1=1 and pname like '��_';
select * from product where 1=1 and pname = '��_';
select * from product where 1=1 and pname = '��%';
select * from product where 1=1 and pname like '%��';







/*
       �������ʽ����
       A and B
       A or B
       not A ȡ��
*/
--֧����Ϣ��
drop table payinfo;
-- userid�û����   paytype֧������   creaditcard���ÿ�
create table payinfo(
       pid int primary key,
       userid int,
       paytype varchar2(10),
       creaditcard varchar2(20)
);

insert into payinfo values(1,1,'���ÿ�','����');
insert into payinfo values(2,2,'���ÿ�','���ǿ�');
insert into payinfo values(3,2,'�ֽ�','');
insert into payinfo values(4,2,'΢��','');

select * from payinfo;

select * from payinfo where paytype='���ÿ�';
select * from payinfo where not(paytype='���ÿ�');

select * from payinfo where not(paytype='���ÿ�') or creaditcard<>'����';






/*
       ������ʱ��
       dual�����Ա��ձ�  �൱��linux�е� NULL
*/

select * from dual;
--dual��һ���ձ����ڲ��Ժ�ѧϰ
select sysdate from dual;       --ϵͳʱ��(oracleʱ��
select systimestamp from dual;  --��ǰϵͳʱ���
select current_timestamp from dual;            --��ʱ�������йأ����ص�����ϵͳ�ģ����ص����ں�ʱ���Ǹ���ʱ��ת������
select current_date from dual;                 --�Ƕ�current_timestamp׼ȷ�������������
select sysdate,systimestamp,current_timestamp,current_date from dual;


/*
       ����ʱ�����ַ�����ת��
       java: new SimpleDateFormat("yyyy��MM��dd HH:mm:ss");
         .format(new Date());
*/

--���ַ���2018-08-23 00:00:00תʱ������ date���� ***
select to_date('2018-08-23 00:00:00','yyyy-mm-dd hh24:mi:ss') from dual;

--��ʱ������ת�ַ���
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') from dual;
select to_char(sysdate,'yyyy-mm-dd') from dual;




/*
   �������һЩ���
   ���� sequence �������ڱ�ʾ��
   create sequence ������
   [increment by n]
   [start with n]
   [{maxvalue/minvalue n| nomaxvalue}]
   [{cycle|nocycle}]
   [{cache n|nocache}];
*/
drop sequence seq_test1;

create sequence seq_test1
start with 100 --��ʼֵ
minvalue 90  --��С
maxvalue 105 --���
cycle        --���������ѭ��
cache 2;--��ǰ��������

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

--����dual�����鿴���ж��������  nextval������һ��ֵ��currval ��ǰֵ
select seq_1.currval from dual;
select seq_1.nextval from dual;

delete from product where pid=7;

insert into product values(seq_1.nextval,'appleyyy');

select * from product;





/*
  insert into ���� [(����,..)]  values(ֵ,...)
       insert ���������÷���
         ��ȫ���в���
         �������ͣ�����˳��Ҫע��
         �ǿ��б���������ݼ�Ĭ��ֵ�÷�
         ����ʱ��Ĳ���
         ��ʶ�еĲ���(sequence���÷�)
*/

drop table student141;

create table student141(
  sid int primary key,
  sname varchar(20) not null unique,
  sex char(4) default '��'  check( sex in('��','Ů')),
  age int check(age>18 and age<25),
  birthday date,
  rolldate varchar2(30)
);


create sequence seq_student141
 increment by 1
 start with 1000;

select * from student141; 
insert into student141(sid,sname,age) values(seq_student141.nextval,'����',20);
insert into student141(sid,sname,age,sex) values(seq_student141.nextval,'����',20,default);
insert into student141(sid,sname,age,sex,birthday) values(seq_student141.nextval,'����',20,default,sysdate);
insert into student141(sid,sname,age,sex,birthday,rolldate) values(seq_student141.nextval,'����',20,default,
                                                                        to_date('1980/1/1','YYYY/MM/DD'),to_char(sysdate,'YYYY/MM/DD'));
                                                                        
--����˳��һ�µ�������һֱ����������������
/*
insert into student141
  values(seq_student.nextval,'������',20,default,to_date('1/1/1980','YYYY/MM/DD'),to_char(sysdate,'YYYY/MM/DD');
*/




/*
   ���ⳡ�����������
*/
--1.����֪�ı����±�ԭ�����е������Ƿ�Ҫ��
create table newemp141
as
select * from emp;

select * from newemp141;



--ֻȡ�����У��ҿ��Զ�ĳЩ�и���ֵ
create sequence seq_emp141;

create table newemp141_2
as
select seq_emp141.nextval,ename,job from emp;

select * from newemp141_2;
drop sequence seq_emp141;


--����ʱ�������ĵ����֣�����
create table newemp141_3
as
select seq_emp141.nextval as id,ename as ����,job as ��λ from emp;

select * from newemp141_3;


--ֻ���ƽṹ������������
create table newemp141_4
as
select * from emp where 1<>1;
select * from newemp141_4;




/*
   �������������  �±����ڵ����
   ��һ���������һ�ű�����ݲ��뵽һ���Ѵ��ڵı���
*/


--��emp���е����ݵ������ε�һ���Ѿ����ڵı�
--1.�ȵ�һ��
create sequence seq_141;

create table newemp141_5
as
select seq_141.nextval as id,ename as ����,job as ���� from emp;

drop table newemp141_5;
--
select * from newemp141_5;

--newemp141_4�Ѿ�����
insert into newemp141_4
select * from emp;

--�����
select * from newemp141_4;

--�ṹ��һ��
insert into newemp141_5
select empno,ename,job from emp;

select * from newemp141_5;






/*
  ʹ�ó�����Ŀ������(��insert
            ������Դ��ҵ��ϵͳ(java���ļ�a.txt��ȡ����),Ҫ����Щ���ݴ浽Ŀ�����
*/
--��һЩ�����ݴ浽newemp141_5
insert into newemp141_5(id,����,����)
select seq_141.nextval,'����','clerk' from dual union
select seq_141.nextval,'����','saleman' from dual union
select seq_141.nextval,'����','saleman' from dual;

--������䲻��ִ�У���Ϊunion���벻���������кţ���Ϊunion�²��뵱��һ�β���
insert into newemp141_5(id,����,����)
select 200,'����','clerk' from dual union
select 201,'����','saleman' from dual union
select 202,'����','saleman' from dual;

select * from newemp141_5;







/*
    ����
*/
create table pay(
       id int primary key,
       balance int
);

--dml��䣬plsql���ֶ������ύ
insert into pay values(1,10);

commit;

update pay set balance=5 where id=1;
rollback;

select * from pay;--10Ԫ

savepoint p0;
update pay set balance=balance+1 where id=1;
savepoint p1;
update pay set balance=balance+1 where id=1;
savepoint p2;
update pay set balance=balance+1 where id=1;
savepoint p3;

rollback to p0;











