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

CREATE TABLE Doctor ( 
	dep_name CHAR(20),
    dep_id CHAR(5),
    eid CHAR(5),
    FOREIGN KEY (eid) REFERENCES Employees (eid));

CREATE TABLE Nurse ( 
	shift_hours INTEGER,
    eid CHAR(5),
    FOREIGN KEY (eid) REFERENCES Employees (eid));
    
CREATE TABLE Secretary ( 
	desk_id CHAR(5),
    eid CHAR(5),
    FOREIGN KEY (eid) REFERENCES Employees (eid));
    
CREATE TABLE Medical_Equipment ( 
	eq_id CHAR(3),
	eq_name CHAR(20),
	PRIMARY KEY  (eq_id));
    
CREATE TABLE Room ( 
	room_id CHAR(3),
	room_number CHAR(20),
    availability BOOLEAN,
	PRIMARY KEY  (room_id));

CREATE TABLE Reserves_Appointment( #weak entity x2 ?? record_id ??
   appointment_id  CHAR(5),
   a_date  DATE,
   a_status BOOLEAN,
   pid  CHAR(5) NOT NULL,
   PRIMARY KEY  (appointment_id, pid),
   FOREIGN KEY  (pid) REFERENCES Patient (pid) ON DELETE CASCADE);
CREATE TABLE  Pays_Bill ( #weak entity
   bid  CHAR(5),
   price  DOUBLE,
   pid  CHAR(5) NOT NULL,
   PRIMARY KEY  (bid, pid),
   FOREIGN KEY  (pid) REFERENCES Patient (pid) ON DELETE CASCADE);

CREATE TABLE Pharmaceutical_Supplier ( 
	supplier_id CHAR(5),
	supplier_name CHAR(20),
    location CHAR(25),
    PRIMARY KEY  (supplier_id));
    
CREATE TABLE Medication ( 
	med_id CHAR(5),
	med_name CHAR(20),
	med_price DOUBLE,
    PRIMARY KEY (med_id));

CREATE TABLE Insurance ( #weak entity
	comp_id CHAR(5),
	comp_name CHAR(20),
	PRIMARY KEY  (comp_id));
