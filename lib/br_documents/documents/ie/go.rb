# http://www.sintegra.gov.br/Cad_Estados/cad_GO.html
module BRDocuments
  class IE::GO < IE::Base
    set_verify_digits_weights first: %w(9 8 7 6 5 4 3 2)

    set_format_regexp %r{^(10)[.-]?(\d{3})[.-]?(\d{3})[.-]?(\d{1})}

    set_pretty_format_mask %(%s.%s.%s-%s)

    set_fixed_digits [1, 0]
  end
end