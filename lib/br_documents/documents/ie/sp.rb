# This class is a wrapper/interface to glue all SP IE generators and validators
module BRDocuments
  module IE::SP
    class << self

      # Delegate all methods to specific class
      def method_missing(method, *args)
        class_for_number(args[0]).public_send(method, *args)
      end

      def generate(formatted = true, rural = false)
        class_for(rural).generate(formatted)
      end

      def generate_root_numbers(rural = false)
        class_for(rural).generate_root_numbers
      end

      def rural?(number)
        number.to_s.match(/^P/) && [11, 12].member?(number.to_s.gsub(/[^\d]/, '').size)
      end

      protected
      def class_for_number(number)
        class_for(rural?(number))
      end

      def class_for(rural)
        class_name = class_name_for(rural)
        IE::SP.const_get(class_name)
      end

      def class_name_for(rural = false)
        rural ? "Rural" : "Industria"
      end
    end
  end
end