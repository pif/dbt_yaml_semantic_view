{% macro base_table(relation) %}
      # depends on {{ relation }}
      database: {{ relation.database }}
      schema: {{ relation.schema }}
      table: {{ relation.identifier }}
{%- endmacro %}