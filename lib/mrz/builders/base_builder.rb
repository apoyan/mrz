module Mrz::Builders
  class BaseBuilder
    private

    def calculate_check_digit(str)
      Mrz::CheckDigit.new(str).calculate
    end

    def concat_personal_code
      concat(Mrz::Formatters::PersonalNumber.new(personal_code.to_s).format)
    end

    def concat_expire_date
      concat(Mrz::Formatters::Date.new(expire_date).format)
    end

    def concat_gender
      concat(gender.upcase)
    end

    def concat_birth_date
      concat(Mrz::Formatters::Date.new(birth_date).format)
    end

    def concat_nationality
      concat(nationality.upcase)
    end

    def concat_check_digit(str)
      concat(calculate_check_digit(str))
    end

    def concat_document_number
      concat(Mrz::Formatters::PassportNumber.new(document_number).format)
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
