-- ����� �μ�
select *from department;

-- ����� �μ��� ����� Ȯ��
select COUNT(*) from department;

-- ����� ���� ������� Ȯ��
select COUNT(*) from employee;

-- ��� ����
select * from sal_grade;

-- ��� ����
select * from employee;


-- ���� 1.
-- EMPLOYEE ���̺��� ������ 250���� ���� ���� �޴� ����� ��� ������ �������.
select EMP_NAME from employee where salary >= 2500000;
select *from department;

-- ����2.
-- EMPLOYEE ���̺��� �Ի��� ��¥�� '2000-01-01' ���� �� ������� �̸�, �ֹι�ȣ, �Ի����� ��ȸ����
-- HINT : ��¥������ �� ���� ����
select EMP_ID,EMP_NO,HIRE_DATE from employee where hire_date > '2000-01-01' order by hire_date ;

-- �μ� �ڵ尡 'D6'�� ��� ���� ��� ��ȸ�ϱ�
select *
from employee 
where DEPT_CODE = 'D6';

-- ������ 'J1'�� ����� ���, �����, �����ڵ�, �μ��ڵ带 ��ȸ�Ͻÿ�.
select emp_id,EMP_NAME ,JOB_CODE ,DEPT_CODE  
from employee 
where JOB_CODE ='J1';

-- ������ 2�� �̻� �پ��� ��� (AND | OR) �μ��ڵ尡 'D6' �̸鼭, �̸��� '�����'�� ����� ��� ���� ��ȸ�ϱ� 
select *
from employee 
where DEPT_CODE = 'D6'
  and EMP_NAME ='�����';


 







