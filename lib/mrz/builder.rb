module Mrz
  class Builder

    PASSPORT_CODE = 'P'
    FIRST_LINE_START = 0
    FIRST_LINE_END = 43
    SECOND_LINE_START = 44
    SECOND_LINE_END = 87

    CD_START1 = 44
    CD_START2 = 57
    CD_START3 = 65
    CD_END1 = 53
    CD_END2 = 63
    CD_END3 = 86

    attr_accessor :type, :country, :first_name, :last_name, :passport_number, :nationality,
                  :date_of_birth, :gender, :expiration_date, :personal_number, :code

    def initialize(params)
      @code = PASSPORT_CODE
      @type = Formatters::Base::SEPARATOR
      @country = params[:country]
      @first_name = params[:first_name]
      @last_name = params[:last_name]
      @passport_number = params[:passport_number]
      @nationality = params[:nationality]
      @date_of_birth = params[:date_of_birth]
      @gender = params[:gender]
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
      concat_gender
      concat_check_digit(concat_expiration_date)
      concat_check_digit(concat_personal_number)
      concat_final_check_digit

      [code[FIRST_LINE_START..FIRST_LINE_END], code[SECOND_LINE_START..SECOND_LINE_END]]
    end

    private

    def concat_final_check_digit
      concat(
        calculate_check_digit(
          code[CD_START1..CD_END1] + code[CD_START2..CD_END2] + code[CD_START3..CD_END3]
        )
      )
    end

    def calculate_check_digit(str)
      CheckDigit.new(str).calculate
    end

    def concat_personal_number
      concat(Formatters::PersonalNumber.new(personal_number).format)
    end

    def concat_expiration_date
      concat(Formatters::Date.new(expiration_date).format)
    end

    def concat_gender
      concat(gender.upcase)
    end

    def concat_date_of_birth
      concat(Formatters::Date.new(date_of_birth).format)
    end

    def concat_nationality
      concat(nationality.upcase)
    end

    def concat_check_digit(str)
      concat(calculate_check_digit(str))
    end

    def concat_passport_number
      concat(Formatters::PassportNumber.new(passport_number).format)
    end

    def concat_name
      concat(Formatters::Name.new(first_name, last_name).format)
    end

    def concat_country
      concat(country.upcase)
    end

    def concat_type
      concat(type)
    end

    def concat(str)
      @code += str.to_s
      str
    end

  end
end
