# EncodingChecker

[![Build Status](https://secure.travis-ci.org/fxposter/encoding_checker.png?branch=master)](http://travis-ci.org/fxposter/encoding_checker)

When you need to parse some text files - you need to be sure, that they are in some particular encoding
before actually parsing them. For example, some symbols are invalid for UTF-8 encoding, but nevertheless
files which are mainly in UTF-8 can contain some invalid characters and many of editors will not show you that.
This gem will help you identify lines and characters of the text which are invalid for particular encoding.

## Installation

This gem relies on encoding information, which is available only in Ruby 1.9.x.
Maybe sometimes I'll add 1.8.x support through iconv library, but for now 1.8.x is not supported.

Add this line to your application's Gemfile:

  gem 'encoding_checker'

And then execute:

  $ bundle

Or install it yourself as:

  $ gem install encoding_checker

## Usage

  # instantiate checker with encoding name
  checker = EncodingChecker.new("utf-8")
  # check any particular text
  result = checker.check("some string with wrong\xA0symbol")

  unless result.empty?
    result.invalid_lines.each do |line|
      # use line.content, line.index and line.invalid_characters
      line.invalid_characters.each do |character|
        # use character.content and character.index
      end
    end
  end

  # raises EncodingChecker::Error
  checker.check!("some string with wrong\xA0symbol")

Read the specs for more information.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
