# http://www.sintegra.gov.br/Cad_Estados/cad_PR.html
module BRDocuments
  class IE::PR < IE::Base
    set_verify_digits_weights first: %w(3 2 7 6 5 4 3 2),
                              last:  %w(4 3 2 7 6 5 4 3 2)

    set_valid_format_regexp %r{^(\d{8})[-.]?(\d{1})}

    set_pretty_format_mask %(%s-%s)
  end
end