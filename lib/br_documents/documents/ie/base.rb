# http://www.sintegra.gov.br/insc_est.html
module BRDocuments
  module IE
    class Base < ::DigitChecksum::BaseDocument
      # MOD 11
      set_division_modulo 11

      # remove any non digit from document number
      set_clear_number_regexp %r{[^(\d+)]}

      # numbers sampled to generate new document numbers
      set_generator_numbers (0..9).to_a

      # Start from first position
      INITIAL_FIX_NUMBERS_POSITION = 0
      # No one
      FIXED_INITIAL_NUMBERS = []

      def valid?
        return false unless valid_fixed_numbers?

        return super
      end

      def valid_fixed_numbers?
        return true unless validate_fixed_numbers?

        self.class.valid_fixed_numbers?(self.number)
      end

      def validate_fixed_numbers?
        true
      end

      class << self
        def valid_fixed_numbers?(number)
          number = new(number).normalize

          initial_pos = initial_fix_numbers_position
          fixed_numbers = fixed_initial_numbers

          return (number.slice(initial_pos, fixed_numbers.size) == fixed_numbers)
        end

        def generate_root_numbers
          numbers = (root_digits_count - fixed_initial_numbers.size).times.map {
            get_generator_numbers.sample.to_i
          }

          insert_fixed_numbers(numbers)

          numbers
        end

        def initial_fix_numbers_position
          self.const_get('INITIAL_FIX_NUMBERS_POSITION')
        end

        def fixed_initial_numbers
          self.const_get('FIXED_INITIAL_NUMBERS')
        end

        def set_fixed_initial_numbers(initial_numbers)
          self.const_set('FIXED_INITIAL_NUMBERS', initial_numbers).freeze
        end

        def self.digit_verify(quotient_rest, division_factor)
          rest = (division_factor - quotient_rest)

          return [0, 1].member?(quotient_rest.to_i) ? 0 : rest
        end

        protected
        def insert_fixed_numbers(numbers)
          fixed_initial_numbers.each_with_index {|number, index|
            numbers.insert(initial_fix_numbers_position + index, number)
          }

          numbers
        end
      end

    end
  end
end