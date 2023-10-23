{% from "zabbix/map.jinja" import zabbix with context -%}
{% set settings = salt['pillar.get']('zabbix-proxy', {}) -%}
{% set defaults = zabbix.get('proxy', {}) -%}

include:
  - zabbix.users

zabbix-proxy:
  pkg.installed:
    - pkgs:
      {%- for name in zabbix.proxy.pkgs %}
      - {{ name }}{% if zabbix.proxy.version is defined and 'zabbix' in name %}: '{{ zabbix.proxy.version }}'{% endif %}
      {%- endfor %}
    - require_in:
      - user: zabbix-formula_zabbix_user
      - group: zabbix-formula_zabbix_group
  service.running:
    - name: {{ zabbix.proxy.service }}
    - enable: True
    - require:
      - pkg: zabbix-proxy
      - file: zabbix-proxy-logdir
      - file: zabbix-proxy-piddir
      {% for include in settings.get('includes', defaults.get('includes', [])) %}
      - file: {{ include }}
      {%- endfor %}
    - watch:
      - pkg: zabbix-proxy

zabbix-proxy-logdir:
  file.directory:
    - name: {{ salt['file.dirname'](zabbix.proxy.logfile) }}
    - user: {{ zabbix.user }}
    - group: {{ zabbix.group }}
    - dirmode: 755
    - require:
      - pkg: zabbix-proxy

zabbix-proxy-piddir:
  file.directory:
    - name: {{ salt['file.dirname'](zabbix.proxy.pidfile) }}
    - user: {{ zabbix.user }}
    - group: {{ zabbix.group }}
    - dirmode: 750
    - require:
      - pkg: zabbix-proxy

# basic check does 'dbname' looks like a file path
{% if zabbix.proxy.dbname.startswith('/') -%}
zabbix-proxy-sqlitedir:
  file.directory:
    - name: {{ salt['file.dirname'](zabbix.proxy.dbname) }}
    - user: {{ zabbix.user }}
    - group: {{ zabbix.group }}
    - dirmode: 750
    - require:
      - pkg: zabbix-proxy
    - watch_in:
      - service: zabbix-proxy
{%- endif %}

{% for include in settings.get('includes', defaults.get('includes', [])) %}
{{ include }}:
  file.directory:
    - user: {{ zabbix.user }}
    - group: {{ zabbix.group }}
    - dirmode: 750
    - require:
      - pkg: zabbix-proxy
{%- endfor %}
