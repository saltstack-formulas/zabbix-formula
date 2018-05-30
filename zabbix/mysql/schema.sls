{% from "zabbix/map.jinja" import zabbix with context -%}
{% from "zabbix/macros.jinja" import files_switch with context -%}
{% set settings = salt['pillar.get']('zabbix-mysql', {}) -%}
{% set defaults = zabbix.get('mysql', {}) -%}
# This required for backward compatibility
{% if 'dbpass' in settings -%}
{%  do settings.update({'dbpassword': settings['dbpass']}) -%}
{% endif -%}

{% set dbhost = settings.get('dbhost', defaults.dbhost) -%}
{% set dbname = settings.get('dbname', defaults.dbname) -%}
{% set dbuser = settings.get('dbuser', defaults.dbuser) -%}
{% set dbpassword = settings.get('dbpassword', defaults.dbpassword) -%}

{% set dbroot_user = settings.get('dbroot_user') -%}
{% set dbroot_pass = settings.get('dbroot_pass') -%}

{% if zabbix.version_repo|float < 3 -%}
{%  set db_version = '22' -%}
{% elif zabbix.version_repo|float < 3.4 -%}
{%  set db_version = '30' -%}
{% else -%}
{%  set db_version = '34' -%}
{% endif -%}
{% set sql_file = settings.get('sql_file', '/usr/share/zabbix-server-mysql/salt-provided-create-' ~ db_version ~ '.sql') -%}

# Connection args required only if dbroot_user and dbroot_pass defined.
{% set connection_args = {} -%}
{% if dbroot_user and dbroot_pass -%}
{%  set connection_args = {'connection_host': dbhost, 'connection_user': dbroot_user, 'connection_pass': dbroot_pass} -%}
{% endif -%}

# Check is there any tables in database.
# salt.mysql.db_tables(dbname) return 'False' if there is no tables or any other error i.e. failed auth.
{% set is_db_empty = True -%}
{% if salt.mysql.db_tables(dbname, **connection_args) -%}
{%  set is_db_empty = False -%}
{% endif -%}

include:
  - zabbix.mysql.conf

check_db:
  test.configurable_test_state:
    - name: Is there any tables in '{{ dbname }}' database?
    - changes: {{ is_db_empty }}
    - result: True
    - comment: If changes is 'True' data import required.

{{ sql_file }}:
  file.managed:
    - makedirs: True
    - source: {{ files_switch('zabbix', [ sql_file ]) }}
  mysql_query.run_file:
    - database: {{ dbname }}
    {%- if dbroot_user and dbroot_pass %}
    - connection_host: {{ dbhost }}
    - connection_user: {{ dbroot_user }}
    - connection_pass: {{ dbroot_pass }}
    {%- endif %}
    - connection_charset: utf8
    - query_file: {{ sql_file }}
    - require:
      - mysql_packages
      - mysql_database: zabbix_db
      - file: {{ sql_file }}
    - onchanges:
      - test: check_db
