
/*Purchase Orders Audit -  To audit the orders placed to suppliers, we will log the details*/

create table purchase_order_log
(operation varchar(20), time_stamp varchar(30), SYS_USER char(30), old_supplier char(20), new_supplier char(20),
product_number char(20), 
old_quantity char(20), new_quantity char(20));



create or replace trigger PURCHASE_ORDER_AUDIT
AFTER INSERT OR DELETE OR UPDATE ON PURCHASE_ORDER
FOR EACH ROW
ENABLE /*by this class we will have the trigger start working as soon as we compile it*/
DECLARE
    sys_date varchar2(30); /*To have time stamp we need to convert current time to hr min sec format*/
BEGIN
select TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS') INTO sys_date from dual;
IF INSERTING THEN
    INSERT INTO purchase_order_log(operation, time_stamp, SYS_USER, old_supplier, new_supplier, product_number, old_quantity, new_quantity)
    VALUES ('Insert', sys_date, user, NULL, :NEW.SUPPLIER_ID, :NEW.PRODUCT_NUMBER, NULL, :NEW.QUANTITY_ORDERED);
ELSIF UPDATING THEN
    INSERT INTO purchase_order_log(operation, time_stamp, SYS_USER, old_supplier, new_supplier, product_number, old_quantity, new_quantity)
    VALUES ('Update', sys_date, user, :OLD.SUPPLIER_ID, :NEW.SUPPLIER_ID, :NEW.PRODUCT_NUMBER, :OLD.QUANTITY_ORDERED, :NEW.QUANTITY_ORDERED);
ELSIF DELETING THEN
    INSERT INTO purchase_order_log(operation, time_stamp, SYS_USER, old_supplier, new_supplier, product_number, old_quantity, new_quantity)
    VALUES ('DElETE', sys_date, user, :OLD.SUPPLIER_ID, NULL, :OLD.PRODUCT_NUMBER, :OLD.QUANTITY_ORDERED, NULL);
END IF;
END;


/*Customer Table Audit*/

create table customer_table_log
OPERATION varchar(20), TIME_STAMP varchar(30), SYS_USER char(30), CUSTOMER_NUMBER varchar(30), CUSTOMER_FIRST_NAME char(30),
OLD_ADDRESS varchar(30), NEW_ADDRESS varchar(30), OLD_CITY varchar(30), NEW_CITY varchar(30), 
OLD_STATE varchar(30), NEW_STATE varchar(30), OLD_ZIP varchar(30), NEW_ZIP varchar(30), 
OLD_CUSTOMER_DISCOUNT varchar(30), OLD_CUSTOMER_DISCOUNT varchar(30), OLD_PHONE varchar(30), OLD_PHONE varchar(30), OLD_CONTACT_PERSON varchar(30), NEW_CONTACT_PERSON varchar(30));
);




/*CUSTOMER TABLE LOG AND AUDIT TRIGGERS:*/


/*Customer Table Audit*/

create table customer_table_log
(OPERATION varchar(20), 
TIME_STAMP varchar(30), 
SYS_USER char(30), 
CUSTOMER_NUMBER varchar(30), 
CUSTOMER_FIRST_NAME varchar(30),
OLD_ADDRESS varchar(40), 
NEW_ADDRESS varchar(40), 
OLD_CITY varchar(30), 
NEW_CITY varchar(30), 
OLD_STATE char(2),
NEW_STATE char(2), 
OLD_ZIP char(5), 
NEW_ZIP char(5), 
OLD_CUSTOMER_DISCOUNT varchar(30), 
NEW_CUSTOMER_DISCOUNT varchar(30), 
OLD_PHONE char(10), 
NEW_PHONE char(10), 
OLD_CONTACT_PERSON varchar(30), 
NEW_CONTACT_PERSON varchar(30));

/*Trigger to log changes to customer table*/

create or replace trigger CUSTOMER_TABLE_AUDIT
AFTER INSERT OR DELETE OR UPDATE ON CUSTOMER
FOR EACH ROW
ENABLE /*by this class we will have the trigger start working as soon as we compile it*/
DECLARE
    sys_date varchar2(30); /*To have time stamp we need to convert current time to hr min sec format*/
BEGIN
select TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS') INTO sys_date from dual;
IF INSERTING THEN
    INSERT INTO customer_table_log
    (operation, time_stamp, SYS_USER, CUSTOMER_NUMBER, CUSTOMER_FIRST_NAME, 
    OLD_ADDRESS, NEW_ADDRESS, OLD_CITY, NEW_CITY, OLD_STATE, NEW_STATE, 
    OLD_ZIP, NEW_ZIP, OLD_CUSTOMER_DISCOUNT, NEW_CUSTOMER_DISCOUNT , 
    OLD_PHONE, NEW_PHONE, OLD_CONTACT_PERSON, NEW_CONTACT_PERSON)
    VALUES ('Insert', sys_date, user, :NEW.CUSTOMER_NUMBER, :NEW.CUSTOMER_FIRST_NAME, NULL,
    :NEW.ADDRESS, NULL, :NEW.CITY, NULL, :NEW.STATE, NULL, :NEW.ZIP, NULL, :NEW.CUSTOMER_DISCOUNT, 
    NULL, :NEW.PHONE, NULL, :NEW.CONTACT_PERSON);

ELSIF UPDATING THEN
    INSERT INTO customer_table_log
    (operation, time_stamp, SYS_USER, CUSTOMER_NUMBER, CUSTOMER_FIRST_NAME, 
    OLD_ADDRESS, NEW_ADDRESS, OLD_CITY, NEW_CITY, OLD_STATE, NEW_STATE, 
    OLD_ZIP, NEW_ZIP, OLD_CUSTOMER_DISCOUNT, NEW_CUSTOMER_DISCOUNT , 
    OLD_PHONE, NEW_PHONE, OLD_CONTACT_PERSON, NEW_CONTACT_PERSON)
    VALUES ('Update', sys_date, user, :NEW.CUSTOMER_NUMBER, :NEW.CUSTOMER_FIRST_NAME, :OLD.ADDRESS,
    :NEW.ADDRESS, :OLD.CITY, :NEW.CITY, :OLD.STATE, :NEW.STATE, :OLD.ZIP, :NEW.ZIP, :OLD.CUSTOMER_DISCOUNT, :NEW.CUSTOMER_DISCOUNT, 
    :OLD.PHONE, :NEW.PHONE, :OLD.CONTACT_PERSON, :NEW.CONTACT_PERSON);


ELSIF DELETING THEN
    INSERT INTO customer_table_log
    (operation, time_stamp, SYS_USER, CUSTOMER_NUMBER, CUSTOMER_FIRST_NAME, 
    OLD_ADDRESS, NEW_ADDRESS, OLD_CITY, NEW_CITY, OLD_STATE, NEW_STATE, 
    OLD_ZIP, NEW_ZIP, OLD_CUSTOMER_DISCOUNT, NEW_CUSTOMER_DISCOUNT , 
    OLD_PHONE, NEW_PHONE, OLD_CONTACT_PERSON, NEW_CONTACT_PERSON)
    
    VALUES ('Delete', sys_date, user, :NEW.CUSTOMER_NUMBER, :NEW.CUSTOMER_FIRST_NAME, :OLD.ADDRESS,
    NULL, :OLD.CITY, NULL, :OLD.STATE, NULL, :OLD.ZIP, NULL, :OLD.CUSTOMER_DISCOUNT, NULL, 
    :OLD.PHONE, NULL, :OLD.CONTACT_PERSON, NULL);
    
END IF;
END;






/*Inventory Audit*/

create table AUDIT_INVENTORY
(OPERATION varchar(20), 
TIME_STAMP varchar(30), 
SYS_USER char(30), 
PRODUCT_NUMBER varchar(30), 
OLD_DEMAND_RATE varchar(40), 
NEW_DEMAND_RATE varchar(40), 
OLD_HOLDING_COST varchar(30), 
NEW_HOLDING_COST varchar(30), 
OLD_SETUP_COST varchar(30), 
NEW_SETUP_COST varchar(30)
);

/*Trigger to log changes to customer table*/

create or replace trigger AUDIT_INVENTORY
AFTER INSERT or UPDATE or DELETE ON INVENTORY
FOR EACH ROW
ENABLE /*by this class we will have the trigger start working as soon as we compile it*/
DECLARE
    sys_date varchar2(30); /*To have time stamp we need to convert current time to hr min sec format*/
BEGIN
select TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS') INTO sys_date from dual;
IF INSERTING THEN
    INSERT INTO AUDIT_INVENTORY_LOG
    (operation, time_stamp, SYS_USER, PRODUCT_NUMBER, OLD_DEMAND_RATE, NEW_DEMAND_RATE, 
    OLD_HOLDING_COST, NEW_HOLDING_COST, OLD_SETUP_COST, NEW_SETUP_COST)
    VALUES ('Insert', sys_date, user, :NEW.PRODUCT_NUMBER, NULL, :NEW.DEMAND_RATE, NULL,
    :NEW.HOLDING_COST, NULL, :NEW.SETUP_COST);

ELSIF UPDATING THEN
     INSERT INTO AUDIT_INVENTORY_LOG
    (operation, time_stamp, SYS_USER, PRODUCT_NUMBER, OLD_DEMAND_RATE, NEW_DEMAND_RATE, 
    OLD_HOLDING_COST, NEW_HOLDING_COST, OLD_SETUP_COST, NEW_SETUP_COST)
    VALUES ('Update', sys_date, user, :NEW.PRODUCT_NUMBER, :OLD.DEMAND_RATE, :NEW.DEMAND_RATE, :OLD.HOLDING_COST,
    :NEW.HOLDING_COST, :OLD.SETUP_COST, :NEW.SETUP_COST);

ELSIF DELETING THEN
     INSERT INTO AUDIT_INVENTORY_LOG
    (operation, time_stamp, SYS_USER, PRODUCT_NUMBER, OLD_DEMAND_RATE, NEW_DEMAND_RATE, 
    OLD_HOLDING_COST, NEW_HOLDING_COST, OLD_SETUP_COST, NEW_SETUP_COST)
    VALUES ('Delete', sys_date, user, :OLD.PRODUCT_NUMBER,  :OLD.DEMAND_RATE, NULL,
    :OLD.HOLDING_COST, NULL, :OLD.SETUP_COST,NULL);
    
END IF;
END;



/*Audit Product Details*/


create table AUDIT_PRODUCT_LOG
(OPERATION varchar(20), 
TIME_STAMP varchar(30), 
SYS_USER char(30), 
PRODUCT_NUMBER varchar(30), 
OLD_DESCRIPTION varchar(40), 
NEW_DESCRIPTION varchar(40), 
OLD_PRICE varchar(30), 
NEW_PRICE varchar(30), 
OLD_DISCOUNT varchar(30), 
NEW_DISCOUNT varchar(30)
);


create or replace trigger AUDIT_PRODUCT
AFTER INSERT or UPDATE or DELETE ON PRODUCT
FOR EACH ROW
ENABLE /*by this class we will have the trigger start working as soon as we compile it*/
DECLARE
    sys_date varchar2(30); /*To have time stamp we need to convert current time to hr min sec format*/
BEGIN
select TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS') INTO sys_date from dual;
IF INSERTING THEN
    INSERT INTO AUDIT_PRODUCT_LOG
    (operation, time_stamp, SYS_USER, PRODUCT_NUMBER, OLD_DESCRIPTION, NEW_DESCRIPTION, 
    OLD_PRICE, NEW_PRICE, OLD_DISCOUNT, NEW_DISCOUNT)
    VALUES ('Insert', sys_date, user, :NEW.PRODUCT_NUMBER, NULL, :NEW.DESCRIPTION, NULL,
    :NEW.PRICE, NULL, :NEW.DISCOUNT);

ELSIF UPDATING THEN
     INSERT INTO AUDIT_PRODUCT_LOG
    (operation, time_stamp, SYS_USER, PRODUCT_NUMBER, OLD_DESCRIPTION, NEW_DESCRIPTION, 
    OLD_PRICE, NEW_PRICE, OLD_DISCOUNT, NEW_DISCOUNT)
    VALUES ('Update', sys_date, user, :NEW.PRODUCT_NUMBER, :OLD.DESCRIPTION, :NEW.DESCRIPTION, :OLD.PRICE,
    :NEW.PRICE, :OLD.DISCOUNT, :NEW.DISCOUNT);

ELSIF DELETING THEN
     INSERT INTO AUDIT_PRODUCT_LOG
    (operation, time_stamp, SYS_USER, PRODUCT_NUMBER, OLD_DESCRIPTION, NEW_DESCRIPTION, 
    OLD_PRICE, NEW_PRICE, OLD_DISCOUNT, NEW_DISCOUNT)
    VALUES ('Delete', sys_date, user, :OLD.PRODUCT_NUMBER, :OLD.DESCRIPTION, NULL, :OLD.PRICE,
    NULL, :OLD.DISCOUNT, NULL);
    
END IF;
END;




/*Bitmap indexes
Conventional wisdom holds that bitmap indexes are most appropriate for columns having low distinct values--such as GENDER, MARITAL_STATUS, and RELATION.
 This assumption is not completely accurate, however. In reality, a bitmap index is always advisable for systems in which data is not frequently updated 
by many concurrent systems. In fact, as I'll demonstrate here, a bitmap index on a column with 100-percent unique values (a column candidate for primary key)
 is as efficient as a B-tree index.

Oracle's two major index types are Bitmap indexes and B-Tree indexes. B-Tree indexes are the regular type that OLTP systems make much use of, and bitmap
 indexes are a highly compressed index type that tends to be used primarily for data warehouses.

Characteristic of Bitmap Indexes

For columns with very few unique values (low cardinality)
Columns that have low cardinality are good candidates (if the cardinality of a column is <= 0.1 %  that the column is ideal candidate, consider also 0.2% – 1%)

Tables that have no or little insert/update are good candidates (static data in warehouse)
 
Stream of bits: each bit relates to a column value in a single row of table
create bitmap index person_region on person (region);

        Row     Region   North   East   West   South
        1       North        1      0      0       0
        2       East         0      1      0       0
        3       West         0      0      1       0
        4       West         0      0      1       0
        5       South        0      0      0       1
        6       North        1      0      0       0

Advantage of Bitmap Indexes

The advantages of them are that they have a highly compressed structure, making them fast to read and their structure makes it possible for the system to
 combine multiple indexes together for fast access to the underlying table.



****************************************/
create BITMAP INDEX bitmap_customer_state on CUSTOMER(STATE);












SQL Analytics

RANK()
Determines the rank of a value in a group of values , based on the order by exp in the over clause

rows with equl values for the raniking criteria receive the same rank
add the no. of tied rows to the tied rank to calc the next rank and thus the ranks might not be consec nums

USAGE: Computes ranks to sales figs within deps of a business


SELECT employees.*, RANK() OVER (PARTITION BY department_id ORDER BY salary DESC NULLS LAST) FROM employees ORDER BY department_id, salary DESC NULL LAST;


select  employees.*, RANK() OVER (ORDER BY salary desc) RANK,
DENSE_RANK() OVER(ORDER BY salary desc) DENSE_RANK
FROM employees
WHERE department_id=20
ORDER BY salary DESC;


PERCENT RANK()

select  employees.*, percent_RANK() OVER (ORDER BY salary desc)
FROM employees
WHERE department_id=30
ORDER BY salary DESC;




AVG
SELECT *, AVG(salary) OVER (PARTITION BY department_id ORDER BY hire_date
select *, avg(salary) over(partition by department_id) as avgsalary from employees;

select *, avg(qty) over(order by dateid, salesid rows unbounded preceding) as avgs 
from winsales order by 2;


ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Rolling_Avg FROM employees ORDER BY department_id, hire_date;

/*ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW  which says top of the table to current row in the department*/

ROW NUMBER()

select *, ROW_NUMBER() OVER(ORDER BY score DESC) FROM students ORDER BY score, studentid DESC;

select * FROM( SELECT *, ROW_NUMBER() OVER(PARTITION BY department_id ORDER BY salary ASC)as rowNum FROM employees)t where employees.rowNum < 4 ; /*To select only top 3*/

select *, ROW_NUMBER() OVER(ORDER BY qty ASC) FROM winsales;


NTILE
quartile, like division
select *, NTILE(4) OVER(PARTITION BY sellerid  ORDER BY qty DESC) FROM winsales ORDER BY sellerid, qty;


SELECT p.FirstName, p.LastName
    ,NTILE(4) OVER(ORDER BY SalesYTD DESC) AS Quartile
    ,CONVERT(nvarchar(20),s.SalesYTD,1) AS SalesYTD
    , a.PostalCode
FROM Sales.SalesPerson AS s 
INNER JOIN Person.Person AS p 
    ON s.BusinessEntityID = p.BusinessEntityID
INNER JOIN Person.Address AS a 
    ON a.AddressID = p.BusinessEntityID
WHERE TerritoryID IS NOT NULL 
    AND SalesYTD <> 0;

SUM()

select *, sum(salary) over(partition by department_id order by salary DESC rows between unbounded preceding and unbounded following ) as SUMSALRY 
from employees order by department_id DESC;



MAX()
select *, max(salary) over() as Max_Salary
from employees;

MIN()
select *, min(salary) over(partition by department_id) as min_salary
from employees;

CUME_DIST
FIRST_VALUE()
select *, first_value(name) over(order by salary DESC rows between unbounded preceding and unbounded following) as least_sal
from employees;


LAST_VALUE
COUNT

NTH_VALUE()
select *, nth_value(salary,4) over(order by salary DESC rows between unbounded preceding and unbounded following) as fourth_sal
from employees;


SELECT department_id,
       employee_id,
       salary,
       name,
       NTH_VALUE(name,3) OVER (PARTITION BY department_id ORDER BY salary DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED following) third_highest_salary_by_department
FROM Employees
ORDER BY department_id,
         salary DESC


LAG


LEAD
MEDIAN
PERCENTILE_CONT
PERCENTILE_DISC
RATION_TO_REPORT
STDDEV_POP
STDDEV_SAMP
VAR_POP
VAR_SAMP


MODEL

SELECT SUBSTR(country, 1, 20) country, 
      SUBSTR(product, 1, 15) product, year, sales
FROM sales_view
WHERE country IN ('Italy', 'Japan')
MODEL
  PARTITION BY (country) DIMENSION BY (product, year)
  MEASURES (sales sales)
  RULES 
  (sales['Bounce', 2002] = sales['Bounce', 2001] + sales['Bounce', 2000],
   sales['Y Box', 2002] = sales['Y Box', 2001],
   sales['All_Products', 2002] = sales['Bounce', 2002] + sales['Y Box', 2002])
ORDER BY country, product, year;






CREATE OR REPLACE TRIGGER customer_trigger_update 
AFTER
    UPDATE ON CUSTOMER
      
FOR EACH ROW
    
BEGIN
      UPDATE customer@meghadbinstance_test1
      
SET  CUSTOMER_FIRST_NAME = :NEW.CUSTOMER_FIRST_NAME 
WHERE CUSTOMER_FIRST_NAME= :OLD.CUSTOMER_FIRST_NAME;
        
END;

































------------------------------------------------------------------------------------------------------------------------------
DBLink Triggers:

------------------------------------------
create database link sharif_link
connect to oraadmin identified by "password"
using '(description=(address=(protocol=tcp)(host=myinstance.cb1wutgkdb52.us-east-1.rds.amazonaws.com) (port=1521))(connect_data=(sid=orcl)))'


CREATE OR REPLACE TRIGGER customer_insert_trigger AFTER
    INSERT ON CUSTOMER--current DB
    FOR EACH ROW
BEGIN
    INSERT INTO customer@sharif_link ( -- remote DB
        "CUSTOMER_NUMBER",
        "CUSTOMER_FIRST_NAME",
        "CUSTOMER_LAST_NAME",
        "ADDRESS",
        "CITY" ,
        "STATE",
        "ZIP",
        "CUSTOMER_DISCOUNT",
        "PHONE",
        "FAX",
        "CONTACT_PERSON"
    ) VALUES (
        :new."CUSTOMER_NUMBER",
        :new."CUSTOMER_FIRST_NAME",
        :new."CUSTOMER_LAST_NAME",
        :new."ADDRESS",
        :new."CITY" ,
        :new."STATE",
        :new."ZIP",
        :new."CUSTOMER_DISCOUNT",
        :new."PHONE",
        :new."FAX",
        :new."CONTACT_PERSON"
    );

END;


--Product Insert Trigger
CREATE OR REPLACE TRIGGER product_insert AFTER
    INSERT ON PRODUCT
    FOR EACH ROW
BEGIN
    INSERT INTO PRODUCT@sharif_link ( 
        "PRODUCT_NUMBER",
        "DESCRIPTION",
        "PRICE",
        "DISCOUNT"
    ) VALUES (
        :new."PRODUCT_NUMBER",
        :new."DESCRIPTION",
        :new."PRICE",
        :new."DISCOUNT"
    );

END;




--Purchase Order Insert Trigger
CREATE OR REPLACE TRIGGER purchase_order_insert AFTER
    INSERT ON PURCHASE_ORDER
    FOR EACH ROW
BEGIN
    INSERT INTO PURCHASE_ORDER@sharif_link ( 
        "PURCHASE_ORDER_ID",
        "PRODUCT_NUMBER",
        "QUANTITY_ORDERED",
        "PURCHASE_ORDER_DATE",
        "PURCHASE_DELIVERY_DATE",
        "SHIPPER_ID",
        "PURCHASE_ORDER_STATUS"
    ) VALUES (
        :new."PURCHASE_ORDER_ID",
        :new."PRODUCT_NUMBER",
        :new."QUANTITY_ORDERED",
        :new."PURCHASE_ORDER_DATE",
        :new."PURCHASE_DELIVERY_DATE",
        :new."SHIPPER_ID",
        :new."PURCHASE_ORDER_STATUS"    
    );

END;


--Supplier Details Insert Trigger
CREATE OR REPLACE TRIGGER supplier_details_insert AFTER
    INSERT ON SUPPLIER_DETAILS
    FOR EACH ROW
BEGIN
    INSERT INTO SUPPLIER_DETAILS@sharif_link ( 
        "SUPPLIER_ID",
        "SUPPLIER_NAME",
        "SUPPLIER_PHONE"
    ) VALUES (
        :new."SUPPLIER_ID",
        :new."SUPPLIER_NAME",
        :new."SUPPLIER_PHONE"  
    );

END;


--Supplier Details Update Trigger
CREATE OR REPLACE TRIGGER supplier_details_update AFTER 
    UPDATE ON SUPPLIER_DETAILS
      FOR EACH ROW
    BEGIN
        UPDATE SUPPLIER_DETAILS@sharif_link 
        SET SUPPLIER_NAME = :NEW.SUPPLIER_NAME WHERE SUPPLIER_ID= :OLD.SUPPLIER_ID;
        UPDATE SUPPLIER_DETAILS@sharif_link
        SET SUPPLIER_PHONE = :NEW.SUPPLIER_PHONE WHERE SUPPLIER_ID= :OLD.SUPPLIER_ID;
    END;


--Purchase Order Update Trigger
CREATE OR REPLACE TRIGGER purchase_order_update AFTER 
    UPDATE ON PURCHASE_ORDER
      FOR EACH ROW
    BEGIN
        UPDATE PURCHASE_ORDER@sharif_link
        SET PRODUCT_NUMBER = :NEW.PRODUCT_NUMBER WHERE PURCHASE_ORDER_ID= :OLD.PURCHASE_ORDER_ID;
        UPDATE PURCHASE_ORDER@sharif_link
        SET QUANTITY_ORDERED = :NEW.QUANTITY_ORDERED WHERE PURCHASE_ORDER_ID= :OLD.PURCHASE_ORDER_ID;
        UPDATE PURCHASE_ORDER@sharif_link
        SET PURCHASE_ORDER_DATE = :NEW.PURCHASE_ORDER_DATE WHERE PURCHASE_ORDER_ID= :OLD.PURCHASE_ORDER_ID;
        UPDATE PURCHASE_ORDER@sharif_link
        SET PURCHASE_DELIVERY_DATE= :NEW.PURCHASE_DELIVERY_DATE WHERE PURCHASE_ORDER_ID= :OLD.PURCHASE_ORDER_ID;
        UPDATE PURCHASE_ORDER@sharif_link
        SET SHIPPER_ID = :NEW.SHIPPER_ID WHERE PURCHASE_ORDER_ID= :OLD.PURCHASE_ORDER_ID;
        UPDATE PURCHASE_ORDER@sharif_link
        SET PURCHASE_ORDER_STATUS = :NEW.PURCHASE_ORDER_STATUS WHERE PURCHASE_ORDER_ID= :OLD.PURCHASE_ORDER_ID;
END;


--Product Update Trigger
CREATE OR REPLACE TRIGGER product_update AFTER 
    UPDATE ON PRODUCT 
      FOR EACH ROW
    BEGIN
        UPDATE PRODUCT@sharif_link
        SET DESCRIPTION = :NEW.DESCRIPTION WHERE PRODUCT_NUMBER= :OLD.PRODUCT_NUMBER;
        UPDATE PRODUCT@sharif_link
        SET PRICE = :NEW.PRICE WHERE PRODUCT_NUMBER= :OLD.PRODUCT_NUMBER;
        UPDATE PRODUCT@sharif_link
        SET DISCOUNT = :NEW.DISCOUNT WHERE PRODUCT_NUMBER= :OLD.PRODUCT_NUMBER;
        
END;







--Product Insert Trigger
CREATE OR REPLACE TRIGGER product_insert AFTER
    INSERT ON PRODUCT
    FOR EACH ROW
BEGIN
    INSERT INTO PRODUCT@sharif_link ( 
        "PRODUCT_NUMBER",
        "DESCRIPTION",
        "PRICE",
        "DISCOUNT"
    ) VALUES (
        :new."PRODUCT_NUMBER",
        :new."DESCRIPTION",
        :new."PRICE",
        :new."DISCOUNT"
    );

END;




--Purchase Order Insert Trigger
CREATE OR REPLACE TRIGGER purchase_order_insert AFTER
    INSERT ON PURCHASE_ORDER
    FOR EACH ROW
BEGIN
    INSERT INTO PURCHASE_ORDER@sharif_link ( 
        "PURCHASE_ORDER_ID",
        "PRODUCT_NUMBER",
        "QUANTITY_ORDERED",
        "PURCHASE_ORDER_DATE",
        "PURCHASE_DELIVERY_DATE",
        "SHIPPER_ID",
        "PURCHASE_ORDER_STATUS"
    ) VALUES (
        :new."PURCHASE_ORDER_ID",
        :new."PRODUCT_NUMBER",
        :new."QUANTITY_ORDERED",
        :new."PURCHASE_ORDER_DATE",
        :new."PURCHASE_DELIVERY_DATE",
        :new."SHIPPER_ID",
        :new."PURCHASE_ORDER_STATUS"    
    );

END;


--Supplier Details Insert Trigger
CREATE OR REPLACE TRIGGER supplier_details_insert AFTER
    INSERT ON SUPPLIER_DETAILS
    FOR EACH ROW
BEGIN
    INSERT INTO SUPPLIER_DETAILS@sharif_link ( 
        "SUPPLIER_ID",
        "SUPPLIER_NAME",
        "SUPPLIER_PHONE"
    ) VALUES (
        :new."SUPPLIER_ID",
        :new."SUPPLIER_NAME",
        :new."SUPPLIER_PHONE"  
    );

END;


--Supplier Details Update Trigger
CREATE OR REPLACE TRIGGER supplier_details_update AFTER 
    UPDATE ON SUPPLIER_DETAILS
      FOR EACH ROW
    BEGIN
        UPDATE SUPPLIER_DETAILS@sharif_link 
        SET SUPPLIER_NAME = :NEW.SUPPLIER_NAME WHERE SUPPLIER_ID= :OLD.SUPPLIER_ID;
        UPDATE SUPPLIER_DETAILS@sharif_link
        SET SUPPLIER_PHONE = :NEW.SUPPLIER_PHONE WHERE SUPPLIER_ID= :OLD.SUPPLIER_ID;
    END;


--Purchase Order Update Trigger
CREATE OR REPLACE TRIGGER purchase_order_update AFTER 
    UPDATE ON PURCHASE_ORDER
      FOR EACH ROW
    BEGIN
        UPDATE PURCHASE_ORDER@sharif_link
        SET PRODUCT_NUMBER = :NEW.PRODUCT_NUMBER WHERE PURCHASE_ORDER_ID= :OLD.PURCHASE_ORDER_ID;
        UPDATE PURCHASE_ORDER@sharif_link
        SET QUANTITY_ORDERED = :NEW.QUANTITY_ORDERED WHERE PURCHASE_ORDER_ID= :OLD.PURCHASE_ORDER_ID;
        UPDATE PURCHASE_ORDER@sharif_link
        SET PURCHASE_ORDER_DATE = :NEW.PURCHASE_ORDER_DATE WHERE PURCHASE_ORDER_ID= :OLD.PURCHASE_ORDER_ID;
        UPDATE PURCHASE_ORDER@sharif_link
        SET PURCHASE_DELIVERY_DATE= :NEW.PURCHASE_DELIVERY_DATE WHERE PURCHASE_ORDER_ID= :OLD.PURCHASE_ORDER_ID;
        UPDATE PURCHASE_ORDER@sharif_link
        SET SHIPPER_ID = :NEW.SHIPPER_ID WHERE PURCHASE_ORDER_ID= :OLD.PURCHASE_ORDER_ID;
        UPDATE PURCHASE_ORDER@sharif_link
        SET PURCHASE_ORDER_STATUS = :NEW.PURCHASE_ORDER_STATUS WHERE PURCHASE_ORDER_ID= :OLD.PURCHASE_ORDER_ID;
END;


--Product Update Trigger
CREATE OR REPLACE TRIGGER product_update AFTER 
    UPDATE ON PRODUCT 
      FOR EACH ROW
    BEGIN
        UPDATE PRODUCT@sharif_link
        SET DESCRIPTION = :NEW.DESCRIPTION WHERE PRODUCT_NUMBER= :OLD.PRODUCT_NUMBER;
        UPDATE PRODUCT@sharif_link
        SET PRICE = :NEW.PRICE WHERE PRODUCT_NUMBER= :OLD.PRODUCT_NUMBER;
        UPDATE PRODUCT@sharif_link
        SET DISCOUNT = :NEW.DISCOUNT WHERE PRODUCT_NUMBER= :OLD.PRODUCT_NUMBER;
        
END;




--customer insert

CREATE OR REPLACE TRIGGER customerinsert AFTER
    INSERT ON CUSTOMER--current DB
    FOR EACH ROW
BEGIN
    INSERT INTO customer@sharif_link ( -- remote DB
        "CUSTOMER_NUMBER",
        "CUSTOMER_FIRST_NAME",
        "CUSTOMER_LAST_NAME",
        "ADDRESS",
        "CITY" ,
        "STATE",
        "ZIP",
        "CUSTOMER_DISCOUNT",
        "PHONE",
        "FAX",
        "CONTACT_PERSON"
    ) VALUES (
        :new."CUSTOMER_NUMBER",
        :new."CUSTOMER_FIRST_NAME",
        :new."CUSTOMER_LAST_NAME",
        :new."ADDRESS",
        :new."CITY" ,
        :new."STATE",
        :new."ZIP",
        :new."CUSTOMER_DISCOUNT",
        :new."PHONE",
        :new."FAX",
        :new."CONTACT_PERSON"
    );

END;

--Product Insert Trigger
CREATE OR REPLACE TRIGGER product_insert AFTER
    INSERT ON PRODUCT
    FOR EACH ROW
BEGIN
    INSERT INTO PRODUCT@sharif_link ( 
        "PRODUCT_NUMBER",
        "DESCRIPTION",
        "PRICE",
        "DISCOUNT"
    ) VALUES (
        :new."PRODUCT_NUMBER",
        :new."DESCRIPTION",
        :new."PRICE",
        :new."DISCOUNT"
    );

END;

--Order_sales insert
CREATE OR REPLACE TRIGGER ordersalesinserts AFTER
    INSERT ON ORDER_SALES--current DB
    FOR EACH ROW
BEGIN
    INSERT INTO ORDER_SALES@sharif_link ( -- remote DB
        "ORDER_NUMBER",
        "CUSTOMER_NUMBER",
        "ORDER_DATE",
        "SHIPPING_DATE",
        "ESTIMATED_DELIVERY_DATE" ,
        "ACTUAL_DELIVERY_DATE",
        "ORDER_STATUS",
        "SHIPPER_ID",
        "ADDRESS_INDICATOR"
        
    ) VALUES (
        :new."ORDER_NUMBER",
        :new."CUSTOMER_NUMBER",
        :new."ORDER_DATE",
        :new."SHIPPING_DATE",
        :new."ESTIMATED_DELIVERY_DATE" ,
        :new."ACTUAL_DELIVERY_DATE",
        :new."ORDER_STATUS",
        :new."SHIPPER_ID",
        :new."ADDRESS_INDICATOR"
       
    );

END;


--Mode of shipping insert
CREATE OR REPLACE TRIGGER modeofshippinginsert AFTER
    INSERT ON MODE_OF_SHIPPING--current DB
    FOR EACH ROW
BEGIN
    INSERT INTO MODE_OF_SHIPPING@sharif_link ( -- remote DB
        "SHIPPER_ID",
        "SHIPPER_NAME",
        "SHIPPER_COST",
        "SHIPPER_GUARANTEE"
        
        
    ) VALUES (
        :new."SHIPPER_ID",
        :new."SHIPPER_NAME",
        :new."SHIPPER_COST",
        :new."SHIPPER_GUARANTEE"
        
       
    );

END;


--Inventory insert Trigger
CREATE OR REPLACE TRIGGER inventoryinsert AFTER
    INSERT ON INVENTORY--current DB
    FOR EACH ROW
BEGIN
    INSERT INTO INVENTORY@sharif_link ( -- remote DB
        "PRODUCT_NUMBER",
        "MAX_QUANTITY",
        "QUANTITY_AT_HAND",
        "DEMAND_RATE",
	"HOLDING_COST",
	"SETUP_COST"
		
        
        
    ) VALUES (
        :new."PRODUCT_NUMBER",
        :new."MAX_QUANTITY",
        :new."QUANTITY_AT_HAND",
        :new."DEMAND_RATE",
	:new."HOLDING_COST",
	:new."SETUP_COST"
		
        
       
    );
	END;


--OrderLine Insert
CREATE OR REPLACE TRIGGER orderlineinsert AFTER
    INSERT ON ORDER_LINE--current DB
    FOR EACH ROW
BEGIN
    INSERT INTO ORDER_LINE@sharif_link ( -- remote DB
        "ORDERLINE_ID",
        "ORDER_NUMBER",
        "PRODUCT_NUMBER",
        "QUANTITY_ORDERED"
        
        
    ) VALUES (
        :new."ORDERLINE_ID",
        :new."ORDER_NUMBER",
        :new."PRODUCT_NUMBER",
        :new."QUANTITY_ORDERED"
        
       
    );
	END;




--Purchase Order Insert Trigger
CREATE OR REPLACE TRIGGER purchase_order_insert AFTER
    INSERT ON PURCHASE_ORDER
    FOR EACH ROW
BEGIN
    INSERT INTO PURCHASE_ORDER@sharif_link ( 
        "PURCHASE_ORDER_ID",
        "PRODUCT_NUMBER",
        "QUANTITY_ORDERED",
        "PURCHASE_ORDER_DATE",
        "PURCHASE_DELIVERY_DATE",
        "SHIPPER_ID",
        "PURCHASE_ORDER_STATUS"
    ) VALUES (
        :new."PURCHASE_ORDER_ID",
        :new."PRODUCT_NUMBER",
        :new."QUANTITY_ORDERED",
        :new."PURCHASE_ORDER_DATE",
        :new."PURCHASE_DELIVERY_DATE",
        :new."SHIPPER_ID",
        :new."PURCHASE_ORDER_STATUS"    
    );

END;


--Supplier Details Insert Trigger
CREATE OR REPLACE TRIGGER supplier_details_insert AFTER
    INSERT ON SUPPLIER_DETAILS
    FOR EACH ROW
BEGIN
    INSERT INTO SUPPLIER_DETAILS@sharif_link ( 
        "SUPPLIER_ID",
        "SUPPLIER_NAME",
        "SUPPLIER_PHONE"
    ) VALUES (
        :new."SUPPLIER_ID",
        :new."SUPPLIER_NAME",
        :new."SUPPLIER_PHONE"  
    );

END;


--Supplier Details Update Trigger
CREATE OR REPLACE TRIGGER supplier_details_update AFTER 
    UPDATE ON SUPPLIER_DETAILS
      FOR EACH ROW
    BEGIN
        UPDATE SUPPLIER_DETAILS@sharif_link 
        SET SUPPLIER_NAME = :NEW.SUPPLIER_NAME WHERE SUPPLIER_ID= :OLD.SUPPLIER_ID;
        UPDATE SUPPLIER_DETAILS@sharif_link
        SET SUPPLIER_PHONE = :NEW.SUPPLIER_PHONE WHERE SUPPLIER_ID= :OLD.SUPPLIER_ID;
    END;


--Purchase Order Update Trigger
CREATE OR REPLACE TRIGGER purchase_order_update AFTER 
    UPDATE ON PURCHASE_ORDER
      FOR EACH ROW
    BEGIN
        UPDATE PURCHASE_ORDER@sharif_link
        SET PRODUCT_NUMBER = :NEW.PRODUCT_NUMBER WHERE PURCHASE_ORDER_ID= :OLD.PURCHASE_ORDER_ID;
        UPDATE PURCHASE_ORDER@sharif_link
        SET QUANTITY_ORDERED = :NEW.QUANTITY_ORDERED WHERE PURCHASE_ORDER_ID= :OLD.PURCHASE_ORDER_ID;
        UPDATE PURCHASE_ORDER@sharif_link
        SET PURCHASE_ORDER_DATE = :NEW.PURCHASE_ORDER_DATE WHERE PURCHASE_ORDER_ID= :OLD.PURCHASE_ORDER_ID;
        UPDATE PURCHASE_ORDER@sharif_link
        SET PURCHASE_DELIVERY_DATE= :NEW.PURCHASE_DELIVERY_DATE WHERE PURCHASE_ORDER_ID= :OLD.PURCHASE_ORDER_ID;
        UPDATE PURCHASE_ORDER@sharif_link
        SET SHIPPER_ID = :NEW.SHIPPER_ID WHERE PURCHASE_ORDER_ID= :OLD.PURCHASE_ORDER_ID;
        UPDATE PURCHASE_ORDER@sharif_link
        SET PURCHASE_ORDER_STATUS = :NEW.PURCHASE_ORDER_STATUS WHERE PURCHASE_ORDER_ID= :OLD.PURCHASE_ORDER_ID;
END;


--Product Update Trigger
CREATE OR REPLACE TRIGGER product_update AFTER 
    UPDATE ON PRODUCT 
      FOR EACH ROW
    BEGIN
        UPDATE PRODUCT@sharif_link
        SET DESCRIPTION = :NEW.DESCRIPTION WHERE PRODUCT_NUMBER= :OLD.PRODUCT_NUMBER;
        UPDATE PRODUCT@sharif_link
        SET PRICE = :NEW.PRICE WHERE PRODUCT_NUMBER= :OLD.PRODUCT_NUMBER;
        UPDATE PRODUCT@sharif_link
        SET DISCOUNT = :NEW.DISCOUNT WHERE PRODUCT_NUMBER= :OLD.PRODUCT_NUMBER;
        
END;
--Inventory Update Trigger
CREATE OR REPLACE TRIGGER inventoryupdate AFTER 
    UPDATE ON INVENTORY--current 
      FOR EACH ROW
    BEGIN
        UPDATE INVENTORY@sharif_link
        SET MAX_QUANTITY = :NEW.MAX_QUANTITY WHERE PRODUCT_NUMBER= :OLD.PRODUCT_NUMBER;
        UPDATE INVENTORY@sharif_link
        SET QUANTITY_AT_HAND = :NEW.QUANTITY_AT_HAND WHERE PRODUCT_NUMBER= :OLD.PRODUCT_NUMBER;
        UPDATE INVENTORY@sharif_link
        SET DEMAND_RATE = :NEW.DEMAND_RATE WHERE PRODUCT_NUMBER= :OLD.PRODUCT_NUMBER;
		UPDATE INVENTORY@sharif_link
        SET HOLDING_COST = :NEW.HOLDING_COST WHERE PRODUCT_NUMBER= :OLD.PRODUCT_NUMBER;
		UPDATE INVENTORY@sharif_link
        SET SETUP_COST = :NEW.SETUP_COST WHERE PRODUCT_NUMBER= :OLD.PRODUCT_NUMBER;
        
END;
--Mode of shipping Update
CREATE OR REPLACE TRIGGER modeofshippingupdate AFTER 
    UPDATE ON MODE_OF_SHIPPING
      FOR EACH ROW
    BEGIN
	UPDATE MODE_OF_SHIPPING@sharif_link
      SET SHIPPER_NAME = :NEW.SHIPPER_NAME WHERE SHIPPER_ID= :OLD.SHIPPER_ID;
	  UPDATE MODE_OF_SHIPPING@sharif_link
      SET SHIPPER_COST = :NEW.SHIPPER_COST WHERE SHIPPER_ID= :OLD.SHIPPER_ID;
	  UPDATE MODE_OF_SHIPPING@sharif_link
      SET SHIPPER_GUARANTEE = :NEW.SHIPPER_GUARANTEE WHERE SHIPPER_ID= :OLD.SHIPPER_ID;
	  END;
--

Order sales update--
CREATE OR REPLACE TRIGGER order_sales_trigger_update AFTER 
    UPDATE ON ORDER_SALES
      FOR EACH ROW
    BEGIN
	UPDATE ORDER_SALES@sharif_link
      SET ORDER_STATUS = :NEW.ORDER_STATUS WHERE ORDER_NUMBER= :OLD.ORDER_NUMBER;
	  END;


customer update--
CREATE OR REPLACE TRIGGER customer_trigger_update AFTER 
    UPDATE ON CUSTOMER
      FOR EACH ROW
    BEGIN
	UPDATE customer@sharif_link
      SET CUSTOMER_FIRST_NAME = :NEW.CUSTOMER_FIRST_NAME WHERE CUSTOMER_NUMBER= :OLD.CUSTOMER_NUMBER;
	UPDATE customer@sharif_link
      SET CUSTOMER_LAST_NAME = :NEW.CUSTOMER_LAST_NAME WHERE CUSTOMER_NUMBER= :OLD.CUSTOMER_NUMBER;
	  UPDATE customer@sharif_link
      SET CITY = :NEW.CITY WHERE CUSTOMER_NUMBER= :OLD.CUSTOMER_NUMBER;
	  UPDATE customer@sharif_link
      SET STATE= :NEW.STATE WHERE CUSTOMER_NUMBER= :OLD.CUSTOMER_NUMBER;
      UPDATE customer@sharif_link
      SET ZIP = :NEW.ZIP WHERE CUSTOMER_NUMBER= :OLD.CUSTOMER_NUMBER;
       UPDATE customer@sharif_link
       SET ADDRESS = :NEW.ADDRESS WHERE CUSTOMER_NUMBER= :OLD.CUSTOMER_NUMBER;
        UPDATE customer@sharif_link
        SET PHONE = :NEW.PHONE WHERE CUSTOMER_NUMBER= :OLD.CUSTOMER_NUMBER;
         UPDATE customer@sharif_link
         SET FAX = :NEW.FAX WHERE CUSTOMER_NUMBER= :OLD.CUSTOMER_NUMBER;
          UPDATE customer@sharif_link
          SET CONTACT_PERSON = :NEW.CONTACT_PERSON WHERE CUSTOMER_NUMBER= :OLD.CUSTOMER_NUMBER;
           UPDATE customer@sharif_link
           SET CUSTOMER_DISCOUNT = :NEW.CUSTOMER_DISCOUNT WHERE CUSTOMER_NUMBER= :OLD.CUSTOMER_NUMBER;
        END;









SQL Analytics:


select  SUPPLIER_PRODUCT.*,
DENSE_RANK() OVER(ORDER BY unit_cost desc) as DENSE_RANK
FROM SUPPLIER_PRODUCT
ORDER BY unit_cost DESC;


select PRODUCT.*, round((avg(price) over(order by product_number)),2) as avg_price from PRODUCT order by 1;

















create or replace TRIGGER inventoryupdate AFTER 
    UPDATE ON INVENTORY--current 
      FOR EACH ROW
    BEGIN
        UPDATE INVENTORY@toMeghaDBLink
        SET MAX_QUANTITY = :NEW.MAX_QUANTITY WHERE PRODUCT_NUMBER= :OLD.PRODUCT_NUMBER;
        UPDATE INVENTORY@toMeghaDBLink
        SET QUANTITY_AT_HAND = :NEW.QUANTITY_AT_HAND WHERE PRODUCT_NUMBER= :OLD.PRODUCT_NUMBER;
        UPDATE INVENTORY@toMeghaDBLink
        SET DEMAND_RATE = :NEW.DEMAND_RATE WHERE PRODUCT_NUMBER= :OLD.PRODUCT_NUMBER;
		UPDATE INVENTORY@toMeghaDBLink
        SET HOLDING_COST = :NEW.HOLDING_COST WHERE PRODUCT_NUMBER= :OLD.PRODUCT_NUMBER;
		UPDATE INVENTORY@toMeghaDBLink
        SET SETUP_COST = :NEW.SETUP_COST WHERE PRODUCT_NUMBER= :OLD.PRODUCT_NUMBER;

END;

create or replace TRIGGER inventoryinserttomegha AFTER
    INSERT ON INVENTORY--current DB
    FOR EACH ROW
    WHERE (:new.PRODUCT_NUMBER <> :old.PRODUCT_NUMBER)
BEGIN
    INSERT INTO INVENTORY@toMeghaDBLink ( -- remote DB
        "PRODUCT_NUMBER",
        "MAX_QUANTITY",
        "QUANTITY_AT_HAND",
        "DEMAND_RATE",
	"HOLDING_COST",
	"SETUP_COST"



    ) VALUES (
        :new."PRODUCT_NUMBER",
        :new."MAX_QUANTITY",
        :new."QUANTITY_AT_HAND",
        :new."DEMAND_RATE",
	:new."HOLDING_COST",
	:new."SETUP_COST"



    );
	END;


/*Policy adding in our project*/

BEGIN
  DBMS_FGA.add_policy(
    
object_schema   => 'ORAADMIN',
    
object_name     => 'INVENTORY',
    
policy_name     => 'Qty_on_hand_Audit',
    
statement_types  => 'UPDATE',
    
audit_column    => 'QUANTITY_AT_HAND');

END;

/*ADD_POLICY Procedure
This procedure creates an audit policy using the supplied predicate as the audit condition. The maximum number of FGA policies on any table or view object is 256.
*/
Syntax

DBMS_FGA.ADD_POLICY(
   object_schema      VARCHAR2, 
   object_name        VARCHAR2, 
   policy_name        VARCHAR2, 
   audit_condition    VARCHAR2, 
   audit_column       VARCHAR2, 
   handler_schema     VARCHAR2, 
   handler_module     VARCHAR2, 
   enable             BOOLEAN, 
   statement_types    VARCHAR2,
   audit_trail        BINARY_INTEGER IN DEFAULT,
   audit_column_opts  BINARY_INTEGER IN DEFAULT);	



ALTER TABLE CUSTOMER MODIFY (PHONE ENCRYPT NO SALT);

Transparent Data Encryption (TDE) column encryption can be used for encrypting a specific column data in the database tables that are confidential, such as credit card numbers, social security numbers (SSN) and personal account numbers (PAN). This approach is useful when,

 

1.      The database tables are large.

 

2.      The columns holding the sensitive information are pre-known.


To create database tables with encrypted columns, we must use the ENCRYPT clause in its column definition in the CREATE TABLE statement as shown in the below example.

 

CREATE

  TABLE customer

  (

    cust_id      NUMBER,

    cust_name    VARCHAR2(100),

    cust_email   VARCHAR2(50) encrypt,

    cust_phone   NUMBER encrypt,

    cust_address VARCHAR2(3000) encrypt

  );

The TDE by default adds SALT (adding extra characters) to the column before its encryption. Adding SALT makes it tough for the stealers who use brute force method. We can also choose whether or not to SALT our column data before encrypting it irrespective of whether or not other encrypted columns use SALT.

 

We can also choose any other encrypting algorithm from the available list and define it through the USING clause as shown below,

 

CREATE

  TABLE customer

  (

    cust_id      NUMBER,

    cust_name    VARCHAR2(100),

    cust_email   VARCHAR2(50) encrypt no salt,

    cust_phone   NUMBER encrypt,

    cust_address VARCHAR2(3000) encrypt USING 'AES256'

  );

 

To add an encrypted column to an existing table in the database,
ALTER TABLE customer ADD (cust_ssn VARCHAR2(11) ENCRYPT USING 'AES256' salt);

To encrypt an existing column in a table in the database,
ALTER TABLE customer MODIFY (cust_name encrypt);

To decrypt an existing column in a table in the database,
ALTER TABLE customer MODIFY (cust_name decrypt);

To add SALT to an encrypted column in a table in the database,
ALTER TABLE customer MODIFY (cust_email encrypt salt); 

To remove SALT from an encrypted column in a table in the database,
ALTER TABLE customer MODIFY (cust_email encrypt no salt);

To change the encrypted key for the table containing one or more encrypted column,
ALTER TABLE customer rekey; 

To change the encryption algorithm for the table containing one or more encrypted column,
ALTER TABLE customer rekey USING '3DES168'; 

The TDE also adds a Message Authentication Code (MAC) to the data for integrity checking. The default integrity algorithm is SHA-1.
ALTER TABLE customer rekey USING '3DES168' 'SHA-1';

We can also use the parameter NOMAC for bypassing the integrity check, thus saving up to 20bytes of disk space per encrypted value.
ALTER TABLE customer rekey USING '3DES168' 'NOMAC';





CREATE VIEW top_selling_products 
AS 
select distinct product_number, total_qty, 
  
dense_rank() over( order by total_qty desc) as top_sellling_products from a order by total_qty desc;


