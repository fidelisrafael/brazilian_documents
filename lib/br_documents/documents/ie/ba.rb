# This class is a wrapper/interface to glue all Bahia IE generators and validators
module BRDocuments
  module IE::BA
    class << self

      DIGITS_MOD_10 = [0,1,2,3,4,5,8]
      DIGITS_MOD_11 = [6,7,9]

      # Delegate all methods to specific class
      def method_missing(method, *args)
        class_for_document_number(args[0]).public_send(method, *args)
      end

      def generate(formatted = true, digits_count = 9, modulo = 10)
        generator_class(digits_count, modulo).generate(formatted)
      end

      def generate_root_numbers(digits_count = 9, modulo = 10)
        generator_class(digits_count, modulo).generate_root_numbers
      end

      def class_for_document_number(document_number)
        class_name = class_name_for_document_number(document_number)
        IE::BA.const_get(class_name)
      end

      def rand_generate(formatted = true)
        generate(formatted, rand_digits_count, rand_modulo)
      end

      protected
      def generator_class(digits_count = 9, modulo = 10)
        IE::BA.const_get("Digits#{digits_count}::Modulo#{modulo}")
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