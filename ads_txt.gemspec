# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
puts lib
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ads_txt/version'

Gem::Specification.new do |spec|
  spec.name          = "ads_txt"
  spec.version       = AdsTxt::VERSION
  spec.authors       = ["Geronimo Diaz"]
  spec.email         = ["geronimod@gmail.com"]
  spec.summary       = %q{Ads.txt Parser}
  spec.description   = %q{Parses content according to ads.txt specification https://iabtechlab.com/ads-txt/ }
  spec.homepage      = "https://github.com/geronimod/ads_txt"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.8"
end
