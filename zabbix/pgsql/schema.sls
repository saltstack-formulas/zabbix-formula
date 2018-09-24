{% from "zabbix/map.jinja" import zabbix with context -%}
{% from "zabbix/macros.jinja" import files_switch with context -%}
{% set settings = salt['pillar.get']('zabbix-pgsql', {}) -%}
{% set defaults = zabbix.get('pgsql', {}) -%}

{% set dbhost = settings.get('dbhost', defaults.dbhost) -%}
{% set dbname = settings.get('dbname', defaults.dbname) -%}
{% set dbuser = settings.get('dbuser', defaults.dbuser) -%}
{% set dbpassword = settings.get('dbpassword', defaults.dbpassword) -%}

{% set dbroot_user = settings.get('dbroot_user') -%}
{% set dbroot_pass = settings.get('dbroot_pass') -%}

{% set sql_file = settings.get('sql_file', '/usr/share/doc/zabbix-server-pgsql/create.sql.gz') -%}

# Connection args required only if dbroot_user and dbroot_pass defined.
{% set connection_args = {} -%}
{% if dbroot_user and dbroot_pass -%}
{%  set connection_args = {'runas': 'nobody', 'host': dbhost, 'user': dbroot_user, 'password': dbroot_pass} -%}
{% endif -%}

# Check is there any tables in database.
# salt.postgres.psql_query return empty result if there is no tables or 'False' on any error i.e. failed auth.
{% set list_tables = "SELECT tablename FROM pg_catalog.pg_tables WHERE schemaname != 'pg_catalog' AND schemaname != 'information_schema' LIMIT 1;" %}
{% set is_db_empty = True -%}
{% if salt.postgres.psql_query(query=list_tables, maintenance_db=dbname, **connection_args) -%}
{%  set is_db_empty = False -%}
{% endif -%}

include:
  - zabbix.pgsql.conf

check_db_pgsql:
  test.configurable_test_state:
    - name: Is there any tables in '{{ dbname }}' database?
    - changes: {{ is_db_empty }}
    - result: True
    - comment: If changes is 'True' data import required.

{% if 'sql_file' in settings -%}
upload_sql_dump:
  file.managed:
    - makedirs: True
    - source: {{ files_switch('zabbix', [ sql_file ]) }}
    - require_in:
      - import_sql
{% endif -%}

import_sql:
  cmd.run:
    - name: zcat {{ sql_file }} | psql | head -5
    - runas: {{ zabbix.user }}
    - env:
      - PGUSER: {{ dbuser }}
      - PGPASSWORD: {{ dbpassword }}
      - PGDATABASE: {{ dbname }}
      - PGHOST: {{ dbhost }}
    - require:
      - pkg: zabbix-server
    - onchanges:
      - test: check_db_pgsql
