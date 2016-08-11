# http://www.sintegra.gov.br/Cad_Estados/cad_SP.html
module BRDocuments
   module IE::SP
    class Industria < IE::Base
      set_root_digits_count 10

      set_verify_digits_positions [8, 11]

      set_verify_digits_weights first: %w(1 3 4 5 6 7 8 10),
                                last:  %w(3 2 10 9 8 7 6 5 4 3 2)

      set_format_regexp %r{(\d{3})[-.]?(\d{3})[-.]?(\d{3})[-.]?(\d{3})}

      set_pretty_format_mask %(%s.%s.%s.%s)

      # the last number from rest, WHY São Paulo??? IDK
      def calc_verify_digit(quotient_rest)
        quotient_rest.to_i.to_s[-1].to_i
      end
    end
  end
end