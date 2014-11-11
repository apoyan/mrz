module Mrz
  class Builder

    PASSPORT_CODE = 'P'
    SEPARATOR = '<'

    attr_accessor :type, :country, :first_name, :last_name, :passport_number, :nationality,
                  :date_of_birth, :sex, :expiration_date, :personal_number, :code

    def initialize(params)
      @code = PASSPORT_CODE
      @type = SEPARATOR
      @country = params[:country]
      @first_name = params[:first_name]
      @last_name = params[:last_name]
      @passport_number = params[:passport_number]
      @nationality = params[:nationality]
      @date_of_birth = params[:date_of_birth]
      @sex = params[:sex]
      @expiration_date = params[:expiration_date]
      @personal_number = params[:personal_number]
    end

    def generate
      concat_type
      concat_country
      concat_name
      concat_check_digit(concat_passport_number)
      concat_nationality
      concat_check_digit(concat_date_of_birth)
      concat_sex
      concat_check_digit(concat_expiration_date)
      concat_check_digit(concat_personal_number)
      concat_final_check_digit

      [code[0..43], code[44..87]]
    end

    private

    def concat_final_check_digit
      concat(calculate_check_digit(code[44..53] + code[57..63] + code[65..86]))
    end

    def calculate_check_digit(str)
      CheckDigit.new(str).calculate
    end

    def concat_personal_number
      concat(pad_out(personal_number.upcase, 14))
    end

    def concat_expiration_date
      concat(format_date(expiration_date))
    end

    def concat_sex
      concat(sex.upcase)
    end

    def concat_date_of_birth
      concat(format_date(date_of_birth))
    end

    def format_date(date)
      year = date.year.to_s[2..3]
      month = "%02d" % date.month
      day = "%02d" % date.day

      year + month + day
    end

    def concat_nationality
      concat(nationality.upcase)
    end

    def concat_check_digit(str)
      concat(calculate_check_digit(str))
    end

    def concat_passport_number
      concat(pad_out(passport_number.upcase, 9))
    end

    def concat_name
      name = remove_empty_chars(last_name + SEPARATOR * 2 + first_name).upcase
      name = Encoder.new(name).convert
      concat(pad_out(name, 39))
    end

    def pad_out(str, length)
      str = str[0..length-1]
      while str.length < length
        str += SEPARATOR
      end
      str
    end

    def remove_empty_chars(str)
      str.gsub(' ', SEPARATOR)
    end

    def concat_country
      concat(country.upcase)
    end

    def concat_type
      concat(type.upcase)
    end

    def concat(str)
      @code += str.to_s
      str
    end

  end
end
