module BRDocuments
  class CPF < ::DigitChecksum::BaseDocument
    set_verify_digits_weights first:  %w(10 9 8 7 6 5 4 3 2),
                              second: %w(11 10 9 8 7 6 5 4 3 2)

    # MOD 11
    set_division_modulo 11

    # remove any non digit from document number
    set_clear_number_regexp %r{[^(\d+)]}

    # match format such as: 999.999.999-99 | 999-999-999-99 | 99999999999
    set_format_regexp %r{(\d{3})[-.]?(\d{3})[-.]?(\d{3})[-.]?(\d{2})}

    set_pretty_format_mask %(%s.%s.%s-%s)

    # numbers sampled to generate new document numbers
    set_generator_numbers (0..9).to_a

    def valid?
      # This avoid numbers like: "000.000.000-00" being calculate as valid
      return false if normalize.uniq.size == 1

      super
    end
  end
end