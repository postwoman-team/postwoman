require 'rubygems'
require 'bundler/setup'
require_relative '../utils/loaders/builtin/base'
Bundler.require

def load_loaders
  load 'loaders/base.rb'
  Dir[File.dirname(__FILE__) + '/../loaders/**/*.rb'].each { |file| load file }
end

Dir[File.dirname(__FILE__) + '/../utils/**/*.rb'].each { |file| require_relative file }
load_loaders
ENV.merge!(Dotenv.load)
