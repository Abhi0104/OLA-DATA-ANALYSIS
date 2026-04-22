DROP TABLE IF EXISTS rides;

CREATE TABLE rides (
    "Date" TEXT,
    "Time" TEXT,
    "Booking_ID" TEXT,
    "Booking_Status" TEXT,
    "Customer_ID" TEXT,
    "Vehicle_Type" TEXT,
    "Pickup_Location" TEXT,
    "Drop_Location" TEXT,
    "V_TAT" TEXT,
    "C_TAT" TEXT,
    "Canceled_Rides_by_Customer" TEXT,
    "Canceled_Rides_by_Driver" TEXT,
    "Incomplete_Rides" TEXT,
    "Incomplete_Rides_Reason" TEXT,
    "Booking_Value" TEXT,
    "Payment_Method" TEXT,
    "Ride_Distance" TEXT,
    "Driver_Ratings" TEXT,
    "Customer_Rating" TEXT
);

-- Bookings DataSet
SELECT * FROM rides;

-- Retrieve all successful bookings:
CREATE VIEW Successful_Bookings AS
SELECT * 
FROM rides
WHERE "Booking_Status" = 'Success';

-- Find the average ride distance for each vehicle type:
--Convert TEXT to Float
CREATE VIEW ride_distance_for_each_vehicle AS 
SELECT "Vehicle_Type", 
       AVG("Ride_Distance"::FLOAT) AS avg_distance
FROM rides
GROUP BY "Vehicle_Type";


-- Get the total number of cancelled rides by customers:
CREATE VIEW Cancelled_rides_by_customers AS 
SELECT COUNT(*) AS Total_cancelled_rides
FROM rides
WHERE "Booking_Status" = 'Canceled by Customer';

-- Get the number of rides cancelled by drivers due to personal and car-related issues:
CREATE VIEW rides_cancelled_by_drivers AS
SELECT COUNT(*) AS total_rides_cancelled
FROM rides
WHERE "Incomplete_Rides_Reason" = 'Personal & Car related issue';

-- List the top 5 customers who booked the highest number of rides:
CREATE VIEW top_5_customers AS
SELECT "Customer_ID", COUNT("Booking_ID") AS "Total_rides"
FROM rides
GROUP BY "Customer_ID"
ORDER BY "Total_rides" DESC
LIMIT 5;


-- Find the maximum and minimum driver ratings for Prime Sedan bookings:
CREATE VIEW Max_Min_Driver_Rating AS
SELECT MAX("Driver_Ratings") AS Max_Ratings,MIN("Driver_Ratings") AS Min_Ratings
FROM rides
WHERE "Vehicle_Type" = 'Prime Sedan';


--  Retrieve all rides where payment was made using UPI:
CREATE VIEW UPI_PAYMENT AS
SELECT * 
FROM rides
WHERE "Payment_Method" = 'UPI';

-- Find the average customer rating per vehicle type:
CREATE VIEW Avg_Cust_Rating AS
SELECT "Vehicle_Type", 
ROUND(AVG("Customer_Rating"::FLOAT):: NUMERIC,2) AS AVG_CUSTOMER_RATING
FROM rides
WHERE "Booking_Status" = 'Success'
GROUP BY "Vehicle_Type";

-- Calculate the total booking value of rides completed successfully:
CREATE VIEW total_successful_ride_value AS
SELECT SUM("Booking_Value"::FLOAT) AS total_booking_value
FROM rides
WHERE "Booking_Status" = 'Success';

-- List all incomplete rides along with the reason:
CREATE VIEW Incomplete_rides_reason AS
SELECT "Booking_ID", "Incomplete_Rides_Reason"
FROM rides
WHERE "Incomplete_Rides" = 'Yes';


-- Retrieve All Answers Using VIEWS
-- #1. Retrieve all successful bookings:
Select * From Successful_Bookings;


-- #2. Find the average ride distance for each vehicle type:
Select * From ride_distance_for_each_vehicle;

-- #3. Get the total number of cancelled rides by customers:
Select * From Cancelled_rides_by_customers;

-- #4. List the top 5 customers who booked the highest number of rides:
Select * From rides_cancelled_by_drivers;

-- #5. Get the number of rides cancelled by drivers due to personal and car-related issues:
Select * From top_5_customers;

-- #6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
Select * From Max_Min_Driver_Rating;

-- #7. Retrieve all rides where payment was made using UPI:
Select * From UPI_PAYMENT;

-- #8. Find the average customer rating per vehicle type:
SELECT * FROM Avg_Cust_Rating;

-- #9. Calculate the total booking value of rides completed successfully:
Select * From total_successful_ride_value;

-- #10. List all incomplete rides along with the reason:
Select * From Incomplete_rides_reason;







