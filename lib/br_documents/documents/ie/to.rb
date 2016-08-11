# http://www.sintegra.gov.br/Cad_Estados/cad_TO.html
module BRDocuments
  class IE::TO < IE::Base
    set_verify_digits_weights first: %w(9 8 7 6 5 4 3 2)

    set_format_regexp %r{^(\d{2})[-.]?(\d{3})[-.]?(\d{3})[-.]?(\d{1})}

    set_pretty_format_mask %(%s.%s.%s-%s)

    set_fixed_initial_numbers [2, 9]
  end
end