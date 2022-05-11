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
	unique(USER_NO, USER_ID) -- �ΰ��� �ѹ���
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
 
insert into user_pk_table2 values (1,'USER01','231','��');
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
insert into USER_FOREIGN_KEY VALUES(3,'456','654','M',10);
insert into USER_FOREIGN_KEY VALUES(4,'DEF','DEF1','F',3);
insert into USER_FOREIGN_KEY VALUES(5,'QWE','QWE1','F',10);

select *from USER_GRADE;
select *from user_foreign_key;

update user_grade set GRADE_CODE = 1 where grade_code = 10;
-- ------------------------------------------------------------------
-- �⺻�� �����ϱ�
drop table default_table;
create table default_table(
	data_col1 varchar(30) default '����',
	data_col2 date default (CURRENT_DATE),
	data_col3 DATETIME default (CURRENT_TIME)
);
insert into default_table values(default,default,default);

select *from default_table;
-- ------------------------------------------------------------------
-- DDL - ALTER
-- ALTER : ����
alter table department add constraint PK_DEPT_DEPRID primary KEY(DEPT_ID);

alter table employee add constraint foreign key(DEPT_CODE) references DEPARTMENT(DEPT_ID);
alter table employee add constraint foreign KEY(SAL_LEVEL) references SAL_GRADE(SAL_LEVEL);

alter table employee add CHECK(ENT_YN in('Y','N'));
alter table employee add CHECK(SALARY>0);

alter table employee add UNIQUE(EMP_NO);

alter table employee add foreign KEY(JOB_CODE) references JOB(JOB_CODE);

alter table department add foreign KEY(location_ID) references LOCATION(LOCAL_CODE);

alter table location add foreign KEY(national_CODE) references NATIONAL(NATIONAL_CODE);
-- ------------------------------------------------------------------
-- DML
-- SELECT, INSERT, UPDATE, DELETE
-- [CRUD] 
-- C : INSERT
-- R : SELECT
-- U : UPDATE
-- D : DELETE

-- INSERT ���ο� �ο�(��)�� Ư�� ���̺� �߰��ϴ� ����̴�.
desc employee;

-- �÷� ���
insert into employee (EMP_ID, EMP_NAME, EMP_NO, EMAIL,PHONE, DEPT_CODE,JOB_CODE,SAL_LEVEL,SALARY,
					BONUS,MANAGER_ID,HIRE_DATE,ENT_DATE,ENT_YN)
				VALUES(500,'������','700101-1234567','LEE@NAVER.COM','01011111111','D1','J7','S4',
					3100000,0.1,'200',now(),null, default);

select *from employee 
where EMP_NAME = '������';

-- �÷� ���� (��� �÷��� �� �߰�)
insert into employee values(900,'���μ�','510101-1234567','park@NAVER.COM','01011111111','D1','J4','S3',
					4300000,0.2,'200',now(),null, default);

-- INSERT + SUBQAUERY

create table EMP_01(
	EMP_ID INT,
	EMP_NAME VARCHAR(20),
	DEPT_TITLE VARCHAR(40)
);

insert into EMP_01 (select EMP_ID,EMP_NAME,DEPT_TITLE 
					from employee
					left join department on(DEPT_CODE=DEPT_ID)
);

select *from emp_01;
-- ------------------------------------------------------------------
-- UPDATE : �ش� ���̺��� �����͸� �����ϴ� ��ɾ�
create table DEPT_COPY 
as select * from department;

select *from dept_Copy;

update DEPT_COPY set DEPT_TITLE = '������ȹ�η�' where DEPT_ID = 'D9';

-- EMPLOYEE �ֹι�ȣ �߸� ǥ��� ������.
select EMP_ID, EMP_NO
from employee
where SUBSTR(EMP_NO,5,2) > 31;
-- 200, 201, 214

desc employee ;
update employee set EMP_NO = CONCAT('621230',substr(EMP_NO ,7))
where EMP_ID =200;

update employee set EMP_NO = CONCAT('631126',substr(EMP_NO ,7))
where EMP_ID =201;

update employee set EMP_NO = CONCAT('850705',substr(EMP_NO ,7))
where EMP_ID =214;

select EMP_ID ,EMP_NO  
from employee 
where EMP_ID IN('200','201','214');

-- SQL Error [1452] [23000]: Cannot add or update a child row: a foreign key constraint fails
update employee set DEPT_CODE = 'D0' where DEPT_CODE ='D6';

update employee set ENT_YN = default where EMP_ID = 222;
-- ------------------------------------------------------------------
-- DELETE
-- ���̺��� ���� �����ϴ� ��ɾ�

create table TEST_DELETE as select *from employee;

select *from test_delete;

-- DELETE�� ���� ��ü ����
delete from test_delete;
-- ------------------------------------------------------------------
drop table DEPT_COPY;

create table DEPT_COPY as select *from department;

select *from dept_copy;
-- �÷� �߰�
alter table DEPT_COPY add (LNAME VARCHAR(20));
-- �÷� ����
alter table DEPT_COPY drop column LNAME;
-- �÷� �߰�(�⺻���� �����Ͽ� �߰�)
alter table DEPT_COPY add (LNAME VARCHAR(20) default '�ѱ�');

alter table DEPT_COPY add CONSTRAINT PK_DEPTCOPY primary key(DEPT_ID);

desc dept_copy ;

-- select(������,�Լ�) CREATE INSERT, UPDATE, DELETE, DROP, ALTER
-- ------------------------------------------------------------------
-- TCL
-- COMMIT, ROLLBACK (+SAVEPOINT, ROLLBACK TO)

-- Ʈ����� : �����͸� ó���ϴ� �ּ� ����.
-- �ϳ��� Ʈ������� �̷���� �۾��� �ݵ�� �۾� ������ ��� �����Ͽ� ����ǰų�, �����Ͽ� ��� �������� �����Ǿ�� �Ѵ�.
commit;

create table USER_TBL(
	USER_NO INT unique,
	USER_ID VARCHAR(20) not null unique,
	USER_PW VARCHAR(30) not null
);

desc USER_TBL;

insert into USER_TBL values(1,'TEST01','PASS01');
insert into USER_TBL values(2,'TEST02','PASS02');

select *from USER_TBL;

commit; -- ������� �۾��� DML������ DB�� �ݿ��Ѵ�.

insert into USER_TBL values(3,'TEST03','PASS03');

select *from USER_TBL;

rollback; -- ���� �ֱٿ� COMMIT�ߴ� �������� �ǵ��� ���ڴ�.

select *from USER_TBL;

insert into USER_TBL values(3,'TEST03','PASS03');
savepoint SP1;

insert into USER_TBL VALUES(4,'TEST04','PASS04');
select *from USER_TBL;

rollback to SP1;
select *from USER_TBL;

rollback;
select *from USER_TBL;
-- ------------------------------------------------------------------
-- VIEW(��) --

-- CREATE VIEW ���̸�
-- AS ��������(�信�� Ȯ���� SELECT ����)

create view V_EMP
as select EMP_ID,EMP_NAME,DEPT_CODE from EMPLOYEE;

select *from V_EMP;


-- ���, �̸�, ���޸�, �μ���, �ٹ������� ��ȸ
-- �� ����� V_RES_EMP ��� �並 ����� ��� �並 ���� ��� ��ȸ

-- 1) �������� �غ�
select EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
from employee
left join JOB USING(JOB_CODE)
left join department on(DEPT_CODE = DEPT_ID)
left join location on(LOCATION_ID =LOCAL_CODE);

-- 2) �� ����
create or replace view V_RES_EMP(���,�̸�,����,�μ���,�ٹ���)
as select EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
from employee
left join JOB USING(JOB_CODE)
left join department on(DEPT_CODE = DEPT_ID)
left join location on(LOCATION_ID =LOCAL_CODE);

select *from V_RES_EMP;
-- 8���� , 9�� ���� (�޸������� ����)

show create view V_RES_EMP;

-- ������� VIEW(V_RES_EMP)�� Ȱ���Ͽ� ����� '205'�� ���� ���� ��ȸ�ϱ�.

select * from V_RES_EMP
where TKQJS = '205';

commit;
-- �� ����
drop view V_RES_EMP;
-- �÷��� ��Ī�� ���� �� �ִ�.
create or replace view V_EMP(���, �����, �μ��ڵ�)
as 
select EMP_ID,EMP_NAME ,DEPT_CODE 
from EMPLOYEE;
-- �信�� ����,�Լ� ����� �����Ͽ� ���� ����.

-- ���, �̸�, ����, �ٹ���� ��ȸ
-- 1)
select EMP_ID,EMP_NAME,
	IF(SUBSTR(EMP_NO,8,1)=1,'����','����'),
	extract(year from NOW()) - extract(year from HIRE_DATE)
from employee;
-- 2)
create or replace view V_EMP(���, �̸�, ����, �ٹ����)
as 
select EMP_ID,EMP_NAME,
	IF(SUBSTR(EMP_NO,8,1)=1,'����','����'),
	extract(year from NOW()) - extract(year from HIRE_DATE)
from employee;

select *from V_EMP;

-- �信 ������ ����, ���� �����ϱ�
create or replace view V_JOB
as
select *from JOB;

select *from V_JOB;
select *from JOB;

-- �並 ���� ������ �߰�
insert into V_JOB values ('J8','����');
-- �並 ���� ������ ������ ����
update V_JOB
set JOB_NAME = '�˹�'
where JOB_CODE = 'J8';
-- �並 ���� ������ ������ ����
delete from V_JOB
where JOB_CODE='J8';
-- ------------------------------------------------------------------
-- AUTO_INCREMENT
-- INSERT �Ҷ� ���� �ڵ����� 1�� ����.
create table AT_TEST(
	ID INT auto_increment primary key,
	NAME VARCHAR(30)
);

select *from AT_TEST;
desc AT_TEST;

insert into AT_TEST values(1,'ȫ�浿');
insert into AT_TEST values(11,'������');

insert into AT_TEST values(null,'��浿');
insert into AT_TEST values(null,'������');
insert into AT_TEST (NAME) values('�Ż��Ӵ�');
select *from AT_TEST;

-- ���� ��� ���ڱ��� ���� �Ǿ����� Ȯ��
select LAST_INSERT_ID();
-- ����
alter table AT_TEST auto_increment = 50;
select *from AT_TEST;
insert into AT_TEST (NAME) values('�Ż��Ӵ�');

set @@AUTO_INCREMENT_INCREMENT=1; -- STATIC ������ ���.
insert into AT_TEST (NAME) values('�Ż��Ӵ�');

select *from AT_TEST;

create table AT_TEST2(
	ID INT auto_increment primary key,
	NAME VARCHAR(30) 
);

insert into at_test2 VALUES(null,'A');
insert into at_test2 VALUES(null,'B');
select *from AT_TEST2;


















