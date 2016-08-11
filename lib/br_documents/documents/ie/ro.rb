# This class is a wrapper/interface to glue all RO IE generators and validators
module BRDocuments
  module IE::RO
    class << self

      def convert_legacy(legacy_number)
        new(legacy_number.gsub(/^(\d{3})/, '00000000')).pretty # remove city code
      end

      # Delegate all methods to specific class
      def method_missing(method, *args)
        class_for_number(args[0]).public_send(method, *args)
      end

      def generate(formatted = true, legacy = false)
        class_for(legacy).generate(formatted)
      end

      def generate_root_numbers(legacy = false)
        class_for(legacy).generate_root_numbers
      end

      def legacy?(number)
        [8, 9].member?(number.to_s.gsub(/[^\d+]/, '').size)
      end

      def class_for_number(number)
        class_for(legacy?(number))
      end

      protected
      def class_for(legacy)
        class_name = class_name_for(legacy)
        IE::RO.const_get(class_name)
      end

      def class_name_for(legacy = false)
        legacy ? "Legacy" : "Current"
      end
    end
  end
end