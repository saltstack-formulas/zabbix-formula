{% from "mysql/map.jinja" import mysql with context %}

{% set dbhost = salt['pillar.get']('zabbix-mysql:dbhost', 'localhost') %}
{% set dbname = salt['pillar.get']('zabbix-mysql:dbname', 'zabbix') %}
{% set dbuser = salt['pillar.get']('zabbix-mysql:dbuser', 'zabbixuser') %}
{% set dbpass = salt['pillar.get']('zabbix-mysql:dbpass', 'zabbixpass') %}


include:
  - mysql.client


{% set files_switch = salt['pillar.get']('zabbix-mysql:files_switch', ['id']) %}


{% for file in [
  '/usr/share/zabbix-server-mysql/schema.sql',
  '/usr/share/zabbix-server-mysql/images.sql',
  '/usr/share/zabbix-server-mysql/data.sql'
] %}
{{ file }}:
  file:
    - managed
    - source:
      {% for grain in files_switch if salt['grains.get'](grain) is defined -%}
      - salt://zabbix/files/{{ salt['grains.get'](grain) }}{{ file }}
      {% endfor -%}
      - salt://zabbix/files/default{{ file }}
    - makedirs: true
  cmd:
    - run
    - name: /usr/bin/mysql -h {{ dbhost }} -u {{ dbuser }} --password={{ dbpass }} {{ dbname }} < {{ file }} && touch {{ file }}.applied
    - unless: test -f {{ file }}.applied
    - require:
      - file: {{ file }}
      - pkg: mysql-client
{% endfor %}
