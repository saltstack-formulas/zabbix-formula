{% from "mysql/map.jinja" import mysql with context %}

{% set dbhost = salt['pillar.get']('zabbix-mysql:dbhost', 'localhost') %}
{% set dbname = salt['pillar.get']('zabbix-mysql:dbname', 'zabbix') %}
{% set dbuser = salt['pillar.get']('zabbix-mysql:dbuser', 'zabbixuser') %}
{% set dbpass = salt['pillar.get']('zabbix-mysql:dbpass', 'zabbixpass') %}


include:
  - mysql.client


{% for file in [
  '/usr/share/zabbix-server-mysql/schema.sql',
  '/usr/share/zabbix-server-mysql/images.sql',
  '/usr/share/zabbix-server-mysql/data.sql'
] %}
{{ file }}:
  file:
    - managed
    - source:
      - salt://zabbix/files/{{ grains['id'] }}{{ file }}
      - salt://zabbix/files/default{{ file }}
  cmd:
    - run
    - name: /usr/bin/mysql -h {{ dbhost }} -u {{ dbuser }} --password={{ dbpass }} {{ dbname }} < {{ file }} && touch {{ file }}.applied
    - unless: test -f {{ file }}.applied
    - require:
      - file: {{ file }}
      - pkg: mysql-client
{% endfor %}
