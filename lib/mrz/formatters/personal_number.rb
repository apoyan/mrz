module Mrz
  module Formatters
    class PersonalNumber < Base

      PAD_OUT_TO = 14

      attr_accessor :personal_code

      def initialize(personal_code)
        @personal_code = personal_code
      end

      def format
        pad_out(personal_code.upcase, PAD_OUT_TO)
      end

    end
  end
end
