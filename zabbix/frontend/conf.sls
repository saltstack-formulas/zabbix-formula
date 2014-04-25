{% from "zabbix/map.jinja" import zabbix with context %}


include:
  - zabbix.frontend
  - zabbix.frontend.repo


{{ zabbix.config_frontend }}:
  file:
    - managed
    - source:
      - salt://zabbix/files/{{ grains['id'] }}/etc/zabbix/web/zabbix.conf.php.jinja
      - salt://zabbix/files/default/etc/zabbix/web/zabbix.conf.php.jinja
    - template: jinja
    - require:
      - pkg: zabbix-frontend-php
