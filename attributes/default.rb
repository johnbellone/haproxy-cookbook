#
# Cookbook: haproxy
# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#
default['haproxy']['service_name'] = 'haproxy'
default['haproxy']['service_user'] = 'haproxy'
default['haproxy']['service_group'] = 'haproxy'

default['haproxy']['config']['path'] = '/etc/haproxy/haproxy.cfg'
default['haproxy']['service']['install_method'] = 'package'
