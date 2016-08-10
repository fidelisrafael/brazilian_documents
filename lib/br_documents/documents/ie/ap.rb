# http://www.sintegra.gov.br/Cad_Estados/cad_AP.html
module BRDocuments
  class IE::AP < IE::Base
    set_verify_digits_weights first: %w(9 8 7 6 5 4 3 2)

    set_format_regexp %r{^(03)[-.]?(\d{6})[-.]?(\d{1})}

    set_pretty_format_mask %(%s.%s-%s)

    # In RANGE_VALUES we remove the first '0' character so
    # numbers are't treated as octal numberss
    # see: :obtain_magic_number_for method
    RANGE_VALUES = {
      3000001..3017000 => [5, 0],
      3017001..3019022 => [9, 1]
    }.freeze

    DEFAULT_RANGE_CONF = [0, 0]

    set_fixed_initial_numbers [0, 3]

    def range_aux_values_hash
      range_conf = obtain_range_aux_value(@number.dup)

      {
        :p => range_conf[0],
        :d => range_conf[1]
      } # equivalent to Hash[[:p, :d].zip(range_conf)]
    end

    def reduce_digits_weights(number, weights)
      range_aux_values_hash[:p] + super(number, weights)
    end

    def calc_verify_digit(quotient_rest)
      if ([11].member?(get_division_modulo - quotient_rest))
        return range_aux_values_hash[:d]
      end

      super
    end

    private
    def obtain_range_aux_value(document_number)
      remove_verify_digits(document_number)

      # remove first '0' digit so number is not a octal
      number = (stripped(document_number)[1..-1]).to_i

      # We try to check if `number` is include in one of the pre defined range
      range_conf = RANGE_VALUES.map do |range, aux_values|
        range.include?(number) ? aux_values : nil
      end.compact

      # One of the configured values or the default
      range_conf.shift || DEFAULT_RANGE_CONF
    end

  end
end