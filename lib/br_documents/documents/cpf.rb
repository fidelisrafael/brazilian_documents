require "digit_checksum"

module BRDocuments
  class CPF < ::DigitChecksum::BaseDocument
    digits_verify_mask first:  %w(10 9 8 7 6 5 4 3 2),
                       second: %w(11 10 9 8 7 6 5 4 3 2)

    # MOD 11
    division_factor_modulo 11

    # remove any non digit from document number
    clear_number_regexp %r{[^(\d+)]}

    # match format such as: 999.999.999-99 | 999-999-999-99 | 99999999999
    valid_format_regexp %r{(\d{3})[-.]?(\d{3})[-.]?(\d{3})[-.]?(\d{2})}

    # mask utilized to prettify doc number
    pretty_format_mask %(%s.%s.%s-%s)

    # numbers sampled to generate new document numbers
    generator_numbers (0..9).to_a
  end
end