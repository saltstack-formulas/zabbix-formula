{% from "zabbix/map.jinja" import zabbix with context %}


include:
  - zabbix.agent


{% set files_switch = salt['pillar.get']('zabbix-agent:files_switch', ['id']) %}


{{ zabbix.agent.config }}:
  file:
    - managed
    - source:
      {% for grain in files_switch if salt['grains.get'](grain) is defined -%}
      - salt://zabbix/files/{{ salt['grains.get'](grain) }}/etc/zabbix/zabbix_agentd.conf.jinja
      {% endfor -%}
      - salt://zabbix/files/default/etc/zabbix/zabbix_agentd.conf.jinja
    - template: jinja
    - require:
      - pkg: zabbix-agent
    - watch_in:
      - service: zabbix-agent
