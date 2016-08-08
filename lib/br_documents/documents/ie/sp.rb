# This class is a wrapper/interface to glue all SP IE generators and validators
module BRDocuments
  module IE::SP
    class << self

      METHODS_TO_DELEGATE = [
        :calculate_verify_digits,
        :remove_verify_digits!,
        :append_verify_digits,
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

      def generate(rural = false, formatted = true)
        document = rural ? "P" : ""
        class_for_document_number(document).generate(formatted)
      end

      def generate_root_numbers(rural = false)
        document = rural ? "P" : ""
        class_for_document_number(document).generate_root_numbers
      end

      METHODS_TO_DELEGATE.each do |method|
        define_method method do |document_number|
          klass = class_for_document_number(document_number)
          klass.public_send(method, document_number)
        end
      end

      protected
      def class_for_document_number(document_number)
        class_name = class_name_for_document_number(document_number)
        IE::SP.const_get(class_name)
      end

      def class_name_for_document_number(document_number)
        rural?(document_number) ? "Rural" : "Industria"
      end

      def rural?(document_number)
        document_number.to_s.match(/^P/)
      end
    end
  end
end

