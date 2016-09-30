{% from "zabbix/map.jinja" import zabbix with context -%}
{% set settings = salt['pillar.get']('zabbix', {}) -%}

{{ salt['file.dirname'](zabbix.server.logfile) }}:
  file.directory:
    - user: {{ zabbix.user }}
    - group: {{ zabbix.group }}
    - dirmode: 755

{{ salt['file.dirname'](zabbix.server.pidfile) }}:
  file.directory:
    - user: {{ zabbix.user }}
    - group: {{ zabbix.group }}
    - dirmode: 755

zabbix-server:
  pkg.installed:
    - pkgs:
      {%- for name in zabbix.server.pkgs %}
      - {{ name }}
      {%- endfor %}
    {%- if zabbix.server.version is defined %}
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
