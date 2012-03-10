# encoding: utf-8
require 'spec_helper'

describe EncodingChecker do
  let(:checker) { EncodingChecker.new("utf-8") }
  let(:valid_string) { "some string with only_right symbols" }
  let(:invalid_symbol) { "\xA0" }
  let(:invalid_string) { "some string with wrong#{invalid_symbol}symbol" }
  let(:invalid_text) { [valid_string, invalid_string].join("\n") }

  describe '#check(string)' do
    it 'returns result which contains invalid lines and characters in them' do
      result = checker.check(invalid_text)
      result.should_not be_empty

      result.invalid_lines.should have(1).element
      invalid_line = result.invalid_lines[0]
      check_line(invalid_line, invalid_string, 1)

      invalid_line.invalid_characters.should have(1).element
      invalid_character = invalid_line.invalid_characters[0]
      check_character(invalid_character, invalid_symbol, 22)
    end

    it 'returns empty result when a string is in the specified encoding' do
      checker = EncodingChecker.new("utf-8")
      result = checker.check(valid_string)
      result.should be_empty
      result.invalid_lines.should be_empty
    end
  end

  describe '#check!(string)' do
    it 'raises EncodingChecker::Error when errors are present' do
      expect {
        checker.check!(invalid_string)
      }.to raise_error(EncodingChecker::Error)
    end

    it 'raises EncodingChecker::Error which contains invalid lines when errors are present' do
      begin
        checker.check!(invalid_string)
      rescue EncodingChecker::Error => e
        e.result.should_not be_nil
        e.result.invalid_lines.should have(1).element
      end
    end

    it 'returns true when no errors are present' do
      checker.check!(valid_string).should be_true
    end
  end

  def check_line(line, content, index)
    line.content.should == content
    line.index.should == index
  end

  def check_character(character, content, index)
    character.content.should == content
    character.index.should == index
  end
end
