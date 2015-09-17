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
    - name: deb http://repo.zabbix.com/zabbix/{{ zabbix.version_repo }}/{{ salt['grains.get']('os')|lower }} {{ salt['grains.get']('oscodename') }} main
    - file: /etc/apt/sources.list.d/zabbix.list
    - require:
      - cmd: {{ id_prefix }}_repo_add_gpg


{{ id_prefix }}_repo_add_gpg:
  cmd.wait:
    - name: /usr/bin/apt-key add /var/tmp/zabbix-official-repo.gpg
    - watch:
      - file: {{ id_prefix }}_repo_gpg_file


# GPG key of official Zabbix repo
{{ id_prefix }}_repo_gpg_file:
  file.managed:
    - name: /var/tmp/zabbix-official-repo.gpg
    - source: {{ files_switch('zabbix',
                              ['/tmp/zabbix-official-repo.gpg']) }}


{%- elif salt['grains.get']('os_family') == 'RedHat' and
         salt['grains.get']('osmajorrelease')[0] >= '6' %}
{{ id_prefix }}_repo:
  pkgrepo.managed:
    - name: zabbix
    - humanname: Zabbix Official Repository - $basearch
    - baseurl: http://repo.zabbix.com/zabbix/{{ zabbix.version_repo }}/rhel/{{ grains['osmajorrelease'][0] }}/$basearch/
    - gpgcheck: 1
    - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-ZABBIX
    - require:
      - file: {{ id_prefix }}_repo_gpg_file

{{ id_prefix }}_non_supported_repo:
  pkgrepo.managed:
    - name: zabbix_non_supported
    - humanname: Zabbix Official Repository non-supported - $basearch
    - baseurl: http://repo.zabbix.com/non-supported/rhel/{{ grains['osmajorrelease'][0] }}/$basearch/
    - gpgcheck: 1
    - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-ZABBIX
    - require:
      - file: {{ id_prefix }}_repo_gpg_file

{{ id_prefix }}_repo_gpg_file:
  file.managed:
    - name: /etc/pki/rpm-gpg/RPM-GPG-KEY-ZABBIX
    - source: {{ files_switch('zabbix',
                              ['/tmp/zabbix-official-repo.gpg']) }}
{%- else %}
{{ id_prefix }}_repo: {}
{%- endif %}
