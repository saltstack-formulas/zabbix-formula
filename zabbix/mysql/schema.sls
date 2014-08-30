{% from "zabbix/map.jinja" import zabbix with context %}
{% from "zabbix/macros.jinja" import files_switch with context %}


include:
  - zabbix.mysql.conf


{% set dbhost = salt['pillar.get']('zabbix-mysql:dbhost', 'localhost') %}
{% set dbname = salt['pillar.get']('zabbix-mysql:dbname', 'zabbix') %}
{% set dbuser = salt['pillar.get']('zabbix-mysql:dbuser', 'zabbixuser') %}
{% set dbpass = salt['pillar.get']('zabbix-mysql:dbpass', 'zabbixpass') %}


{% for file in [
  '/usr/share/zabbix-server-mysql/salt-provided-schema.sql',
  '/usr/share/zabbix-server-mysql/salt-provided-images.sql',
  '/usr/share/zabbix-server-mysql/salt-provided-data.sql'
] %}
{{ file }}:
  file:
    - managed
    - makedirs: True
    - source: {{ files_switch('zabbix', [ file ]) }}
  cmd:
    - run
    - name: /usr/bin/mysql -h {{ dbhost }} -u {{ dbuser }} --password={{ dbpass }} {{ dbname }} < {{ file }} && touch {{ file }}.applied
    - unless: test -f {{ file }}.applied
    - require:
      - file: {{ file }}
      - pkg: mysql-client
{% endfor %}
