require 'serverspec'
set :backend, :exec

describe group('haproxy') do
  it { should exist }
end

describe user('haproxy') do
  it { should exist }
  it { should belong_to_group('haproxy') }
end

describe service('haproxy') do
  it { should be_enabled }
  it { should be_running }
end

describe port(8080) do
  it { should be_listening.with('tcp') }
end
