--1. 以system身份登录oracle


--2. 查看dba_tablespaces数据字典视图,了解当前数据库中包括哪里些数据字典, 可知当前库包括了system,sysaux,users和temp等6个表空间
select * from dba_tablespaces;

--3. 创建一个用户hillary,口令为window,默认表空间是users,临时表空间是temp
drop user hillary;

create user hillary
identified by window
default tablespace users
temporary tablespace temp;

-- 注意：创建此用户后，在没有为这个用户授予相应的连接数据库的权限的情况下，它依然不能连接到数据库.
--测试hillary登录，   ora-01045错误


--4. 为hillary授予create session权限，再测试
--赋权限的语法 sql：DCL控制语句：grant 权限名 to 用户
--                               revoke 权限名 from 用户
grant create session to hillary;
revoke create session from hillary;


--5.  修改用户口令
--语法:  alter user 用户名  identified by 新密码
--练习: 使用alter user 语句将hillary 口令修改为door
alter user hillary identified by door;
--修改完后测试登录





--6. 锁定和解除锁定用户:  临时禁止某个用户访问oracle
--语法: alter user 用户名 account [lock|unlock]
--练习: 对hillary 用户进行锁定和解除锁定操作
--注意：应以system身份登录操作
alter user hillary account lock;
alter user hillary account unlock;



--7. 查看用户信息 : 采用dba_users视图来实现
select * from dba_users;

--8. 删除用户
--语法:   drop user 用户名[cascade]
--注意: 如果当前删除的用户拥有对象，那么必须使用cascade关键字才可以删除该用户，级联删除
drop user hillary cascade;





--第二部分: 为用户授予系统权限
--语法:  grant 系统权限1[, 系统权限2] to 用户 [with admin option]
--with admin option: 表示该用户可以将这种系统权限转授予其他用户.
--练习1  以system登录,创建两个用户hillary/window和jackson/tree,
create user hillary
identified by window;

create user jackson
identified by tree;

drop user hillary cascade;
drop user jackson cascade;

--以上创建用户时没指定表空间，则默认以下配置
--defalut tablespace users
--temporary tablespace temp;




--  为hillary 用户授予create session和create user系统权限， 可连接系统和创建用户
grant create session,create user to hillary;

--为hillary用户授予create any table 和execute any procedure系统权限，并使用with admin option选项，这样它可以将授予自己的权限转授别人.
grant create any table,execute any procedure to hillary with admin option;

--以hillary身份登录系统, 为jackson用户授予create any table和execute any procedure系统权限.
grant create any table,execute any procedure to jackson;

--以system身份登录系统，为public用户授予create session权限。因为public 是公共角色，所有的用户都是其成员，所以，系统中所有的用户都拥有联接系统权限. 
grant create session to publec;





--查看用户的系统权限:   user_sys_privs
--以hillary登录系统, 查看当前用户hillary的权限.     user_sys_privs
select * from user_sys_privs;         --以user_xxx开头的视图都表示当前用户的xxx


--收回授予的系统权限 
--语法: revoke 系统权限1[,系统权限2] from 用户名
--练习: 以system登录，从hillary处收回create any table权限
revoke create any table from hillary;

--      以hillary登录，查看它的权限




--第三部分， 对象权限管理.
--对象权限主要是针对表或视图 select,insert,update,delete,..权限
--语法: grant 对象权限1[列名] on 对象名 to 用户名 [with grant option]
--练习: 以scott身份登录系统, 为hillary用户授予对emp表的select,insert和delete对象权限 
select * from emp;

grant select,insert,delete on scott.emp to hillary;

--      为hillary 用户授予对emp表中的ename列的更新权限.
grant update(ename) on scott.emp to hillary;
delete from scott.emp where empno=7289;

update scott.emp set ename='hehehehe' where empno=7288;
update scott.emp set job='123' where empno=7288;

 
 --练习:查看用户的对象权限:    
 --user_tab_privs_made, 某个用户对另外一个用户授予的权限
 --user_col_privs_made, 有关列级的权限
 --user_tab_privs_read  , 有关某个用户接受的权限
 --user_col_privs_read    有关列级对象的权限.
 --以scott登录，查看
 select * from user_tab_privs_made;
 select * from user_col_privs_made;
 select * from user_col_privs_recd;
 select * from user_tab_privs_recd;

 
 
 --收回对象权限
 --语法:  revoke 对象权限  on 对象名  from 用户名
revoke update on scott.emp fromo hillary;


select name from v$datafile;     --访问数据文件 .DBF
select member from v$logfile;    --访问日志文件 .LOG
select name from v$controlfile;  --访问控制文件 .CTL


--创建表空间
--语法：create tablespace tablespacename
--          datafile 'filename' [size integer [K|M]]
--          [autoextend [off|on]];
create tablespace tablespacename datafile 'F:\java\java\。，。\oracle\sql表' [size integer [K|M]] [autoextend [off|on]];

create user hillary2
identified by a
default tablespace zy_tablespace2
temporary tablespace temp;

--删除必须按这个步骤，否则oracle就会打不开
drop user hillary2;
drop tablespace zy_tablespace2;