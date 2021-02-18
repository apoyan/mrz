module Mrz::Builders
  class TD2Builder < BaseBuilder
    attr_accessor :type, :country, :first_name, :last_name, :passport_number, :nationality,
                  :date_of_birth, :gender, :expire_on, :code, :optional_data

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
      @optional_data = params[:optional_data]
    end

    def generate
      concat_type
      concat_country
      concat_name
      concat_check_digit(concat_passport_number)
      concat_nationality
      concat_check_digit(concat_date_of_birth)
      concat_gender
      concat_check_digit(concat_expire_on)
      concat_optional_data
      concat_final_check_digit

      [
        code[0..35],
        code[36..71],
      ]
    end

    private

    def concat_final_check_digit
      concat(
        calculate_check_digit(
          code[36..45] + code[49..55] + code[57..70]
        )
      )
    end

    def concat_type
      concat(Mrz::Formatters::Type.new(type, 1).format)
    end

    def concat_optional_data
      concat(Mrz::Formatters::OptionalData.new(optional_data.to_s, 7).format)
    end

    def concat_name
      concat(Mrz::Formatters::Name.new(first_name, last_name, '').format(31))
    end

  end
end
