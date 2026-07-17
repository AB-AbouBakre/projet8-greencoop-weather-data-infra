{{ config(materialized='view') }}

with infoclimat as (

    select
        station_id,
        measured_at_utc,
        'infoclimat' as source_system,

        temperature_c,
        pressure_hpa,
        humidity_pct,
        dewpoint_c,
        visibility_m,
        wind_speed_kmh,
        wind_gust_kmh,
        wind_direction_deg,
        null::text as wind_direction_text,
        rain_1h_mm,
        rain_3h_mm,
        null::numeric as precip_rate_mm,
        null::numeric as precip_accum_mm,
        snow_depth_cm,
        cloud_cover_octas,
        weather_code,
        null::numeric as uv_index,
        null::numeric as solar_w_m2

    from {{ ref('stg_infoclimat_hourly') }}

),

wu as (

    select
        station_id,
        ('2024-10-01'::date + measured_time)::timestamp as measured_at_utc,
        source_system,

        temperature_c,
        pressure_hpa,
        humidity_pct,
        dewpoint_c,
        null::numeric as visibility_m,
        wind_speed_kmh,
        wind_gust_kmh,
        null::numeric as wind_direction_deg,
        wind_direction_text,
        null::numeric as rain_1h_mm,
        null::numeric as rain_3h_mm,
        precip_rate_mm,
        precip_accum_mm,
        null::numeric as snow_depth_cm,
        null::numeric as cloud_cover_octas,
        null::text as weather_code,
        uv_index,
        solar_w_m2

    from {{ ref('stg_wu_ichtegem') }}

    union all

    select
        station_id,
        ('2024-10-01'::date + measured_time)::timestamp as measured_at_utc,
        source_system,

        temperature_c,
        pressure_hpa,
        humidity_pct,
        dewpoint_c,
        null::numeric as visibility_m,
        wind_speed_kmh,
        wind_gust_kmh,
        null::numeric as wind_direction_deg,
        wind_direction_text,
        null::numeric as rain_1h_mm,
        null::numeric as rain_3h_mm,
        precip_rate_mm,
        precip_accum_mm,
        null::numeric as snow_depth_cm,
        null::numeric as cloud_cover_octas,
        null::text as weather_code,
        uv_index,
        solar_w_m2

    from {{ ref('stg_wu_la_madeleine') }}

)

select *
from infoclimat

union all

select *
from wu
