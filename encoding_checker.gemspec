# -*- encoding: utf-8 -*-
require File.expand_path('../lib/encoding_checker/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Pavel Forkert"]
  gem.email         = ["fxposter@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "encoding_checker"
  gem.require_paths = ["lib"]
  gem.version       = EncodingChecker::VERSION

  gem.add_development_dependency 'rspec', '~> 2.8.0'
end
