/*
===================================================
Creation of the Databases
===================================================
Script purpose:

This script creates the 3 main schemas we will be using for our Medallion Data Warehouse architecture: bronze 🥉, silver 🥈 and gold 🥇.
In MySQL, a schema and a database are essentially the same, so it is not necessary to create a "main" database to contain the bronze, silver and gold schemas, instead, we will only need to create 3 databases, one for each layer 🥉🥈🥇.
*/

CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;
