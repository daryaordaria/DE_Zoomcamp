import io
import pandas as pd
import requests
from io import BytesIO
import gzip

if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test

@data_loader
def load_data_from_api():
    urls = [
        'https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2020-10.csv.gz',
        'https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2020-11.csv.gz',
        'https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2020-12.csv.gz'
    ]

    dataframes = []  

    taxi_dtypes = {
        'VendorID': 'Int64',
        'passenger_count': 'Int64',
        'trip_distance': 'float',
        'RatecodeID': 'Int64',
        'store_and_fwd_flag': 'string',
        'PULocationID': 'Int64',
        'DOLocationID': 'Int64',
        'payment_type': 'Int64',
        'fare_amount': 'float',
        'extra': 'float',
        'mta_tax': 'float',
        'tip_amount': 'float',
        'tolls_amount': 'float',
        'improvement_surcharge': 'float',
        'total_amount': 'float',
        'congestion_surcharge': 'float'
    }

    parse_dates = ['lpep_pickup_datetime', 'lpep_dropoff_datetime']

    for url in urls:
        response = requests.get(url)
        if response.status_code == 200:
            with gzip.open(BytesIO(response.content), 'rt') as f:
                df = pd.read_csv(f, dtype=taxi_dtypes,parse_dates=parse_dates)
                dataframes.append(df)
        else:
            print(f"Failed to download the file from {url}. Status code: {response.status_code}")

    final_df = pd.concat(dataframes, ignore_index=True)
    return final_df