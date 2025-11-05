# Data Warehouse Project (WIP) 🚧 

Designing and building a Data Warehouse with the Medallion Architecture using MySQL, with ETL processes, data modeling and analystics.

This project is inspired by Baraa Salkini's [Data Warehouse Project](https://www.datawithbaraa.com/wiki/sql#sql-welcome), with a key difference: the original project was created using SQL Server, while this project was created with MySQL.

Key Differences between I've found between SQL Server and MySQL:
- SQL Server allows the creation of a global warehouse (database) which can have multiple databases inside (schemas). However, this is not possible in MySQL as "schema" and "database" are considered as the same thing. Thus, the databases for each layer in the Medallion Architecture was created as a separate DB (not inside a higher level).
- SQL Server uses a "GO" delimiter at the end of each database creation in order to separate each command and execute them in order. In MySQL this is not a valid delimiter; it is enough to separate using ";" at the end of each DDL command for database creation.

#### Specifications


#### Business Intelligence: Analytics & Reporting (Data Analytics)


#### Objective

----

#### License


#### About Me
