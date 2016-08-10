# http://www.sintegra.gov.br/Cad_Estados/cad_TO.html
module BRDocuments
  class IE::TO < IE::Base

    set_verify_digits_weights first: %w(9 8 0 0 7 6 5 4 3 2)

    set_format_regexp %r{^(\d{10})[-.]?(\d{1})}

    set_pretty_format_mask %(%s-%s)

    COMPANIES_TYPES = {
      "01": "Produtor Rural (não possui CGC)",
      "02": "Industria e Comércio",
      "03": "Empresas Rudimentares",
      "99": "Empresas do Cadastro Antigo (SUSPENSAS)"
    }

    # company types
    set_fixed_initial_numbers [[0, 1], [0, 2], [0, 3], [0,4]]

    INITIAL_FIX_NUMBERS_POSITION = 2

    class << self
      def company_type(number)
        # .to_s.to_sym to avoid nil.to_sym
        number.match(/^\d{2}(\d{2})/) { COMPANIES_TYPES[$1.to_s.to_sym] }
      end

      def fixed_initial_numbers
        super.sample
      end
    end
  end
end

