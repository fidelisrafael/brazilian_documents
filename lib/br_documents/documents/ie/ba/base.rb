# http://www.sintegra.gov.br/Cad_Estados/cad_BA.html
module BRDocuments
  module IE
    module BA
      class Base < IE::Base

        valid_format_regexp %r{(\d{6,7})[-.]?(\d{2})}

        # mask utilized to prettify doc number
        pretty_format_mask %(%s-%s)

        # I don't know why in Bahia they calculate the LAST digit FIRST and
        # the FIRST digit LAST, wtf
        def self.calculate_verify_digits(document_number)
          super.reverse
        end

        def self.fixed_initial_numbers
          [super.sample.to_i]
        end
      end
    end
  end
end

module BRDocuments::IE::BA
  module Digits8
  end
  module Digits9
  end
end