{% from "zabbix/map.jinja" import zabbix with context %}


{% set dbhost = salt['pillar.get']('zabbix-mysql:dbhost', 'localhost') %}
{% set dbname = salt['pillar.get']('zabbix-mysql:dbname', 'zabbix') %}
{% set dbuser = salt['pillar.get']('zabbix-mysql:dbuser', 'zabbixuser') %}
{% set dbpass = salt['pillar.get']('zabbix-mysql:dbpass', 'zabbixpass') %}
{% set dbuser_host = salt['pillar.get']('zabbix-mysql:dbuser_host', 'localhost') %}
{% set mysql_root_pass = salt['pillar.get']('mysql:server:root_password', salt['grains.get']('server_id')) %}

zabbix_db:
  mysql_database.present:
    - name: {{ dbname }}
    - connection_user: root
    {% if mysql_root_pass %}
    - connection_pass: '{{ mysql_root_pass }}'
    {% endif %}
    - character_set: utf8
    - collate: utf8_bin
    - require:
      - service: mysql
  mysql_grants.present:
    - grant: all privileges
    - database: {{ dbname }}.*
    - user: {{ dbuser }}
    - connection_user: root
    {% if mysql_root_pass %}
    - connection_pass: '{{ mysql_root_pass }}'
    {% endif %}
    - host: '{{ dbuser_host }}'
    - require:
      - mysql_database: zabbix_db
  mysql_user.present:
    - name: {{ dbuser }}
    - connection_user: root
    {% if mysql_root_pass %}
    - connection_pass: '{{ mysql_root_pass }}'
    {% endif %}
    - host: '{{ dbuser_host }}'
    - password: {{ dbpass }}
    - require:
      - mysql_grants: zabbix_db
