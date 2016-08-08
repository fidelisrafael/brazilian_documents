# http://www.sintegra.gov.br/Cad_Estados/cad_AP.html
module BRDocuments
  class IE::AP < IE::Base
    set_verify_digits_weights first: %w(9 8 7 6 5 4 3 2)

    set_valid_format_regexp %r{^(03)[-.]?(\d{5})[-.]?(\d{1})}

    set_pretty_format_mask %(%s%s-%s)

    # In RANGE_VALUES we remove the first '0' character so
    # numbers are't treated as octal numberss
    # see: :obtain_magic_number_for method
    RANGE_VALUES = {
      3000001..3017000 => [5, 0],
      3017001..3019022 => [9, 1]
    }.freeze

    DEFAULT_RANGE_CONF = [0, 0]

    set_fixed_initial_numbers [0, 3]

    class << self
      def digit_verify(quotient_rest, division_factor)
        rest = (division_factor - quotient_rest).to_i

        return @_temp_range_aux_hash[:d] if [11].member?(rest)
        return 0 if [10].member?(rest)

        return rest
      end

      def calculate_digits_sum(document_number, mask)
        @_temp_range_aux_hash = range_aux_values_hash(document_number)

        (super + @_temp_range_aux_hash[:p])
      end

      def range_aux_values_hash(document_number)
        range_conf = obtain_range_aux_value(document_number)

        {
          :p => range_conf[0],
          :d => range_conf[1]
        } # equivalent to Hash[[:p, :d].zip(range_conf)]
      end

      def obtain_range_aux_value(document_number)
        # remove first '0' digit so number is not a octal
        number = (normalize_number_to_s(document_number)[1..-1]).to_i

        # We try to check if `number` is include in one of the pre defined range
        range_conf = RANGE_VALUES.map do |range, aux_values|
          range.include?(number) ? aux_values : nil
        end.compact

        # One of the configured values or the default
        range_conf.shift || DEFAULT_RANGE_CONF
      end

    end
  end
end

