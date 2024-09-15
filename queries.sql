-- What is the number of active buses?
SELECT COUNT(*) FROM "ActiveBuses";

-- What are the oldest active buses, in decreasing order?
SELECT "id" FROM "ActiveBuses" 
ORDER BY "fabrication_year" DESC;

-- What is the plate of the bus with most trips?
SELECT "license_plate" FROM "Buses" 
JOIN "Trips" ON "Buses"."id" = "bus_id"
ORDER BY COUNT(*) DESC LIMIT 1;

-- What are the most experienced drivers in decreasing order?
SELECT "first_name", "last_name" FROM "Drivers"
JOIN "Trips" ON "driver_id" = "Driver"."id"
ORDER BY COUNT("Trips"."id") DESC;

-- What is the line with the highest passenger average?
SELECT "line_id", AVG("passengers_count") AS passengers_average  
FROM "Trips"
GROUP BY passengers_average
ORDER BY passengers_average DESC;

-- What are the most delayed lines?
SELECT "id" FROM "Trips"
JOIN "Lines" ON "Lines"."id" = "Trips"."line_id"
WHERE "Trips"."duration" > "Lines"."expected_duration"
GROUP BY "Lines"."id"
ORDER BY AVG("Lines"."expected_duration" - "Trips"."duration") DESC;

-- What are the places with less lines that stop by?
SELECT "location" FROM "Stops"
JOIN "Lines_Stops" ON "Line_Stops"."Stop_id" = "Stop"."id"
WHERE "Stops"."is_active" = TRUE
ORDER BY COUNT("Lines_Stops"."Stop_id");

-- How many distinct lines stop by Universidade de Brasília?
SELECT DISTINCT COUNT(*) FROM "Lines_Stops"
JOIN "Stops" ON "Stops"."id" = "Lines_Stops"."Stop_id"
WHERE "location" = "Universidade de Brasília"
AND "Stops"."is_active" = TRUE;

-- What are the slowest lines in decreasing order?
SELECT "id" FROM "Lines"
ORDER BY ("expected_duration"/"length") DESC;

-- What are the lines with less bus stops?
SELECT "id" FROM "Lines"
JOIN "Lines_Stops" ON "Lines"."id"="Lines_Stops"."line_id"
ORDER BY COUNT(*) ASC;
