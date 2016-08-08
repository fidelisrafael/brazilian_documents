# http://www.sintegra.gov.br/insc_est.html
module BRDocuments
  module IE
    class Base < ::DigitChecksum::BaseDocument
      # MOD 11
      set_division_factor_modulo 11

      # remove any non digit from document number
      set_clear_number_regexp %r{[^(\d+)]}

      # numbers sampled to generate new document numbers
      set_generator_numbers (0..9).to_a

      # Start from first position
      INITIAL_FIX_NUMBERS_POSITION = 0
      # No one
      FIXED_INITIAL_NUMBERS = []

      class << self
        def generate_root_numbers
          numbers = (root_document_digits_count - fixed_initial_numbers.size).times.map {
            get_generator_numbers.sample.to_i
          }

          numbers.insert(initial_fix_numbers_position, fixed_initial_numbers).flatten
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
      end

    end
  end
end

