{% from "zabbix/map.jinja" import zabbix with context %}


zabbix-agent:
  pkg:
    - installed
    - name: {{ zabbix.pkg_agent }}
  service:
    - running
    - name: {{ zabbix.service_agent }}
    - enable: True
    - require:
      - pkg: zabbix-agent
