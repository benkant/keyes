# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'keyes/version'

Gem::Specification.new do |gem|
  gem.name          = "keyes"
  gem.version       = Keyes::VERSION
  gem.authors       = ["Ben Giles"]
  gem.email         = ["ben@pin.net.au"]
  gem.description   = %q{Keyes is an exceedingly trivial fraud detector service}
  gem.summary       = %q{Keyes is a fraud detector}
  gem.homepage      = "https://github.com/pinpayments/keyes"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
