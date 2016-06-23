{% from "zabbix/map.jinja" import zabbix with context -%}


zabbix-proxy:
  pkg.installed:
    - pkgs:
      {%- for name in zabbix.proxy.pkgs %}
      - {{ name }}
      {%- endfor %}
    {% if zabbix.proxy.version is defined -%}
    - version: {{ zabbix.proxy.version }}
    {%- endif %}
  {% endfor -%}
  service.running:
    - name: {{ zabbix.proxy.service }}
    - enable: True
    - require:
      - pkg: zabbix-proxy
