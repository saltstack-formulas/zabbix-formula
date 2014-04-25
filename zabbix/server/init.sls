{% from "zabbix/map.jinja" import zabbix with context %}


zabbix-server:
  pkg:
    - name: {{ zabbix.pkg_server }}
    - installed
  service:
    - name: {{ zabbix.service_server }}
    - running
    - enable: True
    - require:
      - pkg: zabbix-server
