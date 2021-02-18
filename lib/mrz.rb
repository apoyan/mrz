require "mrz/version"
require "mrz/parsers/invalid_format_error"
require "mrz/parsers/check_digit"
require "mrz/parsers/result"
require "mrz/parsers/base_parser"
require "mrz/parsers/td1_parser"
require "mrz/parsers/td2_parser"
require "mrz/parsers/td3_parser"
require "mrz/builders/base_builder"
require "mrz/builders/td1_builder"
require "mrz/builders/td2_builder"
require "mrz/builders/td3_builder"

module Mrz

  autoload :Builder, 'mrz/builder'
  autoload :CheckDigit, 'mrz/check_digit'
  autoload :Encoder, 'mrz/encoder'

  module Formatters

    autoload :Base, 'mrz/formatters/base'
    autoload :Date, 'mrz/formatters/date'
    autoload :Name, 'mrz/formatters/name'
    autoload :Type, 'mrz/formatters/type'
    autoload :OptionalData, 'mrz/formatters/optional_data'
    autoload :PassportNumber, 'mrz/formatters/passport_number'
    autoload :PersonalNumber, 'mrz/formatters/personal_number'

  end

  def self.parse(mrz_code)
    case determine_type(mrz_code)
    when :td1
      Parsers::TD1Parser.new(mrz_code).parse
    when :td2
      Parsers::TD2Parser.new(mrz_code).parse
    when :td3
      Parsers::TD3Parser.new(mrz_code).parse
    end
  end

  private

  def self.determine_type(code)
    if code.size == 3
      :td1
    elsif code.size == 2 && code.first.size == 36
      :td2
    elsif code.size == 2 && code.first.size == 44
      :td3
    else
      raise Parsers::InvalidFormatError, "invalid or unsupported mrz code given"
    end
  end

end
