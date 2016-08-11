# http://www.sintegra.gov.br/Cad_Estados/cad_MG.html
module BRDocuments
  class IE::MG < IE::Base

    set_verify_digits_weights first: %w(1 2 1 2 1 2 1 2 1 2 1 2),
                              last:  %w(3 2 11 10 9 8 7 6 5 4 3 2)


    set_format_regexp %r{^(\d{9})[-.]?(\d{2})[-.]?(\d{2})}

    set_pretty_format_mask %(%s.%s-%s)

    set_root_digits_count 11

    def calculate_digits_data(number, weights)
      # For the first digit, a very different approach is applied
      if first_weight_mask?(weights)
        return calculate_first_digit_data(number, weights)
      end

      super(number, weights)
    end

    private
    def calculate_verify_digit(number, weights)
      if first_weight_mask?(weights)
        return calculate_digits_data(number, weights)[:digit]
      end

      super(number, weights)
    end

    protected
    def calculate_first_digit_data(number, weights)
      number = normalized(number).insert(3, 0)

      sum = calculate_first_digits_sum(number, weights)
      quotient = (sum / get_division_modulo)

      # calculate the difference from the immediate next ten(dezena)
      verify_digit = next_dezen(sum)

      { sum: sum, quotient: quotient, rest: verify_digit, digit: verify_digit }
    end

    # sum EACH algarisms composing the number, not the entire product
    # eg: 19 + 20 + 12 + 13
    # 1 + 9 + 2 + 0 + 1 + 2 + 1 + 3 = 19
    def calculate_first_digits_sum(number, weights)
      normalized_number = normalized(number)

      normalized_number.each_with_index.map {|n,i| n.to_i * weights[i].to_i }.reduce do |sum, num|
        sum += num.to_s.split(//).map(&:to_i).reduce(:+)
      end
    end

    def next_dezen(sum)
      rest = (sum.to_i % 10)
      rest == 0 ? 0 : 10 - rest
    end

    def first_weight_mask?(weights)
      weights.size == 12 && weights.first.to_i == 1
    end
  end
end