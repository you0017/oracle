

--查询的语法
select * from 表名
select 列名[，列名] from 表名

-- 先查看orcal中的示例表
select * from account;--（账号id，余额）

select * from dept;--部门信息表（部门标号，部门名称，地址  
                                            --    审计部，纽约；
                                            --    研发部，达拉斯；
                                             --   销售部，芝加哥；
                                             --   运营部，波士顿）

select * from emp;--雇员表 （编号，姓名，工作类型。
                               --mgr  上级编号，hiredate 雇佣日期 ，sal工资  ，comm补助
                               --deptno部门号，外键，来源于dept的deptno一样
                               
select deptno,dname,loc from dept;
select deptno 部门号,dname 部门名,loc 地址 from dept;

select empno 工号，ename 雇员名 from emp;


--where
select * from emp where sal>2000 and job='MANAGER';
select * from emp where sal>10000;   --列名不区分大小写，但值区分

--1、算术运算符
--查询每位员工的工资=计本工资+奖金  (算术运算符 +，-，* /  )
select empno,ename,nvl(sal,0),nvl(comm,0),nvl(sal,0)+nvl(comm,0) 总收入 from emp;  --NULL如何处理？NULL替换成0

--nvl(a,b) a为null则用b值，不为空就a
--nvl2(a,b,c) a不为null则为b，为空则为c


--难看，重命名列 （as 可以省略）





--比较运算符   < , > , = , between and , in , like , is null
--带条件的查询
--查询工资在3000元以上的员工信息（ 比较运算符 <,>,=,between...and,in,like,is null）
select * from emp where sal>3000;

--查询 总工资在3000元以上的员工信息（ 比较运算符）
select empno,ename,nvl(sal,0),nvl(comm,0),nvl(sal,0)+nvl(comm,0) 总收入 from emp where nvl(sal,0)+nvl(comm,0)>3000;

--查询 工资在2000-3000的员工（需要关爱，中间力量）
select * from emp where sal between 2000 and 3000;


--查询  职位不是 业务员，销售 的员工信息。不在一个区间（not in）
select * from emp where job not in('CLERK','SALESMAN');
select * from emp where job <>'CLERK' and job<>'SALESMAN';


--查询哪些员工没有奖金，
select * from emp where comm is null or comm = 0;
select * from emp where nvl(comm,0)=0;



--查询一个员工，他的名字是M开头的，
select * from emp where ename like 'N%'; --模糊匹配
select * from emp where ename = 'N%';    --名字叫N%
select * from emp where ename like '%E'; --以E结尾
select * from emp where ename like '_L%';--第二个字母叫L
select * from emp where ename like '%N%';--只要有N
select * from emp where ename like '_%N%_';--中间有N


--3、逻辑运算符(and / or / not) 不等于<>
--查询名字是 M开头的，而且是 审计部 部门的。查到部门编号是10
select * from emp where DEPTNO=10 and ename like 'M%';

select * from emp where Deptno = (select deptno from dept where dname='ACCOUNTING') and ename like 'M%';



--not 是加在  一个表达式之前的。
select * from emp where ename not like 'M%';    --不以N开头
select * from emp where ename is not like 'M%'; --is只能和null一起用

--4、连接操作符
-- java字符串连接操偶符："hello"+"world"
-- oracle用 ||

select empno||'对应名字为'||ename||',他的工作类型是'||job as 个人描述 from emp;
select concat(concat(concat(concat(empno,'对应名字为'),ename),',他的工作类型是'),job) as 个人描述 from emp;



--优先级，算术运算符（乘除高于加减）>连接操作符>比较运算符>逻辑运算符（not>and>or）
--1、同一优先级运算符从左向右执行；
--2、括号内的运算先执行。



--5.集合运算符 从两张表中抽取数据行形成一张新表
--  union,union all 并集
--intersect 交集
-- minus  差集
--供应商表
create table supplier(
       id int primary key,
       sname varchar2(20)
);

create sequence seq_supplier;--创建序列
insert into supplier values(seq_supplier.nextval,'联想');
insert into supplier values(seq_supplier.nextval,'小米');

--客户表
create table customer(
       cid int primary key,
       cname varchar2(20)
);
create sequence seq_customer;
insert into customer values(seq_customer.nextval,'联想');
insert into customer values(seq_customer.nextval,'华为');

--需求：要请供应商和客户参加研讨会  --并集
select * from supplier
union
select * from customer;

select * from supplier
union all
select * from customer;
--说明：各列属性的值都相同就是重复
update supplier set id=4 where id =2;



--sql中 函数分为（单行行数/分组函数/分析函数）
--单行函数

create table stuInfo(
       sid int primary key,
       sname varchar2(10) not null,
       age number(3)
       
)
create table mathScore(
       sid int primary key,
       
       
)
--1、日期函数
    --查询当前日期
      select sysdate from dual;
       
     --查找入职已经超过35年的超级老员工
     --months_between(d1,d2)
     select * from emp;
     
     --解决方法一：months_between(sysdate,hiredate)>=420
     select empno,ename,hiredate,months_between(sysdate,hiredate) as 工作时限 from emp;
     select empno,ename,hiredate,trunc(months_between(sysdate,hiredate)) 工作时限
                   from emp where months_between(sysdate,hiredate)>35*12;

     --解决方法二：add_months
     select empno,ename,hiredate,add_months(sysdate,-35*12)
                   from emp where add_months(sysdate,-35*12)>hiredate;
     select empno,ename,hiredate,add_months(hiredate,35*12)
                   from emp where add_months(hiredate,35*12)<sysdate;

    --对于每个员工，显示其加入公司天数
    select empno,ename,sysdate-hiredate 服务天数 from emp;
    select empno,ename,trunc(sysdate-hiredate) 服务天数 from emp;
    

--2、数字函数
    --对于每个员工，显示其加入公司天数,去整数天数 (floor()向下取整)
    --trunc()接断  round()四舍五入  ceil()大于x的最小整数  floor()向下取整
    select empno,ename,trunc(sysdate-hiredate)服务天数
                      ,round(sysdate-hiredate)服务天数
                      ,ceil(sysdate-hiredate)服务天数
                      ,floor(sysdate-hiredate)服务天数
                      from emp;

--3、字符函数
    --将job转换成小写，认单词困难
    select * from emp;
    select empno,ename,lower(job),upper(job),initcap(job),nls_initcap(job) from emp;
    
         
    --我想看到哪些岗位，之前有重复的(售货员、职员、董事长、经理、分析师) distinct，去重
    select distinct(job) from emp;
         
     --显示正好为5个字符的员工的姓名   b:byte按字节计算
     select ename,length(ename),lengthb(ename) from emp;
     
     update emp set ename='张。' where empno=xxx;

         
     --显示所有员工姓名的前三个字符
     select ename,substr(ename,0,3) from emp;
     select ename,substrb(ename,0,3) from emp;
         
     --显示所有员工姓名的最后三个字符
     select ename,substr(ename,-3,3) from emp;

         
     --以首字母大写的方式显示所有员工的姓名
     select initcap(ename) from emp;
    
          
     --字符替换
     select replace('he love you','he','i') test from dual;
  

          
          
      
--4、转换函数 string-date date->string
         insert into emp values(9800,'Hehehe222','PRESUDENT','',sysdate,2000,8000,10);
         select * from emp;  --hiredate:sysdate插入   2024/20000/3/2  19:23:56(时间戳
         --取出这个hiredate.放到java程序 string
         --date->char  :  to_char()
         select empno,ename,hiredate,to_char(hiredate,'yyyy-mm-dd HH24:mm') from emp;
         select sysdate from dual;
         
         --to_char()对数值型的转换
         select empno,ename,sal,to_char(sal,'$9999.99') from emp;
  
         --找出每个月倒数第三天受雇的员工
         select empno,ename,hiredate from emp where hiredate=last_day(hiredate)-2;

                 
--5、其他函数(nvl nvl2 nvlif) : if
          select ename,nvl(comm,0) 奖金1,
                       nvl2(comm,comm,0) 奖金2
                       from emp;
                       
          --decode: switch...case...
          select * from emp;
          select * from dept;
          --将emp员工名，工资和部门名输出
          select ename,sal,decode(deptno,10,'ACCOUNTING',20,'RESEARCH',30,'SALES',40,'OPERATIONS','其他部门') from emp;
       
       
       
--6、分组函数（avg,min,max,sum,count）   聚合函数：将多个输入数据合并成一个输出
   --平均工资是多少(5451.5625)
   select count(*) 总人数,sum(comm) 总奖金数 ,avg(comm) 平均奖金 ,sum(comm)/count(*) 检验 from emp;
   --avg()统计时comm是null的话，不算人数
   select count(*) 总人数,sum(comm) 总奖金数 
                   ,trunc(avg(nvl(comm,0))) 平均奖金 
                   ,trunc(avg(nvl(comm,0))) 正确的平均奖金
                   ,trunc(sum(comm)/count(*)) 检验 
                   from emp;
 
          
   --最低收入是多少
   select min(nvl(sal,0)+nvl(comm,0)) 最低收入 from emp;

          
    --最高收入是多少
    select max(nvl(sal,0)+nvl(comm,0)) 最高收入 from emp;
    
    --合并输出
     select min(nvl(sal,0)+nvl(comm,0)) 最低收入,max(nvl(sal,0)+nvl(comm,0)) 最高收入 from emp;

   --本月应该发多少工资
   select sum(sal+comm) 工资总支出 from emp;
   select sum(nvl(sal,0)+nvl(comm,0)) 工资总支出 from emp;

          
   --给多少人发工资(16)
   select count(*) 总人数 from emp;
   select count(empno) 总人数 from emp;
   select count(nvl(sal,0)) 总人数 from emp;
          
    --验证
     
          
          
--7、分析函数
    --我想按工资高低排序--order by 列名 desc降序/asc升序,列名2 desc降序/asc升序....
    select * from emp order by sal desc,ename asc;
   
          
   --工资高低排名  伪列 rownum
   select a.*,rownum from emp a;
   --思路：先排序再加rownum编号  rownum 是对原始表排序，然后再升序降序
   --应该先升降，再rownum
   select a.*,rownum from emp a order by sal desc,ename asc;
   select a.*,rownum 名次 from (select empno,ename,nvl(sal,0) 工资 from emp order by nvl(sal,0) desc,ename asc) a;
          
   --以全部员工工资从高到低排序（跳跃的 rank）
      --RANK() OVER([query_partition_clause] order_by_clause)
      select empno,ename,nvl(sal,0) 工资 ,rank() over(order by nvl(sal,0) desc) 名次 from emp a;
        
          
   --以全部员工工资从高到低排序，连续的排名 
      select empno,ename,nvl(sal,0) 工资 ,dense_rank() over(order by nvl(sal,0) desc) 名次 from emp a;
          
   --以部门排名。部门内部排名
     select empno,ename,nvl(sal,0) 工资 ,rank() over(partition by deptno order by nvl(sal,0) desc) 名次 from emp a;
     
     select empno,ename,nvl(sal,0) 工资 ,dense_rank() over(partition by deptno order by nvl(sal,0) desc) 名次 from emp a;
     
     
   --利用row_number()函数排序
   select empno,ename,nvl(sal,0) 工资 ,row_number() over(partition by deptno order by nvl(sal,0) desc) 名次 from emp a;
          
          
   --查询每一个部门的平均工资。（分组 group by）
   select deptno,trunc(avg(nvl(sal,0))) 工资 from emp group by deptno;
        
   --查询每一个部门，每一个岗位的的平均工资(分列分组，)

          
   --查询不了。，查询平均工资在1500快以下部门职位信息
  --select deptno,job,avg(sal) from emp e  这个需要用分组函数
          
        
