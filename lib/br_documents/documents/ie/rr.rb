# http://www.sintegra.gov.br/Cad_Estados/cad_RR.html
module BRDocuments
  class IE::RR < IE::Base
    set_division_factor_modulo 9

    set_verify_digits_weights first: %w(1 2 3 4 5 6 7 8)

    set_valid_format_regexp %r{^(\d{8})[-.]?(\d{1})}

    set_pretty_format_mask %(%s-%s)

    set_fixed_initial_numbers [2, 4]

    class << self
      def digit_verify(quotient_rest, division_factor)
        quotient_rest
      end
    end
  end
end