{% from "zabbix/map.jinja" import zabbix with context -%}

include:
  - zabbix.users

zabbix-agent-logdir:
  file.directory:
    - name: {{ salt['file.dirname'](zabbix.agent.logfile) }}
    - user: {{ zabbix.user }}
    - group: {{ zabbix.group }}
    - dirmode: 755

zabbix-agent-piddir:
  file.directory:
    - name: {{ salt['file.dirname'](zabbix.agent.pidfile) }}
    - user: {{ zabbix.user }}
    - group: {{ zabbix.group }}
    - dirmode: 750

{% if salt['grains.get']('selinux:enforced', False) == 'Enforcing' %}
/root/zabbix_agent.te:
  file.managed:
    - source: salt://zabbix/files/default/tmp/zabbix_agent.te

generate_agent_mod:
  cmd.run:
    - name: checkmodule -M -m -o zabbix_agent.mod zabbix_agent.te
    - cwd: /root
    - onchanges:
      - file: /root/zabbix_agent.te

generate_agent_pp:
  cmd.run:
    - name: semodule_package -o zabbix_agent.pp -m zabbix_agent.mod
    - cwd: /root
    - onchanges:
      - cmd: generate_agent_mod

set_agent_policy:
  cmd.run:
    - name: semodule -i zabbix_agent.pp
    - cwd: /root
    - onchanges:
      - cmd: generate_agent_pp

enable_selinux_agent:
  selinux.module:
    - name: zabbix_agent
    - module_state: enabled
{% endif %}

zabbix-agent:
  pkg.installed:
    - pkgs:
      {%- for name in zabbix.agent.pkgs %}
      - {{ name }}
      {%- endfor %}
    {%- if zabbix.agent.version is defined %}
    - version: {{ zabbix.agent.version }}
    {%- endif %}
  service.running:
    - name: {{ zabbix.agent.service }}
    - enable: True
    - require:
      - pkg: zabbix-agent
      - file: zabbix-agent-logdir
      - file: zabbix-agent-piddir

zabbix-agent-restart:
  module.wait:
    - name: service.restart
    - m_name: {{ zabbix.agent.service }}
