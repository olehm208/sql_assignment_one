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

insert into
Appointment(PatientID, DoctorID, Date, Status) 
values
(1, 1, '2026-03-10', 'Completed'),
(2, 1, '2026-03-11', 'Cancelled'),
(3, 2, '2026-03-10', 'Completed'),
(4, 3, '2026-03-12', 'In-progress'),
(5, 4, '2026-03-15', 'Cancelled'),
(3, 1, '2026-01-11', 'Completed'),
(2, 4, '2026-01-11', 'Completed');

insert into
Bills(PatientID, Amount, Status)
values
(1, 150.00, 'Paid'),
(2, 50.00, 'Paid'),
(3, 200.00, 'Paid'),
(4, 300.00, 'Unpaid'),
(5, 150.00, 'Paid');

with CTE as (
	select 
		'Adults' as PatientCategory,
		dep.departmentname as DepartmentName,
		count(distinct apps.appointmentid) as TotalApps,
		coalesce(sum(bill.amount), 0) as TotalRevenue
	from departaments dep
	join doctors docs on docs.departmentid = dep.departmentid
	join appointment apps on docs.doctorid = apps.doctorid
	join patients pats on apps.patientid = pats.patientid
	join bills bill on bill.patientid = pats.patientid
	where pats.age > 20
	group by dep.departmentname
	
	union all
	
	select 
		'Youngsters' as PatientCategory,
		dep.departmentname as DepartmentName,
		count(distinct apps.appointmentid) as TotalApps,
		coalesce(sum(bill.amount), 0) as TotalRevenue
	from departaments dep
	join doctors docs on docs.departmentid = dep.departmentid
	join appointment apps on docs.doctorid = apps.doctorid
	join patients pats on apps.patientid = pats.patientid
	join bills bill on bill.patientid = pats.patientid
	where pats.age <= 20
	group by dep.departmentname
)
select * from CTE;