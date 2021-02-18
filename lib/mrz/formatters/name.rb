module Mrz
  module Formatters
    class Name < Base

      attr_accessor :first_name, :last_name

      def initialize(first_name, last_name, middle_name = nil)
        @first_name = general_first_name(first_name, middle_name)
        @last_name = last_name
      end

      def format(pad_out_to)
        name = remove_empty_chars(last_name + SEPARATOR * 2 + first_name).upcase
        name = Encoder.new(name).convert
        pad_out(name, pad_out_to)
      end

      private

      def remove_empty_chars(str)
        str.gsub(' ', SEPARATOR)
      end

      def general_first_name(first_name, middle_name)
        [first_name, middle_name].compact.join ' '
      end

    end
  end
end
