require 'rubygems'
require 'bundler/setup'
require_relative '../utils/loaders/builtin/base'
Bundler.require

def create_loader_base_unless_exists
  path = 'loaders/base.rb'
  return if File.exist?(path)

  File.open(path, 'w') do |f|
    f.write(File.read('templates/loader_base.rb'))
  end
end

def load_loaders
  load 'loaders/base.rb'
  Dir[File.dirname(__FILE__) + '/../loaders/**/*.rb'].each { |file| load file }
end

create_loader_base_unless_exists
Dir[File.dirname(__FILE__) + '/../utils/**/base.rb'].each { |file| require_relative file }
Dir[File.dirname(__FILE__) + '/../utils/**/*.rb'].each { |file| require_relative file }
load_loaders
ENV.merge!(Dotenv.load)
