{% from "zabbix/map.jinja" import zabbix with context %}
{% set settings = salt['pillar.get']('zabbix', {}) %}


zabbix-formula_zabbix_user:
  user.present:
    - name: {{ zabbix.user }}
    - gid_from_name: True
    - groups: {{ settings.get('user_groups', []) }}
    - require:
      - group: zabbix-formula_zabbix_group


zabbix-formula_zabbix_group:
  group.present:
    - name: {{ zabbix.group }}
