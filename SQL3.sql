-- NOT IN(��,��,��,...)
select EMP_ID, EMP_NAME, DEPT_CODE
from employee
where DEPT_CODE NOT in('D1', 'D5');

-- ABS(��) : Ư�� ������ ���밪 ǥ��.
select abs(10); 

-- MOD() : �־��� �÷��̳� ���� ���� �������� ��ȯ.
select mod(10,3), mod(10,2);

-- ROUND() : ������ �ڸ��� ���� �ݿø�.
select round(123.456,0), -- �Ҽ��� ù°�ڸ����� �ݿø�
	ROUND(123.456,1),
	ROUND(123.456,2),
	ROUND(123.456,-2); -- 10�� �ڸ� �ݿø�
	
-- CEIL() : ������ ù° �ڸ����� �ø�.
-- FLOOR() : ������ ���� �ڸ��� ��� ����.
select ceil(123.456), floor(123.456); 

-- TRUNCATE() : ������ ��ġ���� ���ڸ� ������ �Լ�.
select truncate(123.456,0),
	truncate(123.456,1),  
	truncate(123.456,2),
	truncate(123.456,-2);

-- CEILING(����) : �Ҽ��� �ݿø�
select ceiling(4.0),
	ceiling(4.1),
	ceiling(3.9),
	ceiling(3.1); 

select ceiling (-4.0),
	ceiling(-4.1),
	ceiling(-3.9);

-- �ǽ�1.
-- EMPLOYEE���̺��� �Ի��� ���� ���ڰ� Ȧ�� ���� ������ ���, �����, �Ի��� ������ ��ȸ
select EMP_ID ,EMP_NAME , HIRE_DATE  
from employee 
where mod(substr(HIRE_DATE, 7,1), 2) = 1;
-- --------------------------------------------------------------------------------------
-- DATE_ADD(��¥, INTERVAL)
-- DATE_SUM(��¥, INTERVAL)

select EMP_NAME ,HIRE_DATE ,
	DATE_ADD(HIRE_DATE, interval 1 DAY)
from employee;

select EMP_NAME ,HIRE_DATE ,
	DATE_SUB(HIRE_DATE, interval 10 YEAR)
from employee;
-- DAYOFWEEK(��¥) : �ش� ��¥�� ���� ����. 1: �Ͽ���, 2: ������, 3: ȭ����, 4: ������ 5: ����� 6: �ݿ���, 7: �����
select dayofweek(NOW());
select EMP_NAME,
	case 
		when DAYOFWEEK(HIRE_DATE) = 1 then '�Ͽ���'
		when DAYOFWEEK(HIRE_DATE) = 2 then '������'
		when DAYOFWEEK(HIRE_DATE) = 3 then 'ȭ����'
		when DAYOFWEEK(HIRE_DATE) = 4 then '������'
		when DAYOFWEEK(HIRE_DATE) = 5 then '�����'
		when DAYOFWEEK(HIRE_DATE) = 6 then '�ݿ���'
		when DAYOFWEEK(HIRE_DATE) = 7 then '�����'
	end as '����'
from employee;

-- LAST_DAY(��¥) : ��¥�� ������ ���ڸ� ��ȸ
select LAST_DAY(now());

-- �ǽ�2.
-- EMPLOYEE ���̺��� �ٹ������ 20�� �̻��� ������� ���, �����, �μ��ڵ�, �Ի��� ��ȸ
select EMP_ID ,EMP_NAME ,DEPT_CODE ,HIRE_DATE  
from employee
where DATE_ADD(HIRE_DATE, interval 20 year) <= NOW();
-- --------------------------------------------------------------------------------------
-- ����ȯ �Լ�--
-- CAST(), CONVERT() : �־��� ���� ���ϴ� �������� ����.
select cast(20220429 as DATE), convert(20220429,DATE); 
select cast(20200101030330 as CHAR), convert(20200101030330, CHAR); 
select cast(now()  as CHAR), convert(now() , CHAR); 

-- BINARY ���� ������
-- CHAR ����
-- DATE ��¥
-- INTEGER ���� (UNSIGNED INTEGER : �����)
-- DECIMAL �Ҽ�������
-- JSON JSONŸ��

select '123'+'456';
select '123'+'456ABC';
select '123'+'4A56BC';
-- --------------------------------------------------------------------------------------
-- SELECT ���� ���� ����
/*
 * 5: SELECT �÷�, ����, �Լ��� AS ��Ī, ...
 * 1: FROM ���̺��
 * 2: WHERE ����
 * 3: GROUP BY �׷��� ���� �ķ�
 * 4: HAVING �׷쿡 ���� ���ǽ�
 * 6: ORDER BY �÷� | ��Ī | ����
 */
-- --------------------------------------------------------------------------------------
-- ORDER BY
-- SELECT ���� ��ȸ�� ���� ������� Ư�� ���ؿ� ���� ����
select EMP_ID, EMP_NAME �̸�, SALARY, DEPT_CODE  
from employee
-- order by EMP_NAME ASC;
-- order by DEPT_CODE desc, EMP_ID;
-- order by �̸� desc;
order by 3 desc; -- :�÷� ����
-- --------------------------------------------------------------------------------------
-- GROUP BY
-- �μ��� ���
-- ��ü 
select truncate(AVG(SALARY),-4)
from employee;

-- D1 ��� �޿�
select truncate(AVG(SALARY),-4)
from employee
where DEPT_CODE ='D1';

-- Ư�� �÷��� �ϳ��� �׷����� ���� �� ���̺� ������ ��ȸ�ϰ��� �Ҷ� �����ϴ� ����.
select DEPT_CODE ,truncate(AVG(SALARY),-4)  
from employee 
group by DEPT_CODE 
order by 1;

-- EMPLOYEE ���̺��� �μ��� �� �ο�, �޿� �հ�, �޿� ���, �ִ� �޿�, �ּ� �޿��� ��ȸ(�μ��ڵ� �������� ����,TRUNCATE(,-3))
select DEPT_CODE, count(*), sum(SALARY), truncate(AVG(SALARY),-3), max(salary), min(salary)
from employee
group by DEPT_CODE 
order by 1;
-- --------------------------------------------------------------------------------------
-- HAVING
-- GROUP BY �� �ұ׷쿡 ���� ������ ����.
-- �μ��� �޿� ����� 300���� �̻��� �μ��� ��ȸ.
select DEPT_CODE,truncate(AVG(SALARY),-4) ���
from employee 
group by DEPT_CODE 
having avg(SALARY)>3000000
order by 1;

-- �ǽ�3
-- �μ��� �׷��� �޿� �հ� �� 900���� �ʱ��ϴ� �μ��� �μ��ڵ�� �޿� �հ� ��ȸ.
select DEPT_CODE, sum(SALARY) ���
from employee 
group by DEPT_CODE 
having sum(SALARY) > 9000000
order by 1;

select DEPT_CODE ,JOB_CODE ,sum(SALARY)  
from employee
group by DEPT_CODE, JOB_CODE;

-- �ǽ� 4
-- EMPLOYEE ���̺��� ���� �� �׷��� ���Ͽ� �����ڵ�, �޿� �հ�, �޿� ���, �ο� ���� ��ȸ.
-- ��,�ο����� 3���� �ʰ��ϴ� ���޸��� ��ȸ, ��ȸ ����� �ο��� ���������Ͽ� ��ȸ
select JOB_CODE ,sum(SALARY), truncate(AVG(SALARY),-4),COUNT(*) '�ο� ��'
from employee
group by JOB_CODE 
having COUNT(*) > 3
order by COUNT(*) desc;
-- --------------------------------------------------------------------------------------
-- SET OPERATION
-- ������
-- UNION : �� �� �̻��� SELECT �� ���(RESULTSET)�� ���ϴ� ��ɾ�.(�ߺ��� ���� ��� �ߺ��Ǵ� ����� 1���� ��ȸ.)
-- UNION ALL : �� �� �̻��� SELECT �� ���(RESULTSET)�� ���ϴ� ��ɾ�.(�ߺ��� ���� ��� �ߺ��Ǵ� ���� �״�� ��ȸ.)
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
-- JOIN : �� �� �̻��� ���̺��� �ϳ��� ���� ����ϴ� ��� ����
-- ���࿡ 'J6'��� ������ ���� ������� �ٹ� �μ����� �ñ��ϴ�.
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
-- �ǽ� EMPLOYEE ���̺��� ���� �޿� ������ SAL_GRADE�� �޿� ����� ���ļ� ���, �����, �޿� ���, ��� ���� �ּ� �޿�, ��� ���� �ִ� �޿��� ��ȸ
-- ���� Ȯ��
select *from sal_grade;
select *from employee ;

select EMP_ID ,EMP_NAME ,SAL_LEVEL ,MIN_SAL, MAX_SAL
from employee 
join sal_grade USING(SAL_LEVEL);
-- --------------------------------------------------------------------------------------
-- INNER JOIN : ���ǿ� �����ϴ� �����͸� ����.
-- OUTER JOIN --
-- LEFT OUTER JOIN : ù��° ���̺� �������� �ι�° ���̺��� JOIN. ���ǿ� �������� �ʴ� ��� ù��° ���̺��� ���� ����.
-- RIGHT OUTER JOIN : LEFT�� �ݴ�. �ι�° ���̺� �������� �ι�° ���̺��� JOIN. ���ǿ� �������� �ʴ� ��� �ι�° ���̺��� ���� ����.

-- INNER JOIN
-- ǥ�� SQL ���
select DEPT_CODE, DEPT_TITLE
from employee
inner join department ON(DEPT_CODE = DEPT_ID)
order by 1;
-- MySQL ���� ����
select DEPT_CODE, DEPT_TITLE
from employee,department
where DEPT_CODE =DEPT_ID;

-- OUTER JOIN 
-- LEFT JOIN ù��° ���̺��� �������� �ι�° ���̺��� ����.
select EMP_NAME , DEPT_CODE, DEPT_TITLE
from employee
LEFT join department ON(DEPT_CODE = DEPT_ID);
-- RIGHT JOIN �ι�° ���̺��� �������� ù��° ���̺��� ����.
select EMP_NAME , DEPT_CODE, DEPT_TITLE
from employee
RIGHT join department ON(DEPT_CODE = DEPT_ID);
-- --------------------------------------------------------------------------------------
select EMP_NAME,DEPT_CODE,SALARY ,S.SAL_LEVEL
from employee E
join sal_grade S on(SALARY between MIN_SAL and MAX_SAL)

-- SELF JOIN : �ڱ� �ڽ��� �����ϴ� ���
-- ������ ������ ������ �����ϴ� �Ŵ����� ������ ��ȸ
select E.EMP_ID ���,E.EMP_NAME �����, E.MANAGER_ID "������ ���", M.EMP_NAME �����ڸ� 
from employee E
join employee M on (E.MANAGER_ID = M.EMP_ID );

-- ���� JOIN : �������� ���̺��� JOIN�ϴ� ��.
select *
from employee
join department ON(DEPT_CODE = DEPT_ID)  
join location ON(LOCATION_ID= LOCAL_CODE);
-- --------------------------------------------------------------------------------------
-- �ǽ�6
-- ������ �븮�̸鼭, �ƽþ� �������� �ٹ��ϴ� �����ȸ
-- ���, �����, ���޸�, �μ���, �ٹ�������, �޿�
select *from employee ;
select *from department;
select *from location ; 
select *from job ; 

select EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME, SALARY
from employee E 
join job J ON (E.JOB_CODE = J.JOB_CODE and J.JOB_NAME = '�븮') 
join department ON(DEPT_CODE = DEPT_ID)
join location ON(LOCATION_ID = LOCAL_CODE and LOCAL_NAME like 'ASIA%');
-- --------------------------------------------------------------------------------------
-- �ǽ� 7
-- �ѱ�(KO)�� �Ϻ�(JP)�� �ٹ��ϴ� �ٹ� �������� ������ ��ȸ�Ͻÿ�.
-- �̶�, �����, �μ���, ������, ������ ��ȸ
select EMP_NAME �����, DEPT_TITLE �μ���, LOCAL_NAME ������,NATIONAL_NAME ������
from employee
join department on (DEPT_CODE = DEPT_ID)
join location I on (LOCATION_ID = LOCAL_CODE)
join national USING (NATIONAL_CODE)
where national_CODE IN('KO','JP') ;
-- --------------------------------------------------------------------------------------
-- SUB QUERY--
-- ���� ���� �ȿ� �����̳� �˻��� ���� �� �ϳ��� ������ �߰��ϴ� ���

-- ���� �� �������� : ��� ���� 1�� ������ ��������
-- �ּ� �޿��� �޴� ��� ���� ��ȸ
select MIN(SALARY)
from employee; -- 1380000

select *
from employee  
where SALARY = (select MIN(SALARY)
				from employee);
-- ���� �� �������� : ��� ���� ���� �� ������ �������� 
-- �� ���޺� �ּ� �޿��� �޴� ��� ����
select MIN(SALARY)
from employee 
group by JOB_CODE; -- ���޺� �ּ� �޿�
			
select *
from employee 
where SALARY IN (select MIN(SALARY)
				 from employee 
				 group by JOB_CODE);
-- ������ ���߿� �������� :��� ���� ���� �÷�, ���� �ο��� ����� �������� ���������� ���.			
select JOB_CODE ,MIN(SALARY)
from employee 		
group by JOB_CODE;	
				
select *
from employee
where (JOB_CODE,SALARY) in (select JOB_CODE ,MIN(SALARY)
						    from employee 		
						    group by JOB_CODE);
-- ������ ���߿� �������� Ȱ���ڵ带 ������ ���������� Ȱ���� �������� ����						   
select *from employee where ENT_YN ='Y';						  

-- ����� �������� ���� ����, �μ��� �ٹ��ϴ� ���� ���� ��ȸ
-- ������ �������� Ȱ��
select *
from employee
where DEPT_CODE = (select DEPT_CODE  from employee where ENT_YN ='Y')
and JOB_CODE = (select JOB_CODE  from employee where ENT_YN ='Y')
and EMP_ID != (select EMP_ID  from employee where ENT_YN ='Y');

-- ���߿� Ȱ��
select *
from employee
where (DEPT_CODE,JOB_CODE) = (select DEPT_CODE,JOB_CODE from employee where ENT_YN ='Y')
and EMP_ID != (select EMP_ID  from employee where ENT_YN ='Y');

-- FROM ��ġ�� ��� �Ǵ� ��������.
-- Inline View(�ζ��� ��) : ���̺��� ���̺������ ���� ��ȸ�ϴ� ��� ���������� resultSet�� Ȱ���Ͽ� ������ ��ȸ

select *from employee ;

select *
from (
select EMP_ID ,EMP_NAME,DEPT_TITLE,JOB_NAME
from employee
join department ON(DEPT_CODE=DEPT_ID)
join job USING(JOB_CODE)
) T;
 
-- Inline View(�ζ��� ��)����ϴ� ����	
-- ���� o
select EMP_NAME ,SALARY,
	rank() over(order by SALARY desc) ����
from employee
where ���� < 5; 			
-- ���� x		
select *
from (select EMP_NAME ,SALARY,
	rank() over(order by SALARY desc) ����
from employee) T
where ���� < 5;
-- --------------------------------------------------------------------------------------
-- RANK() / DENSE_RANK() / ROW_NUMBER()
select EMP_NAME ,SALARY,
	RANK() OVER(order by SALARY DESC) ����
from employee; -- 19, 19, 21 ~

select EMP_NAME ,SALARY,
	DENSE_RANK() OVER(order by SALARY DESC) ����
from employee; -- 19, 19, 20 ~

select EMP_NAME ,SALARY,
	ROW_NUMBER() OVER(order by SALARY DESC) ����
from employee; -- 19, 20, 21 ~

select *
from (select EMP_NAME ,SALARY,
	ROW_NUMBER() OVER(order by SALARY DESC) ����
	from employee) T
where ���� < 4;
-- --------------------------------------------------------------------------------------








			