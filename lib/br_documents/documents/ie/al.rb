# http://www.sintegra.gov.br/Cad_Estados/cad_AL.html
module BRDocuments
  class IE::AL < IE::Base
    set_verify_digits_weights first: %w(9 8 7 6 5 4 3 2)

    set_format_regexp %r{^(24)[-.]?(\d{3})[-.]?(\d{3})[-.]?(\d{1})}

    set_pretty_format_mask %(%s.%s.%s-%s)

    set_fixed_initial_numbers [2, 4]

    COMPANIES_TYPES = {
      "0": "Normal",
      "3": "Produtor Rural",
      "5": "Substituta",
      "7": "Micro-Empresa Ambulante",
      "8": "Micro-Empresa"
    }

    class << self
      def companies_types_labels
        COMPANIES_TYPES.values
      end

      def sample_company_type_digit
        COMPANIES_TYPES.keys.sample.to_s
      end

      def generate_root_numbers
        numbers = super
        # force digit
        numbers[2] = sample_company_type_digit.to_i

        numbers
      end

      def company_type(number)
        # .to_s.to_sym to avoid nil.to_sym
        COMPANIES_TYPES[company_type_digit(number).to_s.to_sym]
      end

      def company_type_digit(number)
        number = new(number).strip

        number.match(/^\d{2}(\d{1})/) && $1
      end
    end
  end
end