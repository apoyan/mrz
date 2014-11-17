module Mrz
  module Formatters
    class PersonalNumber < Base

      PAD_OUT_TO = 14

      attr_accessor :personal_number

      def initialize(personal_number)
        @personal_number = personal_number
      end

      def format
        pad_out(personal_number.upcase, PAD_OUT_TO)
      end

    end
  end
end
