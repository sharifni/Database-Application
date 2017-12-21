# DBMSProject
Developing database system in access and integrating it with oracle DB.

Flow:
Access Development
1. Create ER Diagrams relating all the entities that are required to develop a database system.
2. Create Tables with proper keys
3. Relationship among entities.
4. Create forms, reports and user interface.

Oracle Linking
1. Download oracle 11g express edition and install it. User name: SYSTEM and password: mine
2. To see the database home page, go to C:\oraclexe\app\oracle\product\11.2.0\server and open Database_homepage. This gives error as the 
   url is 127.0.0.0. Try instead with http://localhost:8080/apex/f?p=4500
3. See the tables by querying in SQL Commands select * from all_tables
4. Download SQL Developer from oracle website.
5. Run the sql_developer.exe     In this you can create, alter, delete tables easily
6. Create new Connection, give username:oraadmin, password: pswd(Used in AWS), hostname address of AWS, SID - ORCL and connect.

7.In local create a odbc driver, go to control panel and search for ODBC driver, select 64 bit and configure.
8. In Access, go to export->more->ODBC Database ->Gives a popup, enter Name of table you want to insert into Oracle db in AWS
9. Now select Data source, u will see lish of drivers, select the one u created in 7 step
10. It will ask for password. Give the password for user oraadmin and ok.

To reflect changes made in access form directly reflect in Oracle db.
11. Now that you have exported your tables to oracle db, all your data is in aws backend db of oracle.
12. Delete all the tables from local access. *Take a backup before deleting
13. Now import tables using ODBC connection from oracle db. Change the names of the tables to match exactly as earlier tables. As these names are used in forms and other place.
14. Now the insertions, modifications reflects in oracle db of aws. 







![globalfootprint](https://user-images.githubusercontent.com/32714796/34234400-e8f1dfcc-e5b8-11e7-865b-86130737efc8.PNG)
