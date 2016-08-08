require_relative '../modulo_10'

module BRDocuments
  module IE
    class BA::Digits9::Modulo10 < IE::BA::Modulo10

      set_verify_digits_weights first: %w(8 7 6 5 4 3 2),
                                last:  %w(9 8 7 6 5 4 3 2)


      # 9 digits IE from bahia have FIXED NUMBER in the second position
      INITIAL_FIX_NUMBERS_POSITION = 1

      def initial_fix_numbers_position
        self.const_get('INITIAL_FIX_NUMBERS_POSITION')
      end
    end
  end
end