{% from "zabbix/map.jinja" import zabbix with context %}


zabbix-agent:
  pkg:
    - installed
    - name: {{ zabbix.agent.pkg }}
    {% if zabbix.agent.version is defined %}
    - version: {{ zabbix.agent.version }}
    {% endif %}
  service:
    - running
    - name: {{ zabbix.agent.service }}
    - enable: True
    - require:
      - pkg: zabbix-agent
