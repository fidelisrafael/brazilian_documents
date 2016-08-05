# http://www.sintegra.gov.br/Cad_Estados/cad_AC.html
module BRDocuments
  class IE::AC < IE::Base
    digits_verify_mask first: %w(4 3 2 9 8 7 6 5 4 3 2),
                       last:  %w(5 4 3 2 9 8 7 6 5 4 3 2)

    valid_format_regexp %r{(01)[-.]?(\d{3})[-.]?(\d{3})[\/-]?(\d{3})[-.]?(\d{2})}

    # mask utilized to prettify doc number
    pretty_format_mask %(%s.%s.%s/%s-%s)

    FIXED_INITIAL_NUMBERS = [0, 1].freeze

    def self.digit_verify(quotient_rest, division_factor)
     rest = (division_factor - quotient_rest)

      return [10, 11].member?(rest.to_i) ? 0 : rest
    end

  end
end

