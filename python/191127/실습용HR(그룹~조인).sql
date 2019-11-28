-- 평균을 구하는 AVG 함수 / 컬럼 값이 NULL이면 제외하고 계산
select avg(sal)
from emp;

select round(avg(sal),4)
-- round 함수 = 자리수 표현 / 4번째 자리까지 반올림
from emp;

select round(avg(sal),-2)
-- round 함수 = 자리수 표현 / 10자리에서 반올림
from emp;

select ename, max(sal)
-- ename 줄 수와 max(컬럼) 줄 수가 같아야함 / 줄 수가 달라서 오류남
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
-- count(*) = 모든 줄의 수를 센다.(null값도 포함)
-- count(컬럼) = 줄의 수를 센다.(null값은 미포함)
from emp;

select job from emp;

-- 중복을 제외하고 출력 (distinct)
select distinct job from emp;

-- 중복을 제외하고 job의 숫자를 셈
select count(distinct job) as "업무 수"
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
-- sal은 출력됨, avg(sal)은 오류
group by deptno
order by deptno asc;

-- group by deptno             > deptno가 같은 줄끼리 그룹
-- having avg(sal) >= 2000;    > 각 그룹에 avg(sal) 계산 / 조건에 맞는 그룹 찾음

select deptno, avg(sal), max(sal) as msal
from emp
group by deptno
having avg(sal) >= 2000
order by msal asc;
-- 컬럼 값처럼 보이기 위해서 별칭 작성

select job, avg(sal), count(*) as cjob, max(sal) as msal
from emp
where job != 'SALESMAN'
group by job
having avg(sal) >= 3000
order by cjob desc;

-- group by 절이 있으면
-- select에는 그룹함수, job(group by 컬럼)
-- 만 사용가능

select max(hiredate) as "최근입사일", min(hiredate) as "짬킹"
from emp;

select count(*)
from emp
where deptno = 10;

select count(comm) as "사원 수"
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

-- 8장 조인
select *
from emp, dept;
-- 14 * 4 = 56

select *
from emp, dept
where emp.deptno = dept.deptno;

-- 컬럼이름이 같을 경우에 테이블.컬럼 써준다.
select ename, dname, emp.deptno
from emp, dept
where emp.deptno = dept.deptno
    and ename = 'SCOTT';

-- from절에서 테이블의 별칭을 줄 수 있다.
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

-- self join 할 때는 같은 테이블에 같은 컬럼을 사용하기 때문에 별칭이 반드시 있어야한다.
select e.ename as "사원이름", e.mgr as "상사사번1", 
        m.empno as "상사사번2", m.ename as "상사이름"
from emp e, emp m
where e.mgr = m.empno
order by 사원이름;

-- outer join
select e.ename as "사원이름", e.mgr as "상사사번1",
        m.empno as "상사사번2", m.ename as "상사이름"
from emp e, emp m
where e.mgr = m.empno (+)
order by 사원이름;

select employee.ename 
    || '의 매니저는 '
    || manager.ename
    || '입니다.'
from emp employee, emp manager
where employee.mgr = manager.empno(+);

-- -----------안써도 그만------------
-- ANSI join
select *
from emp cross join dept;

select ename, dname, dept.deptno
from emp inner join dept
on emp.deptno = dept.deptno
-- on에는 조인조건만 사용가능
where ename = 'SCOTT';
-- 추가 조건은 where절에 쓴다.

select emp.ename, deptno, dept.dname
from emp inner join dept
using (deptno);

select emp.ename, deptno, dept.dname
from emp natural join dept;

-- table 생성
create table dept01(
    deptno number(2),
    dname varchar2(14));
    
-- 생성된 table에 자료 넣기
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

-- 새로 생성한 TABLE ANSI INNER JOIN 해보기
select *
from dept01 inner join dept02
on dept01.deptno = dept02.deptno;

-- 왼쪽에서 짝 없는 친구 구제
select *
from dept01 left outer join dept02
on dept01.deptno = dept02.deptno;

-- 오른쪽에서 짝 없는 친구 구제
select *
from dept01 right outer join dept02
on dept01.deptno = dept02.deptno;

-- 왼쪽, 오른쪽에서(양쪽 모두) 짝 없는 친구 구제
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

select employee.ename as "사원", 
        manager.ename as "상사"
from emp employee left outer join emp manager
on employee.mgr = manager.empno;

select employee.ename as "사원", 
        manager.ename as "상사"
from emp employee right outer join emp manager
on employee.mgr = manager.empno;

select employee.ename as "사원", 
        manager.ename as "상사"
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
where s1.name = '전인하';

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