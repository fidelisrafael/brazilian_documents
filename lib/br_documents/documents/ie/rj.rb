# http://www.sintegra.gov.br/Cad_Estados/cad_RJ.html
module BRDocuments
  class IE::RJ < IE::Base
    set_verify_digits_weights first: %w(2 7 6 5 4 3 2)

    set_format_regexp %r{^(\d{2})[-.]?(\d{3})[-.]?(\d{3})}

    set_pretty_format_mask %(%s.%s.%s)

    set_fixed_initial_numbers (80..90).to_a

    def self.valid_fixed_numbers?(number)
      number = new(number).normalize
      current = number[0..1].join.to_i

      self.const_get('FIXED_INITIAL_NUMBERS').member?(current)
    end

    def self.fixed_initial_numbers
      super.sample.to_s.split(//).map(&:to_i)
    end

  end
end