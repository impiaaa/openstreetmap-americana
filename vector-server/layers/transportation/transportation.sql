CREATE OR REPLACE FUNCTION highway_is_link(highway text) RETURNS boolean AS
$$
SELECT highway LIKE '%_link';
$$ LANGUAGE SQL IMMUTABLE
                STRICT
                PARALLEL SAFE;


-- etldoc: layer_transportation[shape=record fillcolor=lightpink, style="rounded,filled",
-- etldoc:     label="<sql> layer_transportation |<z4> z4 |<z5> z5 |<z6> z6 |<z7> z7 |<z8> z8 |<z9> z9 |<z10> z10 |<z11> z11 |<z12> z12|<z13> z13|<z14_> z14+" ] ;
CREATE OR REPLACE FUNCTION layer_transportation(bbox geometry, zoom_level int)
    RETURNS TABLE
            (
                osm_id    bigint,
                geometry  geometry,
                class     text,
                subclass  text,
                ramp      int,
                oneway    int,
                brunnel   text,
                service   text,
                layer     int,
                level     int,
                indoor    int,
                surface   text
            )
AS
$$
SELECT osm_id,
       geometry,
       CASE
           WHEN NULLIF(highway, '') IS NOT NULL OR NULLIF(public_transport, '') IS NOT NULL
               THEN highway_class(highway, public_transport, construction)
           END AS class,
       CASE
           WHEN (highway IS NOT NULL OR public_transport IS NOT NULL)
               AND highway_class(highway, public_transport, construction) = 'path'
               THEN COALESCE(NULLIF(public_transport, ''), highway)
           END AS subclass,
       -- All links are considered as ramps as well
       CASE
           WHEN highway_is_link(highway) OR highway = 'steps'
               THEN 1
           ELSE is_ramp::int END AS ramp,
       is_oneway::int AS oneway,
       brunnel(is_bridge, is_tunnel, is_ford) AS brunnel,
       NULLIF(service, '') AS service,
       NULLIF(layer, 0) AS layer,
       "level",
       CASE WHEN indoor = TRUE THEN 1 END AS indoor,
       NULLIF(surface, '') AS surface
FROM (
         -- etldoc: osm_transportation_merge_linestring_gen_z4 -> layer_transportation:z4
         SELECT osm_id,
                geometry,
                highway,
                construction,
                NULL AS public_transport,
                NULL AS service,
                is_bridge,
                is_tunnel,
                is_ford,
                NULL::boolean AS is_ramp,
                NULL::int AS is_oneway,
                NULL AS man_made,
                NULL::int AS layer,
                NULL::int AS level,
                NULL::boolean AS indoor,
                NULL AS surface,
                z_order
         FROM osm_transportation_merge_linestring_gen_z4
         WHERE zoom_level = 4
         UNION ALL

         -- etldoc: osm_transportation_merge_linestring_gen_z5 -> layer_transportation:z5
         SELECT osm_id,
                geometry,
                highway,
                construction,
                NULL AS public_transport,
                NULL AS service,
                is_bridge,
                is_tunnel,
                is_ford,
                NULL::boolean AS is_ramp,
                NULL::int AS is_oneway,
                NULL AS man_made,
                NULL::int AS layer,
                NULL::int AS level,
                NULL::boolean AS indoor,
                NULL AS surface,
                z_order
         FROM osm_transportation_merge_linestring_gen_z5
         WHERE zoom_level = 5
         UNION ALL

         -- etldoc: osm_transportation_merge_linestring_gen_z6 -> layer_transportation:z6
         SELECT osm_id,
                geometry,
                highway,
                construction,
                NULL AS public_transport,
                NULL AS service,
                is_bridge,
                is_tunnel,
                is_ford,
                NULL::boolean AS is_ramp,
                NULL::int AS is_oneway,
                NULL AS man_made,
                NULL::int AS layer,
                NULL::int AS level,
                NULL::boolean AS indoor,
                NULL AS surface,
                z_order
         FROM osm_transportation_merge_linestring_gen_z6
         WHERE zoom_level = 6
         UNION ALL

         -- etldoc: osm_transportation_merge_linestring_gen_z7  ->  layer_transportation:z7
         SELECT osm_id,
                geometry,
                highway,
                construction,
                NULL AS public_transport,
                NULL AS service,
                is_bridge,
                is_tunnel,
                is_ford,
                NULL::boolean AS is_ramp,
                NULL::int AS is_oneway,
                NULL AS man_made,
                NULL::int AS layer,
                NULL::int AS level,
                NULL::boolean AS indoor,
                NULL AS surface,
                z_order
         FROM osm_transportation_merge_linestring_gen_z7
         WHERE zoom_level = 7
         UNION ALL

         -- etldoc: osm_transportation_merge_linestring_gen_z8  ->  layer_transportation:z8
         SELECT osm_id,
                geometry,
                highway,
                construction,
                NULL AS public_transport,
                NULL AS service,
                is_bridge,
                is_tunnel,
                is_ford,
                NULL::boolean AS is_ramp,
                NULL::int AS is_oneway,
                NULL AS man_made,
                NULL::int AS layer,
                NULL::int AS level,
                NULL::boolean AS indoor,
                NULL AS surface,
                z_order
         FROM osm_transportation_merge_linestring_gen_z8
         WHERE zoom_level = 8
         UNION ALL

         -- etldoc: osm_transportation_merge_linestring_gen_z9  ->  layer_transportation:z9
         SELECT osm_id,
                geometry,
                highway,
                construction,
                NULL AS public_transport,
                NULL AS service,
                is_bridge,
                is_tunnel,
                is_ford,
                NULL::boolean AS is_ramp,
                NULL::int AS is_oneway,
                NULL AS man_made,
                layer,
                NULL::int AS level,
                NULL::boolean AS indoor,
                NULL AS surface,
                z_order
         FROM osm_transportation_merge_linestring_gen_z9
         WHERE zoom_level = 9
         UNION ALL

         -- etldoc: osm_transportation_merge_linestring_gen_z10  ->  layer_transportation:z10
         SELECT osm_id,
                geometry,
                highway,
                construction,
                NULL AS public_transport,
                NULL AS service,
                is_bridge,
                is_tunnel,
                is_ford,
                NULL::boolean AS is_ramp,
                NULL::int AS is_oneway,
                NULL AS man_made,
                layer,
                NULL::int AS level,
                NULL::boolean AS indoor,
                NULL AS surface,
                z_order
         FROM osm_transportation_merge_linestring_gen_z10
         WHERE zoom_level = 10
         UNION ALL

         -- etldoc: osm_transportation_merge_linestring_gen_z11  ->  layer_transportation:z11
         SELECT osm_id,
                geometry,
                highway,
                construction,
                NULL AS public_transport,
                NULL AS service,
                is_bridge,
                is_tunnel,
                is_ford,
                NULL::boolean AS is_ramp,
                NULL::int AS is_oneway,
                NULL AS man_made,
                layer,
                NULL::int AS level,
                NULL::boolean AS indoor,
                NULL AS surface,
                z_order
         FROM osm_transportation_merge_linestring_gen_z11
         WHERE zoom_level = 11
         UNION ALL

         -- etldoc: osm_highway_linestring  ->  layer_transportation:z12
         -- etldoc: osm_highway_linestring  ->  layer_transportation:z13
         -- etldoc: osm_highway_linestring  ->  layer_transportation:z14_
         SELECT osm_id,
                geometry,
                highway,
                construction,
                public_transport,
                service_value(service) AS service,
                is_bridge,
                is_tunnel,
                is_ford,
                is_ramp,
                is_oneway,
                man_made,
                layer,
                CASE WHEN highway IN ('footway', 'steps') THEN "level" END AS "level",
                CASE WHEN highway IN ('footway', 'steps') THEN indoor END AS indoor,
                surface_value(surface) AS "surface",
                z_order
         FROM osm_highway_linestring
         WHERE NOT is_area
           AND (
                     zoom_level = 12 AND (
                             highway_class(highway, public_transport, construction) NOT IN ('track', 'path', 'minor')
                         OR highway IN ('unclassified', 'residential')
                     ) AND man_made <> 'pier'
                 OR zoom_level = 13
                         AND (
                                    highway_class(highway, public_transport, construction) NOT IN ('track', 'path') AND
                                    man_made <> 'pier'
                            OR
                                    man_made = 'pier' AND NOT ST_IsClosed(geometry)
                        )
                 OR zoom_level >= 14
                         AND (
                            man_made <> 'pier'
                            OR
                            NOT ST_IsClosed(geometry)
                        )
             )
     ) AS zoom_levels
WHERE geometry && bbox
ORDER BY z_order ASC;
$$ LANGUAGE SQL STABLE
                -- STRICT
                PARALLEL SAFE;
