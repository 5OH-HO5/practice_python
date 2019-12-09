drop table clothinfo;
drop SEQUENCE num_seq_1;

create SEQUENCE num_seq_1;
create table clothinfo(
    clothID NUMBER(10) PRIMARY KEY,
    title VARCHAR2(300),
    brand VARCHAR2(300),
    season varchar2(300),
    sex VARCHAR2(300),
    popularity NUMBER(10),
    bucket NUMBER(10),
    total_sell NUMBER(10),
    like_ NUMBER(10),
    review NUMBER(5),
    satisfaction NUMBER(5),
    delivery_date NUMBER(3),
    price NUMBER(7),
    sale NUMBER(5),
    category_ VARCHAR2(300)
);

SELECT *
FROM clothinfo;