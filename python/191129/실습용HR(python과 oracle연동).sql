-- �Ϸù�ȣ ���� num_seq.nextval
create sequence num_seq;

-- nextval �� ������ �Ϸù�ȣ ����
select num_seq.nextval
from dual;

select num_seq.nextval
from dual;

create table tourinfo(
num number primary key,
-- primary key: �ߺ��Ұ� null�� �Ұ�
title varchar2(2000),
price number
);
-- ���� �� tourinfo table�� �����Ͱ� ����
insert into tourinfo
values (num_seq.nextval, '�Ͽ��� 3��4�� ���� ����', 150000);
insert into tourinfo
values (num_seq.nextval, '�θ� 10�� 11�� ��Ƽĭ ���� ����', 3800000);