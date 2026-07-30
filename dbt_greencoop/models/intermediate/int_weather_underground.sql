{{ config(materialized='view') }}

select
    airbyte_raw_id,
    station_id,
    source_system,
    measured_time,
    temperature_c,
    dewpoint_c,
    humidity_pct,
    wind_direction_text,
    wind_speed_kmh,
    wind_gust_kmh,
    pressure_hpa,
    precip_rate_mm,
    precip_accum_mm,
    uv_index,
    solar_w_m2,
    loaded_at
from {{ ref('stg_wu_ichtegem') }}

union all

select
    airbyte_raw_id,
    station_id,
    source_system,
    measured_time,
    temperature_c,
    dewpoint_c,
    humidity_pct,
    wind_direction_text,
    wind_speed_kmh,
    wind_gust_kmh,
    pressure_hpa,
    precip_rate_mm,
    precip_accum_mm,
    uv_index,
    solar_w_m2,
    loaded_at
from {{ ref('stg_wu_la_madeleine') }}
