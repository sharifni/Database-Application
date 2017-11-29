
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
