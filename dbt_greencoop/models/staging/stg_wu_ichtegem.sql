{{ config(materialized='view') }}

select
    'IICHTE19' as station_id,
    'weather_underground' as source_system,

    time::time as measured_time,

    nullif(regexp_replace(temperature, '[^0-9\.\-]', '', 'g'), 
'')::numeric as temperature_f,
    ((nullif(regexp_replace(temperature, '[^0-9\.\-]', '', 'g'), 
'')::numeric - 32) * 5 / 9) as temperature_c,

    nullif(regexp_replace(dew_point, '[^0-9\.\-]', '', 'g'), '')::numeric 
as dewpoint_f,
    ((nullif(regexp_replace(dew_point, '[^0-9\.\-]', '', 'g'), 
'')::numeric - 32) * 5 / 9) as dewpoint_c,

    nullif(regexp_replace(humidity, '[^0-9\.\-]', '', 'g'), '')::numeric 
as humidity_pct,

    wind as wind_direction_text,

    nullif(regexp_replace(speed, '[^0-9\.\-]', '', 'g'), '')::numeric as 
wind_speed_mph,
    nullif(regexp_replace(speed, '[^0-9\.\-]', '', 'g'), '')::numeric * 
1.60934 as wind_speed_kmh,

    nullif(regexp_replace(gust, '[^0-9\.\-]', '', 'g'), '')::numeric as 
wind_gust_mph,
    nullif(regexp_replace(gust, '[^0-9\.\-]', '', 'g'), '')::numeric * 
1.60934 as wind_gust_kmh,

    nullif(regexp_replace(pressure, '[^0-9\.\-]', '', 'g'), '')::numeric 
as pressure_inhg,
    nullif(regexp_replace(pressure, '[^0-9\.\-]', '', 'g'), '')::numeric * 
33.8639 as pressure_hpa,

    nullif(regexp_replace(precip_rate, '[^0-9\.\-]', '', 'g'), 
'')::numeric as precip_rate_in,
    nullif(regexp_replace(precip_rate, '[^0-9\.\-]', '', 'g'), 
'')::numeric * 25.4 as precip_rate_mm,

    nullif(regexp_replace(precip_accum, '[^0-9\.\-]', '', 'g'), 
'')::numeric as precip_accum_in,
    nullif(regexp_replace(precip_accum, '[^0-9\.\-]', '', 'g'), 
'')::numeric * 25.4 as precip_accum_mm,

    nullif(uv, '')::numeric as uv_index,
    nullif(regexp_replace(solar, '[^0-9\.\-]', '', 'g'), '')::numeric as 
solar_w_m2,

    loaded_at

from {{ source('raw', 'weather_underground_ichtegem_raw') }}
where nullif(time, '') is not null
