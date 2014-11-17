module Mrz
  module Formatters
    class PassportNumber < Base

      attr_accessor :passport_number

      def initialize(passport_number)
        @passport_number = passport_number
      end

      def format
        pad_out(passport_number.upcase, 9)
      end

    end
  end
end
