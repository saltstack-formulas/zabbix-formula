{% from "mysql/map.jinja" import mysql with context %}

{% set dbhost = salt['pillar.get']('zabbix-mysql:dbhost', 'localhost') %}
{% set dbname = salt['pillar.get']('zabbix-mysql:dbname', 'zabbix') %}
{% set dbuser = salt['pillar.get']('zabbix-mysql:dbuser', 'zabbixuser') %}
{% set dbpass = salt['pillar.get']('zabbix-mysql:dbpass', 'zabbixpass') %}
{% set dbuser_host = salt['pillar.get']('zabbix-mysql:dbuser_host', 'localhost') %}


include:
  - mysql.server


zabbix_db:
  mysql_database:
    - present
    - name: {{ dbname }}
    - character_set: utf8
    - collate: utf8_bin
  mysql_grants:
    - present
    - grant: all privileges
    - database: {{ dbname }}.*
    - user: {{ dbuser }}
    - host: '{{ dbuser_host }}'
    - require:
      - mysql_database: zabbix_db
  mysql_user:
    - present
    - name: {{ dbuser }}
    - host: '{{ dbuser_host }}'
    - password: {{ dbpass }}
    - require:
      - mysql_grants: zabbix_db
