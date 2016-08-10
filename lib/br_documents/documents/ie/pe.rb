# This class is a wrapper/interface to glue all PE IE generators and validators
module BRDocuments
  module IE::PE
    class << self

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
        [13,14].member?(number.to_s.gsub(/[^\d+]/, '').size)
      end

      protected
      def class_for_number(number)
        class_for(legacy?(number))
      end

      def class_for(legacy)
        class_name = class_name_for(legacy)
        IE::PE.const_get(class_name)
      end

      def class_name_for(legacy = false)
        legacy ? "Legacy" : "Current"
      end
    end
  end
end