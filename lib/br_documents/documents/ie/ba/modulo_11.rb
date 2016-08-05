require_relative 'base'

# http://www.sintegra.gov.br/Cad_Estados/cad_BA.html
module BRDocuments
  module IE
    module BA
      class Modulo11 < IE::BA::Base

        # All documents generated through modulo 11 may start
        # with one of theses values
        FIXED_INITIAL_NUMBERS = %w(6 7 9)

        # Force modulo 11
        division_factor_modulo 11

        #def self.digit_verify(quotient_rest, division_factor)
        #  rest = (division_factor - quotient_rest)
        #
        # return [0, 1].member?(quotient_rest.to_i) ? 0 : rest
        #end

      end
    end
  end
end