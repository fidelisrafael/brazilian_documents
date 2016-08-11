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
        return false unless valid_fixed_digits?

        return super
      end

      def valid_fixed_digits?
        return true unless validate_fixed_digits?

        self.class.valid_fixed_digits?(self.number)
      end

      def validate_fixed_digits?
        true
      end

      class << self
        def valid_fixed_digits?(number)
          number = new(number).normalize

          initial_pos = fixed_digits_positions
          fixed_numbers = fixed_digits

          return (number.slice(initial_pos, fixed_numbers.size) == fixed_numbers)
        end

        def generate_root_numbers
          numbers = (root_digits_count - fixed_digits.size).times.map {
            get_generator_numbers.sample.to_i
          }

          append_fixed_digits(numbers)

          numbers
        end

        def fixed_digits_positions
          self.const_get('INITIAL_FIX_NUMBERS_POSITION')
        end

        def fixed_digits
          self.const_get('FIXED_INITIAL_NUMBERS')
        end

        def set_fixed_digits(initial_numbers)
          self.const_set('FIXED_INITIAL_NUMBERS', initial_numbers).freeze
        end

        protected
        def append_fixed_digits(numbers)
          fixed_digits.each_with_index {|number, index|
            numbers.insert(fixed_digits_positions + index, number)
          }

          numbers
        end
      end

    end
  end
end