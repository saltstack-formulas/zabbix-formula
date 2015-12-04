{% from "zabbix/map.jinja" import zabbix with context -%}


zabbix-server:
  pkg.installed:
    - name: {{ zabbix.server.pkg }}
    {% if zabbix.server.version is defined -%}
    - version: {{ zabbix.server.version }}
    {%- endif %}
    {% if salt['grains.get']('os_family') == 'Debian' -%}
    - install_recommends: False
    {% endif %}
  service.running:
    - name: {{ zabbix.server.service }}
    - enable: True
    - require:
      - pkg: zabbix-server
