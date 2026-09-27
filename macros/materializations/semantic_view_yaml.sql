{% materialization semantic_view_yaml, adapter='snowflake' %}

  {%- set target_database = model.database -%}
  {%- set target_schema = model.schema -%}
  {%- set fully_qualified_schema = target_database ~ '.' ~ target_schema -%}

  {%- set yaml_content = sql -%}

  {{ log("Creating semantic view in " ~ fully_qualified_schema, info=True) }}

  {% call statement('main') %}
    call system$create_semantic_view_from_yaml(
      '{{ fully_qualified_schema }}',
      $${{ yaml_content }}$$
    )
  {% endcall %}

  {{ return({'relations': []}) }}

{% endmaterialization %}
