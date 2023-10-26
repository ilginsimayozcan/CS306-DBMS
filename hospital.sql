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



CREATE TABLE r_Use(
	eid CHAR(5),
	eq_id CHAR(3),
	eq_name CHAR(20),
    FOREiGN KEY (eid)
    REFERENCES Employees(eid)
    ON DELETE CASCADE,
    PRiMARY KEY (eid, eq_id),
    FOREiGN KEY (eq_id) 
    REFERENCES Medical_Equipment(eq_id)
	ON DELETE CASCADE
    );
    
    
    #constraints kullanlcak mi emin olmak lazm ve primary key olup olmadklari ve İSA Yİ NE YAPCAZ ?
	SELECT Employees.eid,Medical_Equipment.eq_id 
    FROM Employees
    iNNER JOiN r_Use
    ON Employees.eid = r_Use.eid
    iNNER JOiN Medical_Equipment
    ON r_Use.eid = Medical_Equipment.eq_id;
    
    
    
    
    CREATE TABLE Prescribes(
	eid CHAR(5),
    FOREiGN KEY (eid)
    REFERENCES Employees(eid)
    ON DELETE CASCADE,
    PRiMARY KEY (eid, med_id),
    FOREiGN KEY (med_id) 
    REFERENCES Medication(med_id)
	ON DELETE CASCADE
    );
    
    CREATE TABLE Takes(
    med_id CHAR(5),
    pid CHAR(5) NOT NULL,
    
    
    PRiMARY KEY (med_id,pid),
    FOREiGN KEY(med_id)
    REFERENCES Medication(med_id)
    ON DELETE CASCADE,
    FOREiGN KEY(pid)
    REFERENCES Patient(pid)
    ON DELETE CASCADE
    
    
    );
 
 CREATE TABLE Sold_By(
 
	supplier_id CHAR(5) NOT NULL,
    med_id CHAR(5) NOT NULL,
    
    
    PRiMARY KEY (med_id,supplier_id),
    FOREiGN KEY(med_id)
    REFERENCES Medication(med_id)
    ON DELETE CASCADE,
    FOREiGN KEY(supplier_id)
    REFERENCES Pharmaceutical_Supplier(supplier_id)
    ON DELETE CASCADE
 
 );
 
 CREATE TABLE Taken_Care_By(
	pid CHAR(5),
    eid CHAR(5) NOT NULL,
    
    
    PRiMARY KEY (pid,eid),
    FOREiGN KEY(pid)
    REFERENCES Patient(pid)
    ON DELETE CASCADE,
    FOREiGN KEY(eid)
    REFERENCES Employee(eid)
    ON DELETE CASCADE
 );
 
 
 
 CREATE TABLE Assigned_To (
    room_id CHAR(3) PRIMARY KEY,
    eid CHAR(5) UNIQUE,
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id),
    FOREIGN KEY (eid) REFERENCES Employees(eid)
);

