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
   
insert into course(cid,cname) values(1,'j2se精讲');
insert into course(cid,cname) values(3,'sql server');
insert into course (cid,cname) values(9,'html网页设计');
   
insert into stuinfo(stuid,sname,sage,saddress) values(31,'张果老',22,null);
insert into stuinfo(stuid,sname,sage,saddress) values(29,'张三在',20,null);
insert into stuinfo(stuid,sname,sage,saddress) values(13,'李豹',22,null);
insert into stuinfo(stuid,sname,sage,saddress) values(15,'老胡',22,'北京');
insert into stuinfo(stuid,sname,sage,saddress) values(17,'老江',24,'湖南');
insert into stuinfo(stuid,sname,sage,saddress) values(19,'张无忌',26,'衡阳');
insert into stuinfo(stuid,sname,sage,saddress) values(32,'二师兄',28,'长沙');
insert into stuinfo(stuid,sname,sage,saddress) values(1,'韦小宝',27,'上海');


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

--查出所姓'张'的学员信息
select * from stuinfo where sname like '张%';

--查出所有saddress字段为'NULL'值的学员的信息
select * from stuinfo where saddress is null;

--查出成绩在60到70分之间的学员的id号
select stuinfo.stuid from stuinfo,score where (score between 60 and 70) and stuid=studentid; --有重复编号
select distinct(stuinfo.stuid) from stuinfo,score where (score between 60 and 70) and stuid=studentid;

--查出地址是北京和上海的学生的信息
select * from stuinfo where saddress in ('北京','上海');

--查出学员在'sql server'这门课程中的总成绩和平均成绩,最高分数，最低分数
--聚合
--方案二：多表查询 from 表1，表2 where 表1.外键=表2.主键
select sum(nvl(score,0)) 总成绩,avg(nvl(score,0)) 平均成绩,min(nvl(score,0)) 最低分数 from score,course where courseid=cid and cname='sql server';
--方案一：子查询
select sum(nvl(score,0)) 总成绩,avg(nvl(score,0)) 平均成绩,min(nvl(score,0)) 最低分数 from score 
       where courseid=(select cid from course where cname='sql server');
--方案三：内连接查询  from 表1 inner join 表2 on 表1.外键=表2.主键
select sum(nvl(score,0)) 总成绩,avg(nvl(score,0)) 平均成绩,min(nvl(score,0)) 最低分数 from score 
       inner join course on score.courseid=course.cid
       where cname='j2se精讲';
       
       
--需求：每个学生每门课的成绩，学生编号，学生名，课程号，课程成绩
--方案一：多表查询  from 表1，表2，表3 where 表1.外键=表2.主键 and 表2.外键=表3.主键
select scoreid ,studentid,sname,courseid,cname,score
       from score,course,stuinfo
       where score.studentid=stuinfo.stuid and score.courseid=course.cid;
       
--方案二：内连接查询 from 表1 inner join 表2 on 表1.外键=表2.主键
select scoreid ,studentid,sname,courseid,cname,score
       from score inner join course on score.courseid=course.cid
                  inner join stuinfo on stuinfo.stuid=score.studentid;


--查出学员在'j2se精讲'这门课程中不及格的学生人数
select count(studentid) from score,course where courseid=cid and score<60 and cname='j2se精讲';



select * from stuinfo; --8人
select * from course; --3门
select * from score; --20个成绩
--(31,1)没有成绩,三个学生补考过(13,1),(29,3),(31,9)
--深入思考: 以上只求出了某一特定的课目的平均成绩，那如何一次性求出每一门课程的平均成绩呢？
--解决方案: 对课程进行分组,形成多个虚拟的数据集，对分组之后的结果再来求平均值
--语法: select 列名  from 表名   where 条件   group by 分组列
select trunc(avg(nvl(score,0))) 平均成绩,courseid from score group by courseid;

--显示课程
--方案一：普通多表查询
select courseid,cname,trunc(avg(score)) 平均成绩 from score,course 
where score.courseid=course.cid
group by courseid,cname;
--方案二：内联查询
select courseid,cname,trunc(avg(score)) 平均成绩 from score
inner join course on score.courseid=course.cid
group by courseid,cname;

--方案三：外连接查询
select courseid,cname,trunc(avg(score)) 平均成绩 from score
left join course on score.courseid=course.cid
group by courseid,cname;



--升级：求出各门课程的平均成绩，最高，最低，求和，参考人数
select courseid,trunc(avg(score)) 平均成绩,max(score),min(score),sum(score)总分,count(score)参考人数
from score
group by courseid;

--方案二 普通多表
select courseid,cname ,trunc(avg(score)) 平均成绩,max(score),min(score),sum(score)总分,count(score)参考人数
from score,course where score.courseid=course.cid
group by courseid,cname;
--方案三：内联
select courseid,cname ,trunc(avg(score)) 平均成绩,max(score),min(score),sum(score)总分,count(score)参考人数
from score
inner join course on score.courseid=course.cid
group by courseid,cname;

--特别提醒: 分组后，select 子句后的查询的结果要不就是分组的列，要不必须是聚合函数的列，而不能是其它的列.


--升级需求：查询每个学院每门课程的平均成绩  有三个补考过有两次成绩
select sname,studentid,courseid,cname ,trunc(avg(score)) 平均成绩,max(score),min(score),sum(score)总分,count(score)参考次数
from score
inner join course on score.courseid=course.cid
inner join stuinfo on score.studentid=stuinfo.stuid
group by courseid,cname,studentid,sname 
order by courseid ;


--只看参加过补考的学院的补考科目平均成绩
select sname,studentid,courseid,cname ,trunc(avg(score)) 平均成绩,max(score),min(score),sum(score)总分,count(score)参考次数
from score
inner join course on score.courseid=course.cid
inner join stuinfo on score.studentid=stuinfo.stuid
group by courseid,cname,studentid,sname having count(*)>1
order by courseid ;

--where对原始数据进行筛选
--having是对分完组的虚拟数据集进行筛选

--多列分组的情况: 需求描述: 要求求出每次测试不同学员的不同课目的成绩(如果有补考，则为多次成绩的平均值)
select sname,courseid,cname,trunc(avg(score)) 平均成绩
from score
inner join course on score.courseid=course.cid
inner join stuinfo on score.studentid=stuinfo.stuid
group by courseid,cname,studentid,sname having count(*)=1;
--union all
(select sname,courseid,cname,总分/参考次数 平均成绩 from (select sname,studentid,courseid,cname ,trunc(avg(score)) 平均成绩,max(score),min(score),sum(score)总分,count(score)参考次数
            from score
            inner join course on score.courseid=course.cid
            inner join stuinfo on score.studentid=stuinfo.stuid
            group by sname,studentid,courseid,cname having count(*)>1
            order by courseid));



--在上面基础上，只想查看参加过补考的学员的补考课目的平均成绩.
--分析，这时要对分组后的数据进行分析，如果是补考的课目，则分组后会有多条记录，


--总结：select 语法
-- select 列名
--from 表名
--where 条件
--group by 分组列
--having 条件.


select * from stuinfo; --8人
select * from course; --3门
select * from score; --20个成绩

--从多个表中取数据场景:
--需求: 显示学生姓名，课程名及成绩
--解决方案1. 普通查询+多个主外键相等判断
select stuinfo.stuid,stuinfo.sname,course.cid,course.cname,score.score
from stuinfo,score,course
where stuinfo.stuid=score.studentid and score.courseid=course.cid;

select * from stuinfo inner join score on stuinfo.stuid=score.studentid;
select * from stuinfo left join score on stuinfo.stuid=score.studentid;

--解决方案2: 使用多表联接查询
--种类:1. 内联结(inner join):   仅当至少有一个同属于两表的行符合联接条件时，内联接才返回行. 内联接消除与另一个表中任何不匹配的行.
--     2. 外联结    ： 外联接会返回from 子句中提到的至少一个表的所有行，只要这些行符合任何where或having条件。
--            左外联接   left join ： 左边表中所有的行，右边表中没有的字段用null代替
--            右外联接   right join : 右边表中所有的行, 左边表中没有的字段用null代替
--            完整外联结  full join : 两表数据都返回，没有的地方用null代替. 
--     3. 交叉联结  (cross join)




--1. 内联结语法:  select 列名  from 表名
--                  inner join 表名2
--                  on 联结条件
--案例:   显示学生姓名，课程名及成绩  
select * from stuinfo; --8人
select * from course; --3门
select * from score; --20个成绩

select stuinfo.stuid,stuinfo.sname,course.cid,course.cname,score.score
from score
inner join stuinfo on score.studentid=stuinfo.stuid
inner join course on score.courseid=course.cid;


--深入观察: 以下两条语句查询出来的结果数分别为多少，为什么?
select * from course;
select * from score;
select * from stuinfo;

select c.cname,s.score
from score s
inner join course c
on    s.courseid=c.cid ;
        --结果为:     ___20___条记录  
        
select c.cname,s.score
from score s, course c
where s.courseid=c.cid;


    --结果为:  ____20_____条记录   




--左外联接: 语法:  select 列名 from 表名1  left join 表名2 on 联结条件
--特点:  优先查出表名1中所有的符合条件的数据，如果表名2中没有这个对应的数据，则用nULL填充值
--案例描述: 学生表中有一位学员'韦小宝'， 1号，没有参加过任何考试，下面请求出所有没有参加过任何考试的学员
select st.sname,s.score
from score s
left join stuinfo st
on    s.studentid=st.stuid ;
--20条记录，少两个没有成绩的学生

--右外联接与左外联接正好相反:
select st.sname,s.score
from stuinfo st
left join score s
on    s.studentid=st.stuid ;
--22条记录

select st.sname,decode(s.score,null,'缺考',score) 成绩
from stuinfo st
left join score s
on    s.studentid=st.stuid ;


--只求缺考的学员信息
select st.sname 缺考人员
from stuinfo st
left join score s
on    s.studentid=st.stuid where score is null;

--缺考学号，学生名的名单
select st.stuid 学号,st.sname 缺考人员
from stuinfo st
left join score s
on    s.studentid=st.stuid where score is null;


--完整外联接 full join
select stuid 学号,sname 学生名,decode(score,null,'缺考',score) 成绩
from score
full join stuinfo on stuinfo.stuid=score.studentid;



select stuid 学号,sname 学生名,score
from stuinfo
left join score on stuinfo.stuid=score.studentid;
select stuid 学号,sname 学生名,score
from score
left join stuinfo on stuinfo.stuid=score.studentid;



                      --结果:    ______22_____条记录:   




--交叉联接:  左表中的每一行与右表中的每行都组合成。   笛卡尔乘积=左表数据行*右表数据行
select stuid 学号,sname 学生名,decode(score,null,'缺考',score) 成绩
from score
cross join stuinfo;


---综合案例一:
--需求描述:在数据库表中，数据行位置并不重要，但是一个单位中要根据奇数行和偶数行的数据来汇总，在这个汇总的基础上再得到一个数值，
--因此，要查询数据库表的奇数行和偶数行的总数, 但原表中的id列的值并不是完全连续的，其中有一些数据已经删除了.

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

--方法一：
select * from tab1;
create table tab2 as(select rownum id,tab1.total from tab1);
select * from tab2;

--方法二：
create sequence seq_tab1;
create table newtab1
as
select seq_tab1.nextval as id,total from tab1;

--偶数
select sum(total) from tab2 where mod(id,2)<>1;
--奇数
select sum(total) from tab2 where mod(id,2)=1;

--合并奇数偶数行sum操作
--子查询
select a.奇数行的和,b.偶数行的和
from
(select sum(total) 奇数行的和
from newtab1
where mod(id,2)=1) a,
(select sum(total) 偶数行的和
from newtab1
where mod(id,2)=0)b;

--方案二
select *
from
((select '奇数行的和'||sum(total) 和 from (select rownum id,tab1.total from tab1) where mod(id,2)<>1)
union all
(select '偶数行的和'||sum(total) 和 from (select rownum id,tab1.total from tab1) where mod(id,2)=1))

--方案三 不重新建表
select decode(item,1,'奇数和',2,'偶数和') as 条目 ,和
from
((select 1 as item ,sum(total) 和 from (select rownum id,tab1.total from tab1) where mod(id,2)<>1)
union all
(select 2 as item ,sum(total) 和 from (select rownum id,tab1.total from tab1) where mod(id,2)=1))


--解决方案: 只能依靠标识列的值来进行判断和选取, 但原有主键列已经不能用，所以必须生成一个新表，将原表的total列的数据插过去，并新增加标识列
--然后再在新表中通过新标识列来求奇数列值和偶数列值
--将一个表的数据插入到另一个表语法: create 新表名 as  select 列名, 序列   from 源表名










--案例二: 
--一家银行发行了新的信用卡，刚开始的时候推广得很好，但是逐渐废卡也越来越多（卡上的余额少于2元，并且用户长时间不使用该卡），
--因此银行在二月份把这些少于2元的卡从都数据库表中删除了，但是很快问题就来了，用户发现他的卡再也不能使用而投诉，因此只能再把这些卡恢复。
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
insert into cust values(16,'张三');
insert into cust values(23,'李四');
insert into cust values(25,'王五');
insert into cust values(29,'刘六');
insert into cust values(30,'杨七');

insert into account values(16,3400);
insert into account values(25,4565);
insert into account values(29,456);

--分析: 1. 可以用left join找出cust表中有而account没有的记录（这种记录的特征是account.cardid is null)
--      2. 再将找到的cardid号插入到account表中即可.  因为account表已经存在，这是将一些数据从一个表中提取
--再插入到另一个已存在的表中，所以可以使用insert into 表名1 select 值 from 源表名





