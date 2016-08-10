module BRDocuments
  module IE::Formats
    class FixedInitialNumbers < IE::Base
      set_verify_digits_weights first: %w(4 3 2 9 8 7 6 5 4 3 2),
                                last:  %w(5 4 3 2 9 8 7 6 5 4 3 2)

      set_format_regexp %r{^(01)[-.]?(\d{3})[-.]?(\d{3})[\/-]?(\d{3})[-.]?(\d{2})}

      set_pretty_format_mask %(%s.%s.%s/%s-%s)

      set_fixed_initial_numbers [0, 1]
    end
  end
end

# Candidates:
# AC: digits weigths, format_regexp
# AP
# BA