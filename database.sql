CREATE TABLE Floor (
    number INT PRIMARY KEY,
    area DECIMAL(10, 2)
);

CREATE TABLE RoomType (
    type VARCHAR(50) PRIMARY KEY,
    dailyRate DECIMAL(10, 2)
);

CREATE TABLE Guest (
    guestId INT PRIMARY KEY,
    name VARCHAR(100),
    sex VARCHAR(10),
    age INT
);

CREATE TABLE Meal (
    mealId INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2)
);

CREATE TABLE Employee (
    employeeId INT PRIMARY KEY,
    name VARCHAR(100),
    sex VARCHAR(10),
    salary DECIMAL(10, 2) CHECK (salary > 0)
);

CREATE TABLE Schedule (
    scheduleId INT PRIMARY KEY,
    dayOfWeek VARCHAR(20),
    shiftHours VARCHAR(50)
);

CREATE TABLE Facility (
    facilityId INT PRIMARY KEY,
    openingHours VARCHAR(50),
    location VARCHAR(100)
);

CREATE TABLE Driver (
    employeeId INT PRIMARY KEY,
    licenseNumber VARCHAR(50),
    phone VARCHAR(20),
    FOREIGN KEY (employeeId) REFERENCES Employee(employeeId)
);

CREATE TABLE Gym (
    facilityId INT PRIMARY KEY,
    equipmentType VARCHAR(100),
    FOREIGN KEY (facilityId) REFERENCES Facility(facilityId)
);

CREATE TABLE Spa (
    facilityId INT PRIMARY KEY,
    hasSauna BOOLEAN,
    FOREIGN KEY (facilityId) REFERENCES Facility(facilityId)
);

CREATE TABLE SwimmingPool (
    facilityId INT PRIMARY KEY,
    isHeated BOOLEAN,
    FOREIGN KEY (facilityId) REFERENCES Facility(facilityId)
);

CREATE TABLE Room (
    roomNumber INT PRIMARY KEY,
    capacity INT CHECK (capacity > 0),
    area DECIMAL(10, 2) CHECK (area > 0),
    floorNumber INT,
    roomType VARCHAR(50),
    FOREIGN KEY (floorNumber) REFERENCES Floor(number),
    FOREIGN KEY (roomType) REFERENCES RoomType(type)
);

CREATE TABLE Booking (
    bookingId INT PRIMARY KEY,
    checkInDate DATE,
    checkOutDate DATE,
    status VARCHAR(30),
    totalAmount DECIMAL(10, 2),
    guestId INT,
    roomNumber INT,
    CHECK (checkOutDate > checkInDate),
    FOREIGN KEY (guestId) REFERENCES Guest(guestId),
    FOREIGN KEY (roomNumber) REFERENCES Room(roomNumber)
);

CREATE TABLE Services (
    serviceId INT PRIMARY KEY,
    serviceType VARCHAR(100),
    cost DECIMAL(10, 2),
    bookingId INT,
    FOREIGN KEY (bookingId) REFERENCES Booking(bookingId)
);

CREATE TABLE Payment (
    paymentId INT PRIMARY KEY,
    paymentDate DATE,
    amount DECIMAL(10, 2) CHECK (amount > 0),
    method VARCHAR(50),
    bookingId INT,
    FOREIGN KEY (bookingId) REFERENCES Booking(bookingId)
);

CREATE TABLE Maintenance (
    maintenanceId INT PRIMARY KEY,
    description TEXT,
    maintDate DATE,
    employeeId INT,
    roomNumber INT,
    facilityId INT,
    FOREIGN KEY (employeeId) REFERENCES Employee(employeeId),
    FOREIGN KEY (roomNumber) REFERENCES Room(roomNumber),
    FOREIGN KEY (facilityId) REFERENCES Facility(facilityId)
);

CREATE TABLE MealOrder (
    bookingId INT,
    mealId INT,
    quantity INT,
    orderDate DATE,
    PRIMARY KEY (bookingId, mealId),
    FOREIGN KEY (bookingId) REFERENCES Booking(bookingId),
    FOREIGN KEY (mealId) REFERENCES Meal(mealId)
);

CREATE TABLE EmployeeSchedule (
    employeeId INT,
    scheduleId INT,
    PRIMARY KEY (employeeId, scheduleId),
    FOREIGN KEY (employeeId) REFERENCES Employee(employeeId),
    FOREIGN KEY (scheduleId) REFERENCES Schedule(scheduleId)
);