{{ config(materialized='view') }}

with source_data as (

    select
        "_airbyte_raw_id"::text as airbyte_raw_id,
        "_airbyte_extracted_at" as extracted_at,
        "_airbyte_generation_id" as airbyte_generation_id,

        "Time"::text as raw_time,
        "Temperature"::text as raw_temperature,
        "Dew_Point"::text as raw_dewpoint,
        "Humidity"::text as raw_humidity,
        "Wind"::text as raw_wind_direction,
        "Speed"::text as raw_wind_speed,
        "Gust"::text as raw_wind_gust,
        "Pressure"::text as raw_pressure,
        "Precip__Rate_"::text as raw_precip_rate,
        "Precip__Accum_"::text as raw_precip_accum,
        "UV"::numeric as raw_uv,
        "Solar"::text as raw_solar

    from {{ source('raw', 'weather_underground_la_madeleine_raw') }}

),

cleaned as (

    select
        airbyte_raw_id,
        extracted_at,
        airbyte_generation_id,

        nullif(trim(raw_time), '')::time as measured_time,

        nullif(
            regexp_replace(raw_temperature, '[^0-9.-]', '', 'g'),
            ''
        )::numeric as temperature_f,

        nullif(
            regexp_replace(raw_dewpoint, '[^0-9.-]', '', 'g'),
            ''
        )::numeric as dewpoint_f,

        nullif(
            regexp_replace(raw_humidity, '[^0-9.-]', '', 'g'),
            ''
        )::numeric as humidity_pct,

        nullif(trim(raw_wind_direction), '') as wind_direction_text,

        nullif(
            regexp_replace(raw_wind_speed, '[^0-9.-]', '', 'g'),
            ''
        )::numeric as wind_speed_mph,

        nullif(
            regexp_replace(raw_wind_gust, '[^0-9.-]', '', 'g'),
            ''
        )::numeric as wind_gust_mph,

        nullif(
            regexp_replace(raw_pressure, '[^0-9.-]', '', 'g'),
            ''
        )::numeric as pressure_inhg,

        nullif(
            regexp_replace(raw_precip_rate, '[^0-9.-]', '', 'g'),
            ''
        )::numeric as precip_rate_in,

        nullif(
            regexp_replace(raw_precip_accum, '[^0-9.-]', '', 'g'),
            ''
        )::numeric as precip_accum_in,

        raw_uv as uv_index,

        nullif(
            regexp_replace(raw_solar, '[^0-9.-]', '', 'g'),
            ''
        )::numeric as solar_w_m2

    from source_data

    where nullif(trim(raw_time), '') is not null

)

select
    airbyte_raw_id,

    'ILAMAD25'::text as station_id,
    'weather_underground'::text as source_system,

    measured_time,

    temperature_f,
    round((temperature_f - 32) * 5 / 9, 2) as temperature_c,

    dewpoint_f,
    round((dewpoint_f - 32) * 5 / 9, 2) as dewpoint_c,

    humidity_pct,
    wind_direction_text,

    wind_speed_mph,
    round(wind_speed_mph * 1.60934, 2) as wind_speed_kmh,

    wind_gust_mph,
    round(wind_gust_mph * 1.60934, 2) as wind_gust_kmh,

    pressure_inhg,
    round(pressure_inhg * 33.8639, 2) as pressure_hpa,

    precip_rate_in,
    round(precip_rate_in * 25.4, 2) as precip_rate_mm,

    precip_accum_in,
    round(precip_accum_in * 25.4, 2) as precip_accum_mm,

    uv_index,
    solar_w_m2,

    extracted_at as loaded_at,
    airbyte_generation_id

from cleaned
