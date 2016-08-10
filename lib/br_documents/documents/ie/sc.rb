# http://www.sintegra.gov.br/Cad_Estados/cad_SC.html
module BRDocuments
  class IE::SC < IE::Base
    set_verify_digits_weights first: %w(9 8 7 6 5 4 3 2)

    set_format_regexp %r{^(\d{3})[-.]?(\d{3})[-.]?(\d{2})[-.]?(\d{1})}

    set_pretty_format_mask %(%s.%s.%s%s)
  end
end