require_relative File.dirname(__FILE__) + '/../utils/dependencies.rb'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do
    Env.requests.clear
    Env.workbench.clear
  end

  config.mock_framework = :rspec
end
