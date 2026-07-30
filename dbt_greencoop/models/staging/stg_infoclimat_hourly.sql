{{ config(materialized='view') }}

with hourly_data as (

    select
        station_key,
        measurement
    from {{ source('raw', 'infoclimat_raw') }},
    jsonb_each(raw_data::jsonb -> 'hourly') as h(station_key, measurements),
    jsonb_array_elements(measurements) as measurement

)

select
    measurement ->> 'id_station' as station_id,
    (measurement ->> 'dh_utc')::timestamp as measured_at_utc,

    nullif(measurement ->> 'temperature', '')::numeric as temperature_c,
    nullif(measurement ->> 'pression', '')::numeric as pressure_hpa,
    nullif(measurement ->> 'humidite', '')::numeric as humidity_pct,
    nullif(measurement ->> 'point_de_rosee', '')::numeric as dewpoint_c,
    nullif(measurement ->> 'visibilite', '')::numeric as visibility_m,
    nullif(measurement ->> 'vent_moyen', '')::numeric as wind_speed_kmh,
    nullif(measurement ->> 'vent_rafales', '')::numeric as wind_gust_kmh,
    nullif(measurement ->> 'vent_direction', '')::numeric as 
wind_direction_deg,
    nullif(measurement ->> 'pluie_3h', '')::numeric as rain_3h_mm,
    nullif(measurement ->> 'pluie_1h', '')::numeric as rain_1h_mm,
    nullif(measurement ->> 'neige_au_sol', '')::numeric as snow_depth_cm,
    nullif(measurement ->> 'nebulosite', '')::numeric as 
cloud_cover_octas,
    nullif(measurement ->> 'temps_omm', '') as weather_code

from hourly_data
where nullif(measurement ->> 'id_station', '') is not null
