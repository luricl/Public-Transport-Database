CREATE TABLE Buses (
    "id" INTEGER,
    "license_plate" TEXT,
    "fabrication_year" INTEGER,
    "is_active" INTEGER DEFAULT TRUE,
    PRIMARY KEY("id")
);

CREATE TABLE Lines (
    "id" INTEGER,
    "expected_duration" TIME,
    "destination" TEXT,
    "departure" TEXT,
    "length" REAL,
    "is_active" BOOLEAN,
    PRIMARY KEY("id"),
);

CREATE TABLE Trips (
    "id" INTEGER,
    "bus_id" INTEGER,
    "driver_id" INTEGER,
    "line_id" INTEGER,
    "passengers_count" INTEGER DEFAULT 0,
    "duration" INTEGER,
    "date" TEXT,
    PRIMARY KEY("id"),
    FOREIGN KEY("bus_id") REFERENCES "Buses"("id"),
    FOREIGN KEY("driver_id") REFERENCES "Drivers"("id"),
    FOREIGN KEY("line_id") REFERENCES "Lines"("id")
);

CREATE TABLE Drivers (
    "id" INTEGER,
    "first_name" TEXT,
    "last_name" TEXT,
    "is_active" BOOLEAN,
    PRIMARY KEY("id")
);

CREATE TABLE Lines_Stops (
    "id" INTEGER,
    "line_id" INTEGER,
    "Stop_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("line_id") REFERENCES "Lines"("id")
);

CREATE TABLE Stops (
    "id" INTEGER,
    "location" TEXT,
    "is_active" INTEGER,
    PRIMARY KEY("id")
);

-- View for visualizing active stops
CREATE VIEW "ActiveStops" AS
SELECT * FROM "Stops"
WHERE "is_active" = TRUE;

CREATE VIEW "ActiveBuses" AS
SELECT * FROM "Buses"
WHERE "is_active" = TRUE;

CREATE VIEW "ActiveLines" AS
SELECT * FROM "Lines"
WHERE "is_active" = TRUE;

-- create trigger for excluding bustops
CREATE TRIGGER "DeleteStops"
INSTEAD OF DELETE ON "ActiveStops"
    WHEN OLD."is_active" = FALSE
BEGIN
    UPDATE "Stops" 
    SET "is_active" = FALSE
    WHERE "id" = OLD."id"; 
END;

CREATE TRIGGER "DeleteBuses"
INSTEAD OF DELETE ON "ActiveBuses"
    WHEN OLD."is_active" = FALSE
BEGIN
    UPDATE "Buses" 
    SET "is_active" = FALSE
    WHERE "id" = OLD."id"; 
END;

CREATE TRIGGER "DeleteLines"
INSTEAD OF DELETE ON "ActiveLines"
    WHEN OLD."is_active" = FALSE
BEGIN
    UPDATE "Lines" 
    SET "is_active" = FALSE
    WHERE "id" = OLD."id"; 
END;

-- index on most used columns on trips
CREATE INDEX "bus_index"
ON "Trips"("bus_id"); 

CREATE INDEX "lines_index"
ON "Trips"("lines_id");