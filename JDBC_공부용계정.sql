
-- 관리자 계정에서 JDBC 계정 생성, 최소한의 권한 부여
--CREATE USER JDBC IDENTIFIED BY JDBC;
--GRANT CONNECT, RESOURCE TO JDBC;


-- 여기서부터는 JDBC 계정에서 실행!!
DROP TABLE MEMBER;
CREATE TABLE MEMBER (
    USERNO NUMBER PRIMARY KEY,
    USERID VARCHAR2(15) UNIQUE NOT NULL,
    USERPWD VARCHAR2(20) NOT NULL,
    USERNAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(1) CHECK(GENDER IN ('M', 'F')),
    AGE NUMBER,
    EMAIL VARCHAR2(30),
    PHONE CHAR(11),
    ADDRESS VARCHAR2(100),
    HOBBY VARCHAR2(50),
    ENROLLDATE DATE DEFAULT SYSDATE NOT NULL
);

DROP SEQUENCE SEQ_USERNO;
CREATE SEQUENCE SEQ_USERNO
MINVALUE 0
NOCACHE;

INSERT INTO MEMBER
VALUES(SEQ_USERNO.NEXTVAL, 'admin', '1234', '관리자', 'M', 45, 'admin@naver.com'
     , '01012341234', '서울시 마포구', '잠자기', '2021/01/30');

INSERT INTO MEMBER
VALUES(SEQ_USERNO.NEXTVAL, 'user01', 'pass01', '홍길동', 'F', 23, NULL
     , '01056781234', NULL, '영화보기', SYSDATE);
     
COMMIT;

SELECT * FROM MEMBER;



/*
    오라클에서 객체 이름 붙이는 규칙
    접두사
    테이블 : TB_~~~
    뷰 : VW_~~~
    시퀀스 : SEQ_~~~
*/




