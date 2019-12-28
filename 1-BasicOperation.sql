-- Basic Commands
CREATE DATABASE shubham;
DROP DATABASE shubham;
USE shubham;
CREATE SCHEMA shubham;




-- Create Table
CREATE TABLE shubham.CUSTOMERS(
   ID   INT              NOT NULL,
   NAME VARCHAR (20)     NOT NULL,
   AGE  INT              NOT NULL,
   ADDRESS  CHAR (25) ,
   SALARY   DECIMAL (18, 2),       
   PRIMARY KEY (ID)
);

