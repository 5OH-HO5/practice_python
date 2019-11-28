select deptno
from emp
where ename = 'SCOTT';

select dname
from dept
where deptno = 20;

-- �� �ΰ����� �ѹ��� �����ϴ� ��������
SELECT danme
FROM DEPT
WHERE DEPTNO = (SELECT DEPTNO
                FROM EMP
                WHERE ENAME = 'SCOTT'
                );
-- ���� ����Ǿ�� �� ������ where �� ��������
-- �׻� ���������� ���� ���� ����
-- �� ���� ������ ���� ����

select deptno
from emp
where ename = 'SMITH';

select *
from emp
where deptno = 20;
-- ���߿� �ϴ°� ��������, ���� �ϴ°� ��������

select *
from emp
where deptno = (select deptno
                from emp
                where ename = 'SMITH')
                and ename <> 'SMITH';
-- ���������� ����Ǹ� ������ ��ȯ�ȴ�.
-- �� ���� �������� ����
-- ���������� ������ �� �ʿ��� �� AND, OR �߰�

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
-- ���� �� ���������� ���� �� �����ڿ� �Բ� ���
-- IN: = ��� �� �ϳ��� ��ġ�ϸ� ��
-- ANY: �˻� ����� �ϳ� �̻� ��ġ�ϸ� ��
-- ALL: �˻� ����� ��� ���� ��ġ�ϸ� ��
-- EXISTS: ��� �� �����ϴ� ���� �ϳ��� �����ϸ� ��

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
-- ��������� 950���� ũ�� ���� ����

select '���� 3000 �̻� ����'
from dept;
-- table�� �� ����ŭ ���

select *
from dual;
-- oracle�� ����� �� 1��1���� X ��

select '���� 3000 �̻� ����'
from dual;
-- select �۾��� from�� �� ����ŭ ���

select '20�� �μ� ���� 3000 �̻� ����' result
from dual
where exists (select *
              from emp
              where sal >= 3000
                 and deptno = 20
              );
-- ���������� ���� ����� �ִ�.

select '30�� �μ� ���� 3000 �̻� ����' result
from dual
where exists (select *
              from emp
              where sal >= 3000
                 and deptno = 30
              );
-- ���������� ���� ����� ����.

-- exists = ���������� ��ȸ����� ������ �� ���� ������ ���� ����

--FROM �� ��������
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
-- rownum: from �� ���������� �Ϻ� �����͸� ������ �� ��


-- �� ù��° �ٺ��͸� �� �� �ִ�.
-- where rownum <= 5: ù��° �ٺ��� count
--                  : 6��° �ٿ��� ���X
-- where rownum >= 6: ù��° �ٺ��� 6�̻�(���)
--                  :6��° �� ã��(��ã��)
--                  :1��° �ٺ��� ��(����)
select *
from (select * from emp
    order by sal desc)
where rownum >= 6;

-- rownum ���(��Ī�ο�: �ø�ó��)
select rownum rank, ename,sal
from (select * from emp
    order by sal desc);
where rank >= 6;

-- where�� ���� ���۵�
-- �׷��� from �� �ȿ� from ���� �� ����
select *
from (select rownum rank, ename,sal
      from (select * 
            from emp
            order by sal desc
            )
      )
where rank >= 6 and rank <= 10;
-- ���� ���� from���� sal ���� ������ ����
-- �� ������ rank�� ����
-- ������ where rank ����

select ename, sal, deptno
from emp e
where e.sal = (select max(sal)
                from emp
                where deptno = e.deptno
                );
-- �ߺ��� �����ϰ� ������
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
           -- ������ ���̶���      
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
--                and deptno <> 101; / 101�� �а� ����

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