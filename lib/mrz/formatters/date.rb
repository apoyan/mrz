module Mrz
  module Formatters
    class Date < Struct.new(:date)

      TWO_DIGITS = "%02d"

      def format

        year = date.year.to_s[2..3]
        month = TWO_DIGITS % date.month
        day = TWO_DIGITS % date.day

        year + month + day
      end

    end
  end
end
