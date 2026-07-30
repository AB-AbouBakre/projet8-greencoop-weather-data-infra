{{ config(materialized='view') }}

with weather_underground as (

    select
        airbyte_raw_id as observation_id,
        station_id,
        source_system,

        (
            (date '2024-10-01' + measured_time)
            at time zone 'Europe/Paris'
        ) as measured_at_utc,

        temperature_c,
        dewpoint_c,
        humidity_pct,

        wind_direction_text,
        null::numeric as wind_direction_deg,

        wind_speed_kmh,
        wind_gust_kmh,
        pressure_hpa,

        precip_rate_mm as rain_1h_mm,
        null::numeric as rain_3h_mm,
        precip_accum_mm,

        null::numeric as snow_depth_cm,
        null::numeric as cloud_cover_octas,
        null::text as weather_code,

        uv_index,
        solar_w_m2,
        null::numeric as visibility_m,

        loaded_at

    from {{ ref('int_weather_underground') }}

),

infoclimat as (

    select
        md5(
            station_id || '|' ||
            measured_at_utc::text
        ) as observation_id,

        station_id,
        'infoclimat'::text as source_system,
        measured_at_utc,

        temperature_c,
        dewpoint_c,
        humidity_pct,

        null::text as wind_direction_text,
        wind_direction_deg,

        wind_speed_kmh,
        wind_gust_kmh,
        pressure_hpa,

        rain_1h_mm,
        rain_3h_mm,
        null::numeric as precip_accum_mm,

        snow_depth_cm,
        cloud_cover_octas,
        weather_code,

        null::numeric as uv_index,
        null::numeric as solar_w_m2,
        visibility_m,

        null::timestamptz as loaded_at

    from {{ ref('stg_infoclimat_hourly') }}

)

select * from weather_underground

union all

select * from infoclimat
