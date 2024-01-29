-- q3
SELECT COUNT(*)
 FROM green_taxi_data
 WHERE DATE(lpep_pickup_datetime) = '2019-09-18' and date(lpep_pickup_datetime) = '2019-09-18'

+-------+
| count |
|-------|
| 15767 |
+-------+

-- q4
SELECT DATE(lpep_pickup_datetime) AS pickup_day, MAX(trip_distance) AS max_trip_distance
 FROM green_taxi_data
 WHERE DATE(lpep_pickup_datetime) IN ('2019-09-18', '2019-09-16', '2019-09-26', '2019-09-02')
 GROUP BY DATE(lpep_pickup_datetime)
 ORDER BY max_trip_distance DESC
 LIMIT 1;
 
+------------+-------------------+
| pickup_day | max_trip_distance |
|------------+-------------------|
| 2019-09-26 | 341.64            |
+------------+-------------------+

--q5

-- Btw, postgres is terrible, this case-sensetivity took 20 mins of my life

SELECT b."Borough", SUM(g.total_amount) AS total_borough_amount
FROM green_taxi_data g
JOIN taxi_lookup b
ON g."PULocationID" = b."LocationID"
WHERE DATE(g.lpep_pickup_datetime) = '2019-09-18'
AND b."Borough" <> 'Unknown'  -- Ensure the case matches exactly how it's stored in the database
GROUP BY b."Borough"
HAVING SUM(g.total_amount) > 50000
ORDER BY total_borough_amount DESC
LIMIT 3;

-- 6 

SELECT b_drop."Zone" AS drop_off_zone, MAX(a.tip_amount) AS max_tip
FROM green_taxi_data a
JOIN taxi_lookup b_pick
ON a."PULocationID" = b_pick."LocationID"
JOIN taxi_lookup b_drop
ON a."DOLocationID" = b_drop."LocationID"
WHERE b_pick."Zone" = 'Astoria'
AND DATE(a.lpep_pickup_datetime) >= '2019-09-01' 
AND DATE(a.lpep_pickup_datetime) < '2019-10-01'
GROUP BY b_drop."Zone"
ORDER BY max_tip DESC
LIMIT 1;
