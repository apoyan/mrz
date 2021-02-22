require "date"

module Mrz::Parsers
  class Result
    attr_reader :birth_date_check_digit, :composite_check_digit,
                :document_type, :document_number, :document_number_check_digit,
                :expire_date_check_digit, :first_name, :country, :expire_date,
                :last_name, :nationality, :optional, :optional2, :personal_code

    def initialize(opts = {})
      @birth_date = opts.fetch(:birth_date)
      @birth_date_check_digit = opts.fetch(:birth_date_check_digit)
      @composite_check_digit = opts.fetch(:composite_check_digit)
      @document_type = opts.fetch(:document_type)
      @document_number = opts.fetch(:document_number)
      @document_number_check_digit = opts.fetch(:document_number_check_digit)
      @expire_date = opts.fetch(:expire_date)
      @expire_date_check_digit = opts.fetch(:expire_date_check_digit)
      @first_name = opts.fetch(:first_name)
      @country = opts.fetch(:country)
      @last_name = opts.fetch(:last_name)
      @nationality = opts.fetch(:nationality)
      @optional = opts.fetch(:optional)
      @optional2 = opts.fetch(:optional2)
      @gender = opts.fetch(:gender)
      @type = opts.fetch(:type)
    end

    def to_h
      as_json.symbolize_keys.merge!(
        birth_date: birth_date,
        expire_date: expire_date,
        gender: gender
      )
    end

    def birth_date
      @_birth_date ||= begin
                         year = @birth_date[0..1].to_i
                         month = @birth_date[2..3].to_i
                         day = @birth_date[4..5].to_i

                         Date.new(add_correct_century(year), month, day)
                       end
    end

    def expire_date
      @_expire_date ||= Date.strptime(@expire_date, "%y%m%d")
    end

    def gender
      @_gender ||= @gender == "" ? "nonspecified" : @gender
    end

    def add_correct_century(year)
      if (Date.today.year - (1900 + year)) >= 100
        2000 + year
      else
        1900 + year
      end
    end

    def valid?
      @_valid ||= begin
                    valid_birth_date? && valid_expire_date? && valid_document_number? && valid_composite_digit?
                  end
    end

    def valid_birth_date?
      @_valid_birth_date ||= CheckDigit.calculate(@birth_date).to_s == @birth_date_check_digit
    end

    def valid_expire_date?
      @_valid_expire_date ||= CheckDigit.calculate(@expire_date).to_s == @expire_date_check_digit
    end

    def valid_document_number?
      @_valid_document_number ||= CheckDigit.calculate(@document_number).to_s == @document_number_check_digit
    end

    private

    def valid_composite_digit?
      if @type == :td1
        CheckDigit.calculate(
          @document_number + @document_number_check_digit +
            @optional + @birth_date + @birth_date_check_digit +
            @expire_date + @expire_date_check_digit +
            @optional2
        ).to_s == @composite_check_digit
      elsif [:td2, :td3].include?(@type)
        CheckDigit.calculate(
          @document_number + @document_number_check_digit +
            @birth_date + @birth_date_check_digit +
            @expire_date + @expire_date_check_digit +
            @optional + @optional2
        ).to_s == @composite_check_digit
      else
        raise InvalidFormatError, "Unknown format type"
      end
    end
  end
end
