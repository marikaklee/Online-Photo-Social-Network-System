DROP TABLE Albums CASCADE;
DROP TABLE Pictures CASCADE;
DROP TABLE Users CASCADE;
DROP TABLE Friends CASCADE;
DROP TABLE Tag CASCADE;
DROP TABLE Likes CASCADE;
DROP TABLE Comments Cascade;

DROP SEQUENCE Albums_album_id_seq;
DROP SEQUENCE Pictures_picture_id_seq;
DROP SEQUENCE Users_user_id_seq;

CREATE SEQUENCE Pictures_picture_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 14
  CACHE 1;

CREATE SEQUENCE Albums_album_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE SEQUENCE Users_user_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 14
  CACHE 1;

CREATE SEQUENCE Comments_comment_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE TABLE Users
( 
  user_id int4 NOT NULL DEFAULT nextval('Users_user_id_seq'),
  email varchar(255) NOT NULL,
  password varchar(255) NOT NULL,
  role_name varchar(255) NOT NULL DEFAULT 'RegisteredUser',
  firstname varchar(255) NOT NULL, 
  lastname  varchar(255) NOT NULL, 
  gender varchar(1) NOT NULL,
  dob DATE NOT NULL,
  CONSTRAINT users_pk PRIMARY KEY (user_id)
);

CREATE TABLE Albums 
( 
     aid        INT NOT NULL DEFAULT nextval('Albums_album_id_seq'), 
     aname      varchar(255) NOT NULL, 
     ownid      INT REFERENCES users(uid) ON DELETE CASCADE, 
     datecreate DATE NOT NULL,
     UNIQUE(aname,ownid),
     CONSTRAINT aid_pk PRIMARY KEY (aid) 
); 

CREATE TABLE Pictures
(
  picture_id int4 NOT NULL DEFAULT nextval('Pictures_picture_id_seq'),
  picture_caption varchar(255) NOT NULL,
  picture_imgdata bytea NOT NULL,
  picture_size int4 NOT NULL,
  picture_content_type varchar(255) NOT NULL,
  picture_thumbdata bytea NOT NULL,
  picture_myalbumid INT REFERENCES Albums(aid)ON DELETE CASCADE,
  CONSTRAINT pictures_pk PRIMARY KEY (picture_id)
); 

CREATE TABLE Friends 
( 
  friend_one int4 REFERENCES Users(user_id) ON DELETE CASCADE, 
  friend_two int4 REFERENCES Users(user_id) ON DELETE CASCADE, 
  PRIMARY KEY(friend_one, friend_two) 
); 

CREATE TABLE Tag 
( 
   picture_id int4 REFERENCES Pictures (picture_id) ON DELETE CASCADE, 
   tag_word varchar(255) NOT NULL, 
   PRIMARY KEY(picture_id, tag_word) 
); 

CREATE TABLE Comments
( 
   comment_owner int4 REFERENCES Users(user_id) ON DELETE CASCADE, 
   comment_pid int4 REFERENCES Pictures(picture_id) ON DELETE CASCADE, 
   comment_cid int4 NOT NULL DEFAULT nextval('Comments_comment_id_seq'), 
   comment_text TEXT NOT NULL, 
   comment_datemade DATE NOT NULL,
   CONSTRAINT cid_pk Primary Key (cid)
);  

CREATE TABLE Likes 
  ( 
     likes_pid int4 REFERENCES Pictures(picture_id)ON DELETE CASCADE, 
     likes_user_id  int4 REFERENCES Users(user_id)ON DELETE CASCADE, 
     CONSTRAINT likes_pk PRIMARY KEY(likes_pid, likes_user_id) 
  );



INSERT INTO Users (email, password, firstname, lastname, gender, dob) 
VALUES ('test@bu.edu', 'test', 'Test', 'Test', 'F', '1993-02-13');

INSERT INTO Users (email, password, firstname, lastname, gender, dob) 
VALUES ('marika@bu.edu', 'test', 'Marika', 'Lee', 'F', '1993-02-13');

INSERT INTO Users (email, password, firstname, lastname, gender, dob) 
VALUES ('test2@bu.edu', 'test', 'person', 'one', 'F', '1995-03-12');

INSERT INTO Users (email, password, firstname, lastname, gender, dob) 
VALUES ('test3@bu.edu', 'test', 'person', 'two', 'M', '1995-06-12');

INSERT INTO Users (email, password, firstname, lastname, gender, dob) 
VALUES ('ANONYMOUS', 'ANONYMOUS', 'ANONYMOUS', 'ANONYMOUS', 'M', '1995-06-12');



