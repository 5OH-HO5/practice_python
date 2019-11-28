select deptno
from emp
where ename = 'SCOTT';

select dname
from dept
where deptno = 20;

-- 위 두가지를 한번에 실행하는 서브쿼리
SELECT danme
FROM DEPT
WHERE DEPTNO = (SELECT DEPTNO
                FROM EMP
                WHERE ENAME = 'SCOTT'
                );
-- 먼저 실행되어야 할 쿼리가 where 내 서브쿼리
-- 항상 서브쿼리가 제일 먼저 실행
-- 그 다음 나머지 쿼리 실행

select deptno
from emp
where ename = 'SMITH';

select *
from emp
where deptno = 20;
-- 나중에 하는게 메인쿼리, 먼저 하는게 서브쿼리

select *
from emp
where deptno = (select deptno
                from emp
                where ename = 'SMITH')
                and ename <> 'SMITH';
-- 서브쿼리는 실행되면 값으로 변환된다.
-- 그 다음 메인쿼리 실행
-- 서브쿼리에 조건이 더 필요할 때 AND, OR 추가

select round(avg(sal), 2)
from emp;

select ename, sal
from emp
where sal > 2073.21;

select ename, sal
from emp
where sal > (select round(avg(Sal), 2)
            from emp
            );
            
select distinct(deptno)
from emp
where sal >= 3000;

select *
from emp
where deptno = 20 or deptno = 10;

select *
from emp
where deptno in (select deptno
                from emp
                where sal >= 3000
                );
-- 다중 행 서브쿼리는 다중 행 연산자와 함께 사용
-- IN: = 결과 중 하나라도 일치하면 참
-- ANY: 검색 결과와 하나 이상 일치하면 참
-- ALL: 검색 결과와 모든 값이 일치하면 참
-- EXISTS: 결과 중 만족하는 값이 하나라도 존재하면 참

select sal
from emp
where deptno = 30;

select ename, sal
from emp
where sal > 950 and sal > 1250
    and sal > 1500 and sal > 1600
    and sal > 2850;
    
-- ALL
select ename, sal
from emp
where sal > all (select sal
                from emp
                where deptno = 30
                );
                
-- ANY
select ename, sal
from emp
where sal > ANY (select sal
                from emp
                where deptno = 30
                );
-- 결과적으로 950보다 크면 조건 만족

select '연봉 3000 이상 있음'
from dept;
-- table의 줄 수만큼 출력

select *
from dual;
-- oracle이 만들어 준 1행1열의 X 값

select '연봉 3000 이상 있음'
from dual;
-- select 글씨가 from의 줄 수만큼 출력

select '20번 부서 연봉 3000 이상 있음' result
from dual
where exists (select *
              from emp
              where sal >= 3000
                 and deptno = 20
              );
-- 서브쿼리에 실행 결과가 있다.

select '30번 부서 연봉 3000 이상 있음' result
from dual
where exists (select *
              from emp
              where sal >= 3000
                 and deptno = 30
              );
-- 서브쿼리에 실행 결과가 없다.

-- exists = 서브쿼리에 조회결과가 있으면 그 다음 나머지 쿼리 실행

--FROM 절 서브쿼리
select deptno, max(sal)
from emp
group by deptno;

select *
from (select deptno, max(sal) as msal
    from emp
    group by deptno) me,
    emp e
where me.deptno = e.deptno
    and me.msal = e.sal;
    
select *
from emp
order by sal desc;

select *
from (select * from emp
    order by sal desc)
where rownum <= 5;
-- rownum: from 절 서브쿼리의 일부 데이터만 보려고 할 때


-- 맨 첫번째 줄부터만 셀 수 있다.
-- where rownum <= 5: 첫번째 줄부터 count
--                  : 6번째 줄에서 출력X
-- where rownum >= 6: 첫번째 줄부터 6이상(사람)
--                  :6번째 줄 찾음(못찾음)
--                  :1번째 줄부터 셈(안함)
select *
from (select * from emp
    order by sal desc)
where rownum >= 6;

-- rownum 출력(별칭부여: 컬림처럼)
select rownum rank, ename,sal
from (select * from emp
    order by sal desc);
where rank >= 6;

-- where가 먼저 시작됨
-- 그래서 from 절 안에 from 절을 또 넣음
select *
from (select rownum rank, ename,sal
      from (select * 
            from emp
            order by sal desc
            )
      )
where rank >= 6 and rank <= 10;
-- 제일 안쪽 from에서 sal 높은 순으로 정렬
-- 그 순서에 rank를 대입
-- 마지막 where rank 조건

select ename, sal, deptno
from emp e
where e.sal = (select max(sal)
                from emp
                where deptno = e.deptno
                );
-- 중복은 제거하고 가져옴
-- P.257
select ename, deptno
from emp
where deptno = (select deptno
                from emp
                where ename = 'SCOTT');
                
select *
from emp
where JOB = (select JOB
                from emp
                where ename = 'SCOTT');

-- P.258                
select ename, sal
from emp
where sal >= (select sal
                from emp
                where ename = 'SCOTT');
                
select ename, deptno
from emp
where deptno = (select deptno
                from dept
                where loc = 'DALLAS');

-- P.259                
select ename, sal
from emp
where deptno = (select deptno
                from dept
                where dname = 'SALES');
                
select ename, SAL
from emp
where MGR = (select EMPNO
                from emp
                where ename = 'KING');

-- P.260                
select empno, ename, sal, deptno
from emp
where (deptno, sal) in (select deptno, max(sal)
                        from emp
                        group by deptno);
                        
select deptno, dname, loc
from dept
where deptno in (select deptno
                 from emp
                 where job = 'MANAGER');
                 
select ename, sal
from EMP
where sal > (select MAX(SAL)
                 from emp
                 where job = 'SALESMAN');
           -- 위에랑 또이또이      
-- P.261
select ename, sal
from EMP
where sal > ALL (select SAL
                 from emp
                 where job = 'SALESMAN');

-- P.262                 
select ename, sal, JOB
from EMP
where sal > (select MIN(SAL)
                 from emp
                 where job = 'SALESMAN')
                 AND JOB <> 'SALESMAN';

-- P.263
select studno, name, grade
from student
where grade = (select grade
                from student
                where userid = 'jun123');
                
-- p.264
select name, deptno, weight
from student
where weight < (select avg(weight)
                from student
                where deptno = 101);
--                and deptno <> 101; / 101번 학과 제외

-- p.265
select studno, name, birthdate
from student
where birthdate = (select min(birthdate)
                   from student);
                   
-- p.266
select studno, name, deptno
from student
where deptno in (select deptno
                from department
                where college = 100);
                
-- p.267
select *
from emp
where SAL > ALL (select SAL
                    from emp
                    where DEPTNO = 30);

-- p.268                    
select profno, name, sal, nvl(comm, 0), sal+nvl(comm,0)
from professor
where sal+nvl(comm,0) > ALL (select sal+nvl(comm,0)
                        from professor
                        where deptno = 102)
order by profno asc;

-- p.269                    
select studno, name, weight, deptno
from student
where weight < ALL (select MIN(weight)
                        from student
                        where deptno = 102);
                        
-- p.270                    
select studno, name, height
from student
where height > ALL (select height
                        from student
                        where grade = 4);
                        
-- p.271                    
select studno, name, height
from student
where height < ALL (select min(height)
                        from student
                        where grade = 4);
                        
-- p.272                    
select s.studno, s.name, s.weight, s.deptno
from student s,(select deptno, max(weight) mwei
                from student
                group by deptno) me
where s.deptno = me.deptno and s.weight = me.mwei;
                
-- p.273
select p.profno, p.name, (p.sal+ nvl(p.comm,0))
from professor p,(select deptno, max(sal+nvl(comm,0)) msc
                from professor
                group by deptno) me
where p.deptno = me.deptno and (p.sal+nvl(p.comm,0)) = me.msc;
-- p.sal + nvl(p.comm,0)

-- p.274
select empno, ename, sal
from (select *
      from emp
      order by sal desc)
where rownum <= 5;

-- p.275
select studno, name, height, deptno
from (select *
    from student
    order by height desc)
where rownum <= 10;

-- p.276
select studno, name, weight
from (select *
    from student
    order by weight asc)
where rownum <= 3;

-- p.277
select f.deptno, f.profno, f.name, f.sal
from professor f,(select deptno, max(sal) msal
                from professor
                group by deptno) me
where f.deptno =  me.deptno and f.sal = me.msal;

-- p.278
select s.studno, s.name, s.height, s.deptno
from student s,(select deptno, max(height) hei
                from student
                group by deptno) me
where s.deptno =  me.deptno and s.height = me.hei;