require 'rubygems'
require 'io/console'

bundle_check = `bundle check`.chomp
if bundle_check != "The Gemfile's dependencies are satisfied"
  puts bundle_check
  print 'Install? [Yn] '
  if $stdin.getch == 'n'
    puts 'Exiting...'
    exit
  end
  puts 'Installing...'

  puts `bundle install`
end

require 'bundler/setup'
Bundler.require
require_relative '../utils/loaders/builtin/base'

Dir[File.dirname(__FILE__) + '/../utils/**/base.rb'].each { |file| require_relative file }
Dir[File.dirname(__FILE__) + '/../utils/**/*.rb'].each { |file| require_relative file }
DynamicDependencies.load_loaders

I18n.load_path += Dir[File.dirname(__FILE__) + '/../utils/locales/**/*.yml']
