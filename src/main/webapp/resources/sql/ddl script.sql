/**
 * Countries
 **/
CREATE TABLE COUNTRIES 
    ( 
     COUNTRY_ID CHAR (2 BYTE)  NOT NULL , 
     COUNTRY_NAME VARCHAR2 (40 BYTE) , 
     REGION_ID NUMBER 
    ) LOGGING 
;


CREATE UNIQUE INDEX COUNTRY_C_ID_PKX ON COUNTRIES 
    ( 
     COUNTRY_ID ASC 
    ) 
;

ALTER TABLE COUNTRIES 
    ADD CONSTRAINT COUNTRY_C_ID_PK PRIMARY KEY ( COUNTRY_ID ) ;


/**
 * Departments 
 **/
CREATE TABLE DEPARTMENTS 
    ( 
     DEPARTMENT_ID NUMBER (4)  NOT NULL , 
     DEPARTMENT_NAME VARCHAR2 (30 BYTE)  NOT NULL , 
     MANAGER_ID NUMBER (6) , 
     LOCATION_ID NUMBER (4) 
    ) LOGGING 
;


CREATE INDEX DEPT_LOCATION_IX ON DEPARTMENTS 
    ( 
     LOCATION_ID ASC 
    ) 
    LOGGING 
    NOCOMPRESS 
    NOPARALLEL 
;

CREATE UNIQUE INDEX DEPT_ID_PKX ON DEPARTMENTS 
    ( 
     DEPARTMENT_ID ASC 
    ) 
;

ALTER TABLE DEPARTMENTS 
    ADD CONSTRAINT DEPT_ID_PK PRIMARY KEY ( DEPARTMENT_ID ) ;

/**
 * Employees 
 **/
CREATE TABLE EMPLOYEES 
    ( 
     EMPLOYEE_ID NUMBER (6)  NOT NULL , 
     FIRST_NAME VARCHAR2 (20 BYTE) , 
     LAST_NAME VARCHAR2 (25 BYTE)  NOT NULL , 
     EMAIL VARCHAR2 (25 BYTE)  NOT NULL , 
     PHONE_NUMBER VARCHAR2 (20 BYTE) , 
     HIRE_DATE DATE  NOT NULL , 
     JOB_ID VARCHAR2 (10 BYTE)  NOT NULL , 
     SALARY NUMBER (8,2) , 
     COMMISSION_PCT NUMBER (2,2) , 
     MANAGER_ID NUMBER (6) , 
     DEPARTMENT_ID NUMBER (4) 
    ) LOGGING 
;



ALTER TABLE EMPLOYEES 
    ADD CONSTRAINT EMP_SALARY_MIN 
    CHECK ( salary > 0) 
;


CREATE INDEX EMP_DEPARTMENT_IX ON EMPLOYEES 
    ( 
     DEPARTMENT_ID ASC 
    ) 
    LOGGING 
    NOCOMPRESS 
    NOPARALLEL 
;

CREATE INDEX EMP_JOB_IX ON EMPLOYEES 
    ( 
     JOB_ID ASC 
    ) 
    LOGGING 
    NOCOMPRESS 
    NOPARALLEL 
;

CREATE INDEX EMP_MANAGER_IX ON EMPLOYEES 
    ( 
     MANAGER_ID ASC 
    ) 
    LOGGING 
    NOCOMPRESS 
    NOPARALLEL 
;

CREATE INDEX EMP_NAME_IX ON EMPLOYEES 
    ( 
     LAST_NAME ASC , 
     FIRST_NAME ASC 
    ) 
    LOGGING 
    NOCOMPRESS 
    NOPARALLEL 
;

CREATE UNIQUE INDEX EMP_EMP_ID_PKX ON EMPLOYEES 
    ( 
     EMPLOYEE_ID ASC 
    ) 
;

ALTER TABLE EMPLOYEES 
    ADD CONSTRAINT EMP_EMP_ID_PK PRIMARY KEY ( EMPLOYEE_ID ) ;

ALTER TABLE EMPLOYEES 
    ADD CONSTRAINT EMP_EMAIL_UK UNIQUE ( EMAIL ) ;



/**
 * Jobs 
 **/
CREATE TABLE JOBS 
    ( 
     JOB_ID VARCHAR2 (10 BYTE)  NOT NULL , 
     JOB_TITLE VARCHAR2 (35 BYTE)  NOT NULL , 
     MIN_SALARY NUMBER (6) , 
     MAX_SALARY NUMBER (6) 
    ) LOGGING 
;


CREATE UNIQUE INDEX JOB_ID_PKX ON JOBS 
    ( 
     JOB_ID ASC 
    ) 
;

ALTER TABLE JOBS 
    ADD CONSTRAINT JOB_ID_PK PRIMARY KEY ( JOB_ID ) ;



/**
 * Job History 
 **/
CREATE TABLE JOB_HISTORY 
    ( 
     EMPLOYEE_ID NUMBER (6)  NOT NULL , 
     START_DATE DATE  NOT NULL , 
     END_DATE DATE  NOT NULL , 
     JOB_ID VARCHAR2 (10 BYTE)  NOT NULL , 
     DEPARTMENT_ID NUMBER (4) 
    ) LOGGING 
;



ALTER TABLE JOB_HISTORY 
    ADD CONSTRAINT JHIST_DATE_CHECK 
    CHECK (end_date > start_date)
        INITIALLY IMMEDIATE 
        ENABLE 
        VALIDATE 
;



CREATE INDEX JHIST_JOB_IX ON JOB_HISTORY 
    ( 
     JOB_ID ASC 
    ) 
    LOGGING 
    NOCOMPRESS 
    NOPARALLEL 
;

CREATE INDEX JHIST_EMP_IX ON JOB_HISTORY 
    ( 
     EMPLOYEE_ID ASC 
    ) 
    LOGGING 
    NOCOMPRESS 
    NOPARALLEL 
;

CREATE INDEX JHIST_DEPT_IX ON JOB_HISTORY 
    ( 
     DEPARTMENT_ID ASC 
    ) 
    LOGGING 
    NOCOMPRESS 
    NOPARALLEL 
;

CREATE UNIQUE INDEX JHIST_ID_DATE_PKX ON JOB_HISTORY 
    ( 
     EMPLOYEE_ID ASC , 
     START_DATE ASC 
    ) 
;

ALTER TABLE JOB_HISTORY 
    ADD CONSTRAINT JHIST_ID_DATE_PK PRIMARY KEY ( EMPLOYEE_ID, START_DATE ) ;



/**
 * Locations 
 **/
CREATE TABLE LOCATIONS 
    ( 
     LOCATION_ID NUMBER (4)  NOT NULL , 
     STREET_ADDRESS VARCHAR2 (40 BYTE) , 
     POSTAL_CODE VARCHAR2 (12 BYTE) , 
     CITY VARCHAR2 (30 BYTE)  NOT NULL , 
     STATE_PROVINCE VARCHAR2 (25 BYTE) , 
     COUNTRY_ID CHAR (2 BYTE) 
    ) LOGGING 
;


CREATE INDEX LOC_CITY_IX ON LOCATIONS 
    ( 
     CITY ASC 
    ) 
    LOGGING 
    NOCOMPRESS 
    NOPARALLEL 
;

CREATE INDEX LOC_STATE_PROV_IX ON LOCATIONS 
    ( 
     STATE_PROVINCE ASC 
    ) 
    LOGGING 
    NOCOMPRESS 
    NOPARALLEL 
;

CREATE INDEX LOC_COUNTRY_IX ON LOCATIONS 
    ( 
     COUNTRY_ID ASC 
    ) 
    LOGGING 
    NOCOMPRESS 
    NOPARALLEL 
;

CREATE UNIQUE INDEX LOC_ID_PKX ON LOCATIONS 
    ( 
     LOCATION_ID ASC 
    ) 
;

ALTER TABLE LOCATIONS 
    ADD CONSTRAINT LOC_ID_PK PRIMARY KEY ( LOCATION_ID ) ;



/**
 * Regions 
 **/
CREATE TABLE REGIONS 
    ( 
     REGION_ID NUMBER  NOT NULL , 
     REGION_NAME VARCHAR2 (25 BYTE) 
    ) LOGGING 
;



CREATE UNIQUE INDEX REG_ID_PKX ON REGIONS 
    ( 
     REGION_ID ASC 
    ) 
;

ALTER TABLE REGIONS 
    ADD CONSTRAINT REG_ID_PK PRIMARY KEY ( REGION_ID ) ;




ALTER TABLE COUNTRIES 
    ADD CONSTRAINT COUNTR_REG_FK FOREIGN KEY 
    ( 
     REGION_ID
    ) 
    REFERENCES REGIONS 
    ( 
     REGION_ID
    ) 
    NOT DEFERRABLE 
;



ALTER TABLE DEPARTMENTS 
    ADD CONSTRAINT DEPT_LOC_FK FOREIGN KEY 
    ( 
     LOCATION_ID
    ) 
    REFERENCES LOCATIONS 
    ( 
     LOCATION_ID
    ) 
    NOT DEFERRABLE 
;



ALTER TABLE DEPARTMENTS 
    ADD CONSTRAINT DEPT_MGR_FK FOREIGN KEY 
    ( 
     MANAGER_ID
    ) 
    REFERENCES EMPLOYEES 
    ( 
     EMPLOYEE_ID
    ) 
    NOT DEFERRABLE 
;



ALTER TABLE EMPLOYEES 
    ADD CONSTRAINT EMP_DEPT_FK FOREIGN KEY 
    ( 
     DEPARTMENT_ID
    ) 
    REFERENCES DEPARTMENTS 
    ( 
     DEPARTMENT_ID
    ) 
    NOT DEFERRABLE 
;



ALTER TABLE EMPLOYEES 
    ADD CONSTRAINT EMP_JOB_FK FOREIGN KEY 
    ( 
     JOB_ID
    ) 
    REFERENCES JOBS 
    ( 
     JOB_ID
    ) 
    NOT DEFERRABLE 
;



ALTER TABLE EMPLOYEES 
    ADD CONSTRAINT EMP_MANAGER_FK FOREIGN KEY 
    ( 
     MANAGER_ID
    ) 
    REFERENCES EMPLOYEES 
    ( 
     EMPLOYEE_ID
    ) 
    NOT DEFERRABLE 
;



ALTER TABLE JOB_HISTORY 
    ADD CONSTRAINT JHIST_DEPT_FK FOREIGN KEY 
    ( 
     DEPARTMENT_ID
    ) 
    REFERENCES DEPARTMENTS 
    ( 
     DEPARTMENT_ID
    ) 
    NOT DEFERRABLE 
;



ALTER TABLE JOB_HISTORY 
    ADD CONSTRAINT JHIST_EMP_FK FOREIGN KEY 
    ( 
     EMPLOYEE_ID
    ) 
    REFERENCES EMPLOYEES 
    ( 
     EMPLOYEE_ID
    ) 
    NOT DEFERRABLE 
;



ALTER TABLE JOB_HISTORY 
    ADD CONSTRAINT JHIST_JOB_FK FOREIGN KEY 
    ( 
     JOB_ID
    ) 
    REFERENCES JOBS 
    ( 
     JOB_ID
    ) 
    NOT DEFERRABLE 
;



ALTER TABLE LOCATIONS 
    ADD CONSTRAINT LOC_C_ID_FK FOREIGN KEY 
    ( 
     COUNTRY_ID
    ) 
    REFERENCES COUNTRIES 
    ( 
     COUNTRY_ID
    ) 
    NOT DEFERRABLE 
;


CREATE OR REPLACE VIEW EMP_DETAILS_VIEW AS 
SELECT
  e.employee_id,
  e.job_id,
  e.manager_id,
  e.department_id,
  d.location_id,
  l.country_id,
  e.first_name,
  e.last_name,
  e.salary,
  e.commission_pct,
  d.department_name,
  j.job_title,
  l.city,
  l.state_province,
  c.country_name,
  r.region_name
FROM
  employees e,
  departments d,
  jobs j,
  locations l,
  countries c,
  regions r
WHERE e.department_id = d.department_id
  AND d.location_id = l.location_id
  AND l.country_id = c.country_id
  AND c.region_id = r.region_id
  AND j.job_id = e.job_id
WITH READ ONLY ;




CREATE SEQUENCE DEPARTMENTS_SEQ 
    INCREMENT BY 10 
    MAXVALUE 9990 
    MINVALUE 1 
    NOCACHE 
;


CREATE SEQUENCE EMPLOYEES_SEQ 
    INCREMENT BY 1 
    MAXVALUE 9999999999999999999999999999 
    MINVALUE 1 
    NOCACHE 
;


CREATE SEQUENCE LOCATIONS_SEQ 
    INCREMENT BY 100 
    MAXVALUE 9900 
    MINVALUE 1 
    NOCACHE 
;


CREATE OR REPLACE TRIGGER SECURE_EMPLOYEES 
    BEFORE INSERT OR UPDATE OR DELETE ON EMPLOYEES 
    FOR EACH ROW 
BEGIN
  secure_dml;
END secure_employees; 
/



CREATE OR REPLACE TRIGGER UPDATE_JOB_HISTORY 
    AFTER UPDATE OF JOB_ID, DEPARTMENT_ID ON EMPLOYEES 
    FOR EACH ROW 
BEGIN
  add_job_history(:old.employee_id, :old.hire_date, sysdate,
                  :old.job_id, :old.department_id);
END; 
/




CREATE OR REPLACE PROCEDURE add_job_history
  (  p_emp_id          job_history.employee_id%type
   , p_start_date      job_history.start_date%type
   , p_end_date        job_history.end_date%type
   , p_job_id          job_history.job_id%type
   , p_department_id   job_history.department_id%type
   )
IS
BEGIN
  INSERT INTO job_history (employee_id, start_date, end_date,
                           job_id, department_id)
    VALUES(p_emp_id, p_start_date, p_end_date, p_job_id, p_department_id);
END add_job_history;
/


CREATE OR REPLACE PROCEDURE secure_dml
IS
BEGIN
  IF TO_CHAR (SYSDATE, 'HH24:MI') NOT BETWEEN '08:00' AND '18:00'
        OR TO_CHAR (SYSDATE, 'DY') IN ('SAT', 'SUN') THEN
	RAISE_APPLICATION_ERROR (-20205,
		'You may only make changes during normal office hours');
  END IF;
END secure_dml;
/










-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             7
-- CREATE INDEX                            18
-- ALTER TABLE                             20
-- CREATE VIEW                              1
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         2
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           2
-- CREATE STRUCTURED TYPE                   0
-- CREATE COLLECTION TYPE                   0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          3
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              1
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
