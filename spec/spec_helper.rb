require_relative File.dirname(__FILE__) + '/../utils/dependencies.rb'
Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |file| require file }

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do
    config.include StdoutHelper
    Env.requests.clear
    Env.workbench.clear
    allow(Readline).to receive(:get_screen_size) { [Float::INFINITY, Float::INFINITY] }
    allow(YAML).to receive(:load_file).and_call_original
    allow(YAML).to receive(:load_file).with('config.yml') { Hash.new }
  end

  config.mock_framework = :rspec
end
