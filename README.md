# dbt_yaml_semantic_view

Snowflake-only dbt package to manage [Semantic Views](https://docs.snowflake.com/en/user-guide/views-semantic/overview) as dbt models written in Snowflake's semantic model YAML.

## What's inside

- `semantic_view_yaml` materialization: takes the model body (semantic model YAML) and runs `system$create_semantic_view_from_yaml` in the model's database/schema.
- `base_table(relation)` macro: renders the `base_table` block (database/schema/table) for a `ref()`/`source()`, so dbt tracks the lineage.
- Add your semantic views as `.sql` files so dbt can work on them. Inside you'd use regular YAML syntax. Btw, if you already created a semantic view via UI, you can export it in the semantic view UI --> click `Edit YAML` and copy-paste the output.

> [!NOTE]
> If you're working with semantic views defined as DDL use Snowflake's [dbt_semantic_view](https://github.com/Snowflake-Labs/dbt_semantic_view) package.
> This project uses `semantic_view_yaml` materialization so it doesn't intersect with that one.

## Usage

`packages.yml`:

```yaml
packages:
  - package: pif/dbt-yaml-semantic-view
    version: 1.0.0
```

`dbt_project.yml`:

```yaml
models:
  my_project:
    semantic_views:
      +materialized: semantic_view_yaml
```

`models/semantic_views/sv_company_analytics.sql`:

```yaml
name: SV_COMPANY_ANALYTICS
tables:
  - name: FINANCIAL_CALENDAR
    base_table: {{ dbt_yaml_semantic_view.base_table(ref('dim_dates')) }}
    dimensions:
      - name: DATE_DAY
        expr: DATE_DAY
        data_type: DATE
```
