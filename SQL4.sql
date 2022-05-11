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
	unique(USER_NO, USER_ID) -- 두개가 한번에
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
 
insert into user_pk_table2 values (1,'USER01','231','남');
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
insert into USER_FOREIGN_KEY VALUES(3,'456','654','M',10);
insert into USER_FOREIGN_KEY VALUES(4,'DEF','DEF1','F',3);
insert into USER_FOREIGN_KEY VALUES(5,'QWE','QWE1','F',10);

select *from USER_GRADE;
select *from user_foreign_key;

update user_grade set GRADE_CODE = 1 where grade_code = 10;
-- ------------------------------------------------------------------
-- 기본값 설정하기
drop table default_table;
create table default_table(
	data_col1 varchar(30) default '없음',
	data_col2 date default (CURRENT_DATE),
	data_col3 DATETIME default (CURRENT_TIME)
);
insert into default_table values(default,default,default);

select *from default_table;
-- ------------------------------------------------------------------
-- DDL - ALTER
-- ALTER : 수정
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

-- INSERT 새로운 로우(행)를 특정 테이블에 추가하는 명령이다.
desc employee;

-- 컬럼 명시
insert into employee (EMP_ID, EMP_NAME, EMP_NO, EMAIL,PHONE, DEPT_CODE,JOB_CODE,SAL_LEVEL,SALARY,
					BONUS,MANAGER_ID,HIRE_DATE,ENT_DATE,ENT_YN)
				VALUES(500,'이차진','700101-1234567','LEE@NAVER.COM','01011111111','D1','J7','S4',
					3100000,0.1,'200',now(),null, default);

select *from employee 
where EMP_NAME = '이차진';

-- 컬럼 생략 (모든 컬럼에 값 추가)
insert into employee values(900,'오민섬','510101-1234567','park@NAVER.COM','01011111111','D1','J4','S3',
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
-- UPDATE : 해당 테이블의 데이터를 수정하는 명령어
create table DEPT_COPY 
as select * from department;

select *from dept_Copy;

update DEPT_COPY set DEPT_TITLE = '전략기획부로' where DEPT_ID = 'D9';

-- EMPLOYEE 주민번호 잘못 표기된 데이터.
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
-- 테이블의 행을 삭제하는 명령어

create table TEST_DELETE as select *from employee;

select *from test_delete;

-- DELETE를 통해 전체 삭제
delete from test_delete;
-- ------------------------------------------------------------------
drop table DEPT_COPY;

create table DEPT_COPY as select *from department;

select *from dept_copy;
-- 컬럼 추가
alter table DEPT_COPY add (LNAME VARCHAR(20));
-- 컬럼 삭제
alter table DEPT_COPY drop column LNAME;
-- 컬럼 추가(기본값을 적용하여 추가)
alter table DEPT_COPY add (LNAME VARCHAR(20) default '한국');

alter table DEPT_COPY add CONSTRAINT PK_DEPTCOPY primary key(DEPT_ID);

desc dept_copy ;

-- select(연산자,함수) CREATE INSERT, UPDATE, DELETE, DROP, ALTER
-- ------------------------------------------------------------------
-- TCL
-- COMMIT, ROLLBACK (+SAVEPOINT, ROLLBACK TO)

-- 트랜잭션 : 데이터를 처리하는 최소 단위.
-- 하나의 트랜잭션을 이루어진 작업은 반드시 작업 내용이 모두 성공하여 저장되거나, 실패하여 모두 이전으로 복구되어야 한다.
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

commit; -- 현재까지 작업한 DML내용을 DB에 반영한다.

insert into USER_TBL values(3,'TEST03','PASS03');

select *from USER_TBL;

rollback; -- 가장 최근에 COMMIT했던 구간으로 되돌아 가겠다.

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
-- VIEW(뷰) --

-- CREATE VIEW 뷰이름
-- AS 서브쿼리(뷰에서 확인할 SELECT 쿼리)

create view V_EMP
as select EMP_ID,EMP_NAME,DEPT_CODE from EMPLOYEE;

select *from V_EMP;


-- 사번, 이름, 직급명, 부서명, 근무지역을 조회
-- 그 결과를 V_RES_EMP 라는 뷰를 만들고 헤당 뷰를 통해 결과 조회

-- 1) 서브쿼리 준비
select EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
from employee
left join JOB USING(JOB_CODE)
left join department on(DEPT_CODE = DEPT_ID)
left join location on(LOCATION_ID =LOCAL_CODE);

-- 2) 뷰 생성
create or replace view V_RES_EMP(사번,이름,직급,부서명,근무지)
as select EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
from employee
left join JOB USING(JOB_CODE)
left join department on(DEPT_CODE = DEPT_ID)
left join location on(LOCATION_ID =LOCAL_CODE);

select *from V_RES_EMP;
-- 8문제 , 9일 제출 (메모장으로 제출)

show create view V_RES_EMP;

-- 만들어진 VIEW(V_RES_EMP)를 활용하여 사번이 '205'인 직원 정보 조회하기.

select * from V_RES_EMP
where TKQJS = '205';

commit;
-- 뷰 삭제
drop view V_RES_EMP;
-- 컬럼별 별칭을 붙일 수 있다.
create or replace view V_EMP(사번, 사원명, 부서코드)
as 
select EMP_ID,EMP_NAME ,DEPT_CODE 
from EMPLOYEE;
-- 뷰에서 연산,함수 결과도 포함하여 저장 가능.

-- 사번, 이름, 성별, 근무년수 조회
-- 1)
select EMP_ID,EMP_NAME,
	IF(SUBSTR(EMP_NO,8,1)=1,'남성','여성'),
	extract(year from NOW()) - extract(year from HIRE_DATE)
from employee;
-- 2)
create or replace view V_EMP(사번, 이름, 성별, 근무년수)
as 
select EMP_ID,EMP_NAME,
	IF(SUBSTR(EMP_NO,8,1)=1,'남성','여성'),
	extract(year from NOW()) - extract(year from HIRE_DATE)
from employee;

select *from V_EMP;

-- 뷰에 데이터 삽입, 수정 삭제하기
create or replace view V_JOB
as
select *from JOB;

select *from V_JOB;
select *from JOB;

-- 뷰를 통한 데이터 추가
insert into V_JOB values ('J8','인턴');
-- 뷰를 통해 데이터 수정도 가능
update V_JOB
set JOB_NAME = '알바'
where JOB_CODE = 'J8';
-- 뷰를 통해 데이터 삭제도 가능
delete from V_JOB
where JOB_CODE='J8';
-- ------------------------------------------------------------------
-- AUTO_INCREMENT
-- INSERT 할때 마다 자동으로 1씩 증가.
create table AT_TEST(
	ID INT auto_increment primary key,
	NAME VARCHAR(30)
);

select *from AT_TEST;
desc AT_TEST;

insert into AT_TEST values(1,'홍길동');
insert into AT_TEST values(11,'김유신');

insert into AT_TEST values(null,'고길동');
insert into AT_TEST values(null,'유관순');
insert into AT_TEST (NAME) values('신사임당');
select *from AT_TEST;

-- 현재 어느 숫자까지 증가 되었는지 확인
select LAST_INSERT_ID();
-- 변경
alter table AT_TEST auto_increment = 50;
select *from AT_TEST;
insert into AT_TEST (NAME) values('신사임당');

set @@AUTO_INCREMENT_INCREMENT=1; -- STATIC 느낌이 든다.
insert into AT_TEST (NAME) values('신사임당');

select *from AT_TEST;

create table AT_TEST2(
	ID INT auto_increment primary key,
	NAME VARCHAR(30) 
);

insert into at_test2 VALUES(null,'A');
insert into at_test2 VALUES(null,'B');
select *from AT_TEST2;


















