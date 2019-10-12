{%- from "zabbix/map.jinja" import zabbix with context %}

{%- if grains.os_family == 'Debian' %}
zabbix_debconf-utils:
  pkg.installed:
    - name: debconf-utils
{%- endif %}
