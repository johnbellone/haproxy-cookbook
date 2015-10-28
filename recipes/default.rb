#
# Cookbook: haproxy
# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#
include_recipe 'cpu::affinity'

node.default['sysctl']['params']['net']['core']['somaxconn'] = 10_000
node.default['sysctl']['params']['net']['ipv4']['ip_local_port_range'] = '1024 65023'
node.default['sysctl']['params']['net']['ipv4']['tcp_fin_timeout'] = 30
node.default['sysctl']['params']['net']['ipv4']['tcp_max_syn_backlog'] = 10_240
node.default['sysctl']['params']['net']['ipv4']['tcp_max_tw_buckets'] = 400_000
node.default['sysctl']['params']['net']['ipv4']['tcp_max_orphans'] = 60_000
node.default['sysctl']['params']['net']['ipv4']['tcp_synack_retries'] = 3
node.default['sysctl']['params']['net']['ipv4']['tcp_tw_reuse'] = 1
include_recipe 'sysctl::apply'

poise_service_user node['haproxy']['service_user'] do
  group node['haproxy']['service_group']
end

service = haproxy_service node['haproxy']['service_name'] do |r|
  user node['haproxy']['service_user']
  group node['haproxy']['service_group']
  config_file node['haproxy']['config']['path']

  node['haproxy']['service'].each_pair { |k, v| r.send(k, v) }
end

cpu_affinity "Set CPU affinity for #{service.name}" do
  pid service.pid_file
  cpu 0
  subscribes :set, "haproxy_service[#{service.name}]"
end
