
drop sequence seq_s_sno;
drop sequence seq_c_cno;
drop table S;
drop table SC;
drop table C;
--S (SNO,SNAME��          ѧ����ϵ��SNO Ϊѧ�ţ�SNAME Ϊ����
create sequence seq_s_sno start with 1;

create table S(
  SNO int primary key,
  SNAME varchar(30) not null
)SEGMENT CREATION IMMEDIATE;
--C (CNO,CNAME,CTEACHER)  �γ̹�ϵ��CNO Ϊ�γ̺ţ�CNAME Ϊ�γ�����CTEACHER Ϊ�ον�ʦ
create sequence seq_c_cno start with 1;

create table C(
  CNO int  primary key,
  CNAME varchar(30) not null ,
  CTEACHER  varchar(30) not null
)SEGMENT CREATION IMMEDIATE;
--SC(SNO,CNO,SCGRADE)     ѡ�ι�ϵ��SCGRADE Ϊ�ɼ�

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


insert into S values(seq_s_sno.nextval,'��·');
insert into S values(seq_s_sno.nextval,'Ѧ��');
insert into S values(seq_s_sno.nextval,'��ˮƽ');
insert into S values(seq_s_sno.nextval,'ŷ������');
insert into S values(seq_s_sno.nextval,'��˿');
insert into S values(seq_s_sno.nextval,'լ��');

insert into C values(seq_c_cno.nextval,'C����','����');
insert into C values(seq_c_cno.nextval,'java','��Ӱ');
insert into C values(seq_c_cno.nextval,'���ݿ�','������');
insert into C values(seq_c_cno.nextval,'c++','������');


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

--1. �ҳ�û��ѡ�޹�����������ʦ���ڿγ̵�����ѧ������

--2. �г��ж������ϣ������ţ�������γ̵�ѧ����������ƽ���ɼ�


--3. �г���ѧ����1���ſγ̣���ѧ����2���ſγ̵�����ѧ������

 
--4. �г���1���ſγɼ��ȡ�10002����ͬѧ���ſγɼ��ߵ�����ѧ����ѧ��

--5. �г���1���ſγɼ��ȡ�2���ſγɼ��ߵ�����ѧ����ѧ�ż��䡰1���ſκ͡�2���ſεĳɼ�
