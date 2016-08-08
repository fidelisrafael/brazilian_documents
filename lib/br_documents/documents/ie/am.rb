# http://www.sintegra.gov.br/Cad_Estados/cad_A.html
module BRDocuments
  class IE::AM < IE::Base
    set_verify_digits_weights first: %w(9 8 7 6 5 4 3 2)

    set_valid_format_regexp %r{^(\d{2})[-.]?(\d{3})[-.]?(\d{3})[-.]?(\d{1})}

    set_pretty_format_mask %(%s.%s.%s-%s)
  end
end