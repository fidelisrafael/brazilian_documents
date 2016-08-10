module BRDocuments
  module IE::Formats
    class Simple < IE::Base
      set_verify_digits_weights first: %w(9 8 7 6 5 4 3 2)

      set_format_regexp %r{^(\d{2})[-.]?(\d{6})[-.]?(\d{1})}

      set_pretty_format_mask %(%s.%s-%s)
    end
  end
end

# Candidates:
# AL
# AM