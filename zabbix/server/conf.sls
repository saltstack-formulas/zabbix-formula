{% from "zabbix/map.jinja" import zabbix with context %}


include:
  - zabbix.server


{% if grains['os_family'] == 'Debian' %}
# We don't want to manage the db through dbconfig when we install the package
# so we set this cmd as prereq.
zabbix-server_debconf:
  debconf:
    - set
    - name: {{ zabbix.pkg_server}}
    - data:
        'zabbix-server-mysql/internal/skip-preseed': {'type': 'boolean', 'value': True}
        'zabbix-server-mysql/dbconfig-install': {'type': 'boolean', 'value': False}
        'zabbix-server-mysql/dbconfig-upgrade': {'type': 'boolean', 'value': False}
    - prereq:
      - pkg: zabbix-server
{% endif %}


{{ zabbix.config_server }}:
  file:
    - managed
    - source:
      - salt://zabbix/files/{{ grains['id'] }}/etc/zabbix/zabbix_server.conf.jinja
      - salt://zabbix/files/default/etc/zabbix/zabbix_server.conf.jinja
    - template: jinja
    - require:
      - pkg: zabbix-server
    - watch_in:
      - service: zabbix-server
