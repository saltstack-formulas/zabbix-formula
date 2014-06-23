{% from "zabbix/map.jinja" import zabbix with context %}


zabbix-server:
  pkg:
    - name: {{ zabbix.pkg_server }}
    - installed
    {% if zabbix.version_server is defined %}
    - version: {{ zabbix.version_server }}
    {% endif %}
  service:
    - name: {{ zabbix.service_server }}
    - running
    - enable: True
    - require:
      - pkg: zabbix-server
