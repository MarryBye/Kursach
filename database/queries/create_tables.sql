-- Active: 1762812206599@@127.0.0.1@5432@taxi_kursach

CREATE DATABASE taxi_kursach;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS Client (
	id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
	first_name VARCHAR(32) NOT NULL,
	last_name VARCHAR(32) NOT NULL,
	email TEXT UNIQUE NOT NULL CHECK (check_email(email)),
	tel_number TEXT UNIQUE NOT NULL CHECK (check_tel(tel_number)),
	password TEXT NOT NULL CHECK (check_password(password)),
	rating DOUBLE PRECISION NOT NULL CHECK(rating >= 0 AND rating <= 5)
);

CREATE TABLE IF NOT EXISTS Driver (
	user_id UUID PRIMARY KEY REFERENCES Client(id),
	license_number TEXT UNIQUE NOT NULL CHECK (check_license_number(license_number)),
	balance DOUBLE PRECISION NOT NULL CHECK (balance >= 0),
	rating DOUBLE PRECISION NOT NULL CHECK(rating >= 0 AND rating <= 5)
);

CREATE TABLE IF NOT EXISTS Mechanic (
	user_id UUID PRIMARY KEY REFERENCES Client(id),
	license_number TEXT UNIQUE NOT NULL CHECK (check_license_number(license_number))
);

CREATE TABLE IF NOT EXISTS Dispatcher (
	user_id UUID PRIMARY KEY REFERENCES Client(id)
);

CREATE TABLE IF NOT EXISTS Administrator (
	user_id UUID PRIMARY KEY REFERENCES Client(id)
);

CREATE TABLE IF NOT EXISTS Car_class (
	id SERIAL PRIMARY KEY,
	name VARCHAR(32) UNIQUE NOT NULL,
	min_price DOUBLE PRECISION NOT NULL CHECK (min_price >= 30)
);

CREATE TABLE IF NOT EXISTS Car_status (
	id SERIAL PRIMARY KEY,
	name VARCHAR(32) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS Car (
	id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
	driver_id UUID UNIQUE REFERENCES Driver(user_id),
	mark VARCHAR(32) NOT NULL,
	model VARCHAR(32) NOT NULL,
	car_number VARCHAR(32) UNIQUE NOT NULL CHECK (check_car_number(car_number)),
	car_class_id INT NOT NULL REFERENCES Car_class(id),
	car_status_id INT NOT NULL REFERENCES Car_status(id)
);

CREATE TABLE IF NOT EXISTS RideOrder_status (
	id SERIAL PRIMARY KEY,
	name VARCHAR(32) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS RideOrder (
	id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
	client_id UUID NOT NULL REFERENCES Client(id),
	driver_id UUID NOT NULL REFERENCES Client(id),
	order_status_id INT NOT NULL REFERENCES RideOrder_status(id),
	ride_date TIMESTAMP NOT NULL DEFAULT now(),
	ride_date_end TIMESTAMP,
	price DOUBLE PRECISION NOT NULL CHECK (price > 0)
);

CREATE TABLE IF NOT EXISTS RideOrder_Rating (
	id SERIAL PRIMARY KEY,
	order_id UUID NOT NULL UNIQUE REFERENCES RideOrder(id),
	client_mark DOUBLE PRECISION NOT NULL CHECK (client_mark >= 0 AND client_mark <= 5),
	driver_mark DOUBLE PRECISION NOT NULL CHECK (driver_mark >= 0 AND driver_mark <= 5)
)

CREATE TABLE IF NOT EXISTS Canceled_rideorder (
	id SERIAL PRIMARY KEY,
	order_id UUID NOT NULL UNIQUE REFERENCES RideOrder(id),
	canceled_by UUID NOT NULL REFERENCES Client(id),
	comment VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Payment_method (
	id SERIAL PRIMARY KEY,
	name VARCHAR(32) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Payment_status (
	id SERIAL PRIMARY KEY,
	name VARCHAR(32) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Payment (
	id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
	order_id UUID UNIQUE NOT NULL REFERENCES RideOrder(id),
	payment_method_id INT NOT NULL REFERENCES Payment_method(id),
	payment_status_id INT NOT NULL REFERENCES Payment_status(id),
	price DOUBLE PRECISION NOT NULL CHECK (price > 0)
);

CREATE TABLE IF NOT EXISTS Marchrute (
	id SERIAL PRIMARY KEY,
	order_id UUID NOT NULL UNIQUE REFERENCES RideOrder(id),
	distance DOUBLE PRECISION NOT NULL
);

CREATE TABLE Marchrute_Points (
	id SERIAL PRIMARY KEY,
	position INT NOT NULL,
	address ADDRESS,
	marchrute_id INT NOT NULL REFERENCES Marchrute(id),
	UNIQUE(marchrute_id, position)
)

CREATE TABLE IF NOT EXISTS Maintenance (
	id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
	mechanic_id UUID NOT NULL REFERENCES Mechanic(user_id),
	car_id UUID NOT NULL REFERENCES Car(id),
	maintenance_start TIMESTAMP NOT NULL,
	maintenance_end TIMESTAMP,
	comment VARCHAR(255) NOT NULL
);