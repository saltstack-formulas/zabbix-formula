{% from "zabbix/map.jinja" import zabbix with context %}


include:
  - zabbix.server


{% set files_switch = salt['pillar.get']('zabbix-server:files_switch', ['id']) %}


{% if grains['os_family'] == 'Debian' %}
# We don't want to manage the db through dbconfig when we install the package
# so we set this cmd as prereq.
zabbix-server_debconf:
  debconf:
    - set
    - name: {{ zabbix.server.pkg}}
    - data:
        'zabbix-server-mysql/internal/skip-preseed': {'type': 'boolean', 'value': True}
        'zabbix-server-mysql/dbconfig-install': {'type': 'boolean', 'value': False}
        'zabbix-server-mysql/dbconfig-upgrade': {'type': 'boolean', 'value': False}
    - prereq:
      - pkg: zabbix-server
{% endif %}


{{ zabbix.server.config }}:
  file:
    - managed
    - source:
      {% for grain in files_switch if salt['grains.get'](grain) is defined -%}
      - salt://zabbix/files/{{ salt['grains.get'](grain) }}/etc/zabbix/zabbix_server.conf.jinja
      {% endfor -%}
      - salt://zabbix/files/default/etc/zabbix/zabbix_server.conf.jinja
    - template: jinja
    - require:
      - pkg: zabbix-server
    - watch_in:
      - service: zabbix-server
