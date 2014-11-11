module Mrz
  class Encoder < Struct.new(:str)

    MAP = {
      'Ä' => 'AE',
      'Å' => 'AA',
      'Æ' => 'AE',
      'Ĳ' => 'IJ',
      'Ñ' => 'N',
      'Ö' => 'OE',
      'Ø' => 'OE',
      'Ü' => 'UE',
      'ß' => 'SS'
    }

    def convert
      MAP.each_pair do |k, v|
        str.gsub!(k, v)
      end
      str
    end

  end
end
