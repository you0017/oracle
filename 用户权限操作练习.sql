--1. ��system��ݵ�¼oracle


--2. �鿴dba_tablespaces�����ֵ���ͼ,�˽⵱ǰ���ݿ��а�������Щ�����ֵ�, ��֪��ǰ�������system,sysaux,users��temp��6����ռ�
select * from dba_tablespaces;

--3. ����һ���û�hillary,����Ϊwindow,Ĭ�ϱ�ռ���users,��ʱ��ռ���temp
drop user hillary;

create user hillary
identified by window
default tablespace users
temporary tablespace temp;

-- ע�⣺�������û�����û��Ϊ����û�������Ӧ���������ݿ��Ȩ�޵�����£�����Ȼ�������ӵ����ݿ�.
--����hillary��¼��   ora-01045����


--4. Ϊhillary����create sessionȨ�ޣ��ٲ���
--��Ȩ�޵��﷨ sql��DCL������䣺grant Ȩ���� to �û�
--                               revoke Ȩ���� from �û�
grant create session to hillary;
revoke create session from hillary;


--5.  �޸��û�����
--�﷨:  alter user �û���  identified by ������
--��ϰ: ʹ��alter user ��佫hillary �����޸�Ϊdoor
alter user hillary identified by door;
--�޸������Ե�¼





--6. �����ͽ�������û�:  ��ʱ��ֹĳ���û�����oracle
--�﷨: alter user �û��� account [lock|unlock]
--��ϰ: ��hillary �û����������ͽ����������
--ע�⣺Ӧ��system��ݵ�¼����
alter user hillary account lock;
alter user hillary account unlock;



--7. �鿴�û���Ϣ : ����dba_users��ͼ��ʵ��
select * from dba_users;

--8. ɾ���û�
--�﷨:   drop user �û���[cascade]
--ע��: �����ǰɾ�����û�ӵ�ж�����ô����ʹ��cascade�ؼ��ֲſ���ɾ�����û�������ɾ��
drop user hillary cascade;





--�ڶ�����: Ϊ�û�����ϵͳȨ��
--�﷨:  grant ϵͳȨ��1[, ϵͳȨ��2] to �û� [with admin option]
--with admin option: ��ʾ���û����Խ�����ϵͳȨ��ת���������û�.
--��ϰ1  ��system��¼,���������û�hillary/window��jackson/tree,
create user hillary
identified by window;

create user jackson
identified by tree;

drop user hillary cascade;
drop user jackson cascade;

--���ϴ����û�ʱûָ����ռ䣬��Ĭ����������
--defalut tablespace users
--temporary tablespace temp;




--  Ϊhillary �û�����create session��create userϵͳȨ�ޣ� ������ϵͳ�ʹ����û�
grant create session,create user to hillary;

--Ϊhillary�û�����create any table ��execute any procedureϵͳȨ�ޣ���ʹ��with admin optionѡ����������Խ������Լ���Ȩ��ת�ڱ���.
grant create any table,execute any procedure to hillary with admin option;

--��hillary��ݵ�¼ϵͳ, Ϊjackson�û�����create any table��execute any procedureϵͳȨ��.
grant create any table,execute any procedure to jackson;

--��system��ݵ�¼ϵͳ��Ϊpublic�û�����create sessionȨ�ޡ���Ϊpublic �ǹ�����ɫ�����е��û��������Ա�����ԣ�ϵͳ�����е��û���ӵ������ϵͳȨ��. 
grant create session to publec;





--�鿴�û���ϵͳȨ��:   user_sys_privs
--��hillary��¼ϵͳ, �鿴��ǰ�û�hillary��Ȩ��.     user_sys_privs
select * from user_sys_privs;         --��user_xxx��ͷ����ͼ����ʾ��ǰ�û���xxx


--�ջ������ϵͳȨ�� 
--�﷨: revoke ϵͳȨ��1[,ϵͳȨ��2] from �û���
--��ϰ: ��system��¼����hillary���ջ�create any tableȨ��
revoke create any table from hillary;

--      ��hillary��¼���鿴����Ȩ��




--�������֣� ����Ȩ�޹���.
--����Ȩ����Ҫ����Ա����ͼ select,insert,update,delete,..Ȩ��
--�﷨: grant ����Ȩ��1[����] on ������ to �û��� [with grant option]
--��ϰ: ��scott��ݵ�¼ϵͳ, Ϊhillary�û������emp���select,insert��delete����Ȩ�� 
select * from emp;

grant select,insert,delete on scott.emp to hillary;

--      Ϊhillary �û������emp���е�ename�еĸ���Ȩ��.
grant update(ename) on scott.emp to hillary;
delete from scott.emp where empno=7289;

update scott.emp set ename='hehehehe' where empno=7288;
update scott.emp set job='123' where empno=7288;

 
 --��ϰ:�鿴�û��Ķ���Ȩ��:    
 --user_tab_privs_made, ĳ���û�������һ���û������Ȩ��
 --user_col_privs_made, �й��м���Ȩ��
 --user_tab_privs_read  , �й�ĳ���û����ܵ�Ȩ��
 --user_col_privs_read    �й��м������Ȩ��.
 --��scott��¼���鿴
 select * from user_tab_privs_made;
 select * from user_col_privs_made;
 select * from user_col_privs_recd;
 select * from user_tab_privs_recd;

 
 
 --�ջض���Ȩ��
 --�﷨:  revoke ����Ȩ��  on ������  from �û���
revoke update on scott.emp fromo hillary;


select name from v$datafile;     --���������ļ� .DBF
select member from v$logfile;    --������־�ļ� .LOG
select name from v$controlfile;  --���ʿ����ļ� .CTL


--������ռ�
--�﷨��create tablespace tablespacename
--          datafile 'filename' [size integer [K|M]]
--          [autoextend [off|on]];
create tablespace tablespacename datafile 'F:\java\java\������\oracle\sql��' [size integer [K|M]] [autoextend [off|on]];

create user hillary2
identified by a
default tablespace zy_tablespace2
temporary tablespace temp;

--ɾ�����밴������裬����oracle�ͻ�򲻿�
drop user hillary2;
drop tablespace zy_tablespace2;