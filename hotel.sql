use july7;
commit;
select * from hotels;
---- 1 Total revenue -----
SELECT SUM(costprice * length_of_stay) AS Total_Revenue
FROM hotels;
---- 2 room type wise revenue ---
SELECT room_type,
       SUM(costprice * length_of_stay) AS Revenue
FROM hotels
GROUP BY room_type
ORDER BY Revenue DESC;
------ 3 city wise revenue ----
SELECT City,
       SUM(costprice * length_of_stay) AS Revenue
FROM hotels
GROUP BY City
ORDER BY Revenue DESC;
---- 4 Highest revenue ----
SELECT room_type,
       SUM(costprice * length_of_stay) AS Revenue
FROM hotels
GROUP BY room_type
ORDER BY Revenue DESC
LIMIT 1;
---- 5  Average rating wise roomtype -------
SELECT room_type,
       AVG(star_Rating) AS Avg_Rating
FROM hotels
GROUP BY room_type
ORDER BY Avg_Rating DESC;
---- 6 Roomtype wise booking count ------
SELECT Room_Type,
       COUNT(*) AS Booking_Count
FROM hotels
GROUP BY Room_Type
ORDER BY Booking_Count DESC;
------ 7 Average cost price per roomtype------
SELECT Room_Type,
       AVG(costprice) AS Avg_Price
FROM hotels
GROUP BY Room_Type;
--- 8 Payement methods count ----
SELECT Payment_Method,
       COUNT(*) AS Usage_Count
FROM hotels
GROUP BY Payment_Method
ORDER BY Usage_Count DESC;
---- 9 Monthly wise revune ----
SELECT str_to_date(Booking_Date, '%m/%d/%Y') AS Month,
       SUM(costprice * length_of_stay) AS Revenue
FROM hotels
GROUP BY Month
ORDER BY Month;

SELECT 
    month(STR_TO_DATE(Booking_Date, '%d/%m/%Y')) AS month,
    year(str_to_date(Booking_date,'%d/%m/%y')) as year,
    day(str_to_date(booking_date,'%d/%m/%y')) as day
FROM hotels;

---- 10 cost price above 10000 ----
SELECT *
FROM hotels
WHERE (costprice * length_of_stay) > 10000;

--- 11 Agegroup wise rating ----
SELECT 
    CASE 
        WHEN star_Rating >= 4.5 THEN 'Excellent'
        WHEN star_Rating >= 3.5 THEN 'Good'
        WHEN star_Rating >= 2.5 THEN 'Average'
        ELSE 'Poor'
    END AS Rating_Category,
    COUNT(*) AS Total_Customers
FROM hotels
GROUP BY Rating_Category;

---- 12 Top city in highest bookings---
SELECT City,
       COUNT(*) AS Total_Bookings
FROM hotels
GROUP BY City
ORDER BY Total_Bookings DESC
LIMIT 1;

--- 13 Average of staying days in hotels ----
SELECT AVG(length_of_stay) AS Avg_Stay_Days
FROM hotels;
select * from hotels;
--- 14 city wise count of bookings and revenue ----
SELECT 
    city,
    COUNT(*) AS Total_Bookings,
    SUM(costprice * length_of_stay) AS Revenue
FROM hotels
GROUP BY city;
---- 15 booking_status and refund_status perecenatge
SELECT 
    Booking_Status,
    Refund_Status,
    COUNT(*) AS Total,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM hotels),
        2
    ) AS Percentage
FROM hotels
GROUP BY Booking_Status, Refund_Status
ORDER BY Booking_Status;

--- 16 weekend check in perecentage and count ----
SELECT 
    Is_Weekend_Checkin,
    COUNT(*) AS Total_Count,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM hotels),
        2
    ) AS Percentage
FROM hotels
GROUP BY Is_Weekend_Checkin;

---- 16 coupoon used percentage ----
SELECT 
    coupon_used,
    COUNT(*) AS Total_Count,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM hotels),
        2
    ) AS Percentage
FROM hotels
GROUP BY coupon_used;
describe hotels;

--- 17 refund amount by cystomer_id -----
SELECT 
    Refund_Status,
    customer_id,
    COUNT(*) AS Total_Bookings,
    SUM(
        CASE 
            WHEN Refund_Status = 'yes'
            THEN refund_amount
            ELSE 0
        END
    ) AS Refund_Amount
FROM hotels
GROUP BY Refund_Status,customer_id; 
