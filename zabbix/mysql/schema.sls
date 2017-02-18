{% set zabbix_db = salt['pillar.get']('zabbix-server:dbname', 'zabbix') -%}

include:
  - zabbix.mysql.conf

import_schema:
  mysql_query.run_file:
    - database: {{ zabbix_db }}
    - query_file: /usr/share/zabbix-server-mysql/salt-provided-schema.sql
    - onchanges: 
        - mysql_database: {{ zabbix_db }}
import_images:
  mysql_query.run_file:
    - database: {{ zabbix_db }}
    - query_file: /usr/share/zabbix-server-mysql/salt-provided-images.sql
    - onchanges: 
        - mysql_database: {{ zabbix_db }}
import_data:
  mysql_query.run_file:
    - database: {{ zabbix_db }}
    - query_file: /usr/share/zabbix-server-mysql/salt-provided-data.sql
    - onchanges: 
        - mysql_database: {{ zabbix_db }}
