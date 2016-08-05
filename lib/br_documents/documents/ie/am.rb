# http://www.sintegra.gov.br/Cad_Estados/cad_A.html
module BRDocuments
  class IE::AM < IE::Base
    digits_verify_mask first: %w(9 8 7 6 5 4 3 2)

    valid_format_regexp %r{(\d{2})[-.]?(\d{3})[-.]?(\d{3})[-.]?(\d{1})}

    # mask utilized to prettify doc number
    pretty_format_mask %(%s.%s.%s-%s)

    class << self
      #def digit_verify(quotient_rest, division_factor)
      #  return 0 if quotient_rest <= 1
      #
      #  return (division_factor - quotient_rest)
      #end
    end
  end
end

