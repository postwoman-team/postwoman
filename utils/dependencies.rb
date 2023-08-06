require 'rubygems'
require 'bundler/setup'
require_relative '../utils/loaders/builtin/base'
Bundler.require

def needed_file(path, template_path)
  return if File.exist?(path)

  File.open(path, 'w') do |f|
    f.write(File.read(template_path))
  end
end

def load_loaders
  return unless load_loader('loaders/base.rb')

  Dir[File.dirname(__FILE__) + '/../loaders/**/*.rb'].each do |file|
    load_loader(file)
  end
end

def load_loader(loader_path)
  load loader_path
rescue Exception => e
  puts "Loader '#{loader_path.split('/').last[..-4]}' has syntax errors and couldn't be loaded:".red
  puts e.full_message
end

needed_file('loaders/base.rb', 'templates/loader_base.rb')
needed_file('.env', 'templates/.env.example')

Dir[File.dirname(__FILE__) + '/../utils/**/base.rb'].each { |file| require_relative file }
Dir[File.dirname(__FILE__) + '/../utils/**/*.rb'].each { |file| require_relative file }
load_loaders
Dotenv.overload
