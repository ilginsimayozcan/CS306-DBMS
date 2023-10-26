//NOT NULL UPDATE VS.
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

//Relations
CREATE TABLE r_Use(
	eid CHAR(5),
	eq_id CHAR(3),
	PRIMARY KEY (eid, eq_id,record_id),
	FOREIGN KEY (eid) REFERENCES Employees(eid) ON DELETE CASCADE,
	FOREIGN KEY (eq_id) REFERENCES Medical_Equipment(eq_id) ON DELETE CASCADE);
	
    
    #constraints kullanlcak mi emin olmak lazm ve primary key olup olmadklari ve İSA Yİ NE YAPCAZ ?
    
CREATE TABLE Prescribes( //ISA
	eid CHAR(5),
	PRIMARY KEY (eid, med_id),
	FOREIGN KEY (eid) REFERENCES Employees(eid) ON DELETE CASCADE,
	FOREIGN KEY (med_id) REFERENCES Medication(med_id) ON DELETE CASCADE);

CREATE TABLE Takes(
	med_id CHAR(5),
	pid CHAR(5) NOT NULL,
	record_id CHAR(5) NOT NULL,
	PRIMARY KEY (med_id,pi,record_id),
	FOREIGN KEY (med_id) REFERENCES Medication(med_id) ON DELETE CASCADE,
	FOREIGN KEY (pid) REFERENCES Patient(pid) ON DELETE CASCADE,
	FOREIGN KEY  (record_id) REFERENCES Patient (record_id) ON DELETE CASCADE);


CREATE TABLE Sold_By(

	supplier_id CHAR(5) NOT NULL,
	med_id CHAR(5) NOT NULL,
	PRIMARY KEY (med_id,supplier_id),
	FOREIGN KEY(med_id) REFERENCES Medication(med_id) ON DELETE CASCADE,
	FOREIGN KEY(supplier_id) REFERENCES Pharmaceutical_Supplier(supplier_id) ON DELETE CASCADE);

CREATE TABLE Taken_Care_By( //ISA
	pid CHAR(5),
	eid CHAR(5) NOT NULL,
	PRiMARY KEY (pid,eid),
	FOREiGN KEY(pid) REFERENCES Patient(pid) ON DELETE CASCADE,
	FOREiGN KEY(eid) REFERENCES Employee(eid) ON DELETE CASCADE);


CREATE TABLE Assigned_To (
	room_id CHAR(3) PRIMARY KEY,
	eid CHAR(5) UNIQUE,
	FOREIGN KEY (room_id) REFERENCES Rooms(room_id),
	FOREIGN KEY (eid) REFERENCES Employees(eid)
);
#INSURANCE COVERED 
