# encoding: utf-8

require "encoding_checker/version"

# checker = EncodingChecker.new("utf-8")
# checker.check!("some string with wrong\xA0symbol")
class EncodingChecker
  def initialize(encoding)
    @encoding = encoding
  end

  def check(string)
    string = string.dup
    string.force_encoding(@encoding)
    return Match.new(@encoding, []) if string.valid_encoding?
    errors = []
    string.each_line.with_index do |line, line_index|
      unless line.valid_encoding?
        line_errors = []
        line.each_char.with_index do |char, index|
          unless char.valid_encoding?
            line_errors << CharacterMatch.new(index, char)
          end
        end
        errors << LineMatch.new(line_index, line.strip, line_errors)
      end
    end
    Match.new(@encoding, errors)
  end

  def check!(string)
    check(string).tap do |match|
      raise Error, match unless match.empty?
    end
  end

  class Match < Struct.new(:encoding, :invalid_lines)
    def empty?
      invalid_lines.empty?
    end

    def to_s
      invalid_lines.map { |line|
        result = %(#{encoding.to_s.upcase} error on line #{line}"\n)
        result << 'Invalid characters: ' << line.invalid_characters.join(', ') << "\n"
        result
      }.join("\n")
    end
  end

  class LineMatch < Struct.new(:index, :content, :invalid_characters)
    def to_s
      %(#{index}: "#{content.force_encoding('utf-8')}")
    end
  end

  class CharacterMatch < Struct.new(:index, :content)
    def to_s
      "#{content.inspect} (#{index})"
    end
  end

  class Error < RuntimeError
    attr_reader :result

    def initialize(result)
      @result = result
      super
    end
  end
end
