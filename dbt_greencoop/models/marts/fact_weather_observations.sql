{{ 
    config(
        materialized='table',
        indexes=[
            {'columns': ['station_id']},
            {'columns': ['measured_at_utc']},
            {'columns': ['station_id', 'measured_at_utc']}
        ]
    ) 
}}

select
    station_id,
    measured_at_utc,
    source_system,

    temperature_c,
    pressure_hpa,
    humidity_pct,
    dewpoint_c,
    visibility_m,
    wind_speed_kmh,
    wind_gust_kmh,
    wind_direction_deg,
    wind_direction_text,
    rain_1h_mm,
    rain_3h_mm,
    precip_rate_mm,
    precip_accum_mm,
    snow_depth_cm,
    cloud_cover_octas,
    weather_code,
    uv_index,
    solar_w_m2

from {{ ref('int_weather_observations_standardized') }}
