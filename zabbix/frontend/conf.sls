{% from "zabbix/map.jinja" import zabbix with context %}


include:
  - zabbix.frontend
  - zabbix.frontend.repo


{% set files_switch = salt['pillar.get']('zabbix-frontend:files_switch', ['id']) %}


{{ zabbix.config_frontend }}:
  file:
    - managed
    - source:
      {% for grain in files_switch if salt['grains.get'](grain) is defined -%}
      - salt://zabbix/files/{{ salt['grains.get'](grain) }}/etc/zabbix/web/zabbix.conf.php.jinja
      {% endfor -%}
      - salt://zabbix/files/default/etc/zabbix/web/zabbix.conf.php.jinja
    - template: jinja
    - require:
      - pkg: zabbix-frontend-php
