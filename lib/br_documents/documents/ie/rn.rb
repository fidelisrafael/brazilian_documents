# http://www.sintegra.gov.br/Cad_Estados/cad_RN.html
module BRDocuments
  class IE::RN < IE::Base

    set_verify_digits_weights first: %w(9 8 7 6 5 4 3 2)

    set_format_regexp %r{^(20)[.-]?(\d{3})[.-]?(\d{3})[.-]?(\d{1})}

    set_pretty_format_mask %(%s.%s.%s-%s)

    set_fixed_digits [2, 0]

  end
end