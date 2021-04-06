-- assessments/confirmations/designs/remediations are all slightly different,
-- pull data from crossings table into materialized views

-- currently deployed pg_tileserv does not support materialized views, just use tables for now
-- DROP MATERIALIZED VIEW IF EXISTS bcfishpass.crossings_pscis_assessment_vw;
-- CREATE MATERIALIZED VIEW bcfishpass.crossings_pscis_assessment_vw AS

DROP TABLE IF EXISTS bcfishpass.crossings_pscis_assessment_vw;
CREATE TABLE bcfishpass.crossings_pscis_assessment_vw AS
SELECT
  c.*,
 a.funding_project_number,
 a.funding_project,
 a.funding_source,
 a.responsible_party_name,
 a.consultant_name,
 a.assessment_date,
 a.external_crossing_reference,
 a.crew_members,
 a.stream_name,
 a.road_name,
 a.road_km_mark,
 a.road_tenure,
 a.diameter_or_span,
 a.length_or_width,
 a.continuous_embeddedment_ind,
 a.average_depth_embededdment,
 a.resemble_channel_ind,
 a.backwatered_ind,
 a.percentage_backwatered,
 a.fill_depth,
 a.outlet_drop,
 a.outlet_pool_depth,
 a.inlet_drop_ind,
 a.culvert_slope,
 a.downstream_channel_width,
 a.stream_slope,
 a.beaver_activity_ind,
 a.fish_observed_ind,
 a.valley_fill_code,
 a.valley_fill_code_desc,
 a.habitat_value_code,
 a.habitat_value_desc,
 a.stream_width_ratio,
 a.stream_width_ratio_score,
 a.culvert_length_score,
 a.embed_score,
 a.outlet_drop_score,
 a.culvert_slope_score,
 a.final_score,
 a.barrier_result_code,
 a.barrier_result_description,
 a.crossing_fix_code,
 a.crossing_fix_desc,
 a.recommended_diameter_or_span,
 a.assessment_comment,
 -- convert these into links here rather than messing about in javascript
 '<a href="'||a.ecocat_url||'">LINK</a>' as ecocat_url,
 '<a href="'||a.image_view_url||'">LINK</a>' as image_view_url,
 a.current_pscis_status,
 a.current_crossing_type_code,
 a.current_crossing_type_desc,
 a.current_crossing_subtype_code,
 a.current_crossing_subtype_desc,
 a.current_barrier_result_code,
 a.current_barrier_description
FROM bcfishpass.crossings c
INNER JOIN whse_fish.pscis_assessment_svw a
ON c.stream_crossing_id = a.stream_crossing_id
WHERE c.pscis_status = 'ASSESSED';

CREATE INDEX ON bcfishpass.crossings_pscis_assessment_vw USING GIST (geom);