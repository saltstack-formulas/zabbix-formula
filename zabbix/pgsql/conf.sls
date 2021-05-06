{% from "zabbix/map.jinja" import zabbix with context -%}
{% set settings = salt['pillar.get']('zabbix-pgsql', {}) -%}
{% set defaults = zabbix.get('pgsql', {}) -%}

{% set dbhost = settings.get('dbhost', defaults.dbhost) -%}
{% set dbname = settings.get('dbname', defaults.dbname) -%}
{% set dbuser = settings.get('dbuser', defaults.dbuser) -%}
{% set dbpassword = settings.get('dbpassword', defaults.dbpassword) -%}

{% set dbroot_user = settings.get('dbroot_user') -%}
{% set dbroot_pass = settings.get('dbroot_pass') -%}

include:
  - zabbix.pgsql.pkgs

zabbix_pgsql_user:
  postgres_user.present:
    - name: {{ dbuser }}
    - password: {{ dbpassword }}
    - encrypted: True
    - login: True
    {%- if dbroot_user and dbroot_pass %}
    - db_host: {{ dbhost }}
    - db_user: {{ dbroot_user }}
    - db_password: {{ dbroot_pass }}
    {%- endif %}
    - require:
      - pgsql_packages

zabbix_pgsql_db:
  postgres_database.present:
    - name: {{ dbname }}
    - owner: {{ dbuser }}
    {%- if dbroot_user and dbroot_pass %}
    - db_host: {{ dbhost }}
    - db_user: {{ dbroot_user }}
    - db_password: {{ dbroot_pass }}
    {%- endif %}
    - require:
      - pgsql_packages
      - postgres_user: zabbix_pgsql_user
