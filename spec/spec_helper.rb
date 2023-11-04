require_relative File.dirname(__FILE__) + '/../utils/dependencies.rb'
I18n.locale = :en
Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |file| require file }
default_config = YAML.load_file('utils/default_config.yml')

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each, :file_mocking) do
    config.include FileMocking
  end

  config.before(:each) do
    config.include StdoutHelper
    Env.requests.clear
    Env.workbench.clear
    allow(Readline).to receive(:get_screen_size) { [Float::INFINITY, Float::INFINITY] }
    allow(Env).to receive(:config) { default_config }
  end

  config.mock_framework = :rspec
end
