module Mrz
  module Formatters
    class Type < Base
      attr_accessor :type, :pad_out_to

      def initialize(type, pad_out_to)
        @type = type
        @pad_out_to = pad_out_to
      end

      def format
        pad_out(type.upcase, pad_out_to)
      end

    end
  end
end
