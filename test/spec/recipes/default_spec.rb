require 'spec_helper'

describe 'haproxy::default' do
  cached(:chef_run) { ChefSpec::SoloRunner.new.converge('haproxy::default')  }
  context 'with default node attributes' do
    it { expect(chef_run).to include_recipe('cpu::affinity') }
    it { expect(chef_run).to include_recipe('firewall::default') }
    it { expect(chef_run).to include_recipe('sysctl::apply') }
    it { expect(chef_run).to create_poise_service_user('haproxy').with(group: 'haproxy') }
    it { expect(chef_run).to enable_haproxy_service('haproxy').with(config_file: '/etc/haproxy/haproxy.cfg') }
    it { expect(chef_run).not_to create_firewall_rule('http').with(port: 80, redirect_port: 8080, command: :redirect) }
    it { expect(chef_run).not_to create_firewall_rule('https').with(port: 443, redirect_port: 8443, command: :redirect) }
    it { chef_run }
  end
end
