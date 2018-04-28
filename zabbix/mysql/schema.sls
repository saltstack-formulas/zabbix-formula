{% from "zabbix/map.jinja" import zabbix with context -%}
{% from "zabbix/macros.jinja" import files_switch with context -%}
{% set settings = salt['pillar.get']('zabbix-mysql', {}) -%}
{% set dbhost = settings.get('dbhost', 'localhost') -%}
{% set dbname = settings.get('dbname', 'zabbix') -%}
{% set dbuser = settings.get('dbuser', 'zabbixuser') -%}
{% set dbpass = settings.get('dbpass', 'zabbixpass') -%}
{% set dbroot_user = settings.get('dbroot_user') -%}
{% set dbroot_pass = settings.get('dbroot_pass') -%}

{% if zabbix.version_repo|float < 3 -%}
{% set zabbix_db_ver = '22' -%}
{% else %}
{% set zabbix_db_ver = '34' -%}
{% endif -%}


include:
  - zabbix.mysql.conf


/usr/share/zabbix-server-mysql:
  file.recurse:
    - source: salt://zabbix/files/default/usr/share/zabbix-server-mysql/{{ zabbix_db_ver }}
    - onchanges:
      - mysql_database:  {{ dbname }}


zabbix_import_schema:
  mysql_query.run_file:
    - database: {{ dbname }}
    {%- if dbroot_user and dbroot_pass %}
    - connection_host: {{ dbhost }}
    - connection_user: {{ dbroot_user }}
    - connection_pass: {{ dbroot_pass }}
    {%- endif %}
    - connection_charset: utf8
    - query_file: /usr/share/zabbix-server-mysql/salt-provided-schema.sql
    - onchanges: 
        - mysql_database: {{ dbname }}

zabbix_import_images:
  mysql_query.run_file:
    - database: {{ dbname }}
    {%- if dbroot_user and dbroot_pass %}
    - connection_host: {{ dbhost }}
    - connection_user: {{ dbroot_user }}
    - connection_pass: {{ dbroot_pass }}
    {%- endif %}
    - connection_charset: utf8
    - query_file: /usr/share/zabbix-server-mysql/salt-provided-images.sql
    - onchanges:
      - mysql_query: zabbix_import_schema

zabbix_import_data:
  mysql_query.run_file:
    - database: {{ dbname }}
    {%- if dbroot_user and dbroot_pass %}
    - connection_host: {{ dbhost }}
    - connection_user: {{ dbroot_user }}
    - connection_pass: {{ dbroot_pass }}
    {%- endif %}
    - connection_charset: utf8
    - query_file: /usr/share/zabbix-server-mysql/salt-provided-data.sql
    - onchanges:
      - mysql_query: zabbix_import_schema
