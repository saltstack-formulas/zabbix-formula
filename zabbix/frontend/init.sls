{% from "zabbix/map.jinja" import zabbix with context -%}


zabbix-frontend-php:
  pkg.installed:
    - pkgs:
      {%- for name in zabbix.agent.pkgs %}
      - {{ name }}
      {%- endfor %}
    {% if zabbix.frontend.version is defined -%}
    - version: {{ zabbix.frontend.version }}
    {%- endif %}
