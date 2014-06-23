{% from "zabbix/map.jinja" import zabbix with context %}


zabbix-frontend-php:
  pkg:
    - installed
    - name: {{ zabbix.frontend.pkg }}
    {% if zabbix.frontend.version is defined %}
    - version: {{ zabbix.frontend.version }}
    {% endif %}
