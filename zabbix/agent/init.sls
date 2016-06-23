{% from "zabbix/map.jinja" import zabbix with context -%}


zabbix-agent:
  pkg.installed:
    - pkgs:
      {%- for name in zabbix.agent.pkgs %}
      - {{ name }}
      {%- endfor %}
    {%- if zabbix.agent.version is defined %}
    - version: {{ zabbix.agent.version }}
    {%- endif %}
  service.running:
    - name: {{ zabbix.agent.service }}
    - enable: True
    - require:
      - pkg: zabbix-agent
