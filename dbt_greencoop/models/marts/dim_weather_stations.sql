{{ config(materialized='table') }}

select
    station_id,
    station_name,
    latitude,
    longitude,
    elevation,
    station_type,
    'infoclimat' as source_system,
    null as city,
    null as hardware,
    null as software,
    license_name,
    license_source,
    license_url,
    metadata_url

from {{ ref('stg_infoclimat_stations') }}

union all

select
    'IICHTE19' as station_id,
    'WeerstationBS' as station_name,
    51.092::numeric as latitude,
    2.999::numeric as longitude,
    15::numeric as elevation,
    'semi-professional' as station_type,
    'weather_underground' as source_system,
    'Ichtegem' as city,
    'other' as hardware,
    'EasyWeatherV1.6.6' as software,
    null as license_name,
    null as license_source,
    null as license_url,
    null as metadata_url

union all

select
    'ILAMAD25' as station_id,
    'La Madeleine' as station_name,
    50.659::numeric as latitude,
    3.07::numeric as longitude,
    23::numeric as elevation,
    'semi-professional' as station_type,
    'weather_underground' as source_system,
    'La Madeleine' as city,
    'other' as hardware,
    'EasyWeatherPro_V5.1.6' as software,
    null as license_name,
    null as license_source,
    null as license_url,
    null as metadata_url
