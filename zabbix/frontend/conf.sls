{% from "zabbix/map.jinja" import zabbix with context %}
{% from "zabbix/macros.jinja" import files_switch with context %}


include:
  - zabbix.frontend
  - zabbix.frontend.repo


{{ zabbix.frontend.config }}:
  file:
    - managed
    - source: {{ files_switch('zabbix',
                              ['/etc/zabbix/web/zabbix.conf.php',
                               '/etc/zabbix/web/zabbix.conf.php.jinja'] }}
    - template: jinja
    - require:
      - pkg: zabbix-frontend-php
