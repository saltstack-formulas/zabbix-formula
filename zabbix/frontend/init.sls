{% from "zabbix/map.jinja" import zabbix with context %}


zabbix-frontend-php:
  pkg:
    - installed
    - name: {{ zabbix.pkg_frontend }}
    {% if zabbix.version_frontend is defined %}
    - version: {{ zabbix.version_frontend }}
    {% endif %}
