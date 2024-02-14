-- Ex1
SELECT COUNT(*) FROM `de-317171.ny_taxi.external_green_tripdata`; 

-- Ex2
SELECT COUNT(DISTINCT PULocationID) FROM `de-317171.ny_taxi.external_green_tripdata`;

--Ex3
SELECT COUNT(*) FROM `de-317171.ny_taxi.external_green_tripdata` WHERE Fare_amount=0;

--Ex4
CREATE OR REPLACE TABLE `de-317171.ny_taxi.external_green_tripdata` PARTITION BY DATE(lpep_pickup_datetime) CLUSTER BY PUlocationID AS ( SELECT * FROM`de-317171.ny_taxi.external_green_tripdata` );

--Ex5
SELECT COUNT(DISTINCT PULocationID) FROM `de-317171.ny_taxi.external_green_tripdata` WHERE DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-06-30';

SELECT COUNT(DISTINCT PULocationID) FROM `de-317171.ny_taxi.external_green_tripdata` WHERE DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-06-30';

--Ex6
-- Answer: GCP Bucket
