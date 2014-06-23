{% from "zabbix/map.jinja" import zabbix with context %}


zabbix-agent:
  pkg:
    - installed
    - name: {{ zabbix.pkg_agent }}
    {% if zabbix.version_agent is defined %}
    - version: {{ zabbix.version_agent }}
    {% endif %}
  service:
    - running
    - name: {{ zabbix.service_agent }}
    - enable: True
    - require:
      - pkg: zabbix-agent
