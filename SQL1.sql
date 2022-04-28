-- 사원의 부서
select *from department;

-- 사원의 부서가 몇개인지 확인
select COUNT(*) from department;

-- 사원의 수가 몇명인지 확인
select COUNT(*) from employee;

-- 사원 월급
select * from sal_grade;

-- 사원 정보
select * from employee;


-- 문제 1.
-- EMPLOYEE 테이블에서 월급이 250만원 보다 많이 받는 사원의 모든 정보를 출력하자.
select EMP_NAME from employee where salary >= 2500000;
select *from department;

-- 문제2.
-- EMPLOYEE 테이블에서 입사한 날짜가 '2000-01-01' 이후 인 사원들의 이름, 주민번호, 입사일을 조회하자
-- HINT : 날짜데이터 비교 연산 가능
select EMP_ID,EMP_NO,HIRE_DATE from employee where hire_date > '2000-01-01' order by hire_date ;

-- 부서 코드가 'D6'인 사원 정보 모두 조회하기
select *
from employee 
where DEPT_CODE = 'D6';

-- 직급이 'J1'인 사원의 사번, 사원명, 직급코드, 부서코드를 조회하시오.
select emp_id,EMP_NAME ,JOB_CODE ,DEPT_CODE  
from employee 
where JOB_CODE ='J1';

-- 조건이 2개 이상 붙었을 경우 (AND | OR) 부서코드가 'D6' 이면서, 이름이 '유재식'인 사원의 모든 정보 조회하기 
select *
from employee 
where DEPT_CODE = 'D6'
  and EMP_NAME ='유재식';


 







