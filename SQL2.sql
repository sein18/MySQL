-- CRUD : 데이터 기본 처리 로직
-- CREATE	: 데이터 추가 / INSERT
-- READ 	: 데이터 조회 / SELECT
-- UPDATE	: 데이터 수정 / UPDATE
-- DELETE	: 데이터 삭제 / DELETE 

-- --------------------------------------------------------
-- SELECT : 조회용 SQL 

-- SELECT *(조회컬럼)
-- FROM 테이블명
-- WHERE 조건
-- ORDER BY 컬럼 ;
-- --------------------------------------------------------
-- 컬럼에 별칭 달기
-- 1. AS 표현
select EMP_ID as "사원 번호", EMP_NAME as "사원 명"
from employee ;

-- 2. AS 생략
select EMP_ID "사원 번호", EMP_NAME '사원 명'
from employee ;
-- --------------------------------------------------------
select emp_name "사원명",	
		(salary * 12) "연봉",
		bonus "보너스",
		(SALARY + (SALARY * BONUS))* 12 "연봉총합"
from employee;

-- IFNULL() : 만약 현재 조회하는 값이 NULL이면 지정한 값으로 변경
select emp_name "사원명",	
		(salary * 12) '연봉', '원' 단위,
		ifnull(bonus,0)  보너스,
		(SALARY + (SALARY * IFNULL(BONUS, 0)))* 12 "연봉총합"
from employee;
-- --------------------------------------------------------
-- DISTINCT 중복을 제거 하고 한 개만 조회
select EMP_NAME, DEPT_CODE
from employee;

select distinct DEPT_CODE
from employee;
-- --------------------------------------------------------
-- 실습 1. DEPARTMENT 테이블을 참조하여, 부서가 '해외영업2부'인 부서의 부서코드를 찾고, 
-- EMPLOYEE테이블에서 해당 부서의 사원들 중 급여를 200만원보다 많이 받는 직원의 사번, 사원명, 급여를 조회하시오.
-- 1) '해외영업2부' 부서의 부서코드 조회
select *from department 
where DEPT_TITLE ='해외영업2부'; -- D6
-- 2) 직원 조회
select *from employee ;

select EMP_ID 사번,
		EMP_NAME 사원명,
		SALARY 급여
from employee
where DEPT_CODE = 'D6'
	and SALARY > 2000000
	order by SALARY ;
-- --------------------------------------------------------
-- 연산자 --
-- <, >, <=, >= : 크기를 나타네는 부등호
-- = : 같다
-- !=, <> : 같지 않다.
-- --------------------------------------------------------
-- EMPLOYEE 테이블에서 부서코드가 'D9'이 아닌 직원들의 모든 정보를 조회
select * from employee 
-- where DEPT_CODE !='D9';
where DEPT_CODE <>'D9';
-- --------------------------------------------------------
-- 급여가 350만원 이상, 550만원 이하인 직원의 사번, 사원명, 부서코드, 직급코드, 급여정보 조회
-- 1.
select EMP_ID ,EMP_NAME ,DEPT_CODE ,JOB_CODE ,SALARY  
from employee
where SALARY >=3500000 
  and SALARY <=5500000; 
-- 2. BETWEEN A AND B 
select EMP_ID ,EMP_NAME ,DEPT_CODE ,JOB_CODE ,SALARY  
from employee
where SALARY between 3500000 and 5500000;
-- --------------------------------------------------------
-- LIKE
-- 입력한 숫자, 문자가 포함된 정보를 조회할 때 사용하는 연산자.
-- '_' : 임의의 한 문자
-- '%' : 
-- 사원의 이름에 가운데 글자가 '중'인 사원 정보 조회
select *
from employee 
where EMP_NAME like '_중_';
-- 주민등록번호(EMP_NO) 기준 남성인 사원의 정보만 조회
select *
from employee
where EMP_NO like '______-1%';
-- 사원 중 이메일 아이디가 5글지 이상인 사원의 사원명 사번 이메일 조회
select EMP_NAME, EMP_ID ,EMAIL 
from employee 
where EMAIL like '_____%@%';
-- 사원 중 이메일 4번째 글자가 '_'인 사원의 정보 조회
-- ESCAPE문자를 선언. 뒤에는 문자를 특수문자가 아닌 
-- 일반 문자로 선언하여 사용.
select *
from employee 
where EMAIL like '___#_%@%' escape '#';
-- --------------------------------------------------------
-- IN 연산자
-- IN(값1, 값2,값3, ...)
-- WHERE JOB_CODE = 'J1' OR JOB_CODE' = 'J4'

-- 직급코드가 J1이거나 J4인 직원 정보 조회
select *from employee 
where JOB_CODE in('J1', 'J4');

select *from employee 
where JOB_CODE not in('J1', 'J4');
-- --------------------------------------------------------
-- 함수(FUNCTION)

-- LENGTH, CHAR_LENGTH
-- 문자열의 길이를 계산하는 함수
-- LENGTH : BYTE 길이(영어 1, 한굴 3)
-- CHAR_LENGTH : 글자 수
select length('Hello'), char_length('Hello');
select length('박세인'), char_length('박세인');
-- --------------------------------------------------------
-- INSTR : 주어진 값에서 원하는 문자가 몇번째안지 찾아 반환하는 함수
select instr('ABCD','A'),
	   instr('ABCD','C'),
	   instr('ABCD','Z'), 
	   instr('ABCDEF','CD');

-- SUBSTR() : 주어진 문자열에서 특정 부분만 꺼내 오는 함수
select 'Hello World',
		substr('Hello World',1,5),
		substr('Hello World',7);

-- 실습2.
-- EMPLOYEE 테이블에서 사원들의 이름, 이메일 주소를 조회. 단, 이메일은 아이디 부분만 조회
select EMP_NAME '이름', substr(EMAIL,1,instr(EMAIL,'@')-1) 'ID' from employee ; 
-- --------------------------------------------------------
-- LPAD/ RPAD
-- 빈칸을 지정한 문자로 채우는 함수
select lpad(EMAIL,20,'#') from employee ;
select RPAD(EMAIL,20,'#') from employee ;
-- --------------------------------------------------------
-- TRIM
-- LTRIM/RTRIM : 공백만 찾아 지워주는 함수
select ltrim('   HELLO'), rtrim('HELLO     ');

-- TRIM : 양끝을 기준으로 특정 문자를 지워주는 함수
select TRIM('   5교시     ');

select TRIM('0' from '00012300');
-- LEADING/ TRAILING
select TRIM(leading '0' from '00012300');
select TRIM(trailing  '0' from '00012300');
select TRIM(both '0' from '00012300'); 
-- --------------------------------------------------------
-- CONCAT : 여러 문자열을 하나의 문자열로 합치는 함수
select concat('마이에스큐엘',' 너무너무 재밌어요:)'); 
-- --------------------------------------------------------
-- REPLACE : 주어진 문자열에서 특정 문자를 변겅할 때 사용하는 함수
select replace ('HELLO WORLD', 'HELLO', 'BYE');

-- 실습3 EMPLOYEE 테이블에서 모든 사원의 사번, 사원명, 이메일, 주민번호를 조회
-- 이 때, 이메일은 '@' 전까지, 주민번호는 7번째 자리이후'*'처리하여 조회
select EMP_ID '사번', 
	EMP_NAME '이름', 
	substr(EMAIL,1,instr(EMAIL,'@')-1) '이메일', 
	rpad(substr(EMP_NO,1,8),14,'*') '주민번호' 
from employee;
-- --------------------------------------------------------
-- EMPLOYEE 테이블에서 현재 근무하는 여성 사원의 사번, 사원명,직급 코드를 조회
-- EMT_YN : 퇴사 여부(Y면 퇴사했다) WHERE 절에도 함수 사용 가능

-- 단일행 함수 : 결과 찾아서 출력할 때마다 (각 행마다) 함수 적용
select EMP_ID ,EMP_NAME ,JOB_CODE ,ENT_YN  
from employee
where ENT_YN ='N'
and substr(EMP_NO,8,1) = '2'; 
-- 다중행 함수 : 조건에 만족하는 모든 행을 찾고 나서 한번에 연산
-- 그룹 함수 : SUM(), AVG(), MAX(), MIN(), COUNT()

select SUM(SALARY), avg(SALARY), MAX(SALARY), MIN(SALARY)
from employee;

-- EMPLOYEE 테이블에서 '해외영업1부'에 근무하는 모든 사원의 평균 급여, 가장 높은 급여, 가장 낮은 급여, 급여 합계 조회
select AVG(SALARY), MAX(SALARY), MIN(SALARY), SUM(SALARY) 
from employee 
where DEPT_CODE ='D5'; 

-- COUNT(컬럼명) : 행의 갯수, NULL은 카운트X
select COUNT(*),COUNT(DEPT_CODE), count(distinct DEPT_CODE)  
from employee ;
-- --------------------------------------------------------
-- 날짜 처리 함수
-- SYSDATE() 함수가 실행될 때 시간, NOW() 쿼리 시작 시간 : 현재 컴퓨터의 날짜를 반환.

select  sysdate(), now();
select now(),sleep(5), sysdate();  
select now(),sleep(5), now();  
-- --------------------------------------------------------
-- 두 날짜 사이의 차
-- DATEDIFF : 단순 일 차이
-- TIMESTAMPDIFF : 연, 분기, 월, 주, 일, 시, 분, 초를 지정하여 차이

select HIRE_DATE 입사일,
	 datediff(now(), HIRE_DATE)+1
from employee;

select HIRE_DATE 입사일,
	TIMESTAMPDIFF(year, HIRE_DATE, NOW())
from employee;
-- SECOND: 초, MINUTE: 분, HOUR: 시, DAY : 일
-- WEEK: 주, MONTH: 월, QUARTER: 분기, YEAR: 년
-- --------------------------------------------------------
-- EXTRACT(YEAR | MONTH | DAY FROM 날짜)
select hire_date, 
	extract(year from hire_date),
	extract(month from hire_date),
	extract(day from hire_date)		
from employee;

-- DATE_FORMAT()
-- 날짜 종보 변경
select hire_date, 
	date_format(HIRE_DATE,'%Y%m%d%H%i%s'),
	date_format(HIRE_DATE,'%Y/%m/%d/ %H:%i:%s'),
	date_format(HIRE_DATE,'%y/%m/%d/ %H:%i:%s'),
	date_format(now() ,'%y/%m/%d/ %H:%i:%s')
	from employee;
-- STR_TO_DATE(CHAR,FORMAT)
select 20190322,
	STR_TO_DATE('20190322','%Y%m%d'),
	STR_TO_DATE('190322','%y%m%d'),
	STR_TO_DATE( 190322,'%y%m%d');
-- --------------------------------------------------------
-- IF(조건, 값, 값)
-- 현재 근무하는 직원들의 성별을 남, 여 구분짓기
select EMP_NAME,
	EMP_NO,
	if(substr(EMP_NO,8,1) = 1,'남','여') '성별'
from employee;

-- 실습 4
-- EMPLOYEE 테이블에서 모든 직원의 사번, 사원명, 부서코드, 직급코드, 근무여부, 관리자 여부를 조회.
-- 이때, 근무여부(ENT_YN)가 'Y' 퇴사자,'N' 근무자
-- 	관리자 사번(MANAGER_ID)있으면 사원, 없으면 관리자.
select EMP_ID '사번',
	EMP_NAME '사원명', 
	DEPT_CODE '부서코드',
	SAL_LEVEL '직급코드',
	if(ENT_YN='Y','퇴사자','근무자')'근무 여부',
	IF(MANAGER_ID ,'사원','관리자') '관리자 여부'
from employee;
-- --------------------------------------------------------
-- CASE
-- 자바의 IF, SWITCH처럼 사용 가능

-- CASE
-- WHEN 조건식1 THEN 결과값1
-- WHEN 조건식2 THEN 결과값2
-- ELSE 결과값3
-- END

select EMP_ID '사번',
	EMP_NAME '사원 명',
	DEPT_CODE '부서코드',
	JOB_CODE '직급코드',
	case 
		when ENT_YN = 'Y' then '퇴사자'
		else '근무자'
	end '근무 여부',
	case 
		when MANAGER_ID is null then '관리자'
		else '사원'
	end '관리자 여부'
	from employee;
-- --------------------------------------------------------
-- [1] 직급이 'J2'이면서 200만원 이상 받는 직원이거나, 직급이'J7'인 사원의 사번, 사원명, 직급코드, 급여 정보 조회하기
select EMP_ID '사번',
	EMP_NAME '사원 명',
	JOB_CODE '직급 코드',
	SALARY '급여'
from employee
where (JOB_CODE ='J2'and SALARY >= 2000000) 
	or JOB_CODE ='J7';
-- --------------------------------------------------------
-- [2] EMPLOYEE 테이블에서 사원의 주민 번호를 확인하여 생년 월 일을 각각 조회하시오.
select EMP_NAME '이름',
	concat(substr(EMP_NO,1,2),'년') '생년',  
	concat(substr(EMP_NO,3,2),'월') '생월',  
	concat(substr(EMP_NO,5,2),'일') '생일'  
from employee; 
-- --------------------------------------------------------
-- 1. 부서코드가 D5, D9인 직원들 중에서 2004년도에 입사한 직원의 수 조회함.
--   사번 사원명 부서코드 입사일
select EMP_ID '사번', 
	EMP_NAME '사원명',
	DEPT_CODE '부서코드',
	HIRE_DATE '입사일' 
from employee
where DEPT_CODE IN('D5','D9') and extract(year from hire_date) ='2004';
-- --------------------------------------------------------
-- 2. 직원명, 입사일, 입사한 달의 근무일수 조회
--   단, 주말도 포함함 ( LAST_DAY() : 주어진 날짜의 해당월의 마지막 날 반환)
select EMP_NAME '직원 명', 
	HIRE_DATE '입사일', 
datediff(last_day(HIRE_DATE),HIRE_DATE)  '입사한 달의 근무일수' 
from employee;
-- --------------------------------------------------------
-- 3.*** 직원명, 부서코드, 생년월일, 나이 조회
--   단, 생년월일은 주민번호에서 추출해서 ㅇㅇ년 ㅇㅇ월 ㅇㅇ일로 출력되게 함.
--   나이는 주민번호에서 추출해서 날짜데이터로 변환한 다음, 계산함
select from employee;
select EMP_NAME '직원명',
	DEPT_CODE '부서코드',
	date_format(concat('19',substr(EMP_NO,1,6)),'%y년 %m월 %d일') '생년월일',
	TIMESTAMPDIFF(year,STR_TO_DATE(concat('19',substr(EMP_NO,1,6)),'%Y%m%d') ,now()) '나이' 
from employee;
-- --------------------------------------------------------
-- 4. 부서코드가 D5이면 총무부, D6이면 기획부, D9이면 영업부로 처리하시오.
--   단, 부서코드가 D5, D6, D9 인 직원의 정보만 조회함
--  => case 사용
-- 사원명, 부서코드, 부서명
select EMP_NAME 사원명,
	DEPT_CODE 부서코드,
	case 
		when DEPT_CODE = 'D5' then '총무부'
		when DEPT_CODE = 'D6' then '기획부'
		when DEPT_CODE = 'D9' then '영업부'
	end '근무 여부'
from employee
where DEPT_CODE ='D5' or DEPT_CODE ='D6' or DEPT_CODE ='D9';

-- --------------------------------------------------------
select *from employee ;
































