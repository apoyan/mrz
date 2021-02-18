module Mrz::Builders
  class BaseBuilder
    private

    def calculate_check_digit(str)
      Mrz::CheckDigit.new(str).calculate
    end

    def concat_personal_number
      concat(Mrz::Formatters::PersonalNumber.new(personal_number.to_s).format)
    end

    def concat_expire_on
      concat(Mrz::Formatters::Date.new(expire_on).format)
    end

    def concat_gender
      concat(gender.upcase)
    end

    def concat_date_of_birth
      concat(Mrz::Formatters::Date.new(date_of_birth).format)
    end

    def concat_nationality
      concat(nationality.upcase)
    end

    def concat_check_digit(str)
      concat(calculate_check_digit(str))
    end

    def concat_passport_number
      concat(Mrz::Formatters::PassportNumber.new(passport_number).format)
    end

    def concat_country
      concat(country.upcase)
    end

    def concat(str)
      @code += str.to_s
      str
    end
  end
end
