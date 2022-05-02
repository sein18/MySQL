-- DDL
-- CREATE TABLE
-- ��������

-- ���̺� ����
drop table MEMBER;
create table MEMBER(
	MEMBER_NO INT,    -- ȸ�� ��ȣ
	MEMBER_ID VARCHAR(20), -- ȸ�� ���̵�
	MEMBER_PW VARCHAR(20), -- ȸ�� ��й�ȣ
	MEMBER_NAME VARCHAR(15) COMMENT 'ȸ���̸�'
);
desc member;

select *from member;

-- ��������(CONSTRAINTS)
-- ���̺� ���� �ҋ� �÷��� ���� ����ϴ� �Ϳ� ���� ��������� ���� ����.
-- NOT NULL : NULL�� ������� �ʴ´�. (�ʼ� �Է� ����)
-- UNIQUE : �ߺ� �� ������� �ʴ´�.
-- CHECK : ������ �Է»��� �ܿ��� ���� ���ϰ� ���� ����.
-- PRIMARY KEY : NOT NULL + UNIQUE ���̺� ���ּ� �ش� ���� �ν��� �� �ִ� ���� ��.
-- FOREIGN KEY : �ٸ� ���̺��� ����� ���� ���� ��� ������ �������� �����Ϳ� �����ϴ� ��������

select *from information_schema.TABLE_CONSTRAINTS
where CONSTRAINT_SCHEMA = 'MULTI';

desc employee ;
-- ------------------------------------------------------------------
-- NOT NULL
-- '�ΰ� ������� �ʰڴ�.'
drop table USER_NOCONS;

create table USER_NOCONS(
	USER_NO INT,
	USER_ID VARCHAR(20),
	USER_PW VARCHAR(20)
);

select * from USER_NOCONS;

-- ���̺� �� �߰��ϱ�
insert into USER_NOCONS VALUES(1, 'USER01', 'PASS01');
insert into USER_NOCONS VALUES(2, NULL, NULL);

select * from USER_NOCONS;

create table USER_NOT_NULL(
	USER_NO INT not NULL,
	USER_ID VARCHAR(20) not NULL,
	USER_PW VARCHAR(20) not NULL
);

select * from USER_NOT_NULL;
-- ���̺� �� �߰��ϱ�
insert into USER_NOT_NULL VALUES(1, null, 'PASS01');

desc USER_NOT_NULL;
-- ------------------------------------------------------------------
-- UNIQUE �������� --
-- �ߺ��� ������� �ʴ� ���� ����
insert into user_nocons values(3,'USER01','PASS03');
select * from  user_nocons ;

create table USER_UNIQUE(
	USER_NO INT,
	USER_ID VARCHAR(20) unique,
	USER_PW VARCHAR(30)
);

insert into user_unique values(1,'USER01','PASS01');
-- SQL Error [1062] [23000]: Duplicate entry 'USER01' for key 'user_unique.USER_ID'
insert into user_unique values(2,'USER01','PASS02');

select * from user_unique;
desc user_unique;

create table USER_UNIQUE2(
	USER_NO INT,
	USER_ID VARCHAR(20),
	USER_PW VARCHAR(30),
	UNIQUE(USER_ID)
);
-- ------------------------------------------------------------------
-- UNIQUE ���������� ������ �÷��� ����
-- 1 USER01
-- 1 USER02
-- 2 USER01
-- 2 USER02
create table user_unique3(
	USER_NO INT,
	USER_ID VARCHAR(20),
	USER_PW VARCHAR(30),
	unique(USER_NO, USER_ID)
); 
insert into user_unique3 values(1,'USER01','PASS01');
insert into user_unique3 values(1,'USER02','PASS02');
insert into user_unique3 values(2,'USER01','PASS01');
insert into user_unique3 values(2,'USER02','PASS02');

select *from user_unique3;
-- ------------------------------------------------------------------
-- �������ǿ� �̸� ����
show keys from employee;
select *from information_schema.TABLE_CONSTRAINTS ;

create table CONS_NAME(
	TEST_DATA1 INT,
	TEST_DATA2 VARCHAR(20) unique,
	TEST_DATA3 VARCHAR(20),
	constraint UK_CONSMAME_DATA3 unique(TEST_DATA3) -- �������� �̸� �����ֱ�
);
-- ------------------------------------------------------------------
-- CHECK ��������
-- ������ �� �̿ܿ��� ���� ��ϵ��� �ʵ��� ������ �����ϴ� ����.
create table USER_CHECK(
	USER_NO INT,
	USER_ID VARCHAR(20),
	USER_PW VARCHAR(20),
	GENDER VARCHAR(3) check(GENDER in ('��','��'))
);

insert INTO USER_CHECK VALUES(1,'USER01','PASS01','��');
-- SQL Error [3819] [HY000]: Check constraint 'user_check_chk_1' is violated.
insert INTO USER_CHECK VALUES(2,'USER02','PASS02','����');
-- SQL Error [3819] [HY000]: Check constraint 'user_check_chk_1' is violated.
insert INTO USER_CHECK VALUES(2,'USER02','PASS02','F');

insert INTO USER_CHECK VALUES(2,'USER02','PASS02','��');

-- CHECK �������ǿ� �ε�ȣ
create table TEST_CHECK2(
	TEST_DATA INT,
	constraint CK_TEST_DATA CHECK(TEST_DATA > 0)
);
insert into test_check2 VALUES(10);
-- SQL Error [3819] [HY000]: Check constraint 'CK_TEST_DATA' is violated.
insert into test_check2 VALUES(-10);

create table test_check3(
	C_NAME VARCHAR(15),
	C_PRICE INT,
	C_DATE DATE,
	C_QUAL VARCHAR(1),
	CHECK(C_PRICE between 1 AND 999999),
	CHECK(C_DATE >= '2010-10-01'),
	CHECK(C_QUAL >= 'A' and C_QUAL<='D')
);

-- �ϳ��� �÷��� �������� ������
create table TEST_CONS(
	TEST_NO INT not null unique
);
-- ------------------------------------------------------------------
-- PRIMARY KEY �������� '�⺻Ű ��������'
-- ���̺� ���� �� �࿡�� �� ���� �ĺ��ϱ� ���� �������� ������ �÷��� NOT NULL�� UNIQUE ��������� �Բ� �ɾ��ִ� �ĺ��� ������ �����Ű�� ��������.
create table USER_PK_TABLE(
	USER_NO INT primary key,
	USER_ID VARCHAR(20) unique,
	USER_PW VARCHAR(20) not null,
	GENDER VARCHAR(30) CHECK(GENDER in('��','��'))
);
desc user_pk_table;

insert into user_pk_table VALUES(1, 'USER01','PASS01','��');
insert into user_pk_table VALUES(2, 'USER02','PASS02','��');

-- SQL Error [1062] [23000]: Duplicate entry '2' for key 'user_pk_table.PRIMARY'
insert into user_pk_table VALUES(2, 'USER03','PASS03','��');
-- SQL Error [1048] [23000]: Column 'USER_NO' cannot be null
insert into user_pk_table VALUES(NULL, 'USER03','PASS03','��');

create table user_pk_table2(
	USER_NO INT,
	USER_ID VARCHAR(20) unique,
	USER_PW VARCHAR(30) not null,
	GENDER VARCHAR(15) CHECK(GENDER in('��','��')),
	constraint PK_USER_NOID primary KEY(USER_NO,USER_ID)
); 

insert into user_pk_table2 values (1,'USER01');
-- 1, USER01 --> ����
-- 2, USER02 --> ����
-- 3, USER03 --> ����
-- 2, USER01 --> ����

-- CREATE : ����
-- DROP : ����
drop table member;

-- FOREIGN KEY : �ܷ�Ű, �ܺ�Ű, ����Ű
-- �ٸ� ���̺��� �÷����� �����Ͽ� �����ϴ� ���̺��� ������ ����Ѵ�. (PRIMARY KEY��)

create table USER_GRADE(
	GRADE_CODE INT primary key,
	GRADE_NAME VARCHAR(30) not null
);


insert into USER_GRADE VALUES(1,'�Ϲ�ȸ��');
insert into USER_GRADE VALUES(2,'VIP');
insert into USER_GRADE VALUES(3,'VVIP');
insert into USER_GRADE VALUES(4,'VVVIP');


select *from user_grade;

create table USER_FOREIGN_KEY(
	USER_NO INT primary key,
	USER_ID VARCHAR(20),
	USER_PW VARCHAR(20),
	GENDER VARCHAR(1) CHECK(GENDER in('M','F')),
	GRADE_CODE INT,
	constraint FK_GRADE_CODE foreign key(GRADE_CODE)
	references USER_GRADE(GRADE_CODE)
);

insert into USER_FOREIGN_KEY VALUES(1,'123','321','F',2);
insert into USER_FOREIGN_KEY VALUES(2,'ABC','ABC1','M',4);
insert into USER_FOREIGN_KEY VALUES(3,'456','654','M',1);
insert into USER_FOREIGN_KEY VALUES(4,'DEF','DEF1','F',3);
insert into USER_FOREIGN_KEY VALUES(5,'QWE','QWE1','F',1);

select * from user_foreign_key;

-- SQL Error [1452] [23000]: Cannot add or update a child row: a foreign key constraint fails
insert into USER_FOREIGN_KEY VALUES(6,'QWE','QWE1','F',10);

select *from user_foreign_key
join user_grade USING(GRADE_CODE);

select *from USER_GRADE;
select *from user_foreign_key;

-- SQL Error [1451] [23000]: Cannot delete or update a parent row: a foreign key constraint fails
delete from user_grade
where GRADE_CODE = 4;
-- ------------------------------------------------------------------
-- ���� �ɼ�
-- ON DELETE CASCADE : �ڽ� ���̺��� �����͵� ����.
drop table user_foreign_key;

create table USER_FOREIGN_KEY(
	USER_NO INT primary key,
	USER_ID VARCHAR(20),
	USER_PW VARCHAR(20),
	GENDER VARCHAR(1) CHECK(GENDER in('M','F')),
	GRADE_CODE INT,
	constraint FK_GRADE_CODE foreign key(GRADE_CODE)
	references USER_GRADE(GRADE_CODE) on delete CASCADE
);

insert into USER_FOREIGN_KEY VALUES(1,'123','321','F',2);
insert into USER_FOREIGN_KEY VALUES(2,'ABC','ABC1','M',4);
insert into USER_FOREIGN_KEY VALUES(3,'456','654','M',1);
insert into USER_FOREIGN_KEY VALUES(4,'DEF','DEF1','F',3);
insert into USER_FOREIGN_KEY VALUES(5,'QWE','QWE1','F',1);

select *from USER_GRADE;
select *from user_foreign_key;

delete from user_grade where GRADE_CODE = 4;
-- ------------------------------------------------------------------
-- ON UPDATE CASCADE

-- SQL Error [1451] [23000]: Cannot delete or update a parent row: a foreign key constraint fails
update user_grade set GRADE_CODE = 10 where grade_code = 1;

drop table user_foreign_key;

create table USER_FOREIGN_KEY(
	USER_NO INT primary key,
	USER_ID VARCHAR(20),
	USER_PW VARCHAR(20),
	GENDER VARCHAR(1) CHECK(GENDER in('M','F')),
	GRADE_CODE INT,
	constraint FK_GRADE_CODE foreign key(GRADE_CODE)
	references USER_GRADE(GRADE_CODE) on delete cascade on update cascade
);

insert into USER_FOREIGN_KEY VALUES(1,'123','321','F',2);
-- insert into USER_FOREIGN_KEY VALUES(2,'ABC','ABC1','M',4);
insert into USER_FOREIGN_KEY VALUES(3,'456','654','M',1);
insert into USER_FOREIGN_KEY VALUES(4,'DEF','DEF1','F',3);
insert into USER_FOREIGN_KEY VALUES(5,'QWE','QWE1','F',1);

select *from USER_GRADE;
select *from user_foreign_key;

update user_grade set GRADE_CODE = 10 where grade_code = 1;
-- ------------------------------------------------------------------
































