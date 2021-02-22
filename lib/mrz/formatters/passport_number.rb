module Mrz
  module Formatters
    class PassportNumber < Base

      PAD_OUT_TO = 9

      attr_accessor :document_number

      def initialize(document_number)
        @document_number = document_number
      end

      def format
        pad_out(document_number.upcase, PAD_OUT_TO)
      end

    end
  end
end
