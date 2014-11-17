module Mrz
  module Formatters
    class PassportNumber < Base

      PAD_OUT_TO = 9

      attr_accessor :passport_number

      def initialize(passport_number)
        @passport_number = passport_number
      end

      def format
        pad_out(passport_number.upcase, PAD_OUT_TO)
      end

    end
  end
end
