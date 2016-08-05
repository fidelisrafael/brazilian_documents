# http://www.sintegra.gov.br/Cad_Estados/cad_ES.html
module BRDocuments
  class IE::GO < IE::Base
    digits_verify_mask first: %w(9 8 7 6 5 4 3 2)

    valid_format_regexp %r{(\d{8})[-.]?(\d{1})}

    # mask utilized to prettify doc number
    pretty_format_mask %(%s-%s)
  end
end

