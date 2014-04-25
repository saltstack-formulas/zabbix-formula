{% from "zabbix/map.jinja" import zabbix with context %}


zabbix-agent:
  pkg:
    - name: {{ zabbix.pkg_agent }}
    - installed
  service:
    - name: {{ zabbix.service_agent }}
    - running
    - enable: True
    - require:
      - pkg: zabbix-agent
