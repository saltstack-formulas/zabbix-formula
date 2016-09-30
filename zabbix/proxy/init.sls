{% from "zabbix/map.jinja" import zabbix with context -%}
{% set settings = salt['pillar.get']('zabbix', {}) -%}

{{ salt['file.dirname'](zabbix.proxy.logfile) }}:
  file.directory:
    - user: {{ zabbix.user }}
    - group: {{ zabbix.group }}
    - dirmode: 755

{{ salt['file.dirname'](zabbix.proxy.pidfile) }}:
  file.directory:
    - user: {{ zabbix.user }}
    - group: {{ zabbix.group }}
    - dirmode: 750

zabbix-proxy:
  pkg.installed:
    - pkgs:
      {%- for name in zabbix.proxy.pkgs %}
      - {{ name }}
      {%- endfor %}
    {% if zabbix.proxy.version is defined -%}
    - version: {{ zabbix.proxy.version }}
    {%- endif %}
  service.running:
    - name: {{ zabbix.proxy.service }}
    - enable: True
    - require:
      - pkg: zabbix-proxy
