# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rdepend/version'

Gem::Specification.new do |spec|
  spec.name          = 'rdepend'
  spec.version       = Rdepend::VERSION
  spec.authors       = ['jarra']
  spec.email         = ['suhrawardi@gmail.com']
  spec.summary       = %q(generates a graph visualization of the dependencies in your codebase)
  spec.description   = %q(a work in progress, use it at your own risk)
  spec.homepage      = 'https://github.com/suhrawardi/rdepend'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r(^bin/)) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r(^(test|spec|features)/))
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_dependency 'ruby-graphviz'
  spec.add_dependency 'ruby-prof'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end
