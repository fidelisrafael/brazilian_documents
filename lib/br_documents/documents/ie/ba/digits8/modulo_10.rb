require_relative '../modulo_10'

module BRDocuments
  module IE
    class BA::Digits8::Modulo10 < IE::BA::Modulo10

      digits_verify_mask first: %w(7 6 5 4 3 2),
                         last:  %w(8 7 6 5 4 3 2)

    end
  end
end