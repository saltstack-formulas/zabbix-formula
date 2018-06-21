{% from "zabbix/map.jinja" import zabbix with context -%}

zabbix-frontend-php:
  pkg.installed:
    - pkgs:
      {%- for name in zabbix.frontend.pkgs %}
      - {{ name }}{% if zabbix.frontend.version is defined and 'zabbix' in name %}: '{{ zabbix.frontend.version }}'{% endif %}
      {%- endfor %}

{% if salt['grains.get']('selinux:enforced', False) == 'Enforcing' %}
httpd_can_connect_zabbix:
  selinux.boolean:
    - value: True
    - persist: True

httpd_can_network_connect:
  selinux.boolean:
    - value: True
    - persist: True
{% endif %}
