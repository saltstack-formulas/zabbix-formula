{% from "zabbix/map.jinja" import zabbix with context %}


zabbix-frontend-php:
  pkg:
    - installed
    - name: {{ zabbix.pkg_frontend }}
