zabbix formula
================

1.2 (2014-12-29)

 - More compact and simplified Zabbix configuration files
 - Support for repo versions in RedHat
 - Eliminated requirement of a mysql service in the minion

1.1 (2014-08-30)

 - General improvements: added new pillars, better support for os_family, ...
 - Added macro.jinja with files_switch macro.

1.0 (2014-06-23)

 - Changed structure of the map.jinja to separate between agent, server and
   frontend

0.3 (2014-05-05)

 - Added suport for all Zabbix components
 - Added support for multiple files subdirectories (see README.rst)

0.2 (2014-04-25)

- Added support for zabbix-server

0.1 (2014-04-04)

- Initial version with support just for Debian os_family and zabbix-agent
