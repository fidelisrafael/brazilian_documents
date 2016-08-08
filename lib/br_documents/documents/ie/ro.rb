# This class is a wrapper/interface to glue all RO IE generators and validators
module BRDocuments
  module IE::RO
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

      def generate(legacy = false, formatted = true)
        class_for(legacy).generate(formatted)
      end

      def generate_root_numbers(legacy = false)
        class_for(legacy).generate_root_numbers
      end

      METHODS_TO_DELEGATE.each do |method|
        define_method method do |document_number|
          klass = class_for_document_number(document_number)
          klass.public_send(method, document_number)
        end
      end

      protected
      def class_for_document_number(document_number)
        class_for(legacy?(document_number))
      end

      def class_for(legacy)
        class_name = class_name_for(legacy)
        IE::RO.const_get(class_name)
      end

      def class_name_for(legacy = false)
        legacy ? "Legacy" : "Current"
      end

      def legacy?(document_number)
        BRDocuments::IE::Base.normalize_number(document_number).size == 9
      end
    end
  end
end