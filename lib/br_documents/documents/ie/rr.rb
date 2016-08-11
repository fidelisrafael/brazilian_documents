# http://www.sintegra.gov.br/Cad_Estados/cad_RR.html
module BRDocuments
  class IE::RR < IE::Base
    set_division_modulo 9

    set_verify_digits_weights first: %w(1 2 3 4 5 6 7 8)

    set_format_regexp %r{^(24)[-.]?(\d{6})[-.]?(\d{1})}

    set_pretty_format_mask %(%s.%s-%s)

    set_fixed_digits [2, 4]

    def calc_verify_digit(quotient_rest)
      quotient_rest.to_i
    end
  end
end