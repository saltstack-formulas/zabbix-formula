==============
zabbix-formula
==============

A saltstack formula to manage Zabbix.

This formula has been developed distributing declarations in different files to
make it usable in most situations. It should be useful in scenarios ranging from
a simple install of the packages (without any special configuration) to a more
complex set-up with different nodes for agent, server, database and frontend.

General customization strategies
================================

* **Use pillar data**. This is the absolutely recommended way to use the
  formula. In most occassions all you need is to fill some of the key-values
  shown in the ``pillar.example`` file. If you feel that a certain value
  should be there then don't hesitate to propose an enhancement.

* Use the ``extra_conf`` key that in some cases is present in the pillar to add
  arbitrary configuration lines in the templates provided. This is a way to have
  a better customization without over-populating the pillar with new key-values.

* Add new subdirectories under ``files`` in addition to ``default``. This
  new subdirectories will contain different files to be used in certain
  conditions. This selection mechanism is based by default in the ``ìd`` grain
  of the minion (i.e. if there's a new subdirectory named ``minion01`` then
  the formula is going to look there first for that minion). This selection
  behavior can be extended to make it depend on any sorted list of grains,
  defined by the key ``files_switch``.

  For example, let's define in pillar something like:

  .. code:: yaml

      formula-name:
        files_switch: ['id', 'os_family']

  Let's have this ``files`` directory structure:

  .. code:: asciidoc

      files
        |-- minion01
        |       `-- etc
        |            `-- foo.conf.jinja
        |-- Debian
        |       `-- etc
        |            `-- foo.conf.jinja
        `-- default
                |-- etc
                |    |-- foo.conf.jinja
                |    `-- bar.conf.jinja
                `-- usr/share/thingy/*

  With this, we have the following:

  * if the minion id is ``minion01`` then ``files/minion01/etc/foo.conf.jinja``
    is going to be used

  * else if the minion os_family is ``Debian`` then
    ``files/Debian/etc/foo.conf.jinja`` is going to be used

  * else ``files/default/etc/foo.conf.jinja`` is going to be used

  Beware: **this is not designed to substitute pillar data**. Remember that
  pillar has to be used for information that it's essential to be only known for
  a certain set of minions (i.e. passwords, private keys and such).

* As a last resort you can actually fork the formula to suit your needs, keeping
  an eye for further improvements to merge into yours. Of course any pull-
  request that you can bring back it would be taken in account ;-)


Using RedHat EPEL repo Zabbix packages
======================================

If you want to use the EPEL repo packages, as the naming conventions are
different, you need to tweak the default values of ``map.jinja`` to obtain the
desired results. In short:

* Don't use the ``zabbix.agent.repo`` sls assuming that EPEL repos are already
  configured

* Override the ``map.jinja`` definitions using pillar values like this

.. code:: yaml

    zabbix:
      lookup:
        pkg_agent: zabbix22-agent
        pkg_server: zabbix22-server-mysql


Now you just have to use ``zabbix.agent.conf`` sls file and that's it.


Example of usage
================

Just as an example, this is a ``top.sls`` file to install a complete modular
self- contained Zabbix system:

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

Declares users and groups that could be needed in other formulas (e.g. in the
users formula to make an user pertain to the service group).

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
