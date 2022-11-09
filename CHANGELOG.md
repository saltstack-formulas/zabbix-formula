# Changelog

## [1.3.2](https://github.com/saltstack-formulas/zabbix-formula/compare/v1.3.1...v1.3.2) (2022-11-09)


### Bug Fixes

* **repo:** update repo config for keyring ([5a12da9](https://github.com/saltstack-formulas/zabbix-formula/commit/5a12da962a48be903201f7ddf886e6090e69533d))

## [1.3.1](https://github.com/saltstack-formulas/zabbix-formula/compare/v1.3.0...v1.3.1) (2022-07-19)


### Bug Fixes

* **agent:** don't set Hostname when HostnameItem is set ([e832b6d](https://github.com/saltstack-formulas/zabbix-formula/commit/e832b6d61ca63950c77b07ebda4a4bc789a2bea6))


### Continuous Integration

* update `pre-commit` configuration inc. for pre-commit.ci [skip ci] ([8a8dee9](https://github.com/saltstack-formulas/zabbix-formula/commit/8a8dee91da94c61eb167c05c2c73100afe05080d))
* **kitchen+gitlab:** update for new pre-salted images [skip ci] ([443a9f0](https://github.com/saltstack-formulas/zabbix-formula/commit/443a9f027b242d49f397e64bfcec513301bd03e2))
* update linters to latest versions [skip ci] ([2f0819d](https://github.com/saltstack-formulas/zabbix-formula/commit/2f0819dc70484bc2f088ddf5b2c371b98e5a9e00))
* **gemfile:** allow rubygems proxy to be provided as an env var [skip ci] ([58c978b](https://github.com/saltstack-formulas/zabbix-formula/commit/58c978bd8acf3a476f5e454844f1948de55ba618))
* **kitchen+ci:** update with `3004` pre-salted images/boxes [skip ci] ([d058299](https://github.com/saltstack-formulas/zabbix-formula/commit/d058299a86936ae0a0b76d31bf0cce21d9433574))
* **kitchen+gitlab:** update for new pre-salted images [skip ci] ([0e9a50a](https://github.com/saltstack-formulas/zabbix-formula/commit/0e9a50a8456511ea3cb28e033c9755450fe8a6df))


### Tests

* **system:** add `build_platform_codename` [skip ci] ([67eba9c](https://github.com/saltstack-formulas/zabbix-formula/commit/67eba9ccae6ef196c62c1fda91fec309f850a78e))
* **system.rb:** add support for `mac_os_x` [skip ci] ([68e9f94](https://github.com/saltstack-formulas/zabbix-formula/commit/68e9f94289ad7961e611e04a273e1bbefbcad33a))

# [1.3.0](https://github.com/saltstack-formulas/zabbix-formula/compare/v1.2.1...v1.3.0) (2021-10-19)


### Continuous Integration

* **3003.1:** update inc. AlmaLinux, Rocky & `rst-lint` [skip ci] ([e6eb6c8](https://github.com/saltstack-formulas/zabbix-formula/commit/e6eb6c826ed1e954a3a91a967e8400762fb298f1))
* **gemfile+lock:** use `ssf` customised `inspec` repo [skip ci] ([d063638](https://github.com/saltstack-formulas/zabbix-formula/commit/d06363882716b53beb472d1abe50aa543dc0ce55))
* **kitchen:** move `provisioner` block & update `run_command` [skip ci] ([11bc40c](https://github.com/saltstack-formulas/zabbix-formula/commit/11bc40c773e7f0f420715da55c49c73e0014b448))
* **kitchen+ci:** update with latest `3003.2` pre-salted images [skip ci] ([b50c265](https://github.com/saltstack-formulas/zabbix-formula/commit/b50c265f1563336cb922d832d2d2b88d74ca046b))
* **kitchen+ci:** update with latest CVE pre-salted images [skip ci] ([ee1212e](https://github.com/saltstack-formulas/zabbix-formula/commit/ee1212e847de902c31f97cf94373ead804910350))
* add Debian 11 Bullseye & update `yamllint` configuration [skip ci] ([5ca6072](https://github.com/saltstack-formulas/zabbix-formula/commit/5ca6072008830c263bc55c79ab7549586990b4b4))
* **kitchen+gitlab:** remove Ubuntu 16.04 & Fedora 32 (EOL) [skip ci] ([5e743a8](https://github.com/saltstack-formulas/zabbix-formula/commit/5e743a8559cd30b61c77477f34a7071f89d172c0))


### Features

* **agent:** add HostInterface and HostInterfaceItem to config ([e7fbb96](https://github.com/saltstack-formulas/zabbix-formula/commit/e7fbb96fe0011f604a7c5498a6ae3f5767880df8))

## [1.2.1](https://github.com/saltstack-formulas/zabbix-formula/compare/v1.2.0...v1.2.1) (2021-05-11)


### Bug Fixes

* **pgsql:** do not try to create db and user with schema ([058a800](https://github.com/saltstack-formulas/zabbix-formula/commit/058a800be2a9f1cc1aad58c4dae6b82474bdf188))

# [1.2.0](https://github.com/saltstack-formulas/zabbix-formula/compare/v1.1.0...v1.2.0) (2021-05-11)


### Continuous Integration

* add `arch-master` to matrix and update `.travis.yml` [skip ci] ([95523a9](https://github.com/saltstack-formulas/zabbix-formula/commit/95523a9df12d511e69f00faecdd55d478540a7cd))
* **kitchen+gitlab:** adjust matrix to add `3003` [skip ci] ([1d237e8](https://github.com/saltstack-formulas/zabbix-formula/commit/1d237e8fcf14bd81126c5ab7cf38d0a5fd701cc9))
* **travis:** maintain sync with GitLab CI [skip ci] ([5c81ca1](https://github.com/saltstack-formulas/zabbix-formula/commit/5c81ca16808d3541690be282a1f96e410d68d848)), closes [#146](https://github.com/saltstack-formulas/zabbix-formula/issues/146)


### Features

* **agent:** allow use of string Server and ServerActive ([59dff0a](https://github.com/saltstack-formulas/zabbix-formula/commit/59dff0ace5ff83fd6996845e554dfbce7c9d1a75))

# [1.1.0](https://github.com/saltstack-formulas/zabbix-formula/compare/v1.0.5...v1.1.0) (2021-04-16)


### Features

* add suse support (applied suggestions from hatifnatt and myii) ([a245ec4](https://github.com/saltstack-formulas/zabbix-formula/commit/a245ec44954b3e782787fb09cd84655597cfac01))

## [1.0.5](https://github.com/saltstack-formulas/zabbix-formula/compare/v1.0.4...v1.0.5) (2021-04-16)


### Bug Fixes

* **agent:** fix include dirname ([b36c1a7](https://github.com/saltstack-formulas/zabbix-formula/commit/b36c1a7541c7cbe27fc108a3fd82d78d9cd1f758))


### Continuous Integration

* **commitlint:** ensure `upstream/master` uses main repo URL [skip ci] ([f562f9f](https://github.com/saltstack-formulas/zabbix-formula/commit/f562f9f3e4f757d10ac024cba7fa67649ddda799))
* **gemfile+lock:** use `ssf` customised `kitchen-docker` repo [skip ci] ([1fed266](https://github.com/saltstack-formulas/zabbix-formula/commit/1fed2667ba186102036d0efb74394ccd54a759ec))
* **gitlab-ci:** add `rubocop` linter (with `allow_failure`) [skip ci] ([4799292](https://github.com/saltstack-formulas/zabbix-formula/commit/479929200b96994c1dcd20e844c201489646ebb2))
* **kitchen+ci:** use latest pre-salted images (after CVE) [skip ci] ([aaf82de](https://github.com/saltstack-formulas/zabbix-formula/commit/aaf82ded69295e62dd871e5be600b1aa1a2d05e5))
* **kitchen+gitlab-ci:** use latest pre-salted images [skip ci] ([1701026](https://github.com/saltstack-formulas/zabbix-formula/commit/1701026b0dd547af8a1b0c765865910d0fd2616c))
* **pre-commit:** update hook for `rubocop` [skip ci] ([751e966](https://github.com/saltstack-formulas/zabbix-formula/commit/751e966a788ed7716219a20bf549d07b2bdf3ad0))


### Tests

* standardise use of `share` suite & `_mapdata` state [skip ci] ([05eae71](https://github.com/saltstack-formulas/zabbix-formula/commit/05eae71461c0ee2f3c99108c884de9f64d09a896))
* **config_spec:** fix `rubocop` violations [skip ci] ([fb270d2](https://github.com/saltstack-formulas/zabbix-formula/commit/fb270d2ffbde0386121a87523adf3ca1bbf85cee))

## [1.0.4](https://github.com/saltstack-formulas/zabbix-formula/compare/v1.0.3...v1.0.4) (2020-12-16)


### Continuous Integration

* **gitlab-ci:** use GitLab CI as Travis CI replacement ([44ec1b3](https://github.com/saltstack-formulas/zabbix-formula/commit/44ec1b3d71de71efab27a2f2ccb58c90018cedbe))
* **pre-commit:** add to formula [skip ci] ([c9aeb37](https://github.com/saltstack-formulas/zabbix-formula/commit/c9aeb377d070cae54aa82f15904ab799b5994980))
* **pre-commit:** enable/disable `rstcheck` as relevant [skip ci] ([8990e81](https://github.com/saltstack-formulas/zabbix-formula/commit/8990e81dc256d53249bf2732e5b8af1346133e76))
* **pre-commit:** finalise `rstcheck` configuration [skip ci] ([c7dff99](https://github.com/saltstack-formulas/zabbix-formula/commit/c7dff99d06e25572fc9ee74ec1655fdd8e41cd8a))


### Styles

* **libtofs.jinja:** use Black-inspired Jinja formatting [skip ci] ([497406a](https://github.com/saltstack-formulas/zabbix-formula/commit/497406a77a3431d2e708e2eeadca9221a1833ebf))

## [1.0.3](https://github.com/saltstack-formulas/zabbix-formula/compare/v1.0.2...v1.0.3) (2020-07-10)


### Code Refactoring

* **variable names:** use dbpassword consistently across formula ([5b4b787](https://github.com/saltstack-formulas/zabbix-formula/commit/5b4b78795ef4396b4a94b68af9e04c374b631194))


### Continuous Integration

* **kitchen:** use `saltimages` Docker Hub where available [skip ci] ([aa92ed5](https://github.com/saltstack-formulas/zabbix-formula/commit/aa92ed55e14526a8882a36b151216a2da408ad51))


### Tests

* **packages_spec:** generalise version number verification [skip ci] ([e4952f0](https://github.com/saltstack-formulas/zabbix-formula/commit/e4952f06f3e2c131a2beb2e30b56f6c3e7b4581a))

## [1.0.2](https://github.com/saltstack-formulas/zabbix-formula/compare/v1.0.1...v1.0.2) (2020-05-28)


### Continuous Integration

* **kitchen+travis:** add new platforms [skip ci] ([e7ff4ee](https://github.com/saltstack-formulas/zabbix-formula/commit/e7ff4eeb77198628d75cd3f2b01b6f8f6ce55438))
* **kitchen+travis:** adjust matrix to add `3000.3` [skip ci] ([02926f0](https://github.com/saltstack-formulas/zabbix-formula/commit/02926f08e1220baa5c92c0b5f1ef130195b3b50e))
* **travis:** add notifications => zulip [skip ci] ([473db1c](https://github.com/saltstack-formulas/zabbix-formula/commit/473db1cc7689d3f1ed42d02873f4208f5cf4fea9))
* **travis:** use new platforms (`ubuntu-20.04` & `fedora-32`) ([938aac4](https://github.com/saltstack-formulas/zabbix-formula/commit/938aac4f93472350bcd0fdfc387938494e898541))
* **workflows/commitlint:** add to repo [skip ci] ([ac271fe](https://github.com/saltstack-formulas/zabbix-formula/commit/ac271fe041199e71c0186fc83916c325ad22c91b))


### Tests

* **packages_spec:** add versions for new platforms ([5eb7bd8](https://github.com/saltstack-formulas/zabbix-formula/commit/5eb7bd8d6a74bc0f49ab7703f205ac59ccf49bf8))
* **packages_spec:** update for `4.4.9` ([d30ae38](https://github.com/saltstack-formulas/zabbix-formula/commit/d30ae38e1ec551be3bd456f64091e95692cf30ac))

## [1.0.1](https://github.com/saltstack-formulas/zabbix-formula/compare/v1.0.0...v1.0.1) (2020-05-02)


### Continuous Integration

* **gemfile.lock:** add to repo with updated `Gemfile` [skip ci] ([6f153fa](https://github.com/saltstack-formulas/zabbix-formula/commit/6f153fa8c3609470cbaa93a38f886c089866a74d))
* **kitchen+travis:** adjust matrix to add `3000.2` & remove `2018.3` ([fc6c741](https://github.com/saltstack-formulas/zabbix-formula/commit/fc6c741fbbc50f4569e2218ef62b2a79e710c5c2))
* **kitchen+travis:** remove `master-py2-arch-base-latest` [skip ci] ([92ac6c7](https://github.com/saltstack-formulas/zabbix-formula/commit/92ac6c762061bb45e1f02bc6b40a5887355f3462))


### Tests

* **packages_spec:** update for `4.4.8` ([773e522](https://github.com/saltstack-formulas/zabbix-formula/commit/773e522a26dbf391c844182c26a1bef058b9e4b9))

# [1.0.0](https://github.com/saltstack-formulas/zabbix-formula/compare/v0.21.4...v1.0.0) (2020-04-04)


### Bug Fixes

* **fedora:** get all `fedora` instances working (`2018.3`+) ([32ef0e6](https://github.com/saltstack-formulas/zabbix-formula/commit/32ef0e61fa25d45dbd9ad3f62eaf5166b96d1298))


### Continuous Integration

* **kitchen+travis:** adjust matrix to add `3000` & remove `2017.7` [skip ci] ([74bb032](https://github.com/saltstack-formulas/zabbix-formula/commit/74bb0322724aa5adb728f194372ff10464d433bd))
* **kitchen+travis:** adjust matrix to update `3000` to `3000.1` [skip ci] ([e74bfed](https://github.com/saltstack-formulas/zabbix-formula/commit/e74bfed5e97ec03037b9dc560a113597f2a295d2))


### BREAKING CHANGES

* **fedora:** Minimum Salt version support is now `2018.3` in line
with official upstream support; also use of the `traverse` Jinja filter.

## [0.21.4](https://github.com/saltstack-formulas/zabbix-formula/compare/v0.21.3...v0.21.4) (2020-03-31)


### Tests

* **packages_spec:** update version numbers ([3242c14](https://github.com/saltstack-formulas/zabbix-formula/commit/3242c1469662ffc14368446df5eb11a140ebd2ea))

## [0.21.3](https://github.com/saltstack-formulas/zabbix-formula/compare/v0.21.2...v0.21.3) (2020-03-22)


### Code Refactoring

* **map and defaults:** update the map.jinja file and add yaml maps ([badd17e](https://github.com/saltstack-formulas/zabbix-formula/commit/badd17edecff8119fe25d73329c0445a3ac58769))

## [0.21.2](https://github.com/saltstack-formulas/zabbix-formula/compare/v0.21.1...v0.21.2) (2020-03-12)


### Bug Fixes

* **libtofs:** “files_switch” mess up the variable exported by “map.jinja” [skip ci] ([9d6b5d7](https://github.com/saltstack-formulas/zabbix-formula/commit/9d6b5d7af2fdce59c104d4580d17880f4a5bf8d3))
* **release.config.js:** use full commit hash in commit link [skip ci] ([2072e06](https://github.com/saltstack-formulas/zabbix-formula/commit/2072e06d91fdc74781bf88c33f90ec408b241abd))


### Continuous Integration

* **gemfile:** restrict `train` gem version until upstream fix [skip ci] ([95d4c15](https://github.com/saltstack-formulas/zabbix-formula/commit/95d4c151327987fc287dc682868a7e962e898dfb))
* **kitchen:** avoid using bootstrap for `master` instances [skip ci] ([2c04d93](https://github.com/saltstack-formulas/zabbix-formula/commit/2c04d9311de15b56613a51b95b12bde536ea413e))
* **kitchen:** use `debian-10-master-py3` instead of `develop` [skip ci] ([8645a8e](https://github.com/saltstack-formulas/zabbix-formula/commit/8645a8ee6ea8e1b77c62801929d175cf3d683169))
* **kitchen:** use `develop` image until `master` is ready (`amazonlinux`) [skip ci] ([678b048](https://github.com/saltstack-formulas/zabbix-formula/commit/678b048c34a8483f6bca79796a4e39f07760e5e4))
* **kitchen+travis:** upgrade matrix after `2019.2.2` release [skip ci] ([495f811](https://github.com/saltstack-formulas/zabbix-formula/commit/495f811341907cccf831970cc9da9fff3999f456))
* **travis:** adjust to new working matrix ([41cd6ab](https://github.com/saltstack-formulas/zabbix-formula/commit/41cd6abb624617b8d78b572d0e75ecf42a1f9787))
* **travis:** apply changes from build config validation [skip ci] ([0824612](https://github.com/saltstack-formulas/zabbix-formula/commit/082461270d6286709d2405aaa310f51431290df9))
* **travis:** opt-in to `dpl v2` to complete build config validation [skip ci] ([6e8da04](https://github.com/saltstack-formulas/zabbix-formula/commit/6e8da049ea0089bb0fd60f74c3e1c9956cf8ff54))
* **travis:** quote pathspecs used with `git ls-files` [skip ci] ([0c33ab0](https://github.com/saltstack-formulas/zabbix-formula/commit/0c33ab0eb88beebb422e76effa2262bba4310a6b))
* **travis:** run `shellcheck` during lint job [skip ci] ([33b018d](https://github.com/saltstack-formulas/zabbix-formula/commit/33b018d8013cf5e895c2ba20c0a82c04e5cfb1c7))
* **travis:** update `salt-lint` config for `v0.0.10` [skip ci] ([ecc08c4](https://github.com/saltstack-formulas/zabbix-formula/commit/ecc08c40c2c21ca7ffa197fd376ab61a92d3d4a3))
* **travis:** use `major.minor` for `semantic-release` version [skip ci] ([ece1158](https://github.com/saltstack-formulas/zabbix-formula/commit/ece1158ec2138fd111684e3af9606df8b5d0776d))
* **travis:** use build config validation (beta) [skip ci] ([f4f8626](https://github.com/saltstack-formulas/zabbix-formula/commit/f4f8626d822539deb2f353612f3cfa725530b163))


### Documentation

* **contributing:** remove to use org-level file instead [skip ci] ([889a49b](https://github.com/saltstack-formulas/zabbix-formula/commit/889a49bab69e51efb70be6185adf2f57553c71c0))
* **readme:** update link to `CONTRIBUTING` [skip ci] ([249b89f](https://github.com/saltstack-formulas/zabbix-formula/commit/249b89fb4af4cdbaa29220fd8eee8520a42f67ed))


### Performance Improvements

* **travis:** improve `salt-lint` invocation [skip ci] ([a5b7afb](https://github.com/saltstack-formulas/zabbix-formula/commit/a5b7afb8842bf5744080bef8d49464e914923f2b))


### Tests

* **packages_spec:** update for `4.4.1` release ([c5cc431](https://github.com/saltstack-formulas/zabbix-formula/commit/c5cc431f9489da2139c7ca14ff28797ce859262b))
* **packages_spec:** update version numbers ([0ebd417](https://github.com/saltstack-formulas/zabbix-formula/commit/0ebd417860f157b3d6a31c2b1522db380ece6673))

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
