module Mrz
  module Formatters
    class OptionalData < Base
      attr_accessor :optional_data, :pad_out_to

      def initialize(optional_data, pad_out_to)
        @optional_data = optional_data
        @pad_out_to = pad_out_to
      end

      def format
        pad_out(optional_data.upcase, pad_out_to)
      end

    end
  end
end
