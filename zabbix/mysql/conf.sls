{% from "zabbix/map.jinja" import zabbix with context -%}
{% set settings = salt['pillar.get']('zabbix-mysql', {}) -%}
{% set dbhost = settings.get('dbhost', 'localhost') -%}
{% set dbname = settings.get('dbname', 'zabbix') -%}
{% set dbuser = settings.get('dbuser', 'zabbixuser') -%}
{% set dbpass = settings.get('dbpass', 'zabbixpass') -%}
{% set dbuser_host = settings.get('dbuser_host', 'localhost') -%}


zabbix_db:
  mysql_database.present:
    - name: {{ dbname }}
    - host: {{ dbhost }}
    - character_set: utf8
    - collate: utf8_bin
  mysql_user.present:
    - name: {{ dbuser }}
    - host: '{{ dbuser_host }}'
    - password: {{ dbpass }}
  mysql_grants.present:
    - grant: all privileges
    - database: {{ dbname }}.*
    - user: {{ dbuser }}
    - host: '{{ dbuser_host }}'
    - require:
      - mysql_database: zabbix_db
      - mysql_user: zabbix_db
