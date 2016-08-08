# http://www.sintegra.gov.br/Cad_Estados/cad_SP.html
module BRDocuments
  module IE::SP
    class Rural < IE::Base
      set_root_documents_digits_count 11

      set_verify_digits_positions [8]

      set_verify_digits_weights first: %w(1 3 4 5 6 7 8 10)

      set_valid_format_regexp %r{(P)?[-.]?(\d{8})[-.]?(\d{1})[\/]?(\d{3})}

      set_pretty_format_mask %(P%s-%s.%s/%s)

      class << self
        def valid?(document_number)
          return false unless document_number.to_s.match(/^P/)

          super(document_number)
        end
        # the last number from rest, WHY São Paulo??? IDK
        def digit_verify(quotient_rest, division_factor)
          quotient_rest.to_i.to_s[-1].to_i
        end
      end
    end
  end
end