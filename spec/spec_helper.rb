require_relative File.dirname(__FILE__) + '/../utils/dependencies.rb'
Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |file| require file }

RSpec.configure do |config|
  config.include StdoutHelper

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each, :file_mocking) do
    config.include FileMocking
  end

  config.before(:each) do
    Env.requests.clear
    Env.workbench.clear

    allow(Readline).to receive(:get_screen_size) { [Float::INFINITY, Float::INFINITY] }

    allow(File).to receive(:exist?).and_call_original
    allow(File).to receive(:exist?).with('config.yml').and_return(false)
  end

  config.mock_framework = :rspec
end
