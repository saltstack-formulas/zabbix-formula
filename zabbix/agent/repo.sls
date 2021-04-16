{% from "zabbix/map.jinja" import zabbix with context -%}


include:
  - zabbix.agent


{# We have a common template for the official Zabbix repo #}
{% include "zabbix/repo.sls" %}


# Here we just add a requisite declaration to ensure correct order
extend:
  zabbix_agent_repo:
    {% if salt['grains.get']('os_family') in ['Debian', 'Suse'] -%}
    pkgrepo:
      - require_in:
        - pkg: zabbix-agent
    {% elif salt['grains.get']('os_family') == 'RedHat' -%}
    pkgrepo:
      - require_in:
        - pkg: zabbix-agent
  zabbix_agent_non_supported_repo:
    pkgrepo:
      - require_in:
        - pkg: zabbix-agent
    {%- else %} {}
    {%- endif %}
