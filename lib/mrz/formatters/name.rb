module Mrz
  module Formatters
    class Name < Base

      PAD_OUT_TO = 39
      
      attr_accessor :first_name, :last_name

      def initialize(first_name, last_name)
        @first_name = first_name
        @last_name = last_name
      end

      def format
        name = remove_empty_chars(last_name + SEPARATOR * 2 + first_name).upcase
        name = Encoder.new(name).convert
        pad_out(name, PAD_OUT_TO)
      end

      private

      def remove_empty_chars(str)
        str.gsub(' ', SEPARATOR)
      end

    end
  end
end
