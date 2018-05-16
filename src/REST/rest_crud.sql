drop database soa;
create database soa;
use soa;

create table student (
    prn     int unsigned    primary key,
    fname   char(100)       not null,
    lname   char(100)       not null,
    dob     date            not null,
    branch  char(100)       not null
);

insert into student values
    (506, 'Ankit', 'Pati', '1996-04-02', 'IT'),
    (543, 'Tiashaa', 'Chatterjee', '1995-12-13', 'CS');
