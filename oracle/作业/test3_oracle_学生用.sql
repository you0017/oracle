--CARD     ���鿨��   CNO ���ţ�NAME  ������CLASS �༶
create table card(
   cno int primary key,
   name varchar2(50),
   class varchar2(10)
);
create sequence seq_card;

--BOOKS    ͼ�顣     BNO ��ţ�BNAME ����,AUTHOR ���ߣ�PRICE ���ۣ�QUANTITY ������ 
create table books(
    bno int primary key,
    bname varchar2(50),
    author varchar2(50),
    price float,
    quantity int
);
create sequence seq_books;
--BORROW   �����¼�� CNO ���鿨�ţ�BNO ��ţ�RDATE ��������
create table borrow(
    cno int,
    bno int,
    rdate date
);

alter table borrow
    add constraint fk_borrow_cno  foreign key(cno)  references card(cno) ;
alter table borrow
		add constraint fk_borrow_bno foreign key(bno) references books(bno);

insert into card values(seq_card.nextval,'����','c01');
insert into card values(seq_card.nextval,'����','c02');
insert into card values(seq_card.nextval,'����','c02');
insert into card values(seq_card.nextval,'����','c01');
insert into card values(seq_card.nextval,'����','c01');
insert into card values(seq_card.nextval,'�Ű�','c01');

insert into books values(seq_books.nextval,'�������','smith',30,5);
insert into books values(seq_books.nextval,'�����������','smith',38,5);
insert into books values(seq_books.nextval,'ˮ�','ʩ�Ͱ�',30,5);
insert into books values(seq_books.nextval,'���㷽��','TOM',30,5);
insert into books values(seq_books.nextval,'����ϰ�⼯','John',22,5);
insert into books values(seq_books.nextval,'�����ѧ','smith',39,5);
insert into books values(seq_books.nextval,'����ѧ','Jerry',100,2);

select * from card;
select * from books;

insert into borrow values(2,2,to_date('2012-6-5','yyyy-mm-dd')  );
insert into borrow values(2,2,to_date('2012-6-5','yyyy-mm-dd'));
insert into borrow values(2,3,to_date('2012-6-5','yyyy-mm-dd'));
insert into borrow values(2,4,to_date('2012-6-5','yyyy-mm-dd'));
insert into borrow values(2,3,to_date('2012-6-5','yyyy-mm-dd'));
insert into borrow values(3,2,to_date('2012-4-30','yyyy-mm-dd'));
insert into borrow values(4,4,to_date('2012-6-5','yyyy-mm-dd'));
insert into borrow values(6,4,to_date('2012-6-6','yyyy-mm-dd'));
insert into borrow values(6,6,to_date('2012-6-6','yyyy-mm-dd'));
insert into borrow values(2,5,to_date('2012-6-5','yyyy-mm-dd'));
insert into borrow values(2,6,to_date('2012-6-5','yyyy-mm-dd'));
select * from borrow
--��ע���޶�ÿ��ÿ����ֻ�ܽ�һ��������������顢������ı䡣
 --1�� д������BORROW���SQL��䣬Ҫ��������������Լ��������������Լ����
 --2�� �ҳ����鳬��5���Ķ���,������鿨�ż�����ͼ�������


 --3�� ��ѯ������"ˮ�"һ��Ķ��ߣ�����������༶��


 --4�� ��ѯ����δ��ͼ�飬��������ߣ����ţ�����ż��������ڡ�

 --5�� ��ѯ��������"����"�ؼ��ʵ�ͼ�飬�����š����������ߡ�

 --6�� ��ѯ����ͼ���м۸���ߵ�ͼ�飬������������ߡ�

 --7�� ��ѯ��ǰ����"���㷽��"��û�н�"���㷽��ϰ�⼯"�Ķ��ߣ��������鿨�ţ��������Ž������������

 --8�� ��"C01"��ͬѧ����ͼ��Ļ��ڶ��ӳ�һ�� ��  sysdate+7

 --9�� ��BOOKS����ɾ����ǰ���˽��ĵ�ͼ���¼��
 
 --13����ѯ��ǰͬʱ����"���㷽��"��"�����ѧ"������Ķ��ߣ��������鿨�ţ����������������������

 --15����CARD���������޸ģ�
 --a. ��NAME����п����ӵ�10���ַ����ٶ�ԭΪ6���ַ�����

 --b. Ϊ�ñ�����1��NAME��ϵ�������ɱ䳤�����20���ַ���

