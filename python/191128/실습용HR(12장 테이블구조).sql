----- 12��. ���̺� ���� ���� �� �����ϴ� DDL
create table emp01(
            empno number(4),
            -- ���� 4�ڸ�
            ename varchar2(20),
            -- �۾� 20byte, �ѱ�(3byte) 6����, ������(1byte) 20����
            sal number(7,2)
            -- ���� 7�ڸ�, ���� 5�ڸ�, �Ҽ��� 2�ڸ�
            );

create table emp02
as
select * from emp;
-- emp ���̺� �ִ� ���� ���� ������

create table emp03
as
select empno, ename from emp;
-- emp ���̺� �ִ� empno, ename �÷��� ������

create table emp05
as
select * from emp where deptno = 10;
-- emp ���̺��� deptno 10���� �÷��� ������

-- ���࿡ �ش��ϴ� ������ ���� where ���� ���� ��
create table emp04
as
select * from emp where deptno = 40;
-- �� ���̺�� ���� / (ĭ)�� ���簡 ������ (��)���ڵ�� ����.

-- ĭ�� ����� ���ڵ�� ���� ���̺� �����ϰ� ���� ��
select *
from emp
where 100 < 10;
-- where���� ������ �ۼ��ϸ� �ȴ�.
-- 'where 1=0;' ���� ���

-- ���̺� ����(ĭ)�� ���� ���ڵ�� �������� �ʴ� ���̺� ����
create table emp06
as
select * from emp where 1 = 0;
-- select���� ĭ�� ����ȴ�.
-- where���� ���� ����ȴ�.

-- ALTER TABLE�� �÷� �߰�, ����, ����
-- ADD COLUMN�� ���ο� �÷� �߰�
-- MODIGY COLUMN�� ���� �÷� ����
-- DROP COLUMN�� ���� �÷� ����

-- ���ο� �÷��� �߰��Ǹ� ���� �������� �߰��ȴ�.

-- emp03 ���̺� jobĭ �߰�
alter table emp03
add(job varchar2(9));

-- varchar(9) type�� varchar(30)���� ����
alter table emp03
modify(job varchar2(30));

-- varchar(30) type�� number(10)���� ����
alter table emp03
modify(job number(10));

-- �����Ͱ� �־ Ÿ�Լ��� �Ұ�
alter table emp02
modify(job number(8));

-- �����Ͱ� �־ ������ ���̱� �Ұ�
alter table emp02
modify(job varchar2(8));

-- �����Ͱ� ������ ������ �ø��⸸ ����
alter table emp02
modify(job varchar2(30));

-- �����Ͱ� ���� ĭ�� �����Ӱ� ���� ����
-- �����Ͱ� �ִ� ĭ�� Ÿ�Լ��� �Ұ�
--                  ������ ���̱� �Ұ�
--                  ������ �ø��⸸ ����

-- emp02 ���̺� jobĭ ����
alter table emp02
drop column job;
-- �Ǽ��� (ĭ) ������ ��ҺҰ���
-- �� ���� ���� ��Ұ���(rollback)

-- ���̺� ������ ���� �Ұ�
drop table emp01;


drop table dept01;
drop table dept02;
-- p.297 �ǽ�
create table dept01(
            deptno number(2),
            dname varchar2(14),
            loc varchar2(13)
            );
       
drop table emp04;
-- p.298 �ǽ�
create table emp04
as
select empno, ename, sal from emp;

-- p.299 �ǽ�
create table dept02
as
select * from dept where 1=0;

-- p.300 �ǽ�
alter table dept02
add (DMGR varchar2(15));

-- p.301 �ǽ�
alter table dept02
modify(DMGR number(4));

-- p.302 �ǽ�
alter table dept02
drop (DMGR);

-- p.303 �ǽ�
create table address(
        ID number(3),
        name varchar2(50),
        addr varchar2(100),
        phone varchar2(30),
        email varchar2(100));
        
-- p.304 �ǽ�
create table student_second
as
select * from student where height >= 175 and deptno = 101;

-- p.305 �ǽ�
select max(Sal)
from professor
group by deptno;

-- p.306 �ǽ�
select p.profno, p.name, p.position, p.sal, p.comm
from professor p,(select deptno, max(sal) msal
                  from professor
                  group by deptno) me
where p.deptno = me.deptno and p.sal = me.msal;

-- p.307 �ǽ�
create table professor_second
as
select p.profno, p.name, p.position, p.sal, p.comm
from professor p,(select deptno, max(sal) msal
                  from professor
                  group by deptno) me
where p.deptno = me.deptno and p.sal = me.msal;

drop table dept02;
-- p.308 �ǽ�
create table dept02
as
select * from dept where 1=0;