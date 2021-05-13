.. _readme:

zabbix-formula
==============

|img_travis| |img_sr|

.. |img_travis| image:: https://travis-ci.com/saltstack-formulas/zabbix-formula.svg?branch=master
   :alt: Travis CI Build Status
   :scale: 100%
   :target: https://travis-ci.com/saltstack-formulas/zabbix-formula
.. |img_sr| image:: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
   :alt: Semantic Release
   :scale: 100%
   :target: https://github.com/semantic-release/semantic-release

A SaltStack formula to manage Zabbix.

.. contents:: **Table of Contents**

General notes
-------------

See the full `SaltStack Formulas installation and usage instructions
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

If you are interested in writing or contributing to formulas, please pay attention to the `Writing Formula Section
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#writing-formulas>`_.

If you want to use this formula, please pay attention to the ``FORMULA`` file and/or ``git tag``,
which contains the currently released version. This formula is versioned according to `Semantic Versioning <http://semver.org/>`_.

See `Formula Versioning Section <https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#versioning>`_ for more details.

Contributing to this repo
-------------------------

**Commit message formatting is significant!!**

Please see `How to contribute <https://github.com/saltstack-formulas/.github/blob/master/CONTRIBUTING.rst>`_ for more details.

Overview
--------

This formula has been developed distributing declarations in different files to
make it usable in most situations. It should be useful in scenarios ranging from
a simple install of the packages (without any special configuration) to a more
complex set-up with different nodes for agent, server, database and frontend.

Customization
^^^^^^^^^^^^^

First, **see if providing pillar data is enough for your customization needs**.
That's the recommended way and should be enough for most cases. See that
sometimes there's a key named ``extra_conf`` that's used to add arbitrary
configuration lines in the templates provided.

When providing pillar data is not enough for your needs, you can apply the
Template Override and Files Switch (TOFS) pattern as described in the
documentation file ``TOFS_pattern.md``.

The formula is designed to be independent from other formulas so you could use
this in a non-100% salted environment (i.e. it's not required –although
recommended– to use other formulas to provision other parts of a complete
system).

Using RedHat EPEL repo Zabbix packages
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you want to use the EPEL repo packages, as the naming conventions are
different, you need to tweak the default values of ``map.jinja`` to obtain the
desired results. In short:

* Don't use the ``zabbix.agent.repo`` sls assuming that EPEL repos are already
  configured

* Override the ``map.jinja`` definitions using pillar values like this

.. code:: yaml

    zabbix:
      lookup:
        agent:
          pkg: zabbix22-agent
        server:
          pkg: zabbix22-server-mysql


Now you just have to use ``zabbix.agent.conf`` sls file and that's it.

Example of usage
^^^^^^^^^^^^^^^^

Just as an example, this is a ``top.sls`` file to install a complete modular
self-contained Zabbix system:

.. code:: yaml

  base:
    '*':
      - zabbix.agent.repo
      - zabbix.agent.conf

      - mysql.server.conf
      - mysql.client.conf
      - zabbix.mysql.conf
      - zabbix.mysql.schema

      - zabbix.server.repo
      - zabbix.server.conf

      - nginx.conf

      - php.fpm.repo
      - php.fpm.conf
      - php.fpm.mysql
      - php.fpm.bcmath
      - php.fpm.mbstring
      - php.fpm.gd
      - php.fpm.xml
      - php.fpm.opcache

      - zabbix.frontend.repo
      - zabbix.frontend.conf

You need the appropriate mysql, nginx and php formulas to complete the
installation with this ``top.sls`` file.

If you are installing the zabbix agent for windows you will want to separate the
pillar for windows from other linux and unix agents
This is a pillar ``top.sls`` file example to separate windows and Ubuntu Zabbix agent
pillar files

.. code:: yaml

  base:
    'os:Ubuntu':
      - match: grain
      - zabbix-agent-ubuntu
      
    'os:Windows':
      - match: grain
      - zabbix-agent-windows

.. note::

    See the full `Salt Formulas
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_ doc.

Available states
----------------

.. contents::
    :local:

``zabbix.agent``
^^^^^^^^^^^^^^^^

Installs the zabbix-agent package and starts the associated zabbix-
agent service.

``zabbix.agent.conf``
^^^^^^^^^^^^^^^^^^^^^

Configures the zabbix-agent package.

``zabbix.agent.repo``
^^^^^^^^^^^^^^^^^^^^^

Configures official Zabbix repo specifically for the agent. Actually it just
includes zabbix.repo and adds a requisite for the pkg state declaration

``zabbix.frontend``
^^^^^^^^^^^^^^^^^^^

Installs Zabbix frontend.

``zabbix.frontend.conf``
^^^^^^^^^^^^^^^^^^^^^^^^

Configures the zabbix-frontend package. Actually you need to use other formulas
for apache/nginx and php5-fpm to complete a working setup.

``zabbix.frontend.repo``
^^^^^^^^^^^^^^^^^^^^^^^^

Configures official Zabbix repo specifically for the frontend. Actually it just
includes zabbix.repo and adds a requisite for the pkg state declaration.

``zabbix.mysql.conf``
^^^^^^^^^^^^^^^^^^^^^

Creates database and mysql user for Zabbix.

``zabbix.mysql.schema``
^^^^^^^^^^^^^^^^^^^^^^^

Creates mysql schema for Zabbix.

``zabbix.pgsql.pkgs``
^^^^^^^^^^^^^^^^^^^^^^^

Install required psql packages.

``zabbix.pgsql.conf``
^^^^^^^^^^^^^^^^^^^^^

Creates database and PostgreSQL user for Zabbix. Includes zabbix.pgsql.pkgs.

``zabbix.pgsql.schema``
^^^^^^^^^^^^^^^^^^^^^^^

Creates PostgreSQL schema for Zabbix. Includes zabbix.pgsql.pkgs.

``zabbix.proxy``
^^^^^^^^^^^^^^^^

Installs the zabbix-proxy package and starts the associated zabbix-proxy service.

``zabbix.proxy.conf``
^^^^^^^^^^^^^^^^^^^^^

Configures the zabbix-proxy package.

``zabbix.proxy.repo``
^^^^^^^^^^^^^^^^^^^^^

Configures official Zabbix repo specifically for the proxy. Actually it just
includes zabbix.repo and adds a requisite for the pkg state declaration

``zabbix.repo``
^^^^^^^^^^^^^^^

Configures official Zabbix repo.

``zabbix.server``
^^^^^^^^^^^^^^^^^

Installs the zabbix-server package and starts the associated zabbix-
server service.

``zabbix.server.conf``
^^^^^^^^^^^^^^^^^^^^^^

Configures the zabbix-server package.

``zabbix.server.repo``
^^^^^^^^^^^^^^^^^^^^^^

Configures official Zabbix repo specifically for the server. Actually it just
includes zabbix.repo and adds a requisite for the pkg state declaration

``zabbix.users``
^^^^^^^^^^^^^^^^

Declares users and groups that could be needed in other formulas (e.g. in the
users formula to make an user pertain to the service group).


Testing
-------

Linux testing is done with ``kitchen-salt``.

Requirements
^^^^^^^^^^^^

* Ruby
* Docker

.. code-block:: bash

   $ gem install bundler
   $ bundle install
   $ bin/kitchen test [platform]

Where ``[platform]`` is the platform name defined in ``kitchen.yml``,
e.g. ``debian-9-2019-2-py3``.

``bin/kitchen converge``
^^^^^^^^^^^^^^^^^^^^^^^^

Creates the docker instance and runs the ``template`` main state, ready for testing.

``bin/kitchen verify``
^^^^^^^^^^^^^^^^^^^^^^

Runs the ``inspec`` tests on the actual instance.

``bin/kitchen destroy``
^^^^^^^^^^^^^^^^^^^^^^^

Removes the docker instance.

``bin/kitchen test``
^^^^^^^^^^^^^^^^^^^^

Runs all of the stages above in one go: i.e. ``destroy`` + ``converge`` + ``verify`` + ``destroy``.

``bin/kitchen login``
^^^^^^^^^^^^^^^^^^^^^

Gives you SSH access to the instance for manual testing.
