module Mrz
  module Formatters
    class Base

      SEPARATOR = '<'
      
      private

      def pad_out(str, length)
        str = str[0..length-1]
        while str.length < length
          str += SEPARATOR
        end
        str
      end

    end
  end
end
