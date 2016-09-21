{% from "zabbix/map.jinja" import zabbix with context -%}


zabbix-frontend-php:
  
  
  file.symlink:
    - name: /usr/sbin/a2enconf
    - target: /bin/true

  pkg.installed:
    - pkgs:
      {%- for name in zabbix.frontend.pkgs %}
      - {{ name }}
      {%- endfor %}
    {% if zabbix.frontend.version is defined -%}
    - version: {{ zabbix.frontend.version }}
    {%- endif %}
    - install_recommends: False
    - require:
        - file: /usr/sbin/a2enconf

