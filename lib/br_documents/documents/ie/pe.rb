# http://www.sintegra.gov.br/Cad_Estados/cad_PE.html
module BRDocuments
  class IE::PE < IE::Base
    set_verify_digits_weights first: %w(8 7 6 5 4 3 2),
                              last:  %w(9 8 7 6 5 4 3 2)

    set_valid_format_regexp %r{^(\d{7})[-.]?(\d{2})}

    set_pretty_format_mask %(%s-%s)
  end
end