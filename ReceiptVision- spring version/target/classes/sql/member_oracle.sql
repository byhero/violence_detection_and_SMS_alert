
/* Drop Tables */

DROP TABLE t_comment CASCADE CONSTRAINTS;
DROP TABLE t_article CASCADE CONSTRAINTS;
DROP TABLE t_board CASCADE CONSTRAINTS;
DROP TABLE t_usr CASCADE CONSTRAINTS;



/* Drop Sequences */

DROP SEQUENCE seq_article;
DROP SEQUENCE seq_board;
DROP SEQUENCE seq_comment;
DROP SEQUENCE seq_usr;




/* Create Sequences */

CREATE SEQUENCE seq_article;
CREATE SEQUENCE seq_board INCREMENT BY 10 START WITH 100;
CREATE SEQUENCE seq_comment;
CREATE SEQUENCE seq_usr;



/* Create Tables */

CREATE TABLE t_article
(
	art_no number NOT NULL,
	art_title varchar2(200) NOT NULL,
	art_content varchar2(4000) NOT NULL,
	art_like number(5) DEFAULT 0 NOT NULL,
	art_dislike number(5) DEFAULT 0 NOT NULL,
	art_regdate date DEFAULT sysdate NOT NULL,
	art_readcnt number(5) DEFAULT 0 NOT NULL,
	art_com_cnt number(4) DEFAULT 0 NOT NULL,
	art_ip varchar2(35),
	boa_no number NOT NULL,
	usr_no number NOT NULL,
	PRIMARY KEY (art_no)
);


CREATE TABLE t_board
(
	boa_no number NOT NULL,
	boa_name varchar2(20) NOT NULL,
	boa_status number(1) DEFAULT 1 NOT NULL,
	usr_no number NOT NULL,
	PRIMARY KEY (boa_no)
);


CREATE TABLE t_comment
(
	com_no number NOT NULL,
	com_content varchar2(1000) NOT NULL,
	com_regdate date DEFAULT sysdate NOT NULL,
	com_like number(5) DEFAULT 0 NOT NULL,
	com_dislike number(5) DEFAULT 0 NOT NULL,
	com_ip varchar2(35),
	art_no number NOT NULL,
	usr_no number NOT NULL,
	PRIMARY KEY (com_no)
);


CREATE TABLE t_usr
(
	usr_no number NOT NULL,
	usr_id varchar2(20) NOT NULL UNIQUE,
	usr_pw varchar2(128) NOT NULL,
	usr_name varchar2(30) NOT NULL,
	usr_info varchar2(1000),
	usr_level number(1) DEFAULT 1 NOT NULL,
	usr_status number(1) DEFAULT 0 NOT NULL,
	usr_regdate date DEFAULT sysdate NOT NULL,
	usr_lastlogin date DEFAULT sysdate NOT NULL,
	usr_logcnt number(7) DEFAULT 0 NOT NULL,
	usr_ip varchar2(35),
	usr_zipcode varchar2(7),
	usr_address varchar2(100),
	usr_address_detail varchar2(60),
	PRIMARY KEY (usr_no)
);



/* Create Foreign Keys */

ALTER TABLE t_comment
	ADD FOREIGN KEY (art_no)
	REFERENCES t_article (art_no)
;


ALTER TABLE t_article
	ADD FOREIGN KEY (boa_no)
	REFERENCES t_board (boa_no)
;


ALTER TABLE t_article
	ADD FOREIGN KEY (usr_no)
	REFERENCES t_usr (usr_no)
;


ALTER TABLE t_board
	ADD FOREIGN KEY (usr_no)
	REFERENCES t_usr (usr_no)
;


ALTER TABLE t_comment
	ADD FOREIGN KEY (usr_no)
	REFERENCES t_usr (usr_no)
;



insert into t_usr(usr_no,	usr_id, usr_pw, usr_name, usr_info)
values(seq_usr.nextval, 'next', '비밀번호','신해철','쵝오의 뮤지션');
insert into t_usr(usr_no,	usr_id, usr_pw, usr_name, usr_info)
values(seq_usr.nextval, 'taiji', '비밀번호','서태지','굿 뮤지션');

insert into t_board(boa_no, boa_name, usr_no)
values(seq_board.nextval, '자유 게시판', 1);
insert into t_board(boa_no, boa_name, usr_no)
values(seq_board.nextval, '공지 사항', 2);
insert into t_board(boa_no, boa_name, usr_no)
values(seq_board.nextval, 'Q&A 게시판', 1);


update t_usr set
       usr_pw = '33275a8aa48ea918bd53a9181aa975f15ab0d0645398f5918a006d08675c1cb27d5c645dbd084eee56e675e25ba4019f2ecea37ca9e2995b49fcb12c096a032e';
commit

select count(*) as cnt from t_usr where usr_id = 'next';
select * from t_usr;
