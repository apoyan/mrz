require "mrz/version"

module Mrz

  autoload :Builder, 'mrz/builder'
  autoload :CheckDigit, 'mrz/check_digit'
  autoload :Encoder, 'mrz/encoder'

  module Formatters

    autoload :Base, 'mrz/formatters/base'
    autoload :Date, 'mrz/formatters/date'
    autoload :Name, 'mrz/formatters/name'
    autoload :PassportNumber, 'mrz/formatters/passport_number'
    autoload :PersonalNumber, 'mrz/formatters/personal_number'
    
  end

end
