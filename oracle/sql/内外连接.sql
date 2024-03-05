drop table stuinfo;
drop table course;
drop table score;
drop sequence seq_score_id;

create table stuinfo
(
   stuid int primary key,
   sname varchar2(50) unique,
   sage int not null 
                  constraint CK_age check(sage>=18 and sage<=30),
   saddress varchar2(50) 
);

   
create table course(
      cid int primary key,
      cname varchar2(50)      
);
create sequence seq_score_id start with 1;
create table score(
      scoreid int primary key,
      studentid int ,
      courseid int ,
      score int
)SEGMENT CREATION IMMEDIATE;
   
insert into course(cid,cname) values(1,'j2se����');
insert into course(cid,cname) values(3,'sql server');
insert into course (cid,cname) values(9,'html��ҳ���');
   
insert into stuinfo(stuid,sname,sage,saddress) values(31,'�Ź���',22,null);
insert into stuinfo(stuid,sname,sage,saddress) values(29,'������',20,null);
insert into stuinfo(stuid,sname,sage,saddress) values(13,'�',22,null);
insert into stuinfo(stuid,sname,sage,saddress) values(15,'�Ϻ�',22,'����');
insert into stuinfo(stuid,sname,sage,saddress) values(17,'�Ͻ�',24,'����');
insert into stuinfo(stuid,sname,sage,saddress) values(19,'���޼�',26,'����');
insert into stuinfo(stuid,sname,sage,saddress) values(32,'��ʦ��',28,'��ɳ');
insert into stuinfo(stuid,sname,sage,saddress) values(1,'ΤС��',27,'�Ϻ�');


insert into score values(seq_score_id.nextval,31,1,95);
insert into score values(seq_score_id.nextval,29,1,67);
insert into score values(seq_score_id.nextval,13,1,56);
insert into score values(seq_score_id.nextval,15,1,81);
insert into score values(seq_score_id.nextval,17,1,82);
insert into score values(seq_score_id.nextval,19,1,78);
insert into score values(seq_score_id.nextval,13,3,81);
insert into score values(seq_score_id.nextval,15,3,92);
insert into score values(seq_score_id.nextval,17,3,81);
insert into score values(seq_score_id.nextval,19,3,66);
insert into score values(seq_score_id.nextval,29,3,36);
insert into score values(seq_score_id.nextval,31,3,73);
insert into score values(seq_score_id.nextval,31,9,57);
insert into score values(seq_score_id.nextval,29,9,76);
insert into score values(seq_score_id.nextval,13,9,78);
insert into score values(seq_score_id.nextval,15,9,89);
insert into score values(seq_score_id.nextval,19,9,93);
insert into score values(seq_score_id.nextval,13,1,80);
insert into score values(seq_score_id.nextval,29,3,88);
insert into score values(seq_score_id.nextval,31,9,69);

select * from stuinfo;
select * from course;
select * from score;

--�������'��'��ѧԱ��Ϣ
select * from stuinfo where sname like '��%';

--�������saddress�ֶ�Ϊ'NULL'ֵ��ѧԱ����Ϣ
select * from stuinfo where saddress is null;

--����ɼ���60��70��֮���ѧԱ��id��
select stuinfo.stuid from stuinfo,score where (score between 60 and 70) and stuid=studentid; --���ظ����
select distinct(stuinfo.stuid) from stuinfo,score where (score between 60 and 70) and stuid=studentid;

--�����ַ�Ǳ������Ϻ���ѧ������Ϣ
select * from stuinfo where saddress in ('����','�Ϻ�');

--���ѧԱ��'sql server'���ſγ��е��ܳɼ���ƽ���ɼ�,��߷�������ͷ���
--�ۺ�
--������������ѯ from ��1����2 where ��1.���=��2.����
select sum(nvl(score,0)) �ܳɼ�,avg(nvl(score,0)) ƽ���ɼ�,min(nvl(score,0)) ��ͷ��� from score,course where courseid=cid and cname='sql server';
--����һ���Ӳ�ѯ
select sum(nvl(score,0)) �ܳɼ�,avg(nvl(score,0)) ƽ���ɼ�,min(nvl(score,0)) ��ͷ��� from score 
       where courseid=(select cid from course where cname='sql server');
--�������������Ӳ�ѯ  from ��1 inner join ��2 on ��1.���=��2.����
select sum(nvl(score,0)) �ܳɼ�,avg(nvl(score,0)) ƽ���ɼ�,min(nvl(score,0)) ��ͷ��� from score 
       inner join course on score.courseid=course.cid
       where cname='j2se����';
       
       
--����ÿ��ѧ��ÿ�ſεĳɼ���ѧ����ţ�ѧ�������γ̺ţ��γ̳ɼ�
--����һ������ѯ  from ��1����2����3 where ��1.���=��2.���� and ��2.���=��3.����
select scoreid ,studentid,sname,courseid,cname,score
       from score,course,stuinfo
       where score.studentid=stuinfo.stuid and score.courseid=course.cid;
       
--�������������Ӳ�ѯ from ��1 inner join ��2 on ��1.���=��2.����
select scoreid ,studentid,sname,courseid,cname,score
       from score inner join course on score.courseid=course.cid
                  inner join stuinfo on stuinfo.stuid=score.studentid;


--���ѧԱ��'j2se����'���ſγ��в������ѧ������
select count(studentid) from score,course where courseid=cid and score<60 and cname='j2se����';



select * from stuinfo; --8��
select * from course; --3��
select * from score; --20���ɼ�
--(31,1)û�гɼ�,����ѧ��������(13,1),(29,3),(31,9)
--����˼��: ����ֻ�����ĳһ�ض��Ŀ�Ŀ��ƽ���ɼ��������һ�������ÿһ�ſγ̵�ƽ���ɼ��أ�
--�������: �Կγ̽��з���,�γɶ����������ݼ����Է���֮��Ľ��������ƽ��ֵ
--�﷨: select ����  from ����   where ����   group by ������
select trunc(avg(nvl(score,0))) ƽ���ɼ�,courseid from score group by courseid;

--��ʾ�γ�
--����һ����ͨ����ѯ
select courseid,cname,trunc(avg(score)) ƽ���ɼ� from score,course 
where score.courseid=course.cid
group by courseid,cname;
--��������������ѯ
select courseid,cname,trunc(avg(score)) ƽ���ɼ� from score
inner join course on score.courseid=course.cid
group by courseid,cname;

--�������������Ӳ�ѯ
select courseid,cname,trunc(avg(score)) ƽ���ɼ� from score
left join course on score.courseid=course.cid
group by courseid,cname;



--������������ſγ̵�ƽ���ɼ�����ߣ���ͣ���ͣ��ο�����
select courseid,trunc(avg(score)) ƽ���ɼ�,max(score),min(score),sum(score)�ܷ�,count(score)�ο�����
from score
group by courseid;

--������ ��ͨ���
select courseid,cname ,trunc(avg(score)) ƽ���ɼ�,max(score),min(score),sum(score)�ܷ�,count(score)�ο�����
from score,course where score.courseid=course.cid
group by courseid,cname;
--������������
select courseid,cname ,trunc(avg(score)) ƽ���ɼ�,max(score),min(score),sum(score)�ܷ�,count(score)�ο�����
from score
inner join course on score.courseid=course.cid
group by courseid,cname;

--�ر�����: �����select �Ӿ��Ĳ�ѯ�Ľ��Ҫ�����Ƿ�����У�Ҫ�������ǾۺϺ������У�����������������.


--�������󣺲�ѯÿ��ѧԺÿ�ſγ̵�ƽ���ɼ�  �����������������γɼ�
select sname,studentid,courseid,cname ,trunc(avg(score)) ƽ���ɼ�,max(score),min(score),sum(score)�ܷ�,count(score)�ο�����
from score
inner join course on score.courseid=course.cid
inner join stuinfo on score.studentid=stuinfo.stuid
group by courseid,cname,studentid,sname 
order by courseid ;


--ֻ���μӹ�������ѧԺ�Ĳ�����Ŀƽ���ɼ�
select sname,studentid,courseid,cname ,trunc(avg(score)) ƽ���ɼ�,max(score),min(score),sum(score)�ܷ�,count(score)�ο�����
from score
inner join course on score.courseid=course.cid
inner join stuinfo on score.studentid=stuinfo.stuid
group by courseid,cname,studentid,sname having count(*)>1
order by courseid ;

--where��ԭʼ���ݽ���ɸѡ
--having�ǶԷ�������������ݼ�����ɸѡ

--���з�������: ��������: Ҫ�����ÿ�β��Բ�ͬѧԱ�Ĳ�ͬ��Ŀ�ĳɼ�(����в�������Ϊ��γɼ���ƽ��ֵ)
select sname,courseid,cname,trunc(avg(score)) ƽ���ɼ�
from score
inner join course on score.courseid=course.cid
inner join stuinfo on score.studentid=stuinfo.stuid
group by courseid,cname,studentid,sname having count(*)=1;
--union all
(select sname,courseid,cname,�ܷ�/�ο����� ƽ���ɼ� from (select sname,studentid,courseid,cname ,trunc(avg(score)) ƽ���ɼ�,max(score),min(score),sum(score)�ܷ�,count(score)�ο�����
            from score
            inner join course on score.courseid=course.cid
            inner join stuinfo on score.studentid=stuinfo.stuid
            group by sname,studentid,courseid,cname having count(*)>1
            order by courseid));



--����������ϣ�ֻ��鿴�μӹ�������ѧԱ�Ĳ�����Ŀ��ƽ���ɼ�.
--��������ʱҪ�Է��������ݽ��з���������ǲ����Ŀ�Ŀ����������ж�����¼��


--�ܽ᣺select �﷨
-- select ����
--from ����
--where ����
--group by ������
--having ����.


select * from stuinfo; --8��
select * from course; --3��
select * from score; --20���ɼ�

--�Ӷ������ȡ���ݳ���:
--����: ��ʾѧ���������γ������ɼ�
--�������1. ��ͨ��ѯ+������������ж�
select stuinfo.stuid,stuinfo.sname,course.cid,course.cname,score.score
from stuinfo,score,course
where stuinfo.stuid=score.studentid and score.courseid=course.cid;

select * from stuinfo inner join score on stuinfo.stuid=score.studentid;
select * from stuinfo left join score on stuinfo.stuid=score.studentid;

--�������2: ʹ�ö�����Ӳ�ѯ
--����:1. ������(inner join):   ����������һ��ͬ����������з�����������ʱ�������Ӳŷ�����. ��������������һ�������κβ�ƥ�����.
--     2. ������    �� �����ӻ᷵��from �Ӿ����ᵽ������һ����������У�ֻҪ��Щ�з����κ�where��having������
--            ��������   left join �� ��߱������е��У��ұ߱���û�е��ֶ���null����
--            ��������   right join : �ұ߱������е���, ��߱���û�е��ֶ���null����
--            ����������  full join : �������ݶ����أ�û�еĵط���null����. 
--     3. ��������  (cross join)




--1. �������﷨:  select ����  from ����
--                  inner join ����2
--                  on ��������
--����:   ��ʾѧ���������γ������ɼ�  
select * from stuinfo; --8��
select * from course; --3��
select * from score; --20���ɼ�

select stuinfo.stuid,stuinfo.sname,course.cid,course.cname,score.score
from score
inner join stuinfo on score.studentid=stuinfo.stuid
inner join course on score.courseid=course.cid;


--����۲�: ������������ѯ�����Ľ�����ֱ�Ϊ���٣�Ϊʲô?
select * from course;
select * from score;
select * from stuinfo;

select c.cname,s.score
from score s
inner join course c
on    s.courseid=c.cid ;
        --���Ϊ:     ___20___����¼  
        
select c.cname,s.score
from score s, course c
where s.courseid=c.cid;


    --���Ϊ:  ____20_____����¼   




--��������: �﷨:  select ���� from ����1  left join ����2 on ��������
--�ص�:  ���Ȳ������1�����еķ������������ݣ��������2��û�������Ӧ�����ݣ�����nULL���ֵ
--��������: ѧ��������һλѧԱ'ΤС��'�� 1�ţ�û�вμӹ��κο��ԣ��������������û�вμӹ��κο��Ե�ѧԱ
select st.sname,s.score
from score s
left join stuinfo st
on    s.studentid=st.stuid ;
--20����¼��������û�гɼ���ѧ��

--�����������������������෴:
select st.sname,s.score
from stuinfo st
left join score s
on    s.studentid=st.stuid ;
--22����¼

select st.sname,decode(s.score,null,'ȱ��',score) �ɼ�
from stuinfo st
left join score s
on    s.studentid=st.stuid ;


--ֻ��ȱ����ѧԱ��Ϣ
select st.sname ȱ����Ա
from stuinfo st
left join score s
on    s.studentid=st.stuid where score is null;

--ȱ��ѧ�ţ�ѧ����������
select st.stuid ѧ��,st.sname ȱ����Ա
from stuinfo st
left join score s
on    s.studentid=st.stuid where score is null;


--���������� full join
select stuid ѧ��,sname ѧ����,decode(score,null,'ȱ��',score) �ɼ�
from score
full join stuinfo on stuinfo.stuid=score.studentid;



select stuid ѧ��,sname ѧ����,score
from stuinfo
left join score on stuinfo.stuid=score.studentid;
select stuid ѧ��,sname ѧ����,score
from score
left join stuinfo on stuinfo.stuid=score.studentid;



                      --���:    ______22_____����¼:   




--��������:  ����е�ÿһ�����ұ��е�ÿ�ж���ϳɡ�   �ѿ����˻�=���������*�ұ�������
select stuid ѧ��,sname ѧ����,decode(score,null,'ȱ��',score) �ɼ�
from score
cross join stuinfo;


---�ۺϰ���һ:
--��������:�����ݿ���У�������λ�ò�����Ҫ������һ����λ��Ҫ���������к�ż���е����������ܣ���������ܵĻ������ٵõ�һ����ֵ��
--��ˣ�Ҫ��ѯ���ݿ��������к�ż���е�����, ��ԭ���е�id�е�ֵ��������ȫ�����ģ�������һЩ�����Ѿ�ɾ����.

create table tab1(
    id int primary key,
    total int
);

insert into tab1 values(1,33);
insert into tab1 values(3,44);
insert into tab1 values(4,2);
insert into tab1 values(5,6);
insert into tab1 values(8,88);
insert into tab1 values(9,3);
insert into tab1 values(15,33);
insert into tab1 values(17,34);
insert into tab1 values(19,34);
insert into tab1 values(20,29);

--����һ��
select * from tab1;
create table tab2 as(select rownum id,tab1.total from tab1);
select * from tab2;

--��������
create sequence seq_tab1;
create table newtab1
as
select seq_tab1.nextval as id,total from tab1;

--ż��
select sum(total) from tab2 where mod(id,2)<>1;
--����
select sum(total) from tab2 where mod(id,2)=1;

--�ϲ�����ż����sum����
--�Ӳ�ѯ
select a.�����еĺ�,b.ż���еĺ�
from
(select sum(total) �����еĺ�
from newtab1
where mod(id,2)=1) a,
(select sum(total) ż���еĺ�
from newtab1
where mod(id,2)=0)b;

--������
select *
from
((select '�����еĺ�'||sum(total) �� from (select rownum id,tab1.total from tab1) where mod(id,2)<>1)
union all
(select 'ż���еĺ�'||sum(total) �� from (select rownum id,tab1.total from tab1) where mod(id,2)=1))

--������ �����½���
select decode(item,1,'������',2,'ż����') as ��Ŀ ,��
from
((select 1 as item ,sum(total) �� from (select rownum id,tab1.total from tab1) where mod(id,2)<>1)
union all
(select 2 as item ,sum(total) �� from (select rownum id,tab1.total from tab1) where mod(id,2)=1))


--�������: ֻ��������ʶ�е�ֵ�������жϺ�ѡȡ, ��ԭ���������Ѿ������ã����Ա�������һ���±���ԭ���total�е����ݲ��ȥ���������ӱ�ʶ��
--Ȼ�������±���ͨ���±�ʶ������������ֵ��ż����ֵ
--��һ��������ݲ��뵽��һ�����﷨: create �±��� as  select ����, ����   from Դ����










--������: 
--һ�����з������µ����ÿ����տ�ʼ��ʱ���ƹ�úܺã������𽥷Ͽ�ҲԽ��Խ�ࣨ���ϵ��������2Ԫ�������û���ʱ�䲻ʹ�øÿ�����
--��������ڶ��·ݰ���Щ����2Ԫ�Ŀ��Ӷ����ݿ����ɾ���ˣ����Ǻܿ���������ˣ��û��������Ŀ���Ҳ����ʹ�ö�Ͷ�ߣ����ֻ���ٰ���Щ���ָ���
drop table cust;
create table cust(
   cardid int primary key,
   cname varchar(50)
);
drop table account;
create table account(
   accountid int primary key identity(1,1),
   cardid int constraint FK_cardid foreign key references cust(cardid),
   score int
);
insert into cust values(16,'����');
insert into cust values(23,'����');
insert into cust values(25,'����');
insert into cust values(29,'����');
insert into cust values(30,'����');

insert into account values(16,3400);
insert into account values(25,4565);
insert into account values(29,456);

--����: 1. ������left join�ҳ�cust�����ж�accountû�еļ�¼�����ּ�¼��������account.cardid is null)
--      2. �ٽ��ҵ���cardid�Ų��뵽account���м���.  ��Ϊaccount���Ѿ����ڣ����ǽ�һЩ���ݴ�һ��������ȡ
--�ٲ��뵽��һ���Ѵ��ڵı��У����Կ���ʹ��insert into ����1 select ֵ from Դ����





