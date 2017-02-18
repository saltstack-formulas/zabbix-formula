{% set dbname = salt['pillar.get']('zabbix-server:dbname', 'zabbix') -%}
{% set dbuser = salt['pillar.get']('zabbix-server:dbuser', 'zabbixuser') -%}
{% set dbpass = salt['pillar.get']('zabbix-server:dbpass', 'zabbixpass') -%}
{% set dbuser_host = salt['pillar.get']('zabbix-server:dbuser_host', 'localhost') -%}

zabbix_db:
  mysql_database.present:
    - name: {{ dbname }}
    - character_set: utf8
    - collate: utf8_bin
  mysql_grants.present:
    - grant: all privileges
    - database: {{ dbname }}.*
    - user: {{ dbuser }}
    - host: '{{ dbuser_host }}'
    - require:
      - mysql_database: zabbix_db
  mysql_user.present:
    - name: {{ dbuser }}
    - host: '{{ dbuser_host }}'
    - password: {{ dbpass }}
    - require:
      - mysql_grants: zabbix_db
