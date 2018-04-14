/*
    Secuencia para la tabla informacion de pilotos
*/
CREATE SEQUENCE pilots_inf
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
 
 CREATE TABLE PILOT_INFORMATION(
    ID NUMBER PRIMARY KEY,
    ICAO_LEVE VARCHAR2(256),
    FLIGHT_HOURS NUMBER,
    POSITION VARCHAR2(256),
    ORGANIZATION_LEVEL VARCHAR2(100),
    LICENSE_TYPE VARCHAR2(256)
 );
  
-- NEXVALE ->LLAMAR PRIMERO
-- CURLVAL
-- INSERT INTO PILOT_INFORMATION(pilots_inf.NEXTVAL,'DATOS DE LA TABLA')

ALTER TABLE PILOT_INFORMATION ADD CHECK (ICAO_LEVE in ('Nivel 1 Pre-elementary',
                                                       'Nivel 2 Elementary',
                                                       'Nivel 3 Pre-Operational',
                                                       'Nivel 4 Operational',
                                                       'Nivel 5 Extended',
                                                       'Nivel 6 Expert'));

 ALTER TABLE PILOT_INFORMATION ADD CHECK (POSITION in ('Comandante',
                                                       'Primer Oficial'));
                                                           
ALTER TABLE PILOT_INFORMATION ADD CHECK (LICENSE_TYPE in ('CPL',
                                                           'IFR',
                                                           'ME',
                                                           'ATPL'));

-- -------------------------------------------------------------------
CREATE SEQUENCE aircrafts_type_SEC
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
 CREATE TABLE aircrafts_type(
    ID NUMBER PRIMARY KEY,
    DESCRIPTION VARCHAR2(256)
 );

-- --------------------------------------------------------------------
CREATE SEQUENCE aircrafts_SEC
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

CREATE TABLE AIRCRAFTS(
    ID NUMBER PRIMARY KEY,
    ENROLLMENT VARCHAR2(256),
    SERIAL_NUMBER VARCHAR2(256),
    AGE VARCHAR2(50),
    ID_AIRCRAFT_TYPE NUMBER,
    FOREIGN KEY (ID_AIRCRAFT_TYPE) REFERENCES AIRCRAFTS_TYPE (ID)
);

-- --------------------------------------------------------------------
CREATE SEQUENCE document_type_SEC
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
 CREATE TABLE DOCUMENT_TYPE(
    ID NUMBER PRIMARY KEY,
    DESCRIPTION VARCHAR2(256)
 );
 
ALTER TABLE DOCUMENT_TYPE ADD CHECK (DESCRIPTION in ('Cédula',
                                                     'Pasaporte',
                                                     'DNI',
                                                     'Cédula Extranjería'));
 
 -- --------------------------------------------------------------------

CREATE SEQUENCE location_SEC
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

 CREATE TABLE LOCATION(
    ID NUMBER PRIMARY KEY,
    COUNTRY VARCHAR2(256),
    STATE VARCHAR2(256),
    CITY VARCHAR2(256),
    ADDRESS VARCHAR2(256)
 );

 -- --------------------------------------------------------------------
CREATE SEQUENCE AIRPORTS_SEC
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
 
  CREATE TABLE AIRPORTS(
    ID NUMBER PRIMARY KEY,
    NAME VARCHAR2(256),
    LAT VARCHAR2(256),
    LON VARCHAR2(256),
    ID_LOCATION NUMBER,
    FOREIGN KEY (ID_LOCATION) REFERENCES LOCATION (ID)
 );
 
-- --------------------------------------------------------------------
CREATE SEQUENCE AIRLINES_SEC
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
 CREATE TABLE AIRLINES (
    ID NUMBER PRIMARY KEY,
    abbreviation_airport VARCHAR(20),
    ID_AIRPORT NUMBER,
    FOREIGN KEY (ID_AIRPORT) REFERENCES AIRPORTS (ID)
 );

-- ----------------------------------------------------------------------

CREATE SEQUENCE employee_type_sec
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
 
 CREATE TABLE EMPLOYEE_TYPES(
    ID NUMBER PRIMARY KEY,
    DESCRIPTION VARCHAR2(256)
 );
  
  ALTER TABLE EMPLOYEE_TYPES ADD CHECK (DESCRIPTION in ('Piloto',
                                                       'Auxiliar de Servicio'));
 -- ----------------------------------------------------------------------
CREATE SEQUENCE STATE_employee_sec
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
 CREATE TABLE STATE_EMPLOYEE(
    ID NUMBER PRIMARY KEY,
    DESCRIPTION VARCHAR2(256)
 );

 ALTER TABLE STATE_EMPLOYEE ADD CHECK (DESCRIPTION in ('EN VUELO',
                                                       'ACTIVO',
                                                       'INACTIVO',
                                                       'JUBILADO',
                                                       'SUSPENDIDO',
                                                       'DESPEDIDO',
                                                       'ENTRENAMIENTO',
                                                       'LICENCIA',
                                                       'VACACIONES'));

-- ----------------------------------------------------------------------
CREATE SEQUENCE employee_SEC
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
 
 
CREATE TABLE EMPLOYEES (
    ID NUMBER PRIMARY KEY,
    NAME VARCHAR2(256),
    LAST_NAME VARCHAR2(256),
    GENDRE VARCHAR2(256),
    birt_date DATE,
    antiquity NUMBER,
    last_training DATE,
    address_home VARCHAR2(256),
    email VARCHAR2(256),
    CELLPHONE VARCHAR2(256),
    HOURS_REST NUMBER,
    ID_EMPLOYEE_TYPE NUMBER,
    id_state_employee NUMBER,
    ID_LOCATION NUMBER,
    FOREIGN KEY (ID_EMPLOYEE_TYPE) REFERENCES EMPLOYEE_TYPES (ID),
    FOREIGN KEY (ID_STATE_EMPLOYEE) REFERENCES STATE_EMPLOYEE (ID),
    FOREIGN KEY (ID_LOCATION) REFERENCES LOCATION (ID)
    );
    
  -- ---------------------------------------------------------------------
  CREATE SEQUENCE ROUTES_SEC
     START WITH     1
     INCREMENT BY   1
     NOCACHE
     NOCYCLE;
     
  CREATE TABLE ROUTES(
    ID NUMBER PRIMARY KEY,
    DISTANCE_KMS NUMBER,
    ID_AIRPORT_ORIGIN NUMBER,
    ID_AIRPORT_DESTINY NUMBER,
    FOREIGN KEY (ID_AIRPORT_ORIGIN) REFERENCES AIRPORTS (ID),
    FOREIGN KEY (ID_AIRPORT_DESTINY) REFERENCES AIRPORTS (ID)
  );
  
  -- ----------------------------------------------------------------------
  CREATE SEQUENCE FLIGHT_SEC
     START WITH     1
     INCREMENT BY   1
     NOCACHE
     NOCYCLE;
  
  CREATE TABLE FLIGHTS (
    ID NUMBER PRIMARY KEY,
    NUMBER_FLI NUMBER,
    REQUIRED_CREW NUMBER,
    AVERAGE_HOURS NUMBER,
    FRECUENCY NUMBER,
    ID_PILOT NUMBER,
    ID_AIRCRAFT NUMBER,
    ID_EMPLOYEES NUMBER,
    ID_ROUTE NUMBER,
    FOREIGN KEY (ID_PILOT) REFERENCES PILOT_INFORMATION (ID),
    FOREIGN KEY (ID_AIRCRAFT) REFERENCES AIRCRAFTS (ID),
    FOREIGN KEY (ID_EMPLOYEES) REFERENCES EMPLOYEES (ID),
    FOREIGN KEY (ID_ROUTE) REFERENCES ROUTES (ID)
  );

-- -------------------------------------------------------------------------
CREATE SEQUENCE ITINERARY_SEC
     START WITH     1
     INCREMENT BY   1
     NOCACHE
     NOCYCLE;

  CREATE TABLE ITINERARY (
    ID NUMBER PRIMARY KEY,
    estimate_time_departure TIMESTAMP,
    estimate_time_arrive TIMESTAMP,
    hour_real_departure TIMESTAMP,
    hour_real_arrive TIMESTAMP,
    real_duration NUMBER,
    number_passanger_first_class NUMBER,
    number_passanger_second_class NUMBER,
    ID_AIR_CRAFT NUMBER,
    ID_FLIGHT NUMBER,
    ID_EMPLOIMENT NUMBER,
    FOREIGN KEY (ID_FLIGHT) REFERENCES FLIGHTS (ID),
    FOREIGN KEY (ID_AIR_CRAFT) REFERENCES AIRCRAFTS (ID),
    FOREIGN KEY (ID_EMPLOIMENT) REFERENCES EMPLOYEES (ID)
    );

-- --------------------------------------------------------------------

CREATE SEQUENCE CHECK_IN_SEC
     START WITH     1
     INCREMENT BY   1
     NOCACHE
     NOCYCLE;

  CREATE TABLE CHECK_IN(
    ID NUMBER PRIMARY KEY,
    NAMES VARCHAR2(256),
    LAST_NAMES VARCHAR2(256),
    NUMBER_DOCUMENT VARCHAR2(256),
    NUMBER_CONFIRMATION NUMBER,
    EMERGENCY_CONTACT VARCHAR2(256),
    CITY_EMERGENCY_CONTACT VARCHAR2(256),
    COUNTRY_EMERGENCY_CONTACT VARCHAR2(256),
    EMAIL_EMERGENCY_CONTACT VARCHAR2(256),
    PHONE_EMERGENCY_CONTACT VARCHAR2(256),
    ID_ITINERARY NUMBER,    
    ID_DOCUMENT_TYPE NUMBER,
    FOREIGN KEY (ID_ITINERARY) REFERENCES ITINERARY (ID),
    FOREIGN KEY (ID_DOCUMENT_TYPE) REFERENCES DOCUMENT_TYPE (ID)
  );
-- --------------------------------------------------------------------

CREATE SEQUENCE FLIGHT_LOG_SEC
     START WITH     1
     INCREMENT BY   1
     NOCACHE
     NOCYCLE;

CREATE TABLE FLIGHT_LOG_IN(
    ID NUMBER PRIMARY KEY,
    DATE_ARRIVE TIMESTAMP,
    POSITION VARCHAR2(256),
    ALTITUTED NUMBER,
    SPEED VARCHAR2(256),
    ID_AIRCRAFT NUMBER,
    ID_CHECK_IN NUMBER,    
    FOREIGN KEY (ID_AIRCRAFT) REFERENCES AIRCRAFTS (ID),
    FOREIGN KEY (ID_CHECK_IN) REFERENCES CHECK_IN (ID)
  );
  
-- POINT 2 AND 3
CREATE TABLESPACE AVIANCA
DATAFILE 'AVIANCA1.DBF' SIZE 48M
EXTENT MANAGEMENT LOCAL
SEGMENT SPACE MANAGEMENT AUTO;

CREATE UNDO TABLESPACE UNDO1
DATAFILE 'UNDO.DBF' SIZE 25M
AUTOEXTEND ON NEXT 5M;

ALTER SYSTEM SET UNDO_TABLESPACE = UNDO1;

--POINT 4
CREATE USER NewDBA1 IDENTIFIED BY passwd
       DEFAULT TABLESPACE AVIANCA
       TEMPORARY TABLESPACE temp
       QUOTA UNLIMITED ON AVIANCA;

CREATE ROLE RDBA1;

GRANT CONNECT,RESOURCE,DBA TO NewDBA1;
GRANT CREATE SESSION TO NewDBA1;
GRANT UNLIMITED TABLESPACE TO NewDBA1;

GRANT RDBA1 TO NewDBA1;

--POINT 5
CREATE PROFILE CLERK LIMIT
PASSWORD_LIFE_TIME 40
SESSIONS_PER_USER 1
IDLE_TIME 10
FAILED_LOGIN_ATTEMPTS 4;

CREATE PROFILE DEVELOPMENT LIMIT
PASSWORD_LIFE_TIME 100
SESSIONS_PER_USER 2
IDLE_TIME 30
FAILED_LOGIN_ATTEMPTS 1;

--POINT 6
CREATE USER User1 IDENTIFIED BY user1235;
DEFAULT TABLESPACE AVIANCA
GRANT CONNECT TO User1
PROFILE CLERK
ACCOUNT LOCK;

CREATE USER User2 IDENTIFIED BY user1236;
DEFAULT TABLESPACE AVIANCA
GRANT CONNECT TO User2
PROFILE CLERK;


CREATE USER User3 IDENTIFIED BY user1237;
DEFAULT TABLESPACE AVIANCA1
GRANT CONNECT TO User3
PROFILE DEVELOPMENT;
