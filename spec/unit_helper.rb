$LOAD_PATH.unshift("./app/models")

require 'simplecov'
require 'rspec/fire'
require 'timecop'

SimpleCov.start do
  command_name 'test:units'
end

RSpec.configure do |config|
  config.include(RSpec::Fire)
  config.before(:all) do
    Object.send(:remove_const, :REDIS) if defined?(REDIS)
    REDIS = fire_double("Redis")
  end
end
