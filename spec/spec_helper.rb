require_relative __dir__ + '/../lib/dependencies.rb'

FileUtils.rm_rf('tmp') if Dir.exist?('tmp')

I18n.locale = :en
StartUp.execute
Package.load('./tmp', create_flag: true)
DynamicDependencies.load_loaders

Dir[__dir__ + '/support/**/*.rb'].each { |file| require file }

RSpec.configure do |config|
  config.include StdoutHelper

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.after(:each) do
    Dir.glob('loaders/*').each do |file|
      File.delete(file) unless File.basename(file) == 'base.rb'
    end
  end

  config.before(:each) do
    Env.requests.clear
    Env.workbench.clear

    allow(Readline).to receive(:get_screen_size) { [Float::INFINITY, Float::INFINITY] }
  end

  config.mock_framework = :rspec
end
