# http://www.sintegra.gov.br/Cad_Estados/cad_AL.html
module BRDocuments
  class IE::AL < IE::Base
    digits_verify_mask first: %w(9 8 7 6 5 4 3 2)

    valid_format_regexp %r{(24)[-.]?(\d{6})[-.]?(\d{1})}

    # mask utilized to prettify doc number
    pretty_format_mask %(%s.%s-%s)

    FIXED_INITIAL_NUMBERS = [2, 4].freeze

    class << self
      def calculate_digits_sum_rest(sum, quotient, division_factor)
        (sum - (quotient.to_i * division_factor))
      end

      def digit_verify(quotient_rest, division_factor)
        return [10].member?(quotient_rest.to_i) ? 0 : quotient_rest
      end

      def calculate_digits_sum(document_number, mask)
        (super * 10)
      end
    end
  end
end

