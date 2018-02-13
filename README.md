# DBMSProject
Project description:
- Created an OLTP database and a database application for a cloth store to model sales, procurement, and inventory in MS Access.
- Migrated the database to Oracle DB hosted in Relational Database Service(RDS) instance of AWS. Established connection to Oracle and Access with the help of linked tables by creating ODBC connections for Oracle and configuring TNS entries.
- Used the forecasted demand to manage inventory using EOQ inventory control models and arrived at reorder point.
- Integrated the application for the cloth store with three other applications for stationary, grocery store and electronics store to model acquisitions and mergers yielding to a supermarket sales model.
- Migrated the back end Oracle to multiple database servers located at multiple regions in AWS viz., US East, EU and Asia Pacific to model an organization with a global footprint with sales in EU region, Corporate headquarters in US East region and procurement in Asia Pacific.
- Linked all databases with the help of database links in oracle database.
- Audited tables in all regions to log user interaction using triggers and restricted access through fine grain access control (FGAC) policy implementation in Oracle.
- Created automated periodic snapshots of data in the corporate region at US East region in AWS
- Created reports like top customers and products, cash flow statements etc utilizing Oracle analytical functions which could be accessed both in MS Access front end application and in Tableau to aid decision making for managers of all departments.
- *Used Tableau to predict the future sales of products and customer growth for the next quarter. Prepared dashboards visualizing sales, customer statistics, supply chain and their forecasts in Tableau with live data from RDS instance of AWS which is used by management for key decision making.

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
Add SID details of AWS in tnsnames files inorder to connect to the AWS. Transparent Network Substrate (TNS), a proprietary Oracle computer-networking technology, supports homogeneous peer-to-peer connectivity on top of other networking technologies such as TCP/IP, SDP and named pipes. TNS operates mainly for connection to Oracle databases.
6. Create new Connection, give username:oraadmin, password: password(Used in AWS), hostname address of AWS, SID - ORCL and connect.

7.In local create a odbc driver, go to control panel and search for ODBC driver, select 64 bit and configure.
8. In Access, go to export->more->ODBC Database ->Gives a popup, enter Name of table you want to insert into Oracle db in AWS
9. Now select Data source, u will see list of drivers, select the one u created in 7 step
10. It will ask for password. Give the password for user oraadmin and ok.

To reflect changes made in access form directly reflect in Oracle db.
11. Now that you have exported your tables to oracle db, all your data is in aws backend db of oracle.
12. Delete all the tables from local access. *Take a backup before deleting
13. Now import tables using ODBC connection from oracle db. Change the names of the tables to match exactly as earlier tables. As these names are used in forms and other place.
14. Now the insertions, modifications reflects in oracle db of aws. 




Data Model (Entity Relationship Diagram):
![relationship](https://user-images.githubusercontent.com/32714796/36077934-ac6a0b10-0f3e-11e8-9f94-a3b61e7a0510.PNG)

Application Login Page:
![login_page](https://user-images.githubusercontent.com/32714796/36077938-b48c31a6-0f3e-11e8-82f8-0fcfb21088f8.PNG)

Application Home Page:
![home](https://user-images.githubusercontent.com/32714796/36077939-b778e65c-0f3e-11e8-92bf-304c4d89dff4.PNG)

Global Foot print:
![globalfootprint](https://user-images.githubusercontent.com/32714796/34234400-e8f1dfcc-e5b8-11e7-865b-86130737efc8.PNG)
