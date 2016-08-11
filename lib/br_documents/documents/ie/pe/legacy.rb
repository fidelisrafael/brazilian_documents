# http://www.sintegra.gov.br/Cad_Estados/cad_PE.html
module BRDocuments
  module IE::PE
    class Legacy < IE::Base
      set_verify_digits_weights first: %w(5 4 3 2 1 9 8 7 6 5 4 3 2)

      set_format_regexp %r{^(\d{2})[-.]?(\d{1})[-.]?(\d{3})[-.]?(\d{7})[-.]?(\d{1})}

      set_pretty_format_mask %(%s.%s.%s.%s-%s)
    end
  end
end