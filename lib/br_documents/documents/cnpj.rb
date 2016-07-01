require "digit_checksum"

module BRDocuments
  class CNPJ < ::DigitChecksum::BaseDocument
    digits_verify_mask first:  %w(5 4 3 2 9 8 7 6 5 4 3 2),
                       second: %w(6 5 4 3 2 9 8 7 6 5 4 3 2)

    # MOD 11
    division_factor_modulo 11

    # remove any non digit from document number
    clear_number_regexp %r{[^(\d+)]}

    # match format such as: 99.999.999/9999-99 | 99-999-999/9999-99 | 99999999/999999 | 99999999999999
    valid_format_regexp %r{(\d{2})[-.]?(\d{3})[-.]?(\d{3})[\/]?(\d{4})[-.]?(\d{2})}

    pretty_format_mask %(%s.%s.%s/%s-%s)
  end
end