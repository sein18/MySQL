-- DDL
-- CREATE TABLE
-- 제약조건

-- 테이블 생성
drop table MEMBER;
create table MEMBER(
	MEMBER_NO INT,    -- 회원 번호
	MEMBER_ID VARCHAR(20), -- 회원 아이디
	MEMBER_PW VARCHAR(20), -- 회원 비밀번호
	MEMBER_NAME VARCHAR(15) COMMENT '회원이름'
);
desc member;

select *from member;

-- 제약조건(CONSTRAINTS)
-- 테이블 성성 할떄 컬럼에 값을 기록하는 것에 대한 제약사항을 설정 조건.
-- NOT NULL : NULL값 허용하지 않는다. (필수 입력 사항)
-- UNIQUE : 중복 값 허용하지 않는다.
-- CHECK : 지정한 입력사항 외에는 받지 못하게 막는 조건.
-- PRIMARY KEY : NOT NULL + UNIQUE 테이블 내애서 해당 행을 인식할 수 있는 고유 겂.
-- FOREIGN KEY : 다른 테이블에서 저장된 값을 연결 지어서 참조로 가져오는 데이터에 지정하는 제약조건

select *from information_schema.TABLE_CONSTRAINTS
where CONSTRAINT_SCHEMA = 'MULTI';

desc employee ;
-- ------------------------------------------------------------------
-- NOT NULL
-- '널값 허용하지 않겠다.'
drop table USER_NOCONS;

create table USER_NOCONS(
	USER_NO INT,
	USER_ID VARCHAR(20),
	USER_PW VARCHAR(20)
);

select * from USER_NOCONS;

-- 테이블에 값 추가하기
insert into USER_NOCONS VALUES(1, 'USER01', 'PASS01');
insert into USER_NOCONS VALUES(2, NULL, NULL);

select * from USER_NOCONS;

create table USER_NOT_NULL(
	USER_NO INT not NULL,
	USER_ID VARCHAR(20) not NULL,
	USER_PW VARCHAR(20) not NULL
);

select * from USER_NOT_NULL;
-- 테이블에 값 추가하기
insert into USER_NOT_NULL VALUES(1, null, 'PASS01');

desc USER_NOT_NULL;
-- ------------------------------------------------------------------
-- UNIQUE 제약조건 --
-- 중복을 허용하지 않는 제약 조건
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
-- UNIQUE 제약조건을 여러개 컬럼에 적용
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
-- 제약조건에 이름 설정
show keys from employee;
select *from information_schema.TABLE_CONSTRAINTS ;

create table CONS_NAME(
	TEST_DATA1 INT,
	TEST_DATA2 VARCHAR(20) unique,
	TEST_DATA3 VARCHAR(20),
	constraint UK_CONSMAME_DATA3 unique(TEST_DATA3) -- 제약조건 이름 정해주기
);
-- ------------------------------------------------------------------
-- CHECK 제약조건
-- 지정한 값 이외에는 값이 기록되지 않도록 범위를 제한하는 조건.
create table USER_CHECK(
	USER_NO INT,
	USER_ID VARCHAR(20),
	USER_PW VARCHAR(20),
	GENDER VARCHAR(3) check(GENDER in ('남','여'))
);

insert INTO USER_CHECK VALUES(1,'USER01','PASS01','남');
-- SQL Error [3819] [HY000]: Check constraint 'user_check_chk_1' is violated.
insert INTO USER_CHECK VALUES(2,'USER02','PASS02','여자');
-- SQL Error [3819] [HY000]: Check constraint 'user_check_chk_1' is violated.
insert INTO USER_CHECK VALUES(2,'USER02','PASS02','F');

insert INTO USER_CHECK VALUES(2,'USER02','PASS02','여');

-- CHECK 제약조건에 부등호
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

-- 하나의 컬럼에 제약조건 여러개
create table TEST_CONS(
	TEST_NO INT not null unique
);
-- ------------------------------------------------------------------
-- PRIMARY KEY 제약조건 '기본키 제약조건'
-- 테이블 내의 한 행에서 그 행을 식별하기 위한 고유값을 가지는 컬럼에 NOT NULL과 UNIQUE 재약조건을 함께 걸어주는 식별자 역할을 수행시키는 제약조건.
create table USER_PK_TABLE(
	USER_NO INT primary key,
	USER_ID VARCHAR(20) unique,
	USER_PW VARCHAR(20) not null,
	GENDER VARCHAR(30) CHECK(GENDER in('남','여'))
);
desc user_pk_table;

insert into user_pk_table VALUES(1, 'USER01','PASS01','남');
insert into user_pk_table VALUES(2, 'USER02','PASS02','여');

-- SQL Error [1062] [23000]: Duplicate entry '2' for key 'user_pk_table.PRIMARY'
insert into user_pk_table VALUES(2, 'USER03','PASS03','여');
-- SQL Error [1048] [23000]: Column 'USER_NO' cannot be null
insert into user_pk_table VALUES(NULL, 'USER03','PASS03','여');

create table user_pk_table2(
	USER_NO INT,
	USER_ID VARCHAR(20) unique,
	USER_PW VARCHAR(30) not null,
	GENDER VARCHAR(15) CHECK(GENDER in('남','여')),
	constraint PK_USER_NOID primary KEY(USER_NO,USER_ID)
); 

insert into user_pk_table2 values (1,'USER01');
-- 1, USER01 --> 성공
-- 2, USER02 --> 성공
-- 3, USER03 --> 성공
-- 2, USER01 --> 실패

-- CREATE : 생성
-- DROP : 삭제
drop table member;

-- FOREIGN KEY : 외래키, 외부키, 참조키
-- 다른 테이블의 컬럼값을 참조하여 참조하는 테이블의 값만을 허용한다. (PRIMARY KEY만)

create table USER_GRADE(
	GRADE_CODE INT primary key,
	GRADE_NAME VARCHAR(30) not null
);


insert into USER_GRADE VALUES(1,'일반회원');
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
-- 삭제 옵션
-- ON DELETE CASCADE : 자식 테이블의 데이터도 삭제.
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
































