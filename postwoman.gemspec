Gem::Specification.new do |s|
  s.name        = 'postwoman'
  s.version     = '0.0.0'
  s.required_ruby_version = '>= 3.0.0'
  s.summary     = '100% CLI API platform'
  s.description = 'Make your API requests better with postwoman'
  s.authors     = ['Hikari Luz']
  s.email       = 'hikaridesuyoo@gmail.com'
  s.executables = ['postwoman']
  s.files       = Dir['lib/**/*']
  s.license     = 'GPL-3.0'
  s.add_dependency 'awesome_print', '~> 1.9.2'
  s.add_dependency 'colorize', '~> 1.1.0'
  s.add_dependency 'debug', '~> 1.9.1'
  s.add_dependency 'faraday', '~> 2.7.12'
  s.add_dependency 'faraday-typhoeus', '~> 1.0.0'
  s.add_dependency 'i18n', '~> 1.14.1'
  s.add_dependency 'json', '~> 2.7.1'
  s.add_dependency 'nokogiri', '~> 1.15.5'
  s.add_dependency 'nori', '~> 2.6.0'
  s.add_dependency 'pry-byebug', '~> 3.10.1'
  s.add_dependency 'readline', '~> 0.0.3'
  s.add_dependency 'strscan', '~> 3.0.7'
  s.add_dependency 'tabelinha', '~> 1.0'
  s.add_dependency 'terminal-table', '~> 3.0.2'
  s.add_dependency 'yaml', '~> 0.2.1'
end
