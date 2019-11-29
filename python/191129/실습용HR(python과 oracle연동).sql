-- 일련번호 생성 num_seq.nextval
create sequence num_seq;

-- nextval 할 때마다 일련번호 증가
select num_seq.nextval
from dual;

select num_seq.nextval
from dual;

create table tourinfo(
num number primary key,
-- primary key: 중복불가 null값 불가
title varchar2(2000),
price number
);
-- 생성 된 tourinfo table에 데이터값 삽입
insert into tourinfo
values (num_seq.nextval, '하와이 3박4일 자유 여행', 150000);
insert into tourinfo
values (num_seq.nextval, '로마 10박 11일 바티칸 투어 포함', 3800000);