-- ����� ���ϴ� AVG �Լ� / �÷� ���� NULL�̸� �����ϰ� ���
select avg(sal)
from emp;

select round(avg(sal),4)
-- round �Լ� = �ڸ��� ǥ�� / 4��° �ڸ����� �ݿø�
from emp;

select round(avg(sal),-2)
-- round �Լ� = �ڸ��� ǥ�� / 10�ڸ����� �ݿø�
from emp;

select ename, max(sal)
-- ename �� ���� max(�÷�) �� ���� ���ƾ��� / �� ���� �޶� ������
from emp;

select ename, sal
from emp;

select ename, sal from emp;
select min(ename), max(sal)
from emp;

select ename, sal
from emp
where sal = (select max(sal) from emp);

select count(*), count(comm)
-- count(*) = ��� ���� ���� ����.(null���� ����)
-- count(�÷�) = ���� ���� ����.(null���� ������)
from emp;

select job from emp;

-- �ߺ��� �����ϰ� ��� (distinct)
select distinct job from emp;

-- �ߺ��� �����ϰ� job�� ���ڸ� ��
select count(distinct job) as "���� ��"
from emp;


-- group by
select deptno
from emp
group by deptno;

select deptno, round(avg(Sal), 4)
from emp
group by deptno
order by deptno asc;

select deptno, round(avg(Sal), 4)
from emp
where sal >= 2000
-- sal�� ��µ�, avg(sal)�� ����
group by deptno
order by deptno asc;

-- group by deptno             > deptno�� ���� �ٳ��� �׷�
-- having avg(sal) >= 2000;    > �� �׷쿡 avg(sal) ��� / ���ǿ� �´� �׷� ã��

select deptno, avg(sal), max(sal) as msal
from emp
group by deptno
having avg(sal) >= 2000
order by msal asc;
-- �÷� ��ó�� ���̱� ���ؼ� ��Ī �ۼ�

select job, avg(sal), count(*) as cjob, max(sal) as msal
from emp
where job != 'SALESMAN'
group by job
having avg(sal) >= 3000
order by cjob desc;

-- group by ���� ������
-- select���� �׷��Լ�, job(group by �÷�)
-- �� ��밡��

select max(hiredate) as "�ֱ��Ի���", min(hiredate) as "«ŷ"
from emp;

select count(*)
from emp
where deptno = 10;

select count(comm) as "��� ��"
from emp
where deptno = 10;

select count(comm)
from professor
where deptno = 101;

select name
from professor
where deptno = 101 and comm is not null;

select avg(weight), sum(weight)
from student
where deptno = 101;A

select max(height), min(height)
from studentA
where deptno = 102;

select deptno, count(profno)
from professor
where comm is not null
group by deptno;

select deptno, avg(sal), min(sal), max(sal)
from professor
group by deptno;

select grade, count(studno),
        round(avg(height),0) as h, round(avg(weight),0)
from student
group by grade
having count(*) >= 4
order by h desc;

-- 8�� ����
select *
from emp, dept;
-- 14 * 4 = 56

select *
from emp, dept
where emp.deptno = dept.deptno;

-- �÷��̸��� ���� ��쿡 ���̺�.�÷� ���ش�.
select ename, dname, emp.deptno
from emp, dept
where emp.deptno = dept.deptno
    and ename = 'SCOTT';

-- from������ ���̺��� ��Ī�� �� �� �ִ�.
select ename, dname, e.deptno
from emp e, dept d
where e.deptno = d.deptno
    and ename = 'SCOTT';
    
select e.ename, d.dname, e.deptno
from emp e, dept d
where e.deptno = d.deptno
    and e.ename = 'SCOTT';
    
select * from salgrade;

select ename, sal, grade
from emp, salgrade
where sal between losal and hisal;
-- where sal >= losal and sal <= hisal;

-- self join �� ���� ���� ���̺� ���� �÷��� ����ϱ� ������ ��Ī�� �ݵ�� �־���Ѵ�.
select e.ename as "����̸�", e.mgr as "�����1", 
        m.empno as "�����2", m.ename as "����̸�"
from emp e, emp m
where e.mgr = m.empno
order by ����̸�;

-- outer join
select e.ename as "����̸�", e.mgr as "�����1",
        m.empno as "�����2", m.ename as "����̸�"
from emp e, emp m
where e.mgr = m.empno (+)
order by ����̸�;

select employee.ename 
    || '�� �Ŵ����� '
    || manager.ename
    || '�Դϴ�.'
from emp employee, emp manager
where employee.mgr = manager.empno(+);

-- -----------�Ƚᵵ �׸�------------
-- ANSI join
select *
from emp cross join dept;

select ename, dname, dept.deptno
from emp inner join dept
on emp.deptno = dept.deptno
-- on���� �������Ǹ� ��밡��
where ename = 'SCOTT';
-- �߰� ������ where���� ����.

select emp.ename, deptno, dept.dname
from emp inner join dept
using (deptno);

select emp.ename, deptno, dept.dname
from emp natural join dept;

-- table ����
create table dept01(
    deptno number(2),
    dname varchar2(14));
    
-- ������ table�� �ڷ� �ֱ�
insert into dept01
values(10, 'ACCOUNTING');

insert into dept01
values(20, 'RESERTCH');


create table dept02(
    deptno number(2),
    dname varchar2(14));
    
insert into dept02
values(10, 'ACCOUNTING');

insert into dept02
values(30, 'SALES');

-- ���� ������ TABLE ANSI INNER JOIN �غ���
select *
from dept01 inner join dept02
on dept01.deptno = dept02.deptno;

-- ���ʿ��� ¦ ���� ģ�� ����
select *
from dept01 left outer join dept02
on dept01.deptno = dept02.deptno;

-- �����ʿ��� ¦ ���� ģ�� ����
select *
from dept01 right outer join dept02
on dept01.deptno = dept02.deptno;

-- ����, �����ʿ���(���� ���) ¦ ���� ģ�� ����
select *
from dept01 full outer join dept02
on dept01.deptno = dept02.deptno;

select e.ename, d.deptno, d.dname
from emp e inner join dept d
on e.deptno = d.deptno;

select e.ename, d.deptno, d.dname
from emp e right outer join dept d
on e.deptno = d.deptno;

select *
from emp employee inner join emp manager
on employee.mgr = manager.empno;

select employee.ename as "���", 
        manager.ename as "���"
from emp employee left outer join emp manager
on employee.mgr = manager.empno;

select employee.ename as "���", 
        manager.ename as "���"
from emp employee right outer join emp manager
on employee.mgr = manager.empno;

select employee.ename as "���", 
        manager.ename as "���"
from emp employee full outer join emp manager
on employee.mgr = manager.empno;

select ename, sal, dept.loc
from emp, dept
where dept.loc = 'NEW YORK';

select emp.ename, emp.hiredate
from emp join dept
using (deptno);

select EMP.ENAME, dept.dname, EMP.JOB
from emp join dept
using (deptno)
where emp.job = 'MANAGER';

SELECT b.ENAME, B.JOB
FROM EMP A, EMP B
WHERE A.EMPNO = B.MGR AND a.ENAME = 'KING';

SELECT *
FROM EMP JOIN DEPT
USING (DEPTNO);
WHERE 

SELECT *
FROM DEPT;

SELECT E2.ENAME
FROM EMP E1 INNER JOIN EMP E2
ON E1.DEPTNO=E2.DEPTNO
WHERE E1.ENAME='SCOTT' AND E2.ENAME<>'SCOTT';

select e1.ename, d1.deptno, d1.dname
from emp e1 right outer join dept d1
on e1.deptno = d1.deptno;

select p1.profno, p1.name,
        deptno, d1.dname
from professor p1 join department d1
using (deptno);

select s1.studno, s1.name, dname, d1.loc
from student s1 join department d1
using (deptno)
where s1.name = '������';

select s1.studno, s1.name, 
        s1.weight, dname, d1.loc
from student s1 join department d1
using (deptno)
where s1.weight >= 80;

select p1.name, s1.grade
from professor p1 inner join psalgrade s1
on p1.sal >= s1.losal and p1.sal <= s1.hisal;

select p1.profno, p1.name, p1.sal, s1.grade
from professor p1 inner join psalgrade s1
on p1.sal >= s1.losal and p1.sal <= s1.hisal
where p1.deptno = 101;

select s1.name, p1.name, d1.dname
from student s1 inner join professor p1 
on s1.deptno =  p1.deptno 
inner join department d1
on p1.deptno = d1.deptno;

select d1.dname, d2.dname, d3.dname
from department d1 inner join department d2
on d1.college = d2.deptno 
inner join department d3
on d2.college = d3.deptno;

select d1.deptno, d1.dname, d3.dname
from department d1 inner join department d2
on d1.college = d2.deptno 
inner join department d3
on d2.college = d3.deptno
where d1.deptno = 201;

select d2.dname ,d1.dname
from department d1 inner join department d2
on d1.college = d2.deptno 
inner join department d3
on d2.college = d3.deptno;

SELECT d1.dname, d2.dname, d3.dname
FROM department d1, department d2, department d3
WHERE d1.college = d2.deptno 
  AND d2.college = d3.deptno;

select s1.name, s1.grade, p1.name, p1.position
from student s1 left join professor p1
on s1.profno = p1.profno;

select s1.name, s1.grade, p1.name, p1.position
from student s1 right join professor p1
on s1.profno = p1.profno;