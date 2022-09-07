# frozen_string_literal: true

require File.expand_path("./lib/miniswitch/version", __dir__)

Gem::Specification.new do |s|
  s.name        = 'miniswitch'
  s.version     = Miniswitch::VERSION
  s.summary     = 'Set switches for your app'
  s.description = 'Set switches for your app'
  s.author      = "André D. Piske"
  s.email       = 'andrepiske@gmail.com'
  s.homepage    = 'https://github.com/andrepiske/miniswitch'
  s.licenses    = ['Apache-2.0']

  s.files       = Dir.glob([ "lib/**/*.rb" ])

  s.add_runtime_dependency 'oj', '< 4'
  s.add_runtime_dependency 'multi_json', '< 2'
  s.add_runtime_dependency 'redis', '>= 3.0.5'
  s.add_runtime_dependency 'connection_pool', '>= 2.2.2', '< 3'
  # s.add_runtime_dependency 'concurrent-ruby', '~> 1.1.6'
end
