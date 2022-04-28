-- CRUD : ������ �⺻ ó�� ����
-- CREATE	: ������ �߰� / INSERT
-- READ 	: ������ ��ȸ / SELECT
-- UPDATE	: ������ ���� / UPDATE
-- DELETE	: ������ ���� / DELETE 

-- --------------------------------------------------------
-- SELECT : ��ȸ�� SQL 

-- SELECT *(��ȸ�÷�)
-- FROM ���̺��
-- WHERE ����
-- ORDER BY �÷� ;
-- --------------------------------------------------------
-- �÷��� ��Ī �ޱ�
-- 1. AS ǥ��
select EMP_ID as "��� ��ȣ", EMP_NAME as "��� ��"
from employee ;

-- 2. AS ����
select EMP_ID "��� ��ȣ", EMP_NAME '��� ��'
from employee ;
-- --------------------------------------------------------
select emp_name "�����",	
		(salary * 12) "����",
		bonus "���ʽ�",
		(SALARY + (SALARY * BONUS))* 12 "��������"
from employee;

-- IFNULL() : ���� ���� ��ȸ�ϴ� ���� NULL�̸� ������ ������ ����
select emp_name "�����",	
		(salary * 12) '����', '��' ����,
		ifnull(bonus,0)  ���ʽ�,
		(SALARY + (SALARY * IFNULL(BONUS, 0)))* 12 "��������"
from employee;
-- --------------------------------------------------------
-- DISTINCT �ߺ��� ���� �ϰ� �� ���� ��ȸ
select EMP_NAME, DEPT_CODE
from employee;

select distinct DEPT_CODE
from employee;
-- --------------------------------------------------------
-- �ǽ� 1. DEPARTMENT ���̺��� �����Ͽ�, �μ��� '�ؿܿ���2��'�� �μ��� �μ��ڵ带 ã��, 
-- EMPLOYEE���̺��� �ش� �μ��� ����� �� �޿��� 200�������� ���� �޴� ������ ���, �����, �޿��� ��ȸ�Ͻÿ�.
-- 1) '�ؿܿ���2��' �μ��� �μ��ڵ� ��ȸ
select *from department 
where DEPT_TITLE ='�ؿܿ���2��'; -- D6
-- 2) ���� ��ȸ
select *from employee ;

select EMP_ID ���,
		EMP_NAME �����,
		SALARY �޿�
from employee
where DEPT_CODE = 'D6'
	and SALARY > 2000000
	order by SALARY ;
-- --------------------------------------------------------
-- ������ --
-- <, >, <=, >= : ũ�⸦ ��Ÿ�״� �ε�ȣ
-- = : ����
-- !=, <> : ���� �ʴ�.
-- --------------------------------------------------------
-- EMPLOYEE ���̺��� �μ��ڵ尡 'D9'�� �ƴ� �������� ��� ������ ��ȸ
select * from employee 
-- where DEPT_CODE !='D9';
where DEPT_CODE <>'D9';
-- --------------------------------------------------------
-- �޿��� 350���� �̻�, 550���� ������ ������ ���, �����, �μ��ڵ�, �����ڵ�, �޿����� ��ȸ
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
-- �Է��� ����, ���ڰ� ���Ե� ������ ��ȸ�� �� ����ϴ� ������.
-- '_' : ������ �� ����
-- '%' : 
-- ����� �̸��� ��� ���ڰ� '��'�� ��� ���� ��ȸ
select *
from employee 
where EMP_NAME like '_��_';
-- �ֹε�Ϲ�ȣ(EMP_NO) ���� ������ ����� ������ ��ȸ
select *
from employee
where EMP_NO like '______-1%';
-- ��� �� �̸��� ���̵� 5���� �̻��� ����� ����� ��� �̸��� ��ȸ
select EMP_NAME, EMP_ID ,EMAIL 
from employee 
where EMAIL like '_____%@%';
-- ��� �� �̸��� 4��° ���ڰ� '_'�� ����� ���� ��ȸ
-- ESCAPE���ڸ� ����. �ڿ��� ���ڸ� Ư�����ڰ� �ƴ� 
-- �Ϲ� ���ڷ� �����Ͽ� ���.
select *
from employee 
where EMAIL like '___#_%@%' escape '#';
-- --------------------------------------------------------
-- IN ������
-- IN(��1, ��2,��3, ...)
-- WHERE JOB_CODE = 'J1' OR JOB_CODE' = 'J4'

-- �����ڵ尡 J1�̰ų� J4�� ���� ���� ��ȸ
select *from employee 
where JOB_CODE in('J1', 'J4');

select *from employee 
where JOB_CODE not in('J1', 'J4');
-- --------------------------------------------------------
-- �Լ�(FUNCTION)

-- LENGTH, CHAR_LENGTH
-- ���ڿ��� ���̸� ����ϴ� �Լ�
-- LENGTH : BYTE ����(���� 1, �ѱ� 3)
-- CHAR_LENGTH : ���� ��
select length('Hello'), char_length('Hello');
select length('�ڼ���'), char_length('�ڼ���');
-- --------------------------------------------------------
-- INSTR : �־��� ������ ���ϴ� ���ڰ� ���°���� ã�� ��ȯ�ϴ� �Լ�
select instr('ABCD','A'),
	   instr('ABCD','C'),
	   instr('ABCD','Z'), 
	   instr('ABCDEF','CD');

-- SUBSTR() : �־��� ���ڿ����� Ư�� �κи� ���� ���� �Լ�
select 'Hello World',
		substr('Hello World',1,5),
		substr('Hello World',7);

-- �ǽ�2.
-- EMPLOYEE ���̺��� ������� �̸�, �̸��� �ּҸ� ��ȸ. ��, �̸����� ���̵� �κи� ��ȸ
select EMP_NAME '�̸�', substr(EMAIL,1,instr(EMAIL,'@')-1) 'ID' from employee ; 
-- --------------------------------------------------------
-- LPAD/ RPAD
-- ��ĭ�� ������ ���ڷ� ä��� �Լ�
select lpad(EMAIL,20,'#') from employee ;
select RPAD(EMAIL,20,'#') from employee ;
-- --------------------------------------------------------
-- TRIM
-- LTRIM/RTRIM : ���鸸 ã�� �����ִ� �Լ�
select ltrim('   HELLO'), rtrim('HELLO     ');

-- TRIM : �糡�� �������� Ư�� ���ڸ� �����ִ� �Լ�
select TRIM('   5����     ');

select TRIM('0' from '00012300');
-- LEADING/ TRAILING
select TRIM(leading '0' from '00012300');
select TRIM(trailing  '0' from '00012300');
select TRIM(both '0' from '00012300'); 
-- --------------------------------------------------------
-- CONCAT : ���� ���ڿ��� �ϳ��� ���ڿ��� ��ġ�� �Լ�
select concat('���̿���ť��',' �ʹ��ʹ� ��վ��:)'); 
-- --------------------------------------------------------
-- REPLACE : �־��� ���ڿ����� Ư�� ���ڸ� ������ �� ����ϴ� �Լ�
select replace ('HELLO WORLD', 'HELLO', 'BYE');

-- �ǽ�3 EMPLOYEE ���̺��� ��� ����� ���, �����, �̸���, �ֹι�ȣ�� ��ȸ
-- �� ��, �̸����� '@' ������, �ֹι�ȣ�� 7��° �ڸ�����'*'ó���Ͽ� ��ȸ
select EMP_ID '���', 
	EMP_NAME '�̸�', 
	substr(EMAIL,1,instr(EMAIL,'@')-1) '�̸���', 
	rpad(substr(EMP_NO,1,8),14,'*') '�ֹι�ȣ' 
from employee;
-- --------------------------------------------------------
-- EMPLOYEE ���̺��� ���� �ٹ��ϴ� ���� ����� ���, �����,���� �ڵ带 ��ȸ
-- EMT_YN : ��� ����(Y�� ����ߴ�) WHERE ������ �Լ� ��� ����

-- ������ �Լ� : ��� ã�Ƽ� ����� ������ (�� �ึ��) �Լ� ����
select EMP_ID ,EMP_NAME ,JOB_CODE ,ENT_YN  
from employee
where ENT_YN ='N'
and substr(EMP_NO,8,1) = '2'; 
-- ������ �Լ� : ���ǿ� �����ϴ� ��� ���� ã�� ���� �ѹ��� ����
-- �׷� �Լ� : SUM(), AVG(), MAX(), MIN(), COUNT()

select SUM(SALARY), avg(SALARY), MAX(SALARY), MIN(SALARY)
from employee;

-- EMPLOYEE ���̺��� '�ؿܿ���1��'�� �ٹ��ϴ� ��� ����� ��� �޿�, ���� ���� �޿�, ���� ���� �޿�, �޿� �հ� ��ȸ
select AVG(SALARY), MAX(SALARY), MIN(SALARY), SUM(SALARY) 
from employee 
where DEPT_CODE ='D5'; 

-- COUNT(�÷���) : ���� ����, NULL�� ī��ƮX
select COUNT(*),COUNT(DEPT_CODE), count(distinct DEPT_CODE)  
from employee ;
-- --------------------------------------------------------
-- ��¥ ó�� �Լ�
-- SYSDATE() �Լ��� ����� �� �ð�, NOW() ���� ���� �ð� : ���� ��ǻ���� ��¥�� ��ȯ.

select  sysdate(), now();
select now(),sleep(5), sysdate();  
select now(),sleep(5), now();  
-- --------------------------------------------------------
-- �� ��¥ ������ ��
-- DATEDIFF : �ܼ� �� ����
-- TIMESTAMPDIFF : ��, �б�, ��, ��, ��, ��, ��, �ʸ� �����Ͽ� ����

select HIRE_DATE �Ի���,
	 datediff(now(), HIRE_DATE)+1
from employee;

select HIRE_DATE �Ի���,
	TIMESTAMPDIFF(year, HIRE_DATE, NOW())
from employee;
-- SECOND: ��, MINUTE: ��, HOUR: ��, DAY : ��
-- WEEK: ��, MONTH: ��, QUARTER: �б�, YEAR: ��
-- --------------------------------------------------------
-- EXTRACT(YEAR | MONTH | DAY FROM ��¥)
select hire_date, 
	extract(year from hire_date),
	extract(month from hire_date),
	extract(day from hire_date)		
from employee;

-- DATE_FORMAT()
-- ��¥ ���� ����
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
-- IF(����, ��, ��)
-- ���� �ٹ��ϴ� �������� ������ ��, �� ��������
select EMP_NAME,
	EMP_NO,
	if(substr(EMP_NO,8,1) = 1,'��','��') '����'
from employee;

-- �ǽ� 4
-- EMPLOYEE ���̺��� ��� ������ ���, �����, �μ��ڵ�, �����ڵ�, �ٹ�����, ������ ���θ� ��ȸ.
-- �̶�, �ٹ�����(ENT_YN)�� 'Y' �����,'N' �ٹ���
-- 	������ ���(MANAGER_ID)������ ���, ������ ������.
select EMP_ID '���',
	EMP_NAME '�����', 
	DEPT_CODE '�μ��ڵ�',
	SAL_LEVEL '�����ڵ�',
	if(ENT_YN='Y','�����','�ٹ���')'�ٹ� ����',
	IF(MANAGER_ID ,'���','������') '������ ����'
from employee;
-- --------------------------------------------------------
-- CASE
-- �ڹ��� IF, SWITCHó�� ��� ����

-- CASE
-- WHEN ���ǽ�1 THEN �����1
-- WHEN ���ǽ�2 THEN �����2
-- ELSE �����3
-- END

select EMP_ID '���',
	EMP_NAME '��� ��',
	DEPT_CODE '�μ��ڵ�',
	JOB_CODE '�����ڵ�',
	case 
		when ENT_YN = 'Y' then '�����'
		else '�ٹ���'
	end '�ٹ� ����',
	case 
		when MANAGER_ID is null then '������'
		else '���'
	end '������ ����'
	from employee;
-- --------------------------------------------------------
-- [1] ������ 'J2'�̸鼭 200���� �̻� �޴� �����̰ų�, ������'J7'�� ����� ���, �����, �����ڵ�, �޿� ���� ��ȸ�ϱ�
select EMP_ID '���',
	EMP_NAME '��� ��',
	JOB_CODE '���� �ڵ�',
	SALARY '�޿�'
from employee
where (JOB_CODE ='J2'and SALARY >= 2000000) 
	or JOB_CODE ='J7';
-- --------------------------------------------------------
-- [2] EMPLOYEE ���̺��� ����� �ֹ� ��ȣ�� Ȯ���Ͽ� ���� �� ���� ���� ��ȸ�Ͻÿ�.
select EMP_NAME '�̸�',
	concat(substr(EMP_NO,1,2),'��') '����',  
	concat(substr(EMP_NO,3,2),'��') '����',  
	concat(substr(EMP_NO,5,2),'��') '����'  
from employee; 
-- --------------------------------------------------------
-- 1. �μ��ڵ尡 D5, D9�� ������ �߿��� 2004�⵵�� �Ի��� ������ �� ��ȸ��.
--   ��� ����� �μ��ڵ� �Ի���
select EMP_ID '���', 
	EMP_NAME '�����',
	DEPT_CODE '�μ��ڵ�',
	HIRE_DATE '�Ի���' 
from employee
where DEPT_CODE IN('D5','D9') and extract(year from hire_date) ='2004';
-- --------------------------------------------------------
-- 2. ������, �Ի���, �Ի��� ���� �ٹ��ϼ� ��ȸ
--   ��, �ָ��� ������ ( LAST_DAY() : �־��� ��¥�� �ش���� ������ �� ��ȯ)
select EMP_NAME '���� ��', 
	HIRE_DATE '�Ի���', 
datediff(last_day(HIRE_DATE),HIRE_DATE)  '�Ի��� ���� �ٹ��ϼ�' 
from employee;
-- --------------------------------------------------------
-- 3.*** ������, �μ��ڵ�, �������, ���� ��ȸ
--   ��, ��������� �ֹι�ȣ���� �����ؼ� ������ ������ �����Ϸ� ��µǰ� ��.
--   ���̴� �ֹι�ȣ���� �����ؼ� ��¥�����ͷ� ��ȯ�� ����, �����
select from employee;
select EMP_NAME '������',
	DEPT_CODE '�μ��ڵ�',
	date_format(concat('19',substr(EMP_NO,1,6)),'%y�� %m�� %d��') '�������',
	TIMESTAMPDIFF(year,STR_TO_DATE(concat('19',substr(EMP_NO,1,6)),'%Y%m%d') ,now()) '����' 
from employee;
-- --------------------------------------------------------
-- 4. �μ��ڵ尡 D5�̸� �ѹ���, D6�̸� ��ȹ��, D9�̸� �����η� ó���Ͻÿ�.
--   ��, �μ��ڵ尡 D5, D6, D9 �� ������ ������ ��ȸ��
--  => case ���
-- �����, �μ��ڵ�, �μ���
select EMP_NAME �����,
	DEPT_CODE �μ��ڵ�,
	case 
		when DEPT_CODE = 'D5' then '�ѹ���'
		when DEPT_CODE = 'D6' then '��ȹ��'
		when DEPT_CODE = 'D9' then '������'
	end '�ٹ� ����'
from employee
where DEPT_CODE ='D5' or DEPT_CODE ='D6' or DEPT_CODE ='D9';

-- --------------------------------------------------------
select *from employee ;
































