# Changelog

## [0.21.1](https://github.com/saltstack-formulas/zabbix-formula/compare/v0.21.0...v0.21.1) (2019-10-13)


### Code Refactoring

* **repo:** remove unused `files_switch` import ([](https://github.com/saltstack-formulas/zabbix-formula/commit/e60e111))
* **tofs:** upgrade for all file.managed ([](https://github.com/saltstack-formulas/zabbix-formula/commit/d5c747c))


### Continuous Integration

* **travis:** use `fedora-29` instead of `fedora-30` (for reliability) ([](https://github.com/saltstack-formulas/zabbix-formula/commit/7de7782))

# [0.21.0](https://github.com/saltstack-formulas/zabbix-formula/compare/v0.20.5...v0.21.0) (2019-10-12)


### Bug Fixes

* **init.sls:** fix `salt-lint` errors ([](https://github.com/saltstack-formulas/zabbix-formula/commit/ff28364))
* **pillar.example:** fix `yamllint` violations ([](https://github.com/saltstack-formulas/zabbix-formula/commit/b51907d))
* **repo:** ensure `debconf-utils` is installed for Debian-based OSes ([](https://github.com/saltstack-formulas/zabbix-formula/commit/4980350))


### Continuous Integration

* **inspec:** add pillar to use for testing the `default` suite ([](https://github.com/saltstack-formulas/zabbix-formula/commit/581a748))


### Documentation

* **readme:** move to `docs/` directory and apply common structure ([](https://github.com/saltstack-formulas/zabbix-formula/commit/f0f1563))


### Features

* **semantic-release:** implement for this formula ([](https://github.com/saltstack-formulas/zabbix-formula/commit/40e78a2)), closes [#129](https://github.com/saltstack-formulas/zabbix-formula/issues/129)


### Tests

* **inspec:** add tests for packages, config files & services ([](https://github.com/saltstack-formulas/zabbix-formula/commit/4facac6))
