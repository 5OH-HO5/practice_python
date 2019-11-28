----- 12장. 테이블 구조 생성 및 삭제하는 DDL
create table emp01(
            empno number(4),
            -- 정수 4자리
            ename varchar2(20),
            -- 글씨 20byte, 한글(3byte) 6글자, 영숫자(1byte) 20글자
            sal number(7,2)
            -- 숫자 7자리, 정수 5자리, 소수점 2자리
            );

create table emp02
as
select * from emp;
-- emp 테이블에 있는 정보 전부 가져옴

create table emp03
as
select empno, ename from emp;
-- emp 테이블에 있는 empno, ename 컬럼만 가져옴

create table emp05
as
select * from emp where deptno = 10;
-- emp 테이블에서 deptno 10번인 컬럼을 가져옴

-- 만약에 해당하는 정보가 없는 where 절을 썼을 때
create table emp04
as
select * from emp where deptno = 40;
-- 빈 테이블로 생성 / (칸)은 복사가 되지만 (줄)레코드는 없다.

-- 칸만 만들고 레코드는 없는 테이블 생성하고 싶을 때
select *
from emp
where 100 < 10;
-- where절에 거짓을 작성하면 된다.
-- 'where 1=0;' 많이 사용

-- 테이블 구조(칸)만 복사 레코드는 복사하지 않는 테이블 생성
create table emp06
as
select * from emp where 1 = 0;
-- select에서 칸이 복사된다.
-- where에서 줄이 복사된다.

-- ALTER TABLE로 컬럼 추가, 수정, 삭제
-- ADD COLUMN절 새로운 컬럼 추가
-- MODIGY COLUMN절 기존 컬럼 수정
-- DROP COLUMN절 기존 컬럼 삭제

-- 새로운 컬럼이 추가되면 제일 마지막에 추가된다.

-- emp03 테이블에 job칸 추가
alter table emp03
add(job varchar2(9));

-- varchar(9) type을 varchar(30)으로 수정
alter table emp03
modify(job varchar2(30));

-- varchar(30) type을 number(10)으로 수정
alter table emp03
modify(job number(10));

-- 데이터가 있어서 타입수정 불가
alter table emp02
modify(job number(8));

-- 데이터가 있어서 데이터 줄이기 불가
alter table emp02
modify(job varchar2(8));

-- 데이터가 있으면 데이터 늘리기만 가능
alter table emp02
modify(job varchar2(30));

-- 데이터가 업슨 칸은 자유롭게 수정 가능
-- 데이터가 있는 칸은 타입수정 불가
--                  사이즈 줄이기 불가
--                  사이즈 늘리기만 가능

-- emp02 테이블 job칸 삭제
alter table emp02
drop column job;
-- 실수로 (칸) 지워도 취소불가능
-- 줄 지운 것은 취소가능(rollback)

-- 테이블 삭제는 복구 불가
drop table emp01;


drop table dept01;
drop table dept02;
-- p.297 실습
create table dept01(
            deptno number(2),
            dname varchar2(14),
            loc varchar2(13)
            );
       
drop table emp04;
-- p.298 실습
create table emp04
as
select empno, ename, sal from emp;

-- p.299 실습
create table dept02
as
select * from dept where 1=0;

-- p.300 실습
alter table dept02
add (DMGR varchar2(15));

-- p.301 실습
alter table dept02
modify(DMGR number(4));

-- p.302 실습
alter table dept02
drop (DMGR);

-- p.303 실습
create table address(
        ID number(3),
        name varchar2(50),
        addr varchar2(100),
        phone varchar2(30),
        email varchar2(100));
        
-- p.304 실습
create table student_second
as
select * from student where height >= 175 and deptno = 101;

-- p.305 실습
select max(Sal)
from professor
group by deptno;

-- p.306 실습
select p.profno, p.name, p.position, p.sal, p.comm
from professor p,(select deptno, max(sal) msal
                  from professor
                  group by deptno) me
where p.deptno = me.deptno and p.sal = me.msal;

-- p.307 실습
create table professor_second
as
select p.profno, p.name, p.position, p.sal, p.comm
from professor p,(select deptno, max(sal) msal
                  from professor
                  group by deptno) me
where p.deptno = me.deptno and p.sal = me.msal;

drop table dept02;
-- p.308 실습
create table dept02
as
select * from dept where 1=0;