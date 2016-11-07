{% from "zabbix/map.jinja" import zabbix with context -%}
{% from "zabbix/macros.jinja" import files_switch with context -%}


include:
  - zabbix.agent


{{ zabbix.agent.config }}:
  file.managed:
    - source: {{ files_switch('zabbix',
                              ['/etc/zabbix/zabbix_agentd.conf',
                               '/etc/zabbix/zabbix_agentd.conf.jinja']) }}
    - template: jinja
    - require:
      - pkg: zabbix-agent
    - watch_in:
      - service: zabbix-agent
