{% from "zabbix/map.jinja" import zabbix with context %}


zabbix_user:
  user.present:
    - name: {{ zabbix.user }}
    - gid_from_name: True
    - groups: {{ salt['pillar.get']('zabbix:user_groups', []) }}
    - require:
      - group: zabbix_group


zabbix_group:
  group.present:
    - name: {{ zabbix.group }}
