{% from "zabbix/map.jinja" import zabbix with context -%}
{% from "zabbix/macros.jinja" import files_switch with context -%}


include:
  - zabbix.server
  - zabbix.users


{{ zabbix.server.config }}:
  file.managed:
    - source: {{ files_switch('zabbix',
                              ['/etc/zabbix/zabbix_server.conf',
                               '/etc/zabbix/zabbix_server.conf.jinja']) }}
    - template: jinja
    - context:
        dbsocket: {{ zabbix.server.dbsocket }}
    - require:
      - pkg: zabbix-server
    - watch_in:
      - service: zabbix-server


{% if salt['grains.get']('os_family') == 'Debian' -%}
# We don't want to manage the db through dbconfig
zabbix-server_debconf:
  debconf.set:
    - name: zabbix-server-mysql
    - data:
        'zabbix-server-mysql/internal/skip-preseed': {'type': 'boolean', 'value': True}
        'zabbix-server-mysql/dbconfig-install': {'type': 'boolean', 'value': False}
        'zabbix-server-mysql/dbconfig-upgrade': {'type': 'boolean', 'value': False}
    - prereq:
      - pkg: zabbix-server
{%- endif %}
