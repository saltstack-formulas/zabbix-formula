{% from "zabbix/map.jinja" import zabbix with context -%}
{% from "zabbix/libtofs.jinja" import files_switch with context -%}
{% set settings = salt['pillar.get']('zabbix-pgsql', {}) -%}
{% set defaults = zabbix.get('pgsql', {}) -%}

{% set dbhost = settings.get('dbhost', defaults.dbhost) -%}
{% set dbname = settings.get('dbname', defaults.dbname) -%}
{% set dbuser = settings.get('dbuser', defaults.dbuser) -%}
{% set dbpassword = settings.get('dbpassword', defaults.dbpassword) -%}

{% set sql_file = settings.get('sql_file', defaults.sql_file) -%}

{% set table_query = "SELECT count(tablename) FROM pg_catalog.pg_tables WHERE schemaname != 'pg_catalog' AND schemaname != 'information_schema';" %}
{% set psql_cmd = "$(psql -X -A -t -c \\\"" + table_query + "\\\" || echo \\\"-1\\\") -eq \\\"0\\\" " %}

include:
  - zabbix.pgsql.pkgs

# Check is there any tables in database.
# returns changed if there are zero tables in the db
check_db_pgsql:
  cmd.run:
    - name: "[[ {{ psql_cmd }} ]] && echo \"changed=yes comment='DB needs schema import.'\" || echo \"changed=no comment='No DB import needed or possible.'\""
    - runas: {{ zabbix.user }}
    - stateful: True
    - env:
      - PGUSER: {{ dbuser }}
      - PGPASSWORD: {{ dbpassword }}
      - PGDATABASE: {{ dbname }}
      - PGHOST: {{ dbhost }}

{% if 'sql_file' in settings -%}
upload_sql_dump:
  file.managed:
    - makedirs: True
    - source: {{ files_switch([sql_file],
                              lookup='zabbix-server-pgsql'
                 )
              }}
    - require_in:
      - import_sql
{% endif -%}

import_sql:
  cmd.run:
    - name: zcat {{ sql_file }} | psql | { head -5; cat >/dev/null; }
    - runas: {{ zabbix.user }}
    - env:
      - PGUSER: {{ dbuser }}
      - PGPASSWORD: {{ dbpassword }}
      - PGDATABASE: {{ dbname }}
      - PGHOST: {{ dbhost }}
    - require:
      - pkg: zabbix-server
    - onchanges:
      - cmd: check_db_pgsql
