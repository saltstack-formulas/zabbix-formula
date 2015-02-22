{% from "zabbix/map.jinja" import zabbix with context -%}


include:
  - zabbix.frontend


# We have a common template for the official Zabbix repo
{% include "zabbix/repo.sls" %}


# Here we just add a requisite declaration to ensure correct order
extend:
  zabbix_frontend_repo:
    {% if salt['grains.get']('os_family') == 'Debian' -%}
    pkgrepo:
      - require_in:
        - pkg: zabbix-frontend-php
    {% elif salt['grains.get']('os_family') == 'RedHat' -%}
    pkgrepo:
      - require_in:
        - pkg: zabbix-frontend-php
  zabbix_frontend_non_supported_repo:
    pkgrepo:
      - require_in:
        - pkg: zabbix-frontend-php
    {%- else %} {}
    {%- endif %}
