{% from "zabbix/map.jinja" import zabbix with context -%}
{% set settings = salt['pillar.get']('zabbix-agent', {}) -%}
{% set defaults = zabbix.get('agent', {}) -%}

{% if salt['grains.get']('os') != 'Windows' %}
include:
  - zabbix.users
{% endif %}

zabbix-agent:
  pkg.installed:
    - pkgs:
      {%- for name in zabbix.agent.pkgs %}
      - {{ name }}{% if zabbix.agent.version is defined and 'zabbix' in name %}: '{{ zabbix.agent.version }}'{% endif %}
      {%- endfor %}
{% if salt['grains.get']('os') != 'Windows' %}
    - require_in:
      - user: zabbix-formula_zabbix_user
      - group: zabbix-formula_zabbix_group
{% endif %}
  service.running:
    - name: {{ zabbix.agent.service }}
    - enable: True
    - require:
      - pkg: zabbix-agent
      - file: zabbix-agent-logdir
{% if salt['grains.get']('os') != 'Windows' %}
      - file: zabbix-agent-piddir
{% endif %}
    - watch:
      - pkg: zabbix-agent

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

{% if salt['grains.get']('os') != 'Windows' %}
zabbix-agent-piddir:
  file.directory:
    - name: {{ salt['file.dirname'](zabbix.agent.pidfile) }}
    - user: {{ zabbix.user }}
    - group: {{ zabbix.group }}
    - dirmode: 750
    - require:
      - pkg: zabbix-agent
{% endif %}

{% for include in settings.get('includes', defaults.get('includes', [])) %}
{{ include }}:
  file.directory:
    - name: {{ salt['file.dirname'](include) }}
    - user: {{ zabbix.user }}
    - group: {{ zabbix.group }}
    - dirmode: 750
    - require:
      - pkg: zabbix-agent
{%- endfor %}

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
