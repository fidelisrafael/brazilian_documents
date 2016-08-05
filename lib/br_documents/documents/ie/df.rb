# http://www.sintegra.gov.br/Cad_Estados/cad_DF.html
module BRDocuments
  class IE::DF < IE::Base
    digits_verify_mask first: %w(4 3 2 9 8 7 6 5 4 3 2),
                       last:  %w(5 4 3 2 9 8 7 6 5 4 3 2)


    valid_format_regexp %r{(07)[-.]?(\d{3})[-.]?(\d{3})[\/-]?(\d{3})[-.]?(\d{2})}

    # mask utilized to prettify doc number
    pretty_format_mask %(%s.%s.%s-%s)

    FIXED_INITIAL_NUMBERS = [0, 7].freeze
  end
end

