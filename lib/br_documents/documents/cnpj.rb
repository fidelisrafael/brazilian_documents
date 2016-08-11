module BRDocuments
  class CNPJ < ::DigitChecksum::BaseDocument
    set_verify_digits_weights first:  %w(5 4 3 2 9 8 7 6 5 4 3 2),
                              second: %w(6 5 4 3 2 9 8 7 6 5 4 3 2)

    # MOD 11
    set_division_modulo 11

    # remove any non digit from document number
    set_clear_number_regexp %r{[^(\d+)]}

    # match format such as: 99.999.999/9999-99 | 99-999-999/9999-99 | 99999999/999999 | 99999999999999
    set_format_regexp %r{(\d{2})[-.]?(\d{3})[-.]?(\d{3})[\/]?(\d{4})[-.]?(\d{2})}

    set_pretty_format_mask %(%s.%s.%s/%s-%s)

    # numbers sampled to generate new document numbers
    set_generator_numbers (0..9).to_a
  end
end