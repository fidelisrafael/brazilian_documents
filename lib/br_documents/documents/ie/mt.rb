# http://www.sintegra.gov.br/Cad_Estados/cad_MT.html
module BRDocuments
  class IE::MT < IE::Base
    set_verify_digits_weights first: %w(3 2 9 8 7 6 5 4 3 2)

    set_valid_format_regexp %r{^(\d{10})[-.]?(\d{1})}

    set_pretty_format_mask %(%s-%s)
  end
end

