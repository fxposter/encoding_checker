# -*- encoding: utf-8 -*-
require File.expand_path('../lib/encoding_checker/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Pavel Forkert"]
  gem.email         = ["fxposter@gmail.com"]
  gem.description   = %q{This gem will helps you identify lines and characters of the text which are invalid for particular encoding}
  gem.summary       = %q{When you need to parse some text files - you need to be sure, that they are in some particular encoding before actually parsing them. For example, some symbols are invalid for UTF-8 encoding, but nevertheless files which are mainly in UTF-8 can contain some invalid characters and many of editors will not show you that. This gem will help you identify lines and characters of the text which are invalid for particular encoding.}
  gem.homepage      = "https://github.com/fxposter/encoding_checker"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "encoding_checker"
  gem.require_paths = ["lib"]
  gem.version       = EncodingChecker::VERSION

  gem.add_development_dependency 'rspec', '~> 2.8.0'
end
