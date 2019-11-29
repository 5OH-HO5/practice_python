drop table dept01;

create table sam02(
-- interval year(년도 자리수) to month
-- 년, 월 (10년 2개월), 9개월
year01 interval year(3) to month);

-- sam02 table에 데이터 삽입
-- 10년 2개월(년, 월) 추가
insert into sam02 (year01)
values(interval '10-2' year to month);
-- 숫자를 제외하고 모두 ' ' 붙여줌

-- 9개월(월) 추가
insert into sam02 (year01)
values (interval '9' month);

-- dept01 table을 생성하는데 그 안에는
-- dept table과 (select)동일한 칸을 갖고 (where)데이터는 없다.
create table dept01
as
select * from dept where 1=0;

-- dept01 tabledp 데이터 추가
insert into dept01
            (deptno, dname, loc)
values(10, 'ACCOUNTING','NEW YORK');

-- p.317
-- 컬럼명 생략하고 데이터 추가
insert into dept01
values (20, 'RESEARCH', 'DALLAS');

-- null 값 삽입하는 방법
-- 1. null 값 삽입 안되게 하는 방법
desc dept01;
-- dept01 table 속성 조회
-- p.290 참조
alter table dept01
modify (deptno number(2) not null);
-- not null 추가

-- 2. null 값 삽입하는 방법
insert into dept01
(deptno, dname)
values(30, 'SALES');
-- deptno, dname, loc 컬럼인데
-- null값 받을 컬럼을 비워두면 된다.

-- 컬럼명없이 줄줄이 쓰되 NULL을 삽입
insert into dept01
values(40,'OPERATIONS',NULL);

-- ''안에 공백없이 써도 NULL 값 삽입
-- ' '안에 띄어쓰기가 있다면 공백 삽입
insert into dept01
values(50,'','CHICGO');

-- 서브쿼리로 데이터 삽입
drop table dept02;
create table dept02
as
select * from dept where 1=0;

-- 서브쿼리는 values 안해도 된다.
insert into dept02
select * from dept;

-- table의 모든 행 변경
drop table emp01;

create table emp01
as
select * from emp;

update emp01
set deptno = 30;

-- 추가 수정 삭제 내용 되돌리기
rollback;

update emp01
set sal = sal*1.1;

-- 취소 못하게 함
-- commit하면 rollback이 안됨
commit;
-- rollback 완료라고는 뜨지만 효과없음
rollback;
-- 커밋하기 전에는 롤백 가능

select sysdate
from dept01;

select * from dual;

select sysdate
from dual;

-- emp01 table의 hiredate를 오늘 날짜로 바꿈
update emp01
set hiredate = sysdate;

-- drop, create 명령은 auto commit
-- 따라서 rollback 안됨
-- drop, create 전에 rollback 처리
-- commit - drop - commit 순
-- commit - create - commit 순
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
-- 문자열에서 일부만 잘라주는 함수
-- 1글자부터 2글자 자르겠다.
-- 2글자부터 3글자 자르겠다.

-- hiredate 처음부터 2글자가 82라면 오늘날짜로 바꾼다
update emp01
set hiredate = sysdate
where substr(hiredate, 1, 2) = '82';

-- 20번 부서의 지역명을 40번 부서 지역명으로 변경
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
-- delete는 drop과 다르게 rollback 가능
rollback;
-- 강제로 sql 종료해버리면 rollback 된다.

delete from dept01
where deptno = 30;
-- 부서번호 30번에 해당하는 데이터 삭제

-- 서브쿼리를 이용한 delete
delete from dept01
where deptno = (select deptno
                from dept
                where dname = 'SALES');
-- 부서이름이 SALES인 부서번호를 찾아서
-- 그 번호와 같은 데이터 삭제

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

-- primary key 설정
-- 컬럼에 중복값, null값 입력제한 설정
create table s_dept
as
select * from dept;

insert into s_dept (deptno)
values(10);
insert into s_dept (deptno)
values(null);
-- deptno 컬럼에 중복불가, null불가
-- 설정 (primary key 제약)

create table t_dept
as
select * from dept;
-- primary key 제약
alter table t_dept
add primary key (deptno);
-- t_dept table안에 deptno칸에 primary 제약 설정

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

-- 사원정보 deptno 컬럼에 값이
-- t_dept table deptno 칸에 존재하는
-- 부서번호(10, 20, 30, 40)만 삽입가능 설정(제약)
-- foreign key 제약

create table t_emp
as
select * from emp;

-- foreign key 설정(제약) 방법
alter table t_emp
add foreign key (deptno)
references t_dept;

insert into t_emp
(empno, ename, deptno)
values(123,'AROMA',90);

-- deptno 컬럼에 제한을 건다
-- t_dept에 부서번호 90이 없다.

-- 제약 지우기
alter table t_emp
drop constraint SYS_C007024;

-- 제약이 지워져서 부서번호 90이 들어갈 수 있다.
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
VALUES (10110, '홍길동', 'HONG', 1, 8501011143098, TO_DATE('85-MAY-01','YY-MON-DD'), '055)777-7777', 170, 70, 202, 9903);

-- P.352
INSERT INTO PROFESSOR
VALUES (9920, '최윤식', NULL, '조교수',NULL,'05/01/01',NULL,101);

-- P.353
INSERT INTO PROFESSOR
VALUES (9910, '백미선', 'WHITE', '전임강사', 200, SYSDATE,10,101);

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