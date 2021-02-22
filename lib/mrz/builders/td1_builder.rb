module Mrz::Builders
  class TD1Builder < BaseBuilder
    attr_accessor :type, :country, :first_name, :last_name, :document_number, :nationality,
                  :birth_date, :gender, :expire_date, :code, :optional_data, :optional_data_2

    def initialize(params)
      @code = params[:document_type]
      @type = Mrz::Formatters::Base::SEPARATOR
      @first_name = params[:first_name]
      @last_name = params[:last_name]
      @country = params[:country]
      @document_number = params[:document_number]
      @birth_date = params[:birth_date]
      @gender = params[:gender]
      @expire_date = params[:expire_date]
      @nationality = params[:nationality]
      @optional_data = params[:optional]
      @optional_data_2 = params[:optional2]
    end

    def generate
      concat_type
      concat_country
      concat_check_digit(concat_document_number)
      concat_optional_data
      concat_check_digit(concat_birth_date)
      concat_gender
      concat_check_digit(concat_expire_date)
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

    def concat_optional_data
      concat(Mrz::Formatters::OptionalData.new(optional_data.to_s, 15).format)
    end

    def concat_optional_data_2
      concat(Mrz::Formatters::OptionalData.new(optional_data_2.to_s, 11).format)
    end

    def concat_name
      concat(Mrz::Formatters::Name.new(first_name, last_name, '').format(30))
    end

  end
end
