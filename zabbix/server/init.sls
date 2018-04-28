{% from "zabbix/map.jinja" import zabbix with context -%}
{% set settings = salt['pillar.get']('zabbix', {}) -%}

zabbis-server-logdir:
  file.directory:
    - name: {{ salt['file.dirname'](zabbix.server.logfile) }}
    - user: {{ zabbix.user }}
    - group: {{ zabbix.group }}
    - dirmode: 755

zabbix-server-piddir:
  file.directory:
    - name: {{ salt['file.dirname'](zabbix.server.pidfile) }}
    - user: {{ zabbix.user }}
    - group: {{ zabbix.group }}
    - dirmode: 755

{% if salt['grains.get']('selinux:enforced', False) == 'Enforcing' %}
/root/zabbix_server.te:
  file.managed:
    - source: salt://zabbix/files/default/tmp/zabbix_server.te

generate_server_mod:
  cmd.run:
    - name: checkmodule -M -m -o zabbix_server.mod zabbix_server.te
    - cwd: /root
    - onchanges:
      - file: /root/zabbix_server.te

generate_server_pp:
  cmd.run:
    - name: semodule_package -o zabbix_server.pp -m zabbix_server.mod
    - cwd: /root
    - onchanges:
      - cmd: generate_server_mod

set_server_policy:
  cmd.run:
    - name: semodule -i zabbix_server.pp
    - cwd: /root
    - onchanges:
      - cmd: generate_server_pp

enable_selinux_server:
  selinux.module:
    - name: zabbix_server
    - module_state: enabled

{% if zabbix.version_repo|float >= 3.4 -%}
/root/zabbix_server_34.te:
  file.managed:
    - source: salt://zabbix/files/default/tmp/zabbix_server_34.te

generate_server_34_mod:
  cmd.run:
    - name: checkmodule -M -m -o zabbix_server_34.mod zabbix_server_34.te
    - cwd: /root
    - onchanges:
      - file: /root/zabbix_server_34.te

generate_server_34_pp:
  cmd.run:
    - name: semodule_package -o zabbix_server_34.pp -m zabbix_server_34.mod
    - cwd: /root
    - onchanges:
      - cmd: generate_server_mod

set_server_policy_34:
  cmd.run:
    - name: semodule -i zabbix_server_34.pp
    - cwd: /root
    - onchanges:
      - cmd: generate_server_pp

enable_selinux_server_34:
  selinux.module:
    - name: zabbix_server_34
    - module_state: enabled
{% endif -%}

{% endif %}

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
