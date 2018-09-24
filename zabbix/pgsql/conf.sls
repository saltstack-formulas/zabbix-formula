{% from "zabbix/map.jinja" import zabbix with context -%}
{% set settings = salt['pillar.get']('zabbix-pgsql', {}) -%}
{% set defaults = zabbix.get('pgsql', {}) -%}

{% set dbhost = settings.get('dbhost', defaults.dbhost) -%}
{% set dbname = settings.get('dbname', defaults.dbname) -%}
{% set dbuser = settings.get('dbuser', defaults.dbuser) -%}
{% set dbpassword = settings.get('dbpassword', defaults.dbpassword) -%}

{% set dbroot_user = settings.get('dbroot_user') -%}
{% set dbroot_pass = settings.get('dbroot_pass') -%}

# Install packages required for Salt postgres module
{% if settings.get('pkgs', defaults.get('pkgs', False))
      and not settings.get('skip_pkgs', defaults.skip_pkgs) -%}
pgsql_packages:
  pkg.installed:
    - pkgs: {{ settings.get('pkgs', defaults.pkgs)|json }}
{% elif settings.get('skip_pkgs', defaults.skip_pkgs) -%}
pgsql_packages:
  test.configurable_test_state:
    - name: You skipped installation of packages required for Salt postgres module.
    - changes: False
    - result: True
{% else -%}
pgsql_packages:
  test.configurable_test_state:
    - name: Packages required for Salt postgres module are not defined
    - changes: False
    - result: False
    - comment: |
        Additional packages are required to manage the PostgreSQL database.
        Please specify them in pillar as list.
        Tip: you need postgresql-client packages, like:
        zabbix-pgsql:
          pkgs:
            - postgresql-client-common
            - postgresql-client
        Or you can skip installing them, but formula likely fail without them.
        zabbix-pgsql:
          skip_pkgs: True
{% endif -%}

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
