{% from "zabbix/map.jinja" import zabbix with context -%}
{% set settings = salt['pillar.get']('zabbix', {}) -%}


zabbix_user:
  user.present:
    - name: {{ zabbix.user }}
    - gid_from_name: True
    - groups: {{ settings.get('user_groups', []) }}
    # Home directory should be created by pkg scripts
    - createhome: False
    - require:
      - group: zabbix_group


zabbix_group:
  group.present:
    - name: {{ zabbix.group }}
