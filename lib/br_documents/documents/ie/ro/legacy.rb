# http://www.sintegra.gov.br/Cad_Estados/cad_RO.html
module BRDocuments
  module IE::RO
    class Legacy < IE::Base

      set_verify_digits_weights first: %w(0 0 0 6 5 4 3 2)

      set_format_regexp %r{^(\d{3})[-.]?(\d{5})[-.]?(\d{1})}

      set_pretty_format_mask %(%s.%s-%s)
    end
  end
end