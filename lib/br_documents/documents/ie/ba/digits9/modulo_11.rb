require_relative '../modulo_11'

module BRDocuments
  module IE
    class BA::Digits9::Modulo11 < IE::BA::Modulo11

      set_verify_digits_weights first: %w(8 7 6 5 4 3 2),
                                last:  %w(9 8 7 6 5 4 3 2)


      # 9 digits IE from bahia have FIXED NUMBER in the second position
      INITIAL_FIX_NUMBERS_POSITION = 1

      def fixed_digits_positions
        self.const_get('INITIAL_FIX_NUMBERS_POSITION')
      end
    end
  end
end

