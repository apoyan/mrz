module Mrz::Parsers
  class TD2Parser < BaseParser
    FORMAT_ONE = /\A(.{2})(.{3})([^<]+)<<(.*)\z/
    FORMAT_TWO = /\A(.{9})(\d)(.{3})(\d{6})(\d)(.)(\d{6})(.)(.{7})(.)\z/

    def initialize(code_ary)
      @code = code_ary
      @one = code_ary[0]
      @two = code_ary[1]
    end

    def parse
      if @code.size != 2
        raise InvalidFormatError, "td2 requires two mrz lines"
      end

      line_one_matches = FORMAT_ONE.match(@one)
      line_two_matches = FORMAT_TWO.match(@two)

      if @one.size != 36 || line_one_matches.nil?
        raise InvalidFormatError, "td2 first line does not match the required format"
      end

      if line_two_matches.nil?
        raise InvalidFormatError, "td2 second line does not match the required format"
      end

      Result.new(
        birth_date: line_two_matches[4],
        birth_date_check_digit: line_two_matches[5],
        composite_check_digit: line_two_matches[10],
        document_type: special_char_to_empty_space(line_one_matches[1]),
        document_number: special_char_to_empty_space(line_two_matches[1]),
        document_number_check_digit: line_two_matches[2],
        expire_date: line_two_matches[7],
        expire_date_check_digit: line_two_matches[8],
        first_name: special_char_to_white_space(line_one_matches[4]).strip,
        country: special_char_to_empty_space(line_one_matches[2]),
        last_name: line_one_matches[3],
        nationality: special_char_to_empty_space(line_two_matches[3]),
        personal_code: "",
        optional: special_char_to_empty_space(line_two_matches[9]),
        optional2: "",
        gender: special_char_to_empty_space(line_two_matches[6]),
        type: :td2,
      ).to_h
    end
  end
end
