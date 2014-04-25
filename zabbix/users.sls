{% from "zabbix/map.jinja" import zabbix with context %}


zabbix_user:
  user:
      - present
      - name: {{ salt['pillar.get']('zabbix:user', 'zabbix') }}


zabbix_group:
    group:
      - present
      - name: {{ salt['pillar.get']('zabbix:group', 'zabbix') }}
