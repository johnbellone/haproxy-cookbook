#
# Cookbook: haproxy
# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#
require 'poise_service/service_mixin'

module HaproxyCookbook
  module Resource
    # A custom resource for managing HAProxy.
    # @since 1.0.0
    class HaproxyService < Chef::Resource
      include Poise
      provides(:haproxy_service)
      include PoiseService::ServiceMixin

      attribute(:user, kind_of: String, default: 'haproxy')
      attribute(:group, kind_of: String, default: 'haproxy')
      attribute(:config_file, kind_of: String, default: '/etc/haproxy/haproxy.cfg')
      attribute(:pid_file, kind_of: String, default: '/var/run/haproxy.pid')

      attribute(:install_method, equal_to: %w{package}, default: 'package')
      attribute(:package_name, kind_of: String, default: 'haproxy')
      attribute(:package_version, kind_of: String)
      attribute(:package_source, kind_of: String)

      def command
        "/usr/bin/haproxy -f #{config_file}"
      end
    end
  end

  module Provider
    # A custom provider for managing HAProxy.
    # @since 1.0.0
    class HaproxyService < Chef::Provider
      include Poise
      provides(:haproxy_service)
      include PoiseService::ServiceMixin

      private
      def service_options(service)
        service.command(new_resource.command)
        service.user(new_resource.user)
        service.pid_file(new_resource.pid_file)
        service.restart_on_update(true)
      end
    end
  end
end
