drop table dept01;

create table sam02(
-- interval year(�⵵ �ڸ���) to month
-- ��, �� (10�� 2����), 9����
year01 interval year(3) to month);

-- sam02 table�� ������ ����
-- 10�� 2����(��, ��) �߰�
insert into sam02 (year01)
values(interval '10-2' year to month);
-- ���ڸ� �����ϰ� ��� ' ' �ٿ���

-- 9����(��) �߰�
insert into sam02 (year01)
values (interval '9' month);

-- dept01 table�� �����ϴµ� �� �ȿ���
-- dept table�� (select)������ ĭ�� ���� (where)�����ʹ� ����.
create table dept01
as
select * from dept where 1=0;

-- dept01 tabledp ������ �߰�
insert into dept01
            (deptno, dname, loc)
values(10, 'ACCOUNTING','NEW YORK');

-- p.317
-- �÷��� �����ϰ� ������ �߰�
insert into dept01
values (20, 'RESEARCH', 'DALLAS');

-- null �� �����ϴ� ���
-- 1. null �� ���� �ȵǰ� �ϴ� ���
desc dept01;
-- dept01 table �Ӽ� ��ȸ
-- p.290 ����
alter table dept01
modify (deptno number(2) not null);
-- not null �߰�

-- 2. null �� �����ϴ� ���
insert into dept01
(deptno, dname)
values(30, 'SALES');
-- deptno, dname, loc �÷��ε�
-- null�� ���� �÷��� ����θ� �ȴ�.

-- �÷������ ������ ���� NULL�� ����
insert into dept01
values(40,'OPERATIONS',NULL);

-- ''�ȿ� ������� �ᵵ NULL �� ����
-- ' '�ȿ� ���Ⱑ �ִٸ� ���� ����
insert into dept01
values(50,'','CHICGO');

-- ���������� ������ ����
drop table dept02;
create table dept02
as
select * from dept where 1=0;

-- ���������� values ���ص� �ȴ�.
insert into dept02
select * from dept;

-- table�� ��� �� ����
drop table emp01;

create table emp01
as
select * from emp;

update emp01
set deptno = 30;

-- �߰� ���� ���� ���� �ǵ�����
rollback;

update emp01
set sal = sal*1.1;

-- ��� ���ϰ� ��
-- commit�ϸ� rollback�� �ȵ�
commit;
-- rollback �Ϸ���� ������ ȿ������
rollback;
-- Ŀ���ϱ� ������ �ѹ� ����

select sysdate
from dept01;

select * from dual;

select sysdate
from dual;

-- emp01 table�� hiredate�� ���� ��¥�� �ٲ�
update emp01
set hiredate = sysdate;

-- drop, create ����� auto commit
-- ���� rollback �ȵ�
-- drop, create ���� rollback ó��
-- commit - drop - commit ��
-- commit - create - commit ��
drop table emp02;
create table emp02
as
select * from emp;

drop table emp01;
create table emp01
as
select * from emp;

update emp01
set deptno = 30
where deptno = 10;

update emp01
set sal = sal*1.1
where sal >= 3000;

select hiredate,
        substr(hiredate,1,2),
        substr(hiredate,2,3)
from emp;
-- ���ڿ����� �Ϻθ� �߶��ִ� �Լ�
-- 1���ں��� 2���� �ڸ��ڴ�.
-- 2���ں��� 3���� �ڸ��ڴ�.

-- hiredate ó������ 2���ڰ� 82��� ���ó�¥�� �ٲ۴�
update emp01
set hiredate = sysdate
where substr(hiredate, 1, 2) = '82';

-- 20�� �μ��� �������� 40�� �μ� ���������� ����
update dept01
set loc = (select loc
            from dept01
            where deptno = 40)
where deptno = 20;

update dept01
set (dname, loc) = (select dname, loc
                    from dept
                    where deptno = 40)
where deptno = 20;

-- p.337
delete from dept01;
-- delete�� drop�� �ٸ��� rollback ����
rollback;
-- ������ sql �����ع����� rollback �ȴ�.

delete from dept01
where deptno = 30;
-- �μ���ȣ 30���� �ش��ϴ� ������ ����

-- ���������� �̿��� delete
delete from dept01
where deptno = (select deptno
                from dept
                where dname = 'SALES');
-- �μ��̸��� SALES�� �μ���ȣ�� ã�Ƽ�
-- �� ��ȣ�� ���� ������ ����

rollback;

-- p.341
insert into emp01
(empno, ename, hiredate)
values (30, 'AROMA', '2019/11/27');

--p.342
drop table sam01;
create table sam01
as
select empno, ename, job, sal from emp where 1=0;

insert into sam01
values (1000, 'APPLE', 'POLICE', 1000);
insert into sam01
values (1010, 'BANANA', 'NULSE', 15000);
insert into sam01
values (1020, 'ORANGE', 'DOCTOR', 25000);

-- p.343
insert into sam01
values (1030, 'VERY', NULL, 25000);
insert into sam01
values (1040, 'CAT', NULL, 2000);

-- P.344
insert into sam01
select empno, ename, job, sal from emp where deptno = 10;

-- P.345
update sam01
set sal = sal - 5000
where sal >= 10000;

-- P.346
drop table sam02;

create table sam02
as
select ename, sal, hiredate, deptno from emp;

-- primary key ����
-- �÷��� �ߺ���, null�� �Է����� ����
create table s_dept
as
select * from dept;

insert into s_dept (deptno)
values(10);
insert into s_dept (deptno)
values(null);
-- deptno �÷��� �ߺ��Ұ�, null�Ұ�
-- ���� (primary key ����)

create table t_dept
as
select * from dept;
-- primary key ����
alter table t_dept
add primary key (deptno);
-- t_dept table�ȿ� deptnoĭ�� primary ���� ����

insert into t_dept(deptno)
values (10);
insert into t_dept(deptno)
values (null);

create table s_emp
as
select * from emp;

insert into s_emp
(empno, ename, deptno)
values(123, 'AROMA', 90);

-- ������� deptno �÷��� ����
-- t_dept table deptno ĭ�� �����ϴ�
-- �μ���ȣ(10, 20, 30, 40)�� ���԰��� ����(����)
-- foreign key ����

create table t_emp
as
select * from emp;

-- foreign key ����(����) ���
alter table t_emp
add foreign key (deptno)
references t_dept;

insert into t_emp
(empno, ename, deptno)
values(123,'AROMA',90);

-- deptno �÷��� ������ �Ǵ�
-- t_dept�� �μ���ȣ 90�� ����.

-- ���� �����
alter table t_emp
drop constraint SYS_C007024;

-- ������ �������� �μ���ȣ 90�� �� �� �ִ�.
insert into t_emp
(empno, ename, deptno)
values(123,'AROMA',90);

-- p.347
update sam02
set sal = sal + 1000
where deptno = (select deptno
                from dept
                where loc = 'DALLAS');

-- p.348
UPDATE SAM02
SET (SAL, HIREDATE) = (SELECT SAL, HIREDATE
                    FROM EMP
                    WHERE ENAME = 'KING');

-- p.349
DELETE SAM01
WHERE JOB IS NULL;

-- P.350
DELETE SAM02
WHERE DEPTNO =(SELECT DEPTNO
                FROM DEPT
                WHERE DNAME = 'RESEARCH');
                
-- P.351
INSERT INTO STUDENT
VALUES (10110, 'ȫ�浿', 'HONG', 1, 8501011143098, TO_DATE('85-MAY-01','YY-MON-DD'), '055)777-7777', 170, 70, 202, 9903);

-- P.352
INSERT INTO PROFESSOR
VALUES (9920, '������', NULL, '������',NULL,'05/01/01',NULL,101);

-- P.353
INSERT INTO PROFESSOR
VALUES (9910, '��̼�', 'WHITE', '���Ӱ���', 200, SYSDATE,10,101);

-- P.354
CREATE TABLE PSALGRADE2
AS
SELECT * FROM PSALGRADE WHERE 1=0;

INSERT INTO PSALGRADE2 (GRADE, LOSAL, HISAL)
(SELECT GRADE, LOSAL, HISAL
FROM PSALGRADE
WHERE GRADE >= 3);

UPDATE EMP
SET SAL = SAL * 1.1, HIREDATE = SYSDATE;