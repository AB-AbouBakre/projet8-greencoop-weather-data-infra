{{
    config(
        materialized='table',
        indexes=[
            {'columns': ['station_id']},
            {'columns': ['measured_at_utc']},
            {'columns': ['observation_id'], 'unique': true}
        ]
    )
}}

select
    observation_id,
    station_id,
    source_system,
    measured_at_utc,

    temperature_c,
    dewpoint_c,
    humidity_pct,

    wind_direction_text,
    wind_direction_deg,
    wind_speed_kmh,
    wind_gust_kmh,

    pressure_hpa,

    rain_1h_mm,
    rain_3h_mm,
    precip_accum_mm,

    snow_depth_cm,
    cloud_cover_octas,
    weather_code,

    uv_index,
    solar_w_m2,
    visibility_m,

    loaded_at

from {{ ref('int_weather_observations_standardized') }}
