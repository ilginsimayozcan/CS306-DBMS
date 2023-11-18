CREATE TABLE Patient (
    pid CHAR(5) NOT NULL,
    pname CHAR(20) NOT NULL,
    record_id CHAR(5) NOT NULL,
    record_date DATE NOT NULL,
    diagnosis CHAR(20) NOT NULL,
    gender CHAR(1) NOT NULL,
    birth_date DATE NOT NULL,
    PRIMARY KEY (pid, record_id),
    INDEX idx_pid (pid),        
    INDEX idx_record_id (record_id));

CREATE TABLE Employees ( 
	eid CHAR(5) PRIMARY KEY,
	name CHAR(20),
	gender CHAR(1),
	age INTEGER);

CREATE TABLE Doctor_Assigned_To ( 
	dep_name CHAR(20) NOT NULL,
	dep_id CHAR(5) NOT NULL,
	doctor_id CHAR(5),
	room_id CHAR(3) NOT NULL,
	PRIMARY KEY(doctor_id),
	FOREIGN KEY (doctor_id) REFERENCES Employees (eid)ON DELETE SET NULL ON UPDATE CASCADE,
	FOREIGN KEY (room_id) REFERENCES room(room_id) ON DELETE CASCADE ON UPDATE CASCADE
	);

CREATE TABLE Nurse ( 
	shift_hours INTEGER NOT NULL,
	nurse_id CHAR(5) NOT NULL,
	PRIMARY KEY (nurse_id),
	FOREIGN KEY (nurse_id) REFERENCES Employees (eid));
    
CREATE TABLE Secretary ( 
	desk_id CHAR(5) NOT NULL,
	secretary_id CHAR(5) NOT NULL,
	PRIMARY KEY (secretary_id),
	FOREIGN KEY (secretary_id) REFERENCES Employees (eid));
    
CREATE TABLE Medical_Equipment ( 
	eq_id CHAR(3) PRIMARY KEY,
	eq_name CHAR(35));
    
CREATE TABLE Room ( 
	room_id CHAR(3) NOT NULL,
	room_number CHAR(20) NOT NULL,
	availability BOOLEAN NOT NULL,
	PRIMARY KEY  (room_id));

CREATE TABLE Pharmaceutical_Supplier ( 
	supplier_id CHAR(5) NOT NULL,
	supplier_name CHAR(20) NOT NULL,
	location CHAR(25) NOT NULL,
	PRIMARY KEY  (supplier_id));
    
CREATE TABLE Medication ( 
	med_id CHAR(5),
	med_name CHAR(20),
	med_price DOUBLE,
	PRIMARY KEY (med_id));

CREATE TABLE Reserves_Appointment( #weak entity/relation
	appointment_id  CHAR(5) NOT NULL,
	a_date  DATE NOT NULL,
	a_status BOOLEAN NOT NULL,
	pid  CHAR(5) NOT NULL,
	record_id CHAR(5) NOT NULL,
	PRIMARY KEY  (appointment_id,pid,record_id),
	FOREIGN KEY  (pid) REFERENCES Patient (pid) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY  (record_id) REFERENCES Patient (record_id) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE  Pays_Bill ( #weak entity/relation
	bid  CHAR(5) NOT NULL,
	price  DOUBLE NOT NULL,
	pid  CHAR(5) NOT NULL,
	record_id CHAR(5) NOT NULL,
	PRIMARY KEY  (bid,pid,record_id),
	FOREIGN KEY  (pid) REFERENCES Patient (pid) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY  (record_id) REFERENCES Patient (record_id) ON DELETE CASCADE ON UPDATE CASCADE,
   	INDEX idx_bid (bid));       

CREATE TABLE Owns_Insurance ( #weak entity + relation
	comp_id  CHAR(5),
	comp_name  CHAR(20),
	pid  CHAR(5) NOT NULL,
	record_id CHAR(5) NOT NULL,
	PRIMARY KEY  (pid,comp_id,record_id),
	FOREIGN KEY  (pid) REFERENCES Patient (pid) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY  (record_id) REFERENCES Patient (record_id) ON DELETE CASCADE ON UPDATE CASCADE,
	INDEX idx_comp_id (comp_id));  

CREATE TABLE r_Use(
	eid CHAR(5),
	eq_id CHAR(3),
	FOREIGN KEY (eid) REFERENCES Employees(eid) ON DELETE SET NULL ON UPDATE CASCADE,
	FOREIGN KEY (eq_id) REFERENCES Medical_Equipment(eq_id) ON DELETE CASCADE ON UPDATE CASCADE);
    
CREATE TABLE Takes(
	med_id CHAR(5),
	pid CHAR(5) NOT NULL,
	record_id CHAR(5) NOT NULL,
	PRIMARY KEY (pid,record_id),
	FOREIGN KEY (med_id) REFERENCES Medication(med_id) ON DELETE SET NULL ON UPDATE CASCADE,
	FOREIGN KEY (pid) REFERENCES Patient(pid) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (record_id) REFERENCES Patient (record_id) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE Sold_By(
	supplier_id CHAR(5) NOT NULL,
	med_id CHAR(5) NOT NULL,
	PRIMARY KEY (med_id,supplier_id),
	FOREIGN KEY(med_id) REFERENCES Medication(med_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(supplier_id) REFERENCES Pharmaceutical_Supplier(supplier_id) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE Taken_Care_By( 
	pid CHAR(5) ,
	doctor_id CHAR(5),
	PRIMARY KEY (pid),
	FOREIGN KEY(pid) REFERENCES Patient(pid) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(doctor_id) REFERENCES Doctor(doctor_id) ON DELETE SET NULL ON UPDATE CASCADE);

CREATE TABLE Prescribes( 
	med_id CHAR(5),
	doctor_id CHAR(5),
	PRIMARY KEY (med_id,doctor_id),
	FOREIGN KEY(med_id) REFERENCES medication(med_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(doctor_id) REFERENCES Doctor(doctor_id) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE Works_With(
	doctor_id CHAR(5),
	nurse_id CHAR(5),
	PRIMARY KEY (doctor_id,nurse_id),
	FOREIGN KEY(nurse_id) REFERENCES Nurse(nurse_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(doctor_id) REFERENCES Doctor(doctor_id) ON DELETE CASCADE ON UPDATE CASCADE);
	
CREATE TABLE Appoints (
	appointment_id CHAR(3) NOT NULL,
	secretary_id CHAR(5),
	PRIMARY KEY (appointment_id),
	FOREIGN KEY (appointment_id) REFERENCES reserves_appointment(appointment_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (secretary_id) REFERENCES Secretary(secretary_id) ON DELETE SET NULL ON UPDATE CASCADE);

CREATE TABLE Covered_By(
	bid CHAR(5) NOT NULL,
	comp_id CHAR(5),
	PRIMARY KEY (bid),
	FOREIGN KEY(bid) REFERENCES pays_bill(bid) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(comp_id) REFERENCES owns_insurance(comp_id) ON DELETE SET NULL ON UPDATE CASCADE);
