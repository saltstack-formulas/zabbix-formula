{% from "zabbix/map.jinja" import zabbix with context -%}
{% from "zabbix/macros.jinja" import files_switch with context -%}


# Zabbix official repo releases a deb package that sets a zabbix.list apt
# sources. Here we do the same as that package does, including the PGP key for
# the repo.


# In order to share this state file among the different parts of Zabbix (agent,
# server, frontend, proxy) we have to name the states accordingly. See
# https://github.com/moreda/zabbix-saltstack-formula/issues/2 if you're curious.


{% if sls == "zabbix.agent.repo" %}{% set id_prefix = "zabbix_agent" -%}
{% elif sls == "zabbix.server.repo" %}{% set id_prefix = "zabbix_server" -%}
{% elif sls == "zabbix.frontend.repo" %}{% set id_prefix = "zabbix_frontend" -%}
{% elif sls == "zabbix.proxy.repo" %}{% set id_prefix = "zabbix_proxy" -%}
{% else %}{% set id_prefix = "zabbix" -%}
{% endif -%}


{% if salt['grains.get']('os_family') == 'Debian' -%}
{{ id_prefix }}_repo:
  pkgrepo.managed:
    - name: deb https://repo.zabbix.com/zabbix/{{ zabbix.version_repo }}/{{ salt['grains.get']('os')|lower }} {{ salt['grains.get']('oscodename') }} main
    - file: /etc/apt/sources.list.d/zabbix.list
    - key_url: https://repo.zabbix.com/zabbix-official-repo.key
    - clean_file: True

{%- elif salt['grains.get']('os_family') == 'RedHat' and
         salt['grains.get']('osmajorrelease')|int >= 6 %}
{%- if zabbix.version_repo|float > 3.0 %}
{%-   set gpgkey = 'https://repo.zabbix.com/RPM-GPG-KEY-ZABBIX-A14FE591' %}
{%- else %}
{%-   set gpgkey = 'https://repo.zabbix.com/RPM-GPG-KEY-ZABBIX-79EA5ED4' %}
{%- endif %}

{{ id_prefix }}_repo:
  pkgrepo.managed:
    - name: zabbix
    - humanname: Zabbix Official Repository - $basearch
    - baseurl: http://repo.zabbix.com/zabbix/{{ zabbix.version_repo }}/rhel/{{ grains['osmajorrelease']|int }}/$basearch/
    - gpgcheck: 1
    - gpgkey: {{ gpgkey }}

{{ id_prefix }}_non_supported_repo:
  pkgrepo.managed:
    - name: zabbix-non-supported
    - humanname: Zabbix Official Repository non-supported - $basearch
    - baseurl: http://repo.zabbix.com/non-supported/rhel/{{ grains['osmajorrelease']|int }}/$basearch/
    - gpgcheck: 1
    - gpgkey: https://repo.zabbix.com/RPM-GPG-KEY-ZABBIX-79EA5ED4

{%- else %}
{{ id_prefix }}_repo: {}
{%- endif %}
