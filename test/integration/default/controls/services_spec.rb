# frozen_string_literal: true

control 'zabbix service' do
  impact 0.5
  title 'should be running and enabled'

  services =
    case platform[:name]
    when 'fedora'
      %w[zabbix-agent zabbix-server-mysql]
    else
      %w[zabbix-agent zabbix-server]
    end

  services.each do |s|
    describe service(s) do
      it { should be_enabled }
      it { should be_running }
    end
  end
end
