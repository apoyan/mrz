module Mrz
  class CheckDigit < Struct.new(:str)

    MAP = {
      '<' => 0, 'A' => 10, 'B' => 11, 'C' => 12, 'D' => 13, 'E' => 14,
      'F' => 15, 'G' => 16, 'H' => 17, 'I' => 18, 'J' => 19, 'K' => 20,
      'L' => 21, 'M' => 22, 'N' => 23, 'O' => 24, 'P' => 25, 'Q' => 26,
      'R' => 27, 'S' => 28, 'T' => 29, 'U' => 30, 'V' => 31, 'W' => 32,
      'X' => 33, 'Y' => 34, 'Z' => 35
    }

    WEIGHTS = [7, 3, 1]

    def calculate
      sum = 0
      i = 0
      str.chars.each do |char|
        sum += weight(i) * value(char)
        i += 1
      end
      div, mod = sum.divmod(10)
      mod
    end

    private

    def value(input)
      if input.match(/\d/)
        input.to_i
      else
        MAP[input]
      end
    end

    def weight(i)
      WEIGHTS[i % 3]
    end
  end
end
