require_relative '../modulo_11'

module BRDocuments
  module IE
    class BA::Digits8::Modulo11 < IE::BA::Modulo11

      digits_verify_mask first: %w(7 6 5 4 3 2),
                         last: %w(8 7 6 5 4 3 2)

    end
  end
end

