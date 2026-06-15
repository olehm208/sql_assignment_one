CREATE DATABASE ass01;

create table Departaments (
	DepartmentID int primary key,
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