require 'spec_helper'
require_relative 'shared_examples'

describe BRDocuments::IE::AL do

  before :all do

    @format_examples = {
      '240000048' => '24.000.004-8'
    }

    @valid_numbers = %w(
      240000048
      24.000.004-8
      24.000004.8
      24000004-8
      24.810989-8
      24.840219-6
      24.838692-1
      24.885944-7
      24.860732-4
      24.817955-1
      24.577875-6
      24.757527-5
      24.864992-2
    )

    @invalid_numbers = %w(
      24.000.004-80
      124.000.004-8
    )

    @valid_verify_digits = {
      [8] => %w(24.000.004 24.000004 24000004 24.007.177-8 24.007.177 24007177),
      [4] => %w(24.209.925-4 24.209.925 24209925)
    }

    @valid_existent_numbers = [
      '24.000.004-8', # Exemplo Sintegra
      '24.007.177-8', # COMPANHIA ENERGETICA DE ALAGOAS - CEA
      '24.209.925-4', # VIVO S/A
      '24.009.599-5', # BANCO DO ESTADO DE ALAGOAS S A
    ]
  end

  include_examples "IE basic specs"

  it 'must generate a number with valid company type digit' do
    10.times {
      number = described_class.generate

      expect(described_class.company_type(number)).to_not be_nil
    }
  end

  it 'must handle companies type methods' do
    expect(described_class.company_type('24.864992-2')).to eq('Micro-Empresa')
    expect(described_class.company_type('24.577875-6')).to eq('Substituta')
    expect(described_class.company_type_digit('24.577875-6')).to eq('5')
    expect(described_class.company_type_digit('24.885944-7')).to eq('8')
  end
end