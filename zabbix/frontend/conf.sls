{% from "zabbix/map.jinja" import zabbix with context -%}
{% from "zabbix/libtofs.jinja" import files_switch with context -%}
{% set config_file = salt.file.basename(zabbix.frontend.config) -%}
{% set config_file_dir = salt.file.dirname(zabbix.frontend.config) -%}


include:
  - zabbix.frontend
  {%- if grains.os_family == 'Debian' %}
  - zabbix.debconf
  {%- endif %}


{{ zabbix.frontend.config }}:
  file.managed:
    - source: {{ files_switch([zabbix.frontend.config,
                               zabbix.frontend.config ~ '.jinja',
                               '/etc/zabbix/web/' ~ config_file,
                               '/etc/zabbix/web/' ~ config_file ~ '.jinja'],
                              lookup='zabbix-frontend-config'
                 )
              }}
    - template: jinja
    - require:
      - pkg: zabbix-frontend-php
      - file: {{ config_file_dir }}


# Fix permissions to allow to php-fpm include zabbix frontend config file which is usually located under /etc/zabbix
{{ config_file_dir }}:
  file.directory:
    - mode: 755
    - require:
      - pkg: zabbix-frontend-php


{% if salt['grains.get']('os_family') == 'Debian' -%}
# We don't want the package to mess with apache
zabbix-frontend_debconf:
  debconf.set:
    - name: zabbix-frontend-php
    - data:
        'zabbix-frontend-php/configure-apache': {'type': 'boolean', 'value': False}
        'zabbix-frontend-php/restart-webserver': {'type': 'boolean', 'value': False}
    - prereq:
      - pkg: zabbix-frontend-php
    - require:
      - sls: zabbix.debconf
{%- endif %}
