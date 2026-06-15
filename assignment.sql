CREATE DATABASE ass01;

create table Departaments (
	DepartmentID serial primary key,
	DepartmentName varchar(100) not null
);

create table Doctors(
	DoctorID serial primary key,
	DepartmentID int,
	DoctorName varchar(100) not null,
	foreign key (DepartmentID) references Departaments(DepartmentID)
);

create table Patients(
	PatientID serial primary key,
	PatientName varchar(100) not null,
	Sex bool,
	Age int
);

create table Appointment(
	AppointmentID serial primary key,
	PatientID int,
	DoctorID int,
	Date date,
	Status varchar(50),
	foreign key(PatientID) references Patients(PatientID),
	foreign key(DoctorID) references Doctors(DoctorID)
);

create table Bills(
	BillID serial primary key,
	PatientID int,
	Amount decimal(10,2),
	Status varchar(50),
	foreign key(PatientID) references Patients(PatientID)
);

insert into 
Departaments(DepartmentName) 
values
('Cardiology'),
('Neurology'),
('Pediatria');
/*Якщо писати не (,,), а (),(),(), то значення будуть вставлятись не в один рядок, а в кілька.*/

insert into
Doctors(DoctorName, DepartmentID)
values
('Dr. Alex', 1),
('Dr. Andrew', 1),
('Dr. Smith', 2),
('Dr. Muhammad', 3)

insert into
Patients(PatientName, Sex, Age) 
values
('John Doe', true, 30),
('Jane Doe', false, 27),
('Granny Johnson', false, 67),
('Grandpa Bill', true, 69),
('Andrew Billionson', true, 5);