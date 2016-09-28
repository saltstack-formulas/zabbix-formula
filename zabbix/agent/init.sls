{% from "zabbix/map.jinja" import zabbix with context -%}

{{ salt['file.dirname'](zabbix.agent.logfile) }}:
  file.directory:
    - user: {{ zabbix.user }}
    - group: {{ zabbix.group }}
    - dirmode: 755

{{ salt['file.dirname'](zabbix.agent.pidfile) }}:
  file.directory:
    - user: {{ zabbix.user }}
    - group: {{ zabbix.group }}
    - dirmode: 750

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
