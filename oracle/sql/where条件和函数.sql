

--��ѯ���﷨
select * from ����
select ����[������] from ����

-- �Ȳ鿴orcal�е�ʾ����
select * from account;--���˺�id����

select * from dept;--������Ϣ�����ű�ţ��������ƣ���ַ  
                                            --    ��Ʋ���ŦԼ��
                                            --    �з���������˹��
                                             --   ���۲���֥�Ӹ磻
                                             --   ��Ӫ������ʿ�٣�

select * from emp;--��Ա�� ����ţ��������������͡�
                               --mgr  �ϼ���ţ�hiredate ��Ӷ���� ��sal����  ��comm����
                               --deptno���źţ��������Դ��dept��deptnoһ��
                               
select deptno,dname,loc from dept;
select deptno ���ź�,dname ������,loc ��ַ from dept;

select empno ���ţ�ename ��Ա�� from emp;


--where
select * from emp where sal>2000 and job='MANAGER';
select * from emp where sal>10000;   --���������ִ�Сд����ֵ����

--1�����������
--��ѯÿλԱ���Ĺ���=�Ʊ�����+����  (��������� +��-��* /  )
select empno,ename,nvl(sal,0),nvl(comm,0),nvl(sal,0)+nvl(comm,0) ������ from emp;  --NULL��δ���NULL�滻��0

--nvl(a,b) aΪnull����bֵ����Ϊ�վ�a
--nvl2(a,b,c) a��Ϊnull��Ϊb��Ϊ����Ϊc


--�ѿ����������� ��as ����ʡ�ԣ�





--�Ƚ������   < , > , = , between and , in , like , is null
--�������Ĳ�ѯ
--��ѯ������3000Ԫ���ϵ�Ա����Ϣ�� �Ƚ������ <,>,=,between...and,in,like,is null��
select * from emp where sal>3000;

--��ѯ �ܹ�����3000Ԫ���ϵ�Ա����Ϣ�� �Ƚ��������
select empno,ename,nvl(sal,0),nvl(comm,0),nvl(sal,0)+nvl(comm,0) ������ from emp where nvl(sal,0)+nvl(comm,0)>3000;

--��ѯ ������2000-3000��Ա������Ҫ�ذ����м�������
select * from emp where sal between 2000 and 3000;


--��ѯ  ְλ���� ҵ��Ա������ ��Ա����Ϣ������һ�����䣨not in��
select * from emp where job not in('CLERK','SALESMAN');
select * from emp where job <>'CLERK' and job<>'SALESMAN';


--��ѯ��ЩԱ��û�н���
select * from emp where comm is null or comm = 0;
select * from emp where nvl(comm,0)=0;



--��ѯһ��Ա��������������M��ͷ�ģ�
select * from emp where ename like 'N%'; --ģ��ƥ��
select * from emp where ename = 'N%';    --���ֽ�N%
select * from emp where ename like '%E'; --��E��β
select * from emp where ename like '_L%';--�ڶ�����ĸ��L
select * from emp where ename like '%N%';--ֻҪ��N
select * from emp where ename like '_%N%_';--�м���N


--3���߼������(and / or / not) ������<>
--��ѯ������ M��ͷ�ģ������� ��Ʋ� ���ŵġ��鵽���ű����10
select * from emp where DEPTNO=10 and ename like 'M%';

select * from emp where Deptno = (select deptno from dept where dname='ACCOUNTING') and ename like 'M%';



--not �Ǽ���  һ�����ʽ֮ǰ�ġ�
select * from emp where ename not like 'M%';    --����N��ͷ
select * from emp where ename is not like 'M%'; --isֻ�ܺ�nullһ����

--4�����Ӳ�����
-- java�ַ������Ӳ�ż����"hello"+"world"
-- oracle�� ||

select empno||'��Ӧ����Ϊ'||ename||',���Ĺ���������'||job as �������� from emp;
select concat(concat(concat(concat(empno,'��Ӧ����Ϊ'),ename),',���Ĺ���������'),job) as �������� from emp;



--���ȼ���������������˳����ڼӼ���>���Ӳ�����>�Ƚ������>�߼��������not>and>or��
--1��ͬһ���ȼ��������������ִ�У�
--2�������ڵ�������ִ�С�



--5.��������� �����ű��г�ȡ�������γ�һ���±�
--  union,union all ����
--intersect ����
-- minus  �
--��Ӧ�̱�
create table supplier(
       id int primary key,
       sname varchar2(20)
);

create sequence seq_supplier;--��������
insert into supplier values(seq_supplier.nextval,'����');
insert into supplier values(seq_supplier.nextval,'С��');

--�ͻ���
create table customer(
       cid int primary key,
       cname varchar2(20)
);
create sequence seq_customer;
insert into customer values(seq_customer.nextval,'����');
insert into customer values(seq_customer.nextval,'��Ϊ');

--����Ҫ�빩Ӧ�̺Ϳͻ��μ����ֻ�  --����
select * from supplier
union
select * from customer;

select * from supplier
union all
select * from customer;
--˵�����������Ե�ֵ����ͬ�����ظ�
update supplier set id=4 where id =2;



--sql�� ������Ϊ����������/���麯��/����������
--���к���

create table stuInfo(
       sid int primary key,
       sname varchar2(10) not null,
       age number(3)
       
)
create table mathScore(
       sid int primary key,
       
       
)
--1�����ں���
    --��ѯ��ǰ����
      select sysdate from dual;
       
     --������ְ�Ѿ�����35��ĳ�����Ա��
     --months_between(d1,d2)
     select * from emp;
     
     --�������һ��months_between(sysdate,hiredate)>=420
     select empno,ename,hiredate,months_between(sysdate,hiredate) as ����ʱ�� from emp;
     select empno,ename,hiredate,trunc(months_between(sysdate,hiredate)) ����ʱ��
                   from emp where months_between(sysdate,hiredate)>35*12;

     --�����������add_months
     select empno,ename,hiredate,add_months(sysdate,-35*12)
                   from emp where add_months(sysdate,-35*12)>hiredate;
     select empno,ename,hiredate,add_months(hiredate,35*12)
                   from emp where add_months(hiredate,35*12)<sysdate;

    --����ÿ��Ա������ʾ����빫˾����
    select empno,ename,sysdate-hiredate �������� from emp;
    select empno,ename,trunc(sysdate-hiredate) �������� from emp;
    

--2�����ֺ���
    --����ÿ��Ա������ʾ����빫˾����,ȥ�������� (floor()����ȡ��)
    --trunc()�Ӷ�  round()��������  ceil()����x����С����  floor()����ȡ��
    select empno,ename,trunc(sysdate-hiredate)��������
                      ,round(sysdate-hiredate)��������
                      ,ceil(sysdate-hiredate)��������
                      ,floor(sysdate-hiredate)��������
                      from emp;

--3���ַ�����
    --��jobת����Сд���ϵ�������
    select * from emp;
    select empno,ename,lower(job),upper(job),initcap(job),nls_initcap(job) from emp;
    
         
    --���뿴����Щ��λ��֮ǰ���ظ���(�ۻ�Ա��ְԱ�����³�����������ʦ) distinct��ȥ��
    select distinct(job) from emp;
         
     --��ʾ����Ϊ5���ַ���Ա��������   b:byte���ֽڼ���
     select ename,length(ename),lengthb(ename) from emp;
     
     update emp set ename='�š�' where empno=xxx;

         
     --��ʾ����Ա��������ǰ�����ַ�
     select ename,substr(ename,0,3) from emp;
     select ename,substrb(ename,0,3) from emp;
         
     --��ʾ����Ա����������������ַ�
     select ename,substr(ename,-3,3) from emp;

         
     --������ĸ��д�ķ�ʽ��ʾ����Ա��������
     select initcap(ename) from emp;
    
          
     --�ַ��滻
     select replace('he love you','he','i') test from dual;
  

          
          
      
--4��ת������ string-date date->string
         insert into emp values(9800,'Hehehe222','PRESUDENT','',sysdate,2000,8000,10);
         select * from emp;  --hiredate:sysdate����   2024/20000/3/2  19:23:56(ʱ���
         --ȡ�����hiredate.�ŵ�java���� string
         --date->char  :  to_char()
         select empno,ename,hiredate,to_char(hiredate,'yyyy-mm-dd HH24:mm') from emp;
         select sysdate from dual;
         
         --to_char()����ֵ�͵�ת��
         select empno,ename,sal,to_char(sal,'$9999.99') from emp;
  
         --�ҳ�ÿ���µ����������ܹ͵�Ա��
         select empno,ename,hiredate from emp where hiredate=last_day(hiredate)-2;

                 
--5����������(nvl nvl2 nvlif) : if
          select ename,nvl(comm,0) ����1,
                       nvl2(comm,comm,0) ����2
                       from emp;
                       
          --decode: switch...case...
          select * from emp;
          select * from dept;
          --��empԱ���������ʺͲ��������
          select ename,sal,decode(deptno,10,'ACCOUNTING',20,'RESEARCH',30,'SALES',40,'OPERATIONS','��������') from emp;
       
       
       
--6�����麯����avg,min,max,sum,count��   �ۺϺ�����������������ݺϲ���һ�����
   --ƽ�������Ƕ���(5451.5625)
   select count(*) ������,sum(comm) �ܽ����� ,avg(comm) ƽ������ ,sum(comm)/count(*) ���� from emp;
   --avg()ͳ��ʱcomm��null�Ļ�����������
   select count(*) ������,sum(comm) �ܽ����� 
                   ,trunc(avg(nvl(comm,0))) ƽ������ 
                   ,trunc(avg(nvl(comm,0))) ��ȷ��ƽ������
                   ,trunc(sum(comm)/count(*)) ���� 
                   from emp;
 
          
   --��������Ƕ���
   select min(nvl(sal,0)+nvl(comm,0)) ������� from emp;

          
    --��������Ƕ���
    select max(nvl(sal,0)+nvl(comm,0)) ������� from emp;
    
    --�ϲ����
     select min(nvl(sal,0)+nvl(comm,0)) �������,max(nvl(sal,0)+nvl(comm,0)) ������� from emp;

   --����Ӧ�÷����ٹ���
   select sum(sal+comm) ������֧�� from emp;
   select sum(nvl(sal,0)+nvl(comm,0)) ������֧�� from emp;

          
   --�������˷�����(16)
   select count(*) ������ from emp;
   select count(empno) ������ from emp;
   select count(nvl(sal,0)) ������ from emp;
          
    --��֤
     
          
          
--7����������
    --���밴���ʸߵ�����--order by ���� desc����/asc����,����2 desc����/asc����....
    select * from emp order by sal desc,ename asc;
   
          
   --���ʸߵ�����  α�� rownum
   select a.*,rownum from emp a;
   --˼·���������ټ�rownum���  rownum �Ƕ�ԭʼ������Ȼ����������
   --Ӧ������������rownum
   select a.*,rownum from emp a order by sal desc,ename asc;
   select a.*,rownum ���� from (select empno,ename,nvl(sal,0) ���� from emp order by nvl(sal,0) desc,ename asc) a;
          
   --��ȫ��Ա�����ʴӸߵ���������Ծ�� rank��
      --RANK() OVER([query_partition_clause] order_by_clause)
      select empno,ename,nvl(sal,0) ���� ,rank() over(order by nvl(sal,0) desc) ���� from emp a;
        
          
   --��ȫ��Ա�����ʴӸߵ����������������� 
      select empno,ename,nvl(sal,0) ���� ,dense_rank() over(order by nvl(sal,0) desc) ���� from emp a;
          
   --�Բ��������������ڲ�����
     select empno,ename,nvl(sal,0) ���� ,rank() over(partition by deptno order by nvl(sal,0) desc) ���� from emp a;
     
     select empno,ename,nvl(sal,0) ���� ,dense_rank() over(partition by deptno order by nvl(sal,0) desc) ���� from emp a;
     
     
   --����row_number()��������
   select empno,ename,nvl(sal,0) ���� ,row_number() over(partition by deptno order by nvl(sal,0) desc) ���� from emp a;
          
          
   --��ѯÿһ�����ŵ�ƽ�����ʡ������� group by��
   select deptno,trunc(avg(nvl(sal,0))) ���� from emp group by deptno;
        
   --��ѯÿһ�����ţ�ÿһ����λ�ĵ�ƽ������(���з��飬)

          
   --��ѯ���ˡ�����ѯƽ��������1500�����²���ְλ��Ϣ
  --select deptno,job,avg(sal) from emp e  �����Ҫ�÷��麯��
          
        
