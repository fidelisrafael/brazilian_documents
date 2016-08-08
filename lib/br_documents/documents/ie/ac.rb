# http://www.sintegra.gov.br/Cad_Estados/cad_AC.html
module BRDocuments
  class IE::AC < IE::Base
    set_verify_digits_weights first: %w(4 3 2 9 8 7 6 5 4 3 2),
                              last:  %w(5 4 3 2 9 8 7 6 5 4 3 2)

    set_valid_format_regexp %r{^(01)[-.]?(\d{3})[-.]?(\d{3})[\/-]?(\d{3})[-.]?(\d{2})}

    set_pretty_format_mask %(%s.%s.%s/%s-%s)

    set_fixed_initial_numbers [0, 1]
  end
end

