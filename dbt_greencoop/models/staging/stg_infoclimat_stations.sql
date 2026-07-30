{{ config(materialized='view') }}

select
    station ->> 'id' as station_id,
    station ->> 'name' as station_name,
    (station ->> 'latitude')::numeric as latitude,
    (station ->> 'longitude')::numeric as longitude,
    (station ->> 'elevation')::numeric as elevation,
    station ->> 'type' as station_type,
    station -> 'license' ->> 'license' as license_name,
    station -> 'license' ->> 'source' as license_source,
    station -> 'license' ->> 'url' as license_url,
    station -> 'license' ->> 'metadonnees' as metadata_url
from {{ source('raw', 'infoclimat_raw') }},
jsonb_array_elements(raw_data::jsonb -> 'stations') as station
