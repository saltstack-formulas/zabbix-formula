# frozen_string_literal: true

pkg_agent = 'zabbix-agent'
pkg_server = 'zabbix-server-mysql'
pkg_web =
  case platform[:family]
  when 'debian'
    'zabbix-frontend-php'
  else
    'zabbix-web-mysql'
  end
version =
  case platform[:name]
  when 'debian', 'ubuntu'
    '1:4.4'
  when 'centos'
    '4.4'
  when 'fedora'
    '4.0'
  end

control 'zabbix packages' do
  title 'should be installed'

  [
    pkg_agent,
    pkg_server,
    pkg_web
  ].each do |p|
    describe package(p) do
      it { should be_installed }
      its('version') { should match(/^#{version}/) }
    end
  end
end
