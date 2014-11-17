module Mrz
  module Formatters
    class PersonalNumber < Base

      attr_accessor :personal_number

      def initialize(personal_number)
        @personal_number = personal_number
      end

      def format
        pad_out(personal_number.upcase, 14)
      end

    end
  end
end
