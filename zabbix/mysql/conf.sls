{% from "zabbix/map.jinja" import zabbix with context -%}
{% set settings = salt['pillar.get']('zabbix-mysql', {}) -%}
{% set dbhost = settings.get('dbhost', 'localhost') -%}
{% set dbname = settings.get('dbname', 'zabbix') -%}
{% set dbuser = settings.get('dbuser', 'zabbixuser') -%}
{% set dbpass = settings.get('dbpass', 'zabbixpass') -%}
{% set dbuser_host = settings.get('dbuser_host', 'localhost') -%}
{% set connection = settings.get('connection', {}) -%}

zabbix_db:
  mysql_database.present:
    - name: {{ dbname }}
    - host: {{ dbhost }}
    - character_set: utf8
    - collate: utf8_bin
    {% for conn_param in connection %}
    - connection_{{ conn_param }}: '{{ connection[conn_param] }}'
    {% endfor %}
  mysql_grants.present:
    - grant: all privileges
    - database: {{ dbname }}.*
    - user: {{ dbuser }}
    - host: '{{ dbuser_host }}'
    - require:
      - mysql_database: zabbix_db
    {% for conn_param in connection %}
    - connection_{{ conn_param }}: '{{ connection[conn_param] }}'
    {% endfor %}
  mysql_user.present:
    - name: {{ dbuser }}
    - host: '{{ dbuser_host }}'
    - password: {{ dbpass }}
    - require:
      - mysql_grants: zabbix_db
    {% for conn_param in connection %}
    - connection_{{ conn_param }}: '{{ connection[conn_param] }}'
    {% endfor %}
