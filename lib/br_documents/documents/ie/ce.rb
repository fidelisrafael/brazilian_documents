# http://www.sintegra.gov.br/Cad_Estados/cad_CE.html
module BRDocuments
  class IE::CE < IE::Base
    set_verify_digits_weights first: %w(9 8 7 6 5 4 3 2)

    set_valid_format_regexp %r{(\d{8})[-.]?(\d{1})}

    set_pretty_format_mask %(%s-%s)
  end
end

