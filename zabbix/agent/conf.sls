{% from "zabbix/map.jinja" import zabbix with context %}


include:
  - zabbix.agent


{{ zabbix.config_agent }}:
  file:
    - managed
    - source:
      - salt://zabbix/files/{{ grains['id'] }}/etc/zabbix/zabbix_agentd.conf.jinja
      - salt://zabbix/files/default/etc/zabbix/zabbix_agentd.conf.jinja
    - template: jinja
    - require:
      - pkg: zabbix-agent
    - watch_in:
      - service: zabbix-agent
