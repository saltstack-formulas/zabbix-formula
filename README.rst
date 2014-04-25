================
zabbix-formula
================

A saltstack formula to manage Zabbix.

This formula has been developed distributing id and state declarations in
different files to make it usable in most situations. It should be useful from
scenarios with a simple install of the package (without any special
configuration) to a more complex set-up with different nodes for agent, server,
database and frontend.

Any special needs could be addressed forking the formula repo, even in-place at
the server acting as master. I'm trying to keep this as general as possible and
further general improvements would be added.

The ``files`` directory is structured using a ``default`` root and
optional ``<minion-id>`` directories:

.. code:: asciidoc

    files
      |-- default
      |        |-- etc
      |        |    |-- foo.conf
      |        |    `-- bar.conf
      |        `-- usr/share/thingy/*
      `-- <minion-id>
              |-- etc
              |    |-- foo.conf
              |    `-- bar.conf
              `-- usr/share/thingy/*

This way we have certain flexibility to use different files for different
minions. **It's not designed to substitute pillar data**. Remember that
pillar has to be used for info that it's essential to be only known for a
certain set of minions (i.e. passwords, private keys and such).

Just as an example, this is a top.sls file to install a complete modular self-
contained Zabbix system:

.. code:: yaml

    base:
      'minion':
        - zabbix.users
        - zabbix.agent.repo
        - zabbix.agent.conf
        - zabbix.mysql.conf
        - zabbix.mysql.schema
        - zabbix.server.repo
        - zabbix.server.conf
        - apache.repo
        - apache.conf
        - apache.users
        - apache.mod_proxy_fcgi
        - apache.mod_actions
        - php5.fpm.repo
        - php5.fpm.conf
        - php5.mysql
        - zabbix.frontend.repo
        - zabbix.frontend.conf

You need the appropriate apache and php5 formulas to complete the frontend
installation.

.. note::

    See the full `Salt Formulas
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_ doc.

Available states
================

.. contents::
    :local:

``zabbix.repo``
----------------

Configures official Zabbix repo.

``zabbix.users``
----------------

Declares users and groups that could be needed even in other formulas
(e.g. in the users formula to make an user pertain to the service group).

``zabbix.agent``
----------------

Installs the zabbix-agent package and starts the associated zabbix-
agent service.

``zabbix.agent.conf``
---------------------

Configures the zabbix-agent package.

``zabbix.agent.repo``
---------------------

Configures official Zabbix repo specifically for the agent. Actually just
include zabbix.repo and adds arequisite for the pkg state declaration

``zabbix.server``
-----------------

Installs the zabbix-server package and starts the associated zabbix-
server service.

``zabbix.server.conf``
----------------------

Configures the zabbix-server package.

``zabbix.server.repo``
----------------------

Configures official Zabbix repo specifically for the server. Actually just
include zabbix.repo and adds arequisite for the pkg state declaration

``zabbix.mysql``
----------------

Installs mysql-server (via include of mysql.server) and creates database and
user for Zabbix.

``zabbix.mysql.conf``
---------------------

Creates mysql schema for Zabbix.

``zabbix.frontend``
-------------------

Installs Zabbix frontend.

``zabbix.frontend.repo``
----------------------

Configures official Zabbix repo specifically for the frontend. Actually just
include zabbix.repo and adds arequisite for the pkg state declaration.

``zabbix.frontend.conf``
----------------------

Configures the zabbix-frontend package. Actually you need to use other formulas
for apache/nginx and php5-fpm to complete a working setup.


