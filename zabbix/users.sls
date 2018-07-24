{% from "zabbix/map.jinja" import zabbix with context -%}
{% set settings = salt['pillar.get']('zabbix', {}) -%}


zabbix-formula_zabbix_user:
  user.present:
    - name: {{ zabbix.user }}
    - gid: {{ zabbix.group }}
    - groups: {{ settings.get('user_groups', []) }}
    # Home directory should be created by pkg scripts
    - createhome: False
    - shell: {{ zabbix.shell }}
    - system: True
    - require:
      - group: zabbix-formula_zabbix_group


zabbix-formula_zabbix_group:
  group.present:
    - name: {{ zabbix.group }}
    - system: True
