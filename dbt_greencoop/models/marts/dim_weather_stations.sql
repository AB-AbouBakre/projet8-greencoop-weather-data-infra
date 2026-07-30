{{
    config(
        materialized='table',
        indexes=[
            {'columns': ['station_id'], 'unique': true}
        ]
    )
}}

with weather_underground as (

    select *
    from (
        values
            (
                'IICHTE19',
                'WeerstationBS',
                51.092::numeric,
                2.999::numeric,
                15::integer,
                'Ichtegem',
                'weather_underground',
                'other',
                'EasyWeatherV1.6.6'
            ),
            (
                'ILAMAD25',
                'La Madeleine',
                50.659::numeric,
                3.070::numeric,
                23::integer,
                'La Madeleine',
                'weather_underground',
                'other',
                'EasyWeatherPro_V5.1.6'
            )
    ) as stations (
        station_id,
        station_name,
        latitude,
        longitude,
        elevation_m,
        city,
        source_system,
        hardware,
        software
    )

),

infoclimat as (

    select
        station_id,
        station_name,
        latitude,
        longitude,
        elevation::integer as elevation_m,
        station_name as city,
        'infoclimat'::text as source_system,
        station_type as hardware,
        null::text as software
    from {{ ref('stg_infoclimat_stations') }}

)

select * from weather_underground

union all

select * from infoclimat
