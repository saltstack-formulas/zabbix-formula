{% from "zabbix/map.jinja" import zabbix with context %}


include:
  - zabbix.repo


extend:
  zabbix_repo:
    pkgrepo:
      - require_in:
        - pkg: zabbix-agent


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
    - watch:
      - file: {{ zabbix.config_agent }}


{{ zabbix.config_agent }}:
  file:
    - managed
    - source:
      - salt://zabbix/files/etc/zabbix/zabbix_agentd.conf.{{ grains['id'] }}.jinja
      - salt://zabbix/files/etc/zabbix/zabbix_agentd.conf.jinja
    - template: jinja
    - require:
      - pkg: zabbix-agent
