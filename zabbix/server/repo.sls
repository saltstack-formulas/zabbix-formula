{% from "zabbix/map.jinja" import zabbix with context %}


# We have a common state file for the official Zabbix repo
include:
  - zabbix.repo


# Here we just add a requisite declaration to ensure correct order
extend:
  zabbix_repo:
{%- if salt['grains.get']('os_family') == 'Debian' %}
    pkgrepo:
      - require_in:
        - pkg: zabbix-server
{% else %} {}
{% endif %}

# IMPORTANT NOTE: This is needed in Debian to ensure that installing the
# server doesn't trigger a install of mysql-server. The official package of
# zabbix-server-mysql "recommends" mysql-server which forces a default install
# with server + db in the same host... which is not always what we want.
# There's no way so far to tell the apt pkg state module something as the
# "--without-recommends" flag just for a package.
{% if grains['os_family'] == 'Debian' %}
/etc/apt/apt.conf.d/00local-disable-recommends:
  file:
    - managed
    - contents: 'APT::Install-Recommends "false";'
    - require_in:
      - pkgrepo: zabbix_repo
{% endif %}
