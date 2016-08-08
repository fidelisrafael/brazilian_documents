# http://www.sintegra.gov.br/Cad_Estados/cad_MG.html
module BRDocuments
  class IE::MG < IE::Base
    set_verify_digits_weights first: %w(1 2 1 2 1 2 1 2 1 2 1 2),
                              last:  %w(3 2 11 10 9 8 7 6 5 4 3 2)

    set_valid_format_regexp %r{^(\d{3})[-.]?(\d{3})[-.]?(\d{3})[-.]?[\/]?(\d{2})(\d{2})}

    set_pretty_format_mask %(%s.%s.%s/%s%s)

    set_root_documents_digits_count 11

    class << self
      def calculate_digits_data(document_number, mask, division_factor)
        # For the first digit, a very different approach is applied
        if first_mask?(mask)
          return calculate_first_digit_data(document_number, mask, division_factor)
        end

        super(document_number, mask, division_factor)
      end

      def calculate_first_digit_data(document_number, mask, division_factor)
        document_number = normalize_number(document_number).insert(3, 0)

        sum = calculate_first_digits_sum(document_number, mask)
        quotient = (sum / division_factor)

        verify_digit = calculate_first_digit_sum_rest(sum)

        { sum: sum, quotient: quotient, rest: verify_digit, verify_digit: verify_digit }
      end

      # sum EACH algarisms composing the number, not the entire product
      # eg: 19 + 20 + 12 + 13
      # 1 + 9 + 2 + 0 + 1 + 2 + 1 + 3 = 19
      def calculate_first_digits_sum(document_number, mask)
        normalized_document_number = normalize_document_number(document_number)

        normalized_document_number.each_with_index.map {|n,i| n.to_i * mask[i].to_i }.reduce do |sum, num|
          sum += num.to_s.split(//).map(&:to_i).reduce(:+)
        end
      end

      # calculate the difference from the immediate next ten(dezena)
      def calculate_first_digit_sum_rest(sum)
        10 - (sum.to_i % 10)
      end

      protected
      def first_mask?(mask)
        mask.size == 12 && mask.first.to_i == 1
      end
    end
  end
end