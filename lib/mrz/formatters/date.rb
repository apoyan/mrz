module Mrz
  module Formatters
    class Date < Struct.new(:date)

      def format
        year = date.year.to_s[2..3]
        month = "%02d" % date.month
        day = "%02d" % date.day

        year + month + day
      end

    end
  end
end
