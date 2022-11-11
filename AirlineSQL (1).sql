/*create database*/
CREATE DATABASE Airline

/*use database*/
USE Airline

/*table airplan type*/
CREATE TABLE AirplanType(
typeName VARCHAR(20) NOT NULL,
companyName VARCHAR(20) NOT NULL,
maxNoOfSeat INT NOT NULL DEFAULT 0,
CONSTRAINT pk_airplanType PRIMARY KEY(typeName)
);

select * from AirplanType

use Airline

/*table airplan*/
CREATE TABLE Airplan(
airplanID VARCHAR(10) NOT NULL,
airplanName VARCHAR(15) NOT NULL,
totalNoOfSeat INT NOT NULL,
typeName VARCHAR(20) NOT NULL,
CONSTRAINT pk_airplan PRIMARY KEY(airplanID),
CONSTRAINT fk_airplan_airplanType FOREIGN KEY(typeName) REFERENCES AirplanType(typeName)
ON DELETE CASCADE ON UPDATE CASCADE
);

/*table airport*/
CREATE TABLE Airport(
airportCode VARCHAR(15) NOT NULL,
airportName VARCHAR(20) NOT NULL,
airportCity VARCHAR(20) NOT NULL,
airportState VARCHAR(20) NOT NULL,
CONSTRAINT pk_airport PRIMARY KEY(airportCode)
);

/*table flight*/
CREATE TABLE Flight(
flightNumber VARCHAR(15) NOT NULL,
airlineName VARCHAR(15) NOT NULL,
CONSTRAINT pk_flight PRIMARY KEY(flightNumber)
);

/*table flight leg*/
CREATE TABLE FlightLeg(
legNumber VARCHAR(15) NOT NULL,
flightNumber VARCHAR(15) NOT NULL,
airportCode VARCHAR(15) NOT NULL,
arrivalTime TIME NOT NULL,
departureTime TIME NOT NULL,
CONSTRAINT pk_flightleg PRIMARY KEY(legNumber),
CONSTRAINT fk_flightleg_flightNumber FOREIGN KEY(flightNumber) REFERENCES Flight(flightNumber)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_flightleg_airport FOREIGN KEY(airportCode) REFERENCES Airport(airportCode) 
ON DELETE CASCADE ON UPDATE CASCADE
);

/*table leg instance*/
CREATE TABLE LegInstance(
date DATE NOT NULL,
noOfAvailableSeat INT NOT NULL,
airplanID VARCHAR(10) NOT NULL,
legNumber VARCHAR(15) NOT NULL,
airportCode VARCHAR(15) NOT NULL,
legArrivalTime TIME NOT NULL,
legDepartureTime TIME NOT NULL,
CONSTRAINT pk_legInstance PRIMARY KEY(date),
CONSTRAINT fk_legInstance_Airplan FOREIGN KEY(airplanID) REFERENCES Airplan(airplanID),
CONSTRAINT fk_legInstance_LegNumber FOREIGN KEY(legNumber) REFERENCES FlightLeg(legNumber),
CONSTRAINT fk_legInstance_airport FOREIGN KEY(airportCode) REFERENCES Airport(airportCode)

);

/*table seat*/
CREATE TABLE Seat(
saetNumber INT NOT NULL,
date DATE NOT NULL,
customerName VARCHAR(20) NOT NULL,
customerPhoneNumer INT NOT NULL,
CONSTRAINT pk_seat PRIMARY KEY(saetNumber),
CONSTRAINT fk_legInstance FOREIGN KEY(date) REFERENCES LegInstance(date)

);

/*table flight fare*/
CREATE TABLE FlightFare(
flightFareCode VARCHAR(15) NOT NULL,
amount DECIMAL(10,2) NOT NULL DEFAULT 0.00,
restriction VARCHAR(60) NOT NULL DEFAULT 'No Restrition',
flightNumber VARCHAR(15) NOT NULL,
CONSTRAINT pk_flightFare PRIMARY KEY(flightFareCode),
CONSTRAINT fk_flightFare_flight FOREIGN KEY(flightNumber) REFERENCES Flight(flightNumber)
);

/*tanle airplan land*/
CREATE TABLE AirplanLand(
airportCode VARCHAR(15) NOT NULL,
airplanID VARCHAR(10) NOT NULL,
CONSTRAINT pk_airplanLand PRIMARY KEY(airportCode,airplanID),
CONSTRAINT fk_airplanLand_airport FOREIGN KEY(airportCode) REFERENCES Airport(airportCode),
CONSTRAINT fk_airplanland_airplan FOREIGN KEY(airplanID) REFERENCES Airplan(airplanID)
);

/*table airplanHasType*/
CREATE TABLE AirplanHasType(
airportCode VARCHAR(15) NOT NULL,
typeName VARCHAR(20) NOT NULL,
CONSTRAINT pk_AirplanHasType PRIMARY KEY(airportCode,typeName),
CONSTRAINT fk_AirplanHasType_airport FOREIGN KEY(airportCode) REFERENCES Airport(airportCode),
CONSTRAINT fk_AirplanHasType_airplanType FOREIGN KEY(typeName) REFERENCES AirplanType(typeName)
);

/*table flight schedule*/
CREATE TABLE FlightSchedule(
flightNumber VARCHAR(15) NOT NULL,
shedule DATETIME NOT NULL,
CONSTRAINT pk_FlightSchedule PRIMARY KEY(flightNumber,shedule),
CONSTRAINT fk_flighrSchedule_flight FOREIGN KEY(flightNumber) REFERENCES Flight(flightNumber)
);

INSERT INTO AirplanType
VALUES ('MID SIZE JET','Embraer',15);

INSERT INTO Airplan
VALUES ('SQT1849','U-2 spy plane',15,'MID SIZE JET');

INSERT INTO Airport
VALUES ('QA2121','Katunayaka Air port','Katunayaka','North');

INSERT INTO Flight
VALUES ('DN112','Sri lankan');

INSERT INTO FlightLeg
VALUES ('leg100','DN112','QA2121','15:20','22:50');

INSERT INTO LegInstance
VALUES ('2022-10-15',5,'SQT1849','leg100','QA2121','2:15','6:30');


INSERT INTO Seat
VALUES (12,'2022-10-15','Dhanuka',0778090357);


INSERT INTO FlightFare
VALUES ('IC20',25000.00,'No Smooking','DN112');


INSERT INTO AirplanLand
VALUES ('QA2121','SQT1849');

INSERT INTO AirplanHasType
VALUES ('QA2121','MID SIZE JET');


INSERT INTO FlightSchedule
VALUES ('DN112','2022-10-11 2:30:15'),
('DN112','2022-10-12 5:30:20');







