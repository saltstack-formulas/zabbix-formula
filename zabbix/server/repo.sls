{% from "zabbix/map.jinja" import zabbix with context %}


include:
  - zabbix.server


# We have a common template for the official Zabbix repo
{% include "zabbix/repo.sls" %}


# Here we just add a requisite declaration to ensure correct order
extend:
  zabbix_server_repo:
    {% if salt['grains.get']('os_family') == 'Debian' -%}
    pkgrepo:
      - require_in:
        - pkg: zabbix-server
    {% elif salt['grains.get']('os_family') == 'RedHat' -%}
    pkgrepo:
      - require_in:
        - pkg: zabbix-server
  zabbix_server_non_supported_repo:
    pkgrepo:
      - require_in:
        - pkg: zabbix-server
    {%- else %} {}
    {%- endif %}
