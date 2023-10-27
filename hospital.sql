#NOT NULL UPDATE VS.
CREATE TABLE Patient (
    pid CHAR(5) NOT NULL,
    pname CHAR(20),
    record_id CHAR(5) NOT NULL,
    record_date DATE,
    diagnosis CHAR(20),
    gender CHAR(1),
    birth_date DATE,
    PRIMARY KEY (pid, record_id),
    INDEX idx_pid (pid),        -- Add an index for pid
    INDEX idx_record_id (record_id)  -- Add an index for record_id
);

CREATE TABLE Employees ( 
	eid CHAR(5) NOT NULL,
	name CHAR(20),
	gender CHAR(1),
	age INTEGER,
	PRIMARY KEY  (eid),
    	INDEX idx_eid (eid));

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

CREATE TABLE Reserves_Appointment( #weak entity/relation
	appointment_id  CHAR(5),
	a_date  DATE,
	a_status BOOLEAN,
	pid  CHAR(5) NOT NULL,
	record_id CHAR(5) NOT NULL,
	PRIMARY KEY  (appointment_id),
	FOREIGN KEY  (pid) REFERENCES Patient (pid) ON DELETE CASCADE),
	FOREIGN KEY  (record_id) REFERENCES Patient (record_id) ON DELETE CASCADE);

CREATE TABLE  Pays_Bill ( #weak entity/relation
	bid  CHAR(5),
	price  DOUBLE,
	pid  CHAR(5) NOT NULL,
	record_id CHAR(5) NOT NULL,
	PRIMARY KEY  (bid),
	FOREIGN KEY  (pid) REFERENCES Patient (pid) ON DELETE CASCADE),
	FOREIGN KEY  (record_id) REFERENCES Patient (record_id) ON DELETE CASCADE);

CREATE TABLE Owns_Insurance ( #weak entity + relation
	comp_id  CHAR(5),
	comp_name  CHAR(20),
	pid  CHAR(5) NOT NULL,
	record_id CHAR(5) NOT NULL,
	PRIMARY KEY  (pid),
	FOREIGN KEY  (pid) REFERENCES Patient (pid) ON DELETE CASCADE);
	FOREIGN KEY  (record_id) REFERENCES Patient (record_id) ON DELETE CASCADE);

#NOT NULL UPDATE VS.
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
	eq_id CHAR(3) NOT NULL,
	eq_name CHAR(20),
	PRIMARY KEY  (eq_id));
    
CREATE TABLE Room ( 
	room_id CHAR(3) NOT NULL,
	room_number CHAR(20),
    	availability BOOLEAN,
	PRIMARY KEY  (room_id));

CREATE TABLE Pharmaceutical_Supplier ( 
	supplier_id CHAR(5) NOT NULL,
	supplier_name CHAR(20),
	location CHAR(25),
	PRIMARY KEY  (supplier_id));
    
CREATE TABLE Medication ( 
	med_id CHAR(5) NOT NULL,
	med_name CHAR(20),
	med_price DOUBLE,
	PRIMARY KEY (med_id));

CREATE TABLE Reserves_Appointment( #weak entity/relation
	appointment_id  CHAR(5) NOT NULL,
	a_date  DATE,
	a_status BOOLEAN,
	pid CHAR(5) NOT NULL,
	record_id CHAR(5) NOT NULL,
	PRIMARY KEY  (appointment_id),
	FOREIGN KEY  (pid) REFERENCES Patient (pid) ON DELETE CASCADE,
	FOREIGN KEY  (record_id) REFERENCES Patient (record_id) ON DELETE CASCADE);

CREATE TABLE  Pays_Bill ( #weak entity/relation
	bid  CHAR(5),
	price  DOUBLE,
	pid  CHAR(5) NOT NULL,
	record_id CHAR(5) NOT NULL,
	PRIMARY KEY  (bid),
	FOREIGN KEY  (pid) REFERENCES Patient (pid) ON DELETE CASCADE,
	FOREIGN KEY  (record_id) REFERENCES Patient (record_id) ON DELETE CASCADE,
    	INDEX idx_bid (bid));        -- Add an index for bid
    

CREATE TABLE Owns_Insurance ( #weak entity + relation
	comp_id  CHAR(5),
	comp_name  CHAR(20),
	pid  CHAR(5) NOT NULL,
	record_id CHAR(5) NOT NULL,
	PRIMARY KEY  (pid),
	FOREIGN KEY  (pid) REFERENCES Patient (pid) ON DELETE CASCADE,
	FOREIGN KEY  (record_id) REFERENCES Patient (record_id) ON DELETE CASCADE,
    	INDEX idx_comp_id (comp_id));  -- Add an index for comp_id
    
#Relations
CREATE TABLE r_Use(
	eid CHAR(5) NOT NULL,
	eq_id CHAR(3) NOT NULL,
	PRIMARY KEY (eid, eq_id),
	FOREIGN KEY (eid) REFERENCES Employees(eid) ON DELETE CASCADE,
	FOREIGN KEY (eq_id) REFERENCES Medical_Equipment(eq_id) ON DELETE CASCADE);
    
CREATE TABLE Prescribes( #ISA
	eid CHAR(5) NOT NULL,
	med_id CHAR(5) NOT NULL,
	PRIMARY KEY (eid, med_id),
	FOREIGN KEY (eid) REFERENCES Employees(eid) ON DELETE CASCADE,
	FOREIGN KEY (med_id) REFERENCES Medication(med_id) ON DELETE CASCADE);

CREATE TABLE Takes(
	med_id CHAR(5) NOT NULL,
	pid CHAR(5) NOT NULL,
	record_id CHAR(5) NOT NULL,
	PRIMARY KEY (med_id,pid,record_id),
	FOREIGN KEY (med_id) REFERENCES Medication(med_id) ON DELETE CASCADE,
	FOREIGN KEY (pid) REFERENCES Patient(pid) ON DELETE CASCADE,
	FOREIGN KEY  (record_id) REFERENCES Patient (record_id) ON DELETE CASCADE);


CREATE TABLE Sold_By(
	supplier_id CHAR(5) NOT NULL,
	med_id CHAR(5) NOT NULL,
	PRIMARY KEY (med_id,supplier_id),
	FOREIGN KEY(med_id) REFERENCES Medication(med_id) ON DELETE CASCADE,
	FOREIGN KEY(supplier_id) REFERENCES Pharmaceutical_Supplier(supplier_id) ON DELETE CASCADE);

CREATE TABLE Taken_Care_By( 
	pid CHAR(5) NOT NULL,
	eid CHAR(5) NOT NULL,
	PRIMARY KEY (pid,eid),
	FOREIGN KEY(pid) REFERENCES Patient(pid) ON DELETE CASCADE,
	FOREIGN KEY(eid) REFERENCES Employees(eid) ON DELETE CASCADE);

#WORKS_WITH

CREATE TABLE Appoints (
	appointment_id CHAR(3),
	eid CHAR(5) NOT NULL,
    	PRIMARY KEY (appointment_id,eid),
	FOREIGN KEY (appointment_id) REFERENCES reserves_appointment(appointment_id),
	FOREIGN KEY (eid) REFERENCES Employees(eid));

CREATE TABLE Assigned_To (
	room_id CHAR(3) PRIMARY KEY,
	eid CHAR(5) UNIQUE,
	FOREIGN KEY (room_id) REFERENCES room(room_id),
	FOREIGN KEY (eid) REFERENCES Employees(eid)
);

CREATE TABLE Covered_By(
	bid CHAR(5),
	comp_id CHAR(5),
	PRIMARY KEY (bid,comp_id),
	FOREIGN KEY(bid) REFERENCES pays_bill(bid) ON DELETE CASCADE,
	FOREIGN KEY(comp_id) REFERENCES owns_insurance(comp_id) ON DELETE CASCADE);
