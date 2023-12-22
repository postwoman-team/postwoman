require 'rubygems'
require 'io/console'
require 'awesome_print'
require 'byebug'
require 'colorize'
require 'debug'
require 'faraday'
require 'faraday/typhoeus'
require 'fileutils'
require 'i18n'
require 'json'
require 'nokogiri'
require 'nori'
require 'pry-byebug'
require 'readline'
require 'rspec'
require 'rubocop'
require 'rubycritic'
require 'strscan'
require 'tabelinha'
require 'terminal-table'
require 'yaml'

require_relative 'postwoman_loader'

Dir["#{__dir__}/**/base.rb"].each { |file| require_relative file }
Dir["#{__dir__}/**/*.rb"].each { |file| require_relative file }

I18n.load_path += Dir["#{__dir__}/locales/**/*.yml"]
