# frozen_string_literal: true

control 'zabbix agent configuration' do
  title 'should match desired lines'

  describe file('/etc/zabbix/zabbix_agentd.conf') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('mode') { should cmp '0644' }
    its('content') { should include 'Server=localhost' }
    its('content') { should include 'ListenPort=10050' }
    its('content') { should include 'ListenIP=0.0.0.0' }
    its('content') { should include 'ServerActive=localhost' }
    its('content') do
      should include(
        'HostMetadata=c9767034-22c6-4d3d-a886-5fcaf1386b77'
      )
    end
    its('content') { should include 'Include=/etc/zabbix/zabbix_agentd.d/' }
    its('content') do
      should include(
        'UserParameter=net.ping[*],/usr/bin/fping -q -c3 $1 2>&1 | '\
        'sed \'s,.*/\([0-9.]*\)/.*,\1,\''
      )
    end
    its('content') do
      should include(
        'UserParameter=custom.vfs.dev.discovery,/usr/local/bin/dev-discovery.sh'
      )
    end
  end
end

control 'zabbix server configuration' do
  title 'should match desired lines'

  server_file_group = 'zabbix'
  server_file_mode = '0640'
  setting_dbsocket = '/var/lib/mysql/mysql.sock'
  case platform[:family]
  when 'debian'
    server_file_group = 'root'
    server_file_mode = '0644'
    setting_dbsocket = '/var/run/mysqld/mysqld.sock'
  when 'fedora'
    server_file_group = 'zabbixsrv'
  when 'suse'
    setting_dbsocket = '/run/mysql/mysql.sock'
  end

  # TODO: Conditional content to consider for inclusion below
  # 'ExternalScripts=/usr/lib/zabbix/externalscripts' (fedora only)
  # 'FpingLocation=/usr/sbin/fping' (not debian)
  # 'Fping6Location=/usr/sbin/fping6' (not debian)

  # NOTE: The file below is a symlink to `/etc/zabbix_server.conf` on Fedora
  describe file('/etc/zabbix/zabbix_server.conf') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into server_file_group }
    its('mode') { should cmp server_file_mode }
    its('content') { should include 'ListenPort=10051' }
    its('content') { should include '# Mandatory: no' }
    its('content') { should include 'DBHost=localhost' }
    its('content') { should include '#	Database user. Ignored for SQLite.' }
    its('content') { should include 'DBUser=zabbixuser' }
    its('content') { should include 'DBPassword=zabbixpass' }
    its('content') { should include setting_dbsocket }
    its('content') { should include 'ListenIP=0.0.0.0' }
  end
end

control 'zabbix web configuration' do
  title 'should match desired lines'

  describe file('/etc/zabbix/web/zabbix.conf.php') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('mode') { should cmp '0644' }
    its('content') { should include 'global $DB;' }
    its('content') { should match(/\$DB\["TYPE"\].*=.*'MYSQL';/) }
    its('content') { should match(/\$DB\["SERVER"\].*=.*'localhost';/) }
    its('content') { should match(/\$DB\["PORT"\].*=.*'0';/) }
    its('content') { should match(/\$DB\["DATABASE"\].*=.*'zabbix';/) }
    its('content') { should match(/\$DB\["USER"\].*=.*'zabbixuser';/) }
    its('content') { should match(/\$DB\["PASSWORD"\].*=.*'zabbixpass';/) }
    its('content') { should match(/\$DB\["SCHEMA"\].*=.*'';/) }
    its('content') { should match(/\$ZBX_SERVER.*=.*'localhost';/) }
    its('content') { should match(/\$ZBX_SERVER_PORT.*=.*'10051';/) }
    its('content') do
      should match(/\$ZBX_SERVER_NAME.*=.*'Zabbix installed with saltstack';/)
    end
    its('content') { should match(/\$IMAGE_FORMAT_DEFAULT.*=.*IMAGE_FORMAT_PNG;/) }
  end
end
