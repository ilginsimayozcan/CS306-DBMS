CREATE TABLE Patient ( 
	pid CHAR(5),
    pname CHAR(20),
	record_id CHAR(5),
    record_date DATE,
    diagnosis CHAR(20),
	gender CHAR(1),
    birth_date DATE,
	PRIMARY KEY  (pid,record_id));

CREATE TABLE Employees ( 
	eid CHAR(5),
	name CHAR(20),
	gender CHAR(1),
    age INTEGER,
	PRIMARY KEY  (eid));

CREATE TABLE Medical_Equipment ( 
	eq_id CHAR(3),
	eq_name CHAR(20),
	PRIMARY KEY  (eq_id));
    
CREATE TABLE Room ( 
	room_id CHAR(3),
	room_number CHAR(20),
    availability BOOLEAN,
	PRIMARY KEY  (room_id));

CREATE TABLE Bill ( 
	bid CHAR(5),
    pid CHAR(5),
	price DOUBLE,
	PRIMARY KEY  (bid),
    FOREIGN KEY (pid) REFERENCES Patient (pid));

SHOW FULL TABLES;