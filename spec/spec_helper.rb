require_relative File.dirname(__FILE__) + '/../utils/dependencies.rb'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.mock_framework = :rspec
end
