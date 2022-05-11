-- NOT IN(값,값,값,...)
select EMP_ID, EMP_NAME, DEPT_CODE
from employee
where DEPT_CODE NOT in('D1', 'D5');

-- ABS(값) : 특정 숫자의 절대값 표현.
select abs(10); 

-- MOD() : 주어진 컬럼이나 값을 나눈 나머지를 반환.
select mod(10,3), mod(10,2);

-- ROUND() : 지정한 자리수 부터 반올림.
select round(123.456,0), -- 소수점 첫째자리에서 반올림
	ROUND(123.456,1),
	ROUND(123.456,2),
	ROUND(123.456,-2); -- 10의 자리 반올림
	
-- CEIL() : 소주점 첫째 자리에서 올림.
-- FLOOR() : 소주점 이하 자리를 모두 버림.
select ceil(123.456), floor(123.456); 

-- TRUNCATE() : 지정한 위치까지 숫자를 버리는 함수.
select truncate(123.456,0),
	truncate(123.456,1),  
	truncate(123.456,2),
	truncate(123.456,-2);

-- CEILING(숫자) : 소수점 반올림
select ceiling(4.0),
	ceiling(4.1),
	ceiling(3.9),
	ceiling(3.1); 

select ceiling (-4.0),
	ceiling(-4.1),
	ceiling(-3.9);

-- 실습1.
-- EMPLOYEE테이블에서 입사한 달의 숫자가 홀수 다인 직원의 사번, 사워명, 입사일 정보를 조회
select EMP_ID ,EMP_NAME , HIRE_DATE  
from employee 
where mod(substr(HIRE_DATE, 7,1), 2) = 1;
-- --------------------------------------------------------------------------------------
-- DATE_ADD(날짜, INTERVAL)
-- DATE_SUM(날짜, INTERVAL)

select EMP_NAME ,HIRE_DATE ,
	DATE_ADD(HIRE_DATE, interval 1 DAY)
from employee;

select EMP_NAME ,HIRE_DATE ,
	DATE_SUB(HIRE_DATE, interval 10 YEAR)
from employee;
-- DAYOFWEEK(날짜) : 해당 날짜의 요일 리턴. 1: 일요일, 2: 월요일, 3: 화요일, 4: 수요일 5: 목요일 6: 금요일, 7: 토요일
select dayofweek(NOW());
select EMP_NAME,
	case 
		when DAYOFWEEK(HIRE_DATE) = 1 then '일요일'
		when DAYOFWEEK(HIRE_DATE) = 2 then '월요일'
		when DAYOFWEEK(HIRE_DATE) = 3 then '화요일'
		when DAYOFWEEK(HIRE_DATE) = 4 then '수요일'
		when DAYOFWEEK(HIRE_DATE) = 5 then '목요일'
		when DAYOFWEEK(HIRE_DATE) = 6 then '금요일'
		when DAYOFWEEK(HIRE_DATE) = 7 then '토요일'
	end as '요일'
from employee;

-- LAST_DAY(날짜) : 날짜의 마지막 일자를 조회
select LAST_DAY(now());

-- 실습2.
-- EMPLOYEE 테이블에서 근무년수가 20년 이상인 사원들의 사번, 사원명, 부서코드, 입사일 조회
select EMP_ID ,EMP_NAME ,DEPT_CODE ,HIRE_DATE  
from employee
where DATE_ADD(HIRE_DATE, interval 20 year) <= NOW();
-- --------------------------------------------------------------------------------------
-- 형변환 함수--
-- CAST(), CONVERT() : 주어진 값을 원하는 형식으로 변경.
select cast(20220429 as DATE), convert(20220429,DATE); 
select cast(20200101030330 as CHAR), convert(20200101030330, CHAR); 
select cast(now()  as CHAR), convert(now() , CHAR); 

-- BINARY 이진 데이터
-- CHAR 문자
-- DATE 날짜
-- INTEGER 숫자 (UNSIGNED INTEGER : 양수만)
-- DECIMAL 소수점까지
-- JSON JSON타입

select '123'+'456';
select '123'+'456ABC';
select '123'+'4A56BC';
-- --------------------------------------------------------------------------------------
-- SELECT 문의 실행 순서
/*
 * 5: SELECT 컬럼, 계산삭, 함수식 AS 별칭, ...
 * 1: FROM 테이블명
 * 2: WHERE 조건
 * 3: GROUP BY 그룹을 묶을 컴럼
 * 4: HAVING 그룹에 대한 조건식
 * 6: ORDER BY 컬럼 | 별칭 | 순서
 */
-- --------------------------------------------------------------------------------------
-- ORDER BY
-- SELECT 통해 조회한 행의 결과들을 특정 기준에 맞춰 정렬
select EMP_ID, EMP_NAME 이름, SALARY, DEPT_CODE  
from employee
-- order by EMP_NAME ASC;
-- order by DEPT_CODE desc, EMP_ID;
-- order by 이름 desc;
order by 3 desc; -- :컬럼 순서
-- --------------------------------------------------------------------------------------
-- GROUP BY
-- 부서별 평균
-- 전체 
select truncate(AVG(SALARY),-4)
from employee;

-- D1 평균 급여
select truncate(AVG(SALARY),-4)
from employee
where DEPT_CODE ='D1';

-- 특정 컬럼을 하나의 그룹으로 묶어 한 테이블 내에서 조회하고자 할때 선언하는 구문.
select DEPT_CODE ,truncate(AVG(SALARY),-4)  
from employee 
group by DEPT_CODE 
order by 1;

-- EMPLOYEE 테이블에서 부서별 총 인원, 급여 합계, 급여 평균, 최대 급여, 최소 급여를 조회(부서코드 오름차순 정렬,TRUNCATE(,-3))
select DEPT_CODE, count(*), sum(SALARY), truncate(AVG(SALARY),-3), max(salary), min(salary)
from employee
group by DEPT_CODE 
order by 1;
-- --------------------------------------------------------------------------------------
-- HAVING
-- GROUP BY 한 소그룹에 대한 조건을 설정.
-- 부서별 급여 평균이 300만원 이상인 부서만 조회.
select DEPT_CODE,truncate(AVG(SALARY),-4) 평균
from employee 
group by DEPT_CODE 
having avg(SALARY)>3000000
order by 1;

-- 실습3
-- 부서별 그룹의 급여 합계 중 900만원 초괴하는 부서의 부서코드와 급여 합계 조회.
select DEPT_CODE, sum(SALARY) 평균
from employee 
group by DEPT_CODE 
having sum(SALARY) > 9000000
order by 1;

select DEPT_CODE ,JOB_CODE ,sum(SALARY)  
from employee
group by DEPT_CODE, JOB_CODE;

-- 실습 4
-- EMPLOYEE 테이블에서 직급 별 그룹을 편성하여 직급코드, 급여 합계, 급여 평균, 인원 수를 조회.
-- 단,인원수는 3명을 초과하는 직급만을 조회, 조회 결과는 인원수 내림차순하여 조회
select JOB_CODE ,sum(SALARY), truncate(AVG(SALARY),-4),COUNT(*) '인원 수'
from employee
group by JOB_CODE 
having COUNT(*) > 3
order by COUNT(*) desc;
-- --------------------------------------------------------------------------------------
-- SET OPERATION
-- 합집합
-- UNION : 두 개 이상의 SELECT 한 결과(RESULTSET)를 구하는 명령어.(중복이 있을 경우 중복되는 결과는 1번만 조회.)
-- UNION ALL : 두 개 이상의 SELECT 한 결과(RESULTSET)를 구하는 명령어.(중복이 있을 경우 중복되는 내용 그대로 조회.)
-- UNION
select EMP_ID ,EMP_NAME ,DEPT_CODE ,SALARY  
from employee
where DEPT_CODE = 'D5'
union
select EMP_ID ,EMP_NAME ,DEPT_CODE ,SALARY  
from employee
where SALARY  < 3000000;

-- UNION ALL
select EMP_ID ,EMP_NAME ,DEPT_CODE ,SALARY  
from employee
where DEPT_CODE = 'D5'
union all-- ALL 
select EMP_ID ,EMP_NAME ,DEPT_CODE ,SALARY  
from employee
where SALARY  < 3000000;
-- --------------------------------------------------------------------------------------
-- JOIN : 두 개 이상의 테이블을 하나로 합쳐 사용하는 명령 구문
-- 만약에 'J6'라는 직급을 가진 사원들의 근무 부서명이 궁금하다.
select EMP_NAME, JOB_CODE,DEPT_CODE
from employee
where JOB_CODE ='J6';

select * from department ;
select * from job ;
select EMP_NAME, JOB_CODE,DEPT_CODE from employee;

select EMP_NAME, JOB_CODE,DEPT_CODE,DEPT_TITLE
from employee 
join department ON(DEPT_CODE = DEPT_ID);

select EMP_ID,EMP_NAME,JOB_CODE,JOB_NAME
from  employee 
-- join job ON(JOB_CODE = JOB_CODE);
join job USING(job_CODE);
-- --------------------------------------------------------------------------------------
-- 실습 EMPLOYEE 테이블의 직원 급여 정보와 SAL_GRADE의 급여 등급을 합쳐서 사번, 사원명, 급여 등급, 등급 기준 최소 급여, 등급 기준 최대 급여를 조회
-- 정보 확인
select *from sal_grade;
select *from employee ;

select EMP_ID ,EMP_NAME ,SAL_LEVEL ,MIN_SAL, MAX_SAL
from employee 
join sal_grade USING(SAL_LEVEL);
-- --------------------------------------------------------------------------------------
-- INNER JOIN : 조건에 만족하는 데이터만 선택.
-- OUTER JOIN --
-- LEFT OUTER JOIN : 첫번째 테이블 기준으로 두번째 테이블을 JOIN. 조건에 만족하지 않는 경우 첫번째 테이블의 값은 유지.
-- RIGHT OUTER JOIN : LEFT와 반대. 두번째 테이블 기준으로 두번째 테이블을 JOIN. 조건에 만족하지 않는 경우 두번째 테이블의 값은 유지.

-- INNER JOIN
-- 표준 SQL 방식
select DEPT_CODE, DEPT_TITLE
from employee
inner join department ON(DEPT_CODE = DEPT_ID)
order by 1;
-- MySQL 지원 문법
select DEPT_CODE, DEPT_TITLE
from employee,department
where DEPT_CODE =DEPT_ID;

-- OUTER JOIN 
-- LEFT JOIN 첫번째 테이블을 기준으로 두번째 테이블을 조합.
select EMP_NAME , DEPT_CODE, DEPT_TITLE
from employee
LEFT join department ON(DEPT_CODE = DEPT_ID);
-- RIGHT JOIN 두번째 테이블을 기준으로 첫번째 테이블을 조합.
select EMP_NAME , DEPT_CODE, DEPT_TITLE
from employee
RIGHT join department ON(DEPT_CODE = DEPT_ID);
-- --------------------------------------------------------------------------------------
select EMP_NAME,DEPT_CODE,SALARY ,S.SAL_LEVEL
from employee E
join sal_grade S on(SALARY between MIN_SAL and MAX_SAL)

-- SELF JOIN : 자기 자신을 조인하는 방법
-- 직원의 정보와 직원을 관리하는 매니저의 정보를 조회
select E.EMP_ID 사번,E.EMP_NAME 사원명, E.MANAGER_ID "관리자 사번", M.EMP_NAME 관리자명 
from employee E
join employee M on (E.MANAGER_ID = M.EMP_ID );

-- 다중 JOIN : 여러개의 테이블을 JOIN하는 것.
select *
from employee
join department ON(DEPT_CODE = DEPT_ID)  
join location ON(LOCATION_ID= LOCAL_CODE);
-- --------------------------------------------------------------------------------------
-- 실습6
-- 직급이 대리이면서, 아시아 지역에서 근무하는 사원조회
-- 사번, 사원명, 직급명, 부서명, 근무직역명, 급여
select *from employee ;
select *from department;
select *from location ; 
select *from job ; 

select EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME, SALARY
from employee E 
join job J ON (E.JOB_CODE = J.JOB_CODE and J.JOB_NAME = '대리') 
join department ON(DEPT_CODE = DEPT_ID)
join location ON(LOCATION_ID = LOCAL_CODE and LOCAL_NAME like 'ASIA%');
-- --------------------------------------------------------------------------------------
-- 실습 7
-- 한국(KO)과 일본(JP)에 근무하는 근무 직원들의 정보를 조회하시오.
-- 이때, 사원명, 부서명, 지역명, 국가명 조회
select EMP_NAME 사원명, DEPT_TITLE 부서명, LOCAL_NAME 지역명,NATIONAL_NAME 국가명
from employee
join department on (DEPT_CODE = DEPT_ID)
join location I on (LOCATION_ID = LOCAL_CODE)
join national USING (NATIONAL_CODE)
where national_CODE IN('KO','JP') ;
-- --------------------------------------------------------------------------------------
-- SUB QUERY--
-- 메인 쿼리 안에 조건이나 검색을 위한 또 하나의 쿼리를 추가하는 기법

-- 단일 행 서브쿼리 : 결과 값이 1개 나오는 서브쿼리
-- 최소 급여를 받는 사원 정보 조회
select MIN(SALARY)
from employee; -- 1380000

select *
from employee  
where SALARY = (select MIN(SALARY)
				from employee);
-- 다중 행 서브쿼리 : 결과 값이 여러 줄 나오는 서브쿼리 
-- 각 직급별 최소 급여를 받는 사원 정보
select MIN(SALARY)
from employee 
group by JOB_CODE; -- 직급별 최소 급여
			
select *
from employee 
where SALARY IN (select MIN(SALARY)
				 from employee 
				 group by JOB_CODE);
-- 다중행 다중열 서브쿼리 :결과 값이 여러 컬럼, 여러 로우의 결과를 가져오는 서브쿼리를 사용.			
select JOB_CODE ,MIN(SALARY)
from employee 		
group by JOB_CODE;	
				
select *
from employee
where (JOB_CODE,SALARY) in (select JOB_CODE ,MIN(SALARY)
						    from employee 		
						    group by JOB_CODE);
-- 다중행 다중열 서브쿼리 활용코드를 단일행 서브쿼리를 활용한 내용으로 변경						   
select *from employee where ENT_YN ='Y';						  

-- 퇴사한 여직원과 같은 직급, 부서에 근무하는 직원 정보 조회
-- 단일행 서브쿼리 활용
select *
from employee
where DEPT_CODE = (select DEPT_CODE  from employee where ENT_YN ='Y')
and JOB_CODE = (select JOB_CODE  from employee where ENT_YN ='Y')
and EMP_ID != (select EMP_ID  from employee where ENT_YN ='Y');

-- 다중열 활용
select *
from employee
where (DEPT_CODE,JOB_CODE) = (select DEPT_CODE,JOB_CODE from employee where ENT_YN ='Y')
and EMP_ID != (select EMP_ID  from employee where ENT_YN ='Y');

-- FROM 위치에 사용 되는 서브쿼리.
-- Inline View(인라인 뷰) : 테이블을 테이블명으로 직접 조회하는 대신 서브쿼리의 resultSet을 활용하여 데이터 조회

select *from employee ;

select *
from (
select EMP_ID ,EMP_NAME,DEPT_TITLE,JOB_NAME
from employee
join department ON(DEPT_CODE=DEPT_ID)
join job USING(JOB_CODE)
) T;
 
-- Inline View(인라인 뷰)사용하는 이유	
-- 오류 o
select EMP_NAME ,SALARY,
	rank() over(order by SALARY desc) 순위
from employee
where 순위 < 5; 			
-- 오류 x		
select *
from (select EMP_NAME ,SALARY,
	rank() over(order by SALARY desc) 순위
from employee) T
where 순위 < 5;
-- --------------------------------------------------------------------------------------
-- RANK() / DENSE_RANK() / ROW_NUMBER()
select EMP_NAME ,SALARY,
	RANK() OVER(order by SALARY DESC) 순위
from employee; -- 19, 19, 21 ~

select EMP_NAME ,SALARY,
	DENSE_RANK() OVER(order by SALARY DESC) 순위
from employee; -- 19, 19, 20 ~

select EMP_NAME ,SALARY,
	ROW_NUMBER() OVER(order by SALARY DESC) 순위
from employee; -- 19, 20, 21 ~

select *
from (select EMP_NAME ,SALARY,
	ROW_NUMBER() OVER(order by SALARY DESC) 순위
	from employee) T
where 순위 < 4;
-- --------------------------------------------------------------------------------------








			