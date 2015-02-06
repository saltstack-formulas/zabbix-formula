{% from "zabbix/map.jinja" import zabbix with context -%}


zabbix-proxy:
  pkg.installed:
    - name: {{ zabbix.proxy.pkg }}
    {% if zabbix.proxy.version is defined -%}
    - version: {{ zabbix.proxy.version }}
    {%- endif %}
  service.running:
    - name: {{ zabbix.proxy.service }}
    - enable: True
    - require:
      - pkg: zabbix-proxy
