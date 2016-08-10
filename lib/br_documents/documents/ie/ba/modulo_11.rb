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
        set_division_modulo 11
      end
    end
  end
end