require 'chefspec'
require 'chefspec/berkshelf'
require 'chefspec/cacher'
require 'chef/sugar'

RSpec.configure do |c|
  c.platform = 'ubuntu'
  c.version = '12.04'
end
