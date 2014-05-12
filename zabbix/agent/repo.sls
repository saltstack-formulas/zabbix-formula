{% from "zabbix/map.jinja" import zabbix with context %}


# We have a common state file for the official Zabbix repo
include:
  - zabbix.repo


# Here we just add a requisite declaration to ensure correct order
extend:
  zabbix_repo:
{%- if salt['grains.get']('os_family') == 'Debian' %}
    pkgrepo:
      - require_in:
        - pkg: zabbix-agent
{% else %} {}
{% endif %}
