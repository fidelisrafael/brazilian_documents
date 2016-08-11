# http://www.sintegra.gov.br/Cad_Estados/cad_BA.html
module BRDocuments
  module IE
    module BA
      class Base < IE::Base

        set_format_regexp %r{(\d{3})[-.]?(\d{3})[-.]?(\d{2,3})}

        set_pretty_format_mask %(%s.%s.%s)

        # I don't know why in Bahia they calculate the LAST digit FIRST and
        # the FIRST digit LAST, wtf
        def calculate_verify_digits
          super.reverse
        end

        def self.valid_fixed_digits?(number)
          number = new(number).normalize
          fixed_numbers = self.const_get('FIXED_INITIAL_NUMBERS')

          fixed_numbers.member?(number[fixed_digits_positions].to_s)
        end

        def self.fixed_digits
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