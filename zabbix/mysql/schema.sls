{% from "zabbix/map.jinja" import zabbix with context -%}
{% from "zabbix/macros.jinja" import files_switch with context -%}
{% set settings = salt['pillar.get']('zabbix-mysql', {}) -%}
{% set dbhost = settings.get('dbhost', 'localhost') -%}
{% set dbname = settings.get('dbname', 'zabbix') -%}
{% set dbuser = settings.get('dbuser', 'zabbixuser') -%}
{% set dbpass = settings.get('dbpass', 'zabbixpass') -%}


include:
  - zabbix.mysql.conf


{% for file in [
  '/usr/share/zabbix-server-mysql/salt-provided-schema.sql',
  '/usr/share/zabbix-server-mysql/salt-provided-images.sql',
  '/usr/share/zabbix-server-mysql/salt-provided-data.sql'
] -%}
{{ file }}:
  file.managed:
    - makedirs: True
    - source: {{ files_switch('zabbix', [ file ]) }}
  cmd.run:
    - name: /usr/bin/mysql -h {{ dbhost }} -u {{ dbuser }} --password={{ dbpass }} {{ dbname }} < {{ file }} && touch {{ file }}.applied
    - unless: test -f {{ file }}.applied
    - require:
      - file: {{ file }}
      - pkg: mysql-client
{% endfor -%}
