{% from "zabbix/map.jinja" import zabbix with context -%}

include:
  - zabbix.users

zabbix-agent:
  pkg.installed:
    - pkgs:
      {%- for name in zabbix.agent.pkgs %}
      - {{ name }}{% if zabbix.agent.version is defined and 'zabbix' in name %}: '{{ zabbix.agent.version }}'{% endif %}
      {%- endfor %}
    - require_in:
      - user: zabbix-formula_zabbix_user
      - group: zabbix-formula_zabbix_group
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

zabbix-agent-logdir:
  file.directory:
    - name: {{ salt['file.dirname'](zabbix.agent.logfile) }}
    - user: {{ zabbix.user }}
    - group: {{ zabbix.group }}
    - dirmode: 755
    - require:
      - pkg: zabbix-agent

zabbix-agent-piddir:
  file.directory:
    - name: {{ salt['file.dirname'](zabbix.agent.pidfile) }}
    - user: {{ zabbix.user }}
    - group: {{ zabbix.group }}
    - dirmode: 750
    - require:
      - pkg: zabbix-agent

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
