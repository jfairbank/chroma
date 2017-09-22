# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chroma/version'

Gem::Specification.new do |spec|
  spec.name          = 'chroma'
  spec.version       = Chroma::VERSION
  spec.authors       = ['Jeremy Fairbank']
  spec.email         = ['elpapapollo@gmail.com']
  spec.summary       = %q{Color manipulation and palette generation.}
  spec.description   = %q{Chroma is a color manipulation and palette generation gem.}
  spec.homepage      = 'https://github.com/jfairbank/chroma'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.6.0'
end
