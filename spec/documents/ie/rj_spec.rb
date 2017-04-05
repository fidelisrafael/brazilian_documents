require 'spec_helper'
require_relative 'shared_examples'

describe BRDocuments::IE::RJ do

  before :all do

    @format_examples = {
      "81293279" => "81.293.279"
    }

    @valid_numbers = %w(
      8129327-9
      812.932.79
      81293279
    )

    @invalid_numbers = %w(
      8129327-91
      81219327-91
      812932-9
    )

    @valid_verify_digits = {
      [9] => %w(8129327-9 8129327 81293279)
    }

    @valid_existent_numbers = [
      '81.293.279', # PETROBRAS DISTRIBUIDORA SA
      '80.495.072', # Vale 1986
      '81.306.141', # RAIZEN COMBUSTIVEIS S A 17/11/1977
      '81.680.469', # TELEMAR NORTE LESTE S/A 1978
      '81.281.777', # COMPANHIA SIDERURGICA NACIONAL 1977
      '81.380.023', # LIGHT SERVICOS DE ELETRICIDADE S A
      '84.780.707', # COMPANHIA ESTADUAL DE AGUAS E ESGOTOS - CEDAE
      '75.933.118', # BAZAR XING XING PRESENTES LTDA
      '78.166.886', # MUNDO POPULAR BAZAR LTDA
      '92.013.405', # CREDEAL MANUFATURA DE PAPEIS LTDA
    ]
  end

  include_examples "IE basic specs"

  it 'must generate root numbers with fixed numbers' do
    fixed_numbers = described_class.const_get('FIXED_INITIAL_NUMBERS').map(&:to_s)
    fixed_position = described_class.fixed_digits_positions

    10.times {
      numbers = described_class.generate_root_numbers
      expect(fixed_numbers).to include(numbers[fixed_position..1].join)
    }
  end

  it 'must generate new numbers including initial fixed numbers' do
    number = described_class.generate

    regexp = %r{\A#{described_class.const_get('FIXED_INITIAL_NUMBERS').join('|')}}

    expect(number).to match(regexp)
  end
end