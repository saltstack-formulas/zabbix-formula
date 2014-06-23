{% from "zabbix/map.jinja" import zabbix with context %}


zabbix-server:
  pkg:
    - name: {{ zabbix.server.pkg }}
    - installed
    {% if zabbix.server.version is defined %}
    - version: {{ zabbix.server.version }}
    {% endif %}
  service:
    - name: {{ zabbix.server.service }}
    - running
    - enable: True
    - require:
      - pkg: zabbix-server
