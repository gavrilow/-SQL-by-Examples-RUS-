-- DDL for tables creation and data loading for SNOWFLAKE

-- SQL by Examples (RUS)

CREATE TABLE authors (
    a_id int identity(1,1) NOT NULL,
    a_name varchar(150) NOT NULL,
    constraint a_id primary key (a_id)
);

INSERT INTO authors VALUES (1,'Donald Knuth'),(2,'Isaac Asimov'),(3,'Dale Carnegie'),(4,'Lev Landau'),(5,'Evgeny Lifshitz'),(6,'Bjarne Stroustrup'),(7,'Alexander Pushkin');

CREATE TABLE books (
  b_id int identity(1,1) NOT NULL,
  b_name varchar(150) NOT NULL,
  b_year int NOT NULL,
  b_quantity int NOT NULL,
  constraint b_id PRIMARY KEY (b_id)
);

INSERT INTO books VALUES (1,'Eugene Onegin',1985,2),(2,'The Fishermen and the Golden Fish',1990,3),(3,'Foundation and Empire',2000,5),(4,'Programming Psychology',1998,1),(5,'The C++ Programming Language',1996,3),(6,'Course of Theoretical Physics',1981,12),(7,'The Art of Computer Programming',1993,7);

CREATE TABLE genres (
  g_id int identity(1,1) NOT NULL,
  g_name varchar(150) NOT NULL,
constraint g_id PRIMARY KEY (g_id),
  constraint UQ_genres_g_name UNIQUE (g_name)
);

INSERT INTO genres VALUES (5,'Classic'),(4,'Science'),(1,'Poetry'),(2,'Programming'),(3,'Psychology'),(6,'Science Fiction');

CREATE TABLE m2m_books_authors (
  b_id int NOT NULL,
  a_id int  NOT NULL,
  CONSTRAINT FK_m2m_books_authors_authors FOREIGN KEY (a_id) REFERENCES authors (a_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT FK_m2m_books_authors_books FOREIGN KEY (b_id) REFERENCES books (b_id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO m2m_books_authors VALUES (7,1),(3,2),(4,3),(6,4),(6,5),(4,6),(5,6),(1,7),(2,7);

CREATE TABLE m2m_books_genres (
  b_id int  NOT NULL,
  g_id int  NOT NULL,
  CONSTRAINT FK_m2m_books_genres_books FOREIGN KEY (b_id) REFERENCES books (b_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT FK_m2m_books_genres_genres FOREIGN KEY (g_id) REFERENCES genres (g_id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO m2m_books_genres VALUES (1,1),(2,1),(4,2),(5,2),(7,2),(4,3),(1,5),(2,5),(6,5),(7,5),(3,6);

CREATE TABLE subscribers (
  s_id int identity(1,1) NOT NULL,
  s_name varchar(150) NOT NULL,
  constraint s_id PRIMARY KEY (s_id)
);

INSERT INTO subscribers VALUES (1,'Ivanov I.I.'),(2,'Petrov P.P.'),(3,'Sidorov S.S.'),(4,'Sidorov S.S.');

CREATE TABLE subscriptions (
  sb_id int identity(1,1) NOT NULL,
  sb_subscriber int  NOT NULL,
  sb_book int  NOT NULL,
  sb_start date NOT NULL,
  sb_finish date NOT NULL,
  sb_is_active varchar(1) NOT NULL,
  constraint sb_id PRIMARY KEY (sb_id),
  CONSTRAINT FK_subscriptions_books FOREIGN KEY (sb_book) REFERENCES books (b_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT FK_subscriptions_subscribers FOREIGN KEY (sb_subscriber) REFERENCES subscribers (s_id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO subscriptions VALUES (2,1,1,'2011-01-12','2011-02-12','N'),(3,3,3,'2012-05-17','2012-07-17','Y'),(42,1,2,'2012-06-11','2012-08-11','N'),(57,4,5,'2012-06-11','2012-08-11','N'),(61,1,7,'2014-08-03','2014-10-03','N'),(62,3,5,'2014-08-03','2014-10-03','Y'),(86,3,1,'2014-08-03','2014-09-03','Y'),(91,4,1,'2015-10-07','2015-03-07','Y'),(95,1,4,'2015-10-07','2015-11-07','N'),(99,4,4,'2015-10-08','2025-11-08','Y'),(100,1,3,'2011-01-12','2011-02-12','N');
