module Mrz::Builders
  class TD1Builder < BaseBuilder
    attr_accessor :type, :country, :first_name, :last_name, :passport_number, :nationality,
                  :date_of_birth, :gender, :expire_on, :code, :optional_data_1, :optional_data_2

    def initialize(params)
      @code = params[:document_type]
      @type = Mrz::Formatters::Base::SEPARATOR
      @first_name = params[:first_name]
      @last_name = params[:last_name]
      @country = params[:country]
      @passport_number = params[:passport_number]
      @date_of_birth = params[:date_of_birth]
      @gender = params[:gender]
      @expire_on = params[:expire_on]
      @nationality = params[:nationality]
      @optional_data_1 = params[:optional_data_1]
      @optional_data_2 = params[:optional_data_2]
    end

    def generate
      concat_type
      concat_country
      concat_check_digit(concat_passport_number)
      concat_optional_data_1
      concat_check_digit(concat_date_of_birth)
      concat_gender
      concat_check_digit(concat_expire_on)
      concat_nationality
      concat_optional_data_2
      concat_final_check_digit
      concat_name

      [
        code[0..29],
        code[30..59],
        code[60..89]
      ]
    end

    private

    def concat_final_check_digit
      concat(
        calculate_check_digit(
          code[5..29] + code[30..36] + code[38..44] + code[48..58]
        )
      )
    end

    def concat_type
      concat(Mrz::Formatters::Type.new(type, 1).format)
    end

    def concat_optional_data_1
      concat(Mrz::Formatters::OptionalData.new(optional_data_1.to_s, 15).format)
    end

    def concat_optional_data_2
      concat(Mrz::Formatters::OptionalData.new(optional_data_2.to_s, 11).format)
    end

    def concat_name
      concat(Mrz::Formatters::Name.new(first_name, last_name, '').format(30))
    end

  end
end
