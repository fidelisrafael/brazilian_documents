# http://www.sintegra.gov.br/Cad_Estados/cad_RO.html
module BRDocuments
  module IE::RO
    class Legacy < IE::Base

      set_verify_digits_weights first: %w(0 0 0 6 5 4 3 2)

      set_format_regexp %r{^(\d{3})[-.]?(\d{5})[-.]?(\d{1})}

      set_pretty_format_mask %(%s.%s-%s)

      class << self
        def digit_verify(quotient_rest, division_factor)
          rest = (division_factor - quotient_rest).to_i

          # if rest has two digits(checkdigit must be a single digit), subtract 10
          return 10 - rest if rest >= 10

          rest
        end
      end
    end
  end
end