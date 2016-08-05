# This class is a wrapper/interface to glue all Bahia IE generator and validators
module BRDocuments
  module IE::BA
    class << self

      DIGITS_MOD_10 = [0,1,2,3,4,5,8]
      DIGITS_MOD_11 = [6, 7, 9]

      METHODS_TO_DELEGATE = [
        :calculate_verify_digits,
        :normalize_number_to_s,
        :clear_document_number,
        :normalize_number,
        :pretty_formatted,
        :clear_number,
        :formatted,
        :stripped,
        :invalid?,
        :valid?,
        :pretty
      ]

      def generate(strict = false, formatted = true)
        # if is strict always generate documents numbers with 8 digits
        digit_count = strict ? 8 : rand_digits_count
        generate_with_digits(digit_count, formatted)
      end

      METHODS_TO_DELEGATE.each do |method|
        define_method method do |document_number|
          klass = class_for_document_number(document_number)
          klass.public_send(method, document_number)
        end
      end

      protected
      def generate_with_digits(digits, formatted)
        generator = IE::BA.const_get("Digits#{digits}::Modulo#{rand_modulo}")
        generator.generate(formatted)
      end

      def class_for_document_number(document_number)
        class_name = class_name_for_document_number(document_number)
        IE::BA.const_get(class_name)
      end

      def class_name_for_document_number(document_number)
        [
          digits_module_for(document_number),
          modulo_class_for(document_number)
        ].join("::")
      end

      def digits_module_for(document_number)
        eight_digits?(document_number) ? "Digits8" : "Digits9"
      end

      def modulo_class_for(document_number)
        number = normalize_number(document_number)

        # for eigth numbers documents, the first digit is cheched
        # otherwhise the second digit is checked
        check_position = eight_digits?(document_number) ? 0 : 1
        check_digit = number.slice(check_position, 1).to_i

        DIGITS_MOD_11.member?(check_digit) ? 'Modulo11' : 'Modulo10'
      end

      def eight_digits?(document_number)
        normalize_number(document_number).size == 8
      end

      def nine_digits?(document_number)
        normalize_number(document_number).size == 9
      end

      def normalize_number(document_number)
        document_number.to_s.gsub(/[^\d+]/, '')
      end

      def rand_digits_count
        rand_boolean ? 9 : 8
      end

      def rand_modulo
        (rand_boolean ? 10 : 11)
      end

      def rand_boolean
        # 50%/50% of chance
        rand(2) > 0
      end
    end
  end
end

