
Changelog
=========

`0.21.2 <https://github.com/saltstack-formulas/zabbix-formula/compare/v0.21.1...v0.21.2>`_ (2020-03-12)
-----------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **libtofs:** “files_switch” mess up the variable exported by “map.jinja” [skip ci] (\ `9d6b5d7 <https://github.com/saltstack-formulas/zabbix-formula/commit/9d6b5d7af2fdce59c104d4580d17880f4a5bf8d3>`_\ )
* **release.config.js:** use full commit hash in commit link [skip ci] (\ `2072e06 <https://github.com/saltstack-formulas/zabbix-formula/commit/2072e06d91fdc74781bf88c33f90ec408b241abd>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **gemfile:** restrict ``train`` gem version until upstream fix [skip ci] (\ `95d4c15 <https://github.com/saltstack-formulas/zabbix-formula/commit/95d4c151327987fc287dc682868a7e962e898dfb>`_\ )
* **kitchen:** avoid using bootstrap for ``master`` instances [skip ci] (\ `2c04d93 <https://github.com/saltstack-formulas/zabbix-formula/commit/2c04d9311de15b56613a51b95b12bde536ea413e>`_\ )
* **kitchen:** use ``debian-10-master-py3`` instead of ``develop`` [skip ci] (\ `8645a8e <https://github.com/saltstack-formulas/zabbix-formula/commit/8645a8ee6ea8e1b77c62801929d175cf3d683169>`_\ )
* **kitchen:** use ``develop`` image until ``master`` is ready (\ ``amazonlinux``\ ) [skip ci] (\ `678b048 <https://github.com/saltstack-formulas/zabbix-formula/commit/678b048c34a8483f6bca79796a4e39f07760e5e4>`_\ )
* **kitchen+travis:** upgrade matrix after ``2019.2.2`` release [skip ci] (\ `495f811 <https://github.com/saltstack-formulas/zabbix-formula/commit/495f811341907cccf831970cc9da9fff3999f456>`_\ )
* **travis:** adjust to new working matrix (\ `41cd6ab <https://github.com/saltstack-formulas/zabbix-formula/commit/41cd6abb624617b8d78b572d0e75ecf42a1f9787>`_\ )
* **travis:** apply changes from build config validation [skip ci] (\ `0824612 <https://github.com/saltstack-formulas/zabbix-formula/commit/082461270d6286709d2405aaa310f51431290df9>`_\ )
* **travis:** opt-in to ``dpl v2`` to complete build config validation [skip ci] (\ `6e8da04 <https://github.com/saltstack-formulas/zabbix-formula/commit/6e8da049ea0089bb0fd60f74c3e1c9956cf8ff54>`_\ )
* **travis:** quote pathspecs used with ``git ls-files`` [skip ci] (\ `0c33ab0 <https://github.com/saltstack-formulas/zabbix-formula/commit/0c33ab0eb88beebb422e76effa2262bba4310a6b>`_\ )
* **travis:** run ``shellcheck`` during lint job [skip ci] (\ `33b018d <https://github.com/saltstack-formulas/zabbix-formula/commit/33b018d8013cf5e895c2ba20c0a82c04e5cfb1c7>`_\ )
* **travis:** update ``salt-lint`` config for ``v0.0.10`` [skip ci] (\ `ecc08c4 <https://github.com/saltstack-formulas/zabbix-formula/commit/ecc08c40c2c21ca7ffa197fd376ab61a92d3d4a3>`_\ )
* **travis:** use ``major.minor`` for ``semantic-release`` version [skip ci] (\ `ece1158 <https://github.com/saltstack-formulas/zabbix-formula/commit/ece1158ec2138fd111684e3af9606df8b5d0776d>`_\ )
* **travis:** use build config validation (beta) [skip ci] (\ `f4f8626 <https://github.com/saltstack-formulas/zabbix-formula/commit/f4f8626d822539deb2f353612f3cfa725530b163>`_\ )

Documentation
^^^^^^^^^^^^^


* **contributing:** remove to use org-level file instead [skip ci] (\ `889a49b <https://github.com/saltstack-formulas/zabbix-formula/commit/889a49bab69e51efb70be6185adf2f57553c71c0>`_\ )
* **readme:** update link to ``CONTRIBUTING`` [skip ci] (\ `249b89f <https://github.com/saltstack-formulas/zabbix-formula/commit/249b89fb4af4cdbaa29220fd8eee8520a42f67ed>`_\ )

Performance Improvements
^^^^^^^^^^^^^^^^^^^^^^^^


* **travis:** improve ``salt-lint`` invocation [skip ci] (\ `a5b7afb <https://github.com/saltstack-formulas/zabbix-formula/commit/a5b7afb8842bf5744080bef8d49464e914923f2b>`_\ )

Tests
^^^^^


* **packages_spec:** update for ``4.4.1`` release (\ `c5cc431 <https://github.com/saltstack-formulas/zabbix-formula/commit/c5cc431f9489da2139c7ca14ff28797ce859262b>`_\ )
* **packages_spec:** update version numbers (\ `0ebd417 <https://github.com/saltstack-formulas/zabbix-formula/commit/0ebd417860f157b3d6a31c2b1522db380ece6673>`_\ )

`0.21.1 <https://github.com/saltstack-formulas/zabbix-formula/compare/v0.21.0...v0.21.1>`_ (2019-10-13)
-----------------------------------------------------------------------------------------------------------

Code Refactoring
^^^^^^^^^^^^^^^^


* **repo:** remove unused ``files_switch`` import (\ ` <https://github.com/saltstack-formulas/zabbix-formula/commit/e60e111>`_\ )
* **tofs:** upgrade for all file.managed (\ ` <https://github.com/saltstack-formulas/zabbix-formula/commit/d5c747c>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **travis:** use ``fedora-29`` instead of ``fedora-30`` (for reliability) (\ ` <https://github.com/saltstack-formulas/zabbix-formula/commit/7de7782>`_\ )

`0.21.0 <https://github.com/saltstack-formulas/zabbix-formula/compare/v0.20.5...v0.21.0>`_ (2019-10-12)
-----------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **init.sls:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/zabbix-formula/commit/ff28364>`_\ )
* **pillar.example:** fix ``yamllint`` violations (\ ` <https://github.com/saltstack-formulas/zabbix-formula/commit/b51907d>`_\ )
* **repo:** ensure ``debconf-utils`` is installed for Debian-based OSes (\ ` <https://github.com/saltstack-formulas/zabbix-formula/commit/4980350>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **inspec:** add pillar to use for testing the ``default`` suite (\ ` <https://github.com/saltstack-formulas/zabbix-formula/commit/581a748>`_\ )

Documentation
^^^^^^^^^^^^^


* **readme:** move to ``docs/`` directory and apply common structure (\ ` <https://github.com/saltstack-formulas/zabbix-formula/commit/f0f1563>`_\ )

Features
^^^^^^^^


* **semantic-release:** implement for this formula (\ ` <https://github.com/saltstack-formulas/zabbix-formula/commit/40e78a2>`_\ ), closes `#129 <https://github.com/saltstack-formulas/zabbix-formula/issues/129>`_

Tests
^^^^^


* **inspec:** add tests for packages, config files & services (\ ` <https://github.com/saltstack-formulas/zabbix-formula/commit/4facac6>`_\ )
