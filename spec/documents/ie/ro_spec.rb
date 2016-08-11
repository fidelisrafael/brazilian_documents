require 'spec_helper'
require_relative 'shared_examples'

describe BRDocuments::IE::RO do
  before :all do

    @format_examples = {
      "00000000625213" => "0000000062521-3", # current
      "101625213" => "101.62521-3" # legacy
    }

    @valid_numbers = %w(
      0000000062521-3
      00000000625213
      000.000.006.252-13
      101.62521-3
      101625213
      101.62521-3
    )

    @invalid_numbers = %w(
      101625211
      101162521
      1012521
      000000006252131
      0000000062521
    )

    @valid_verify_digits = {
      [7] => %w(0000000025563-7 0000000025563),
      [3] => %w(101.62521-3 101.62521 10162521)
    }

    @valid_existent_numbers = [
      '0000000062521-3',  # Exemplo sintegra,
      '101.62521-3',      # Exemplo Sintegra (Legado)
      '0000000025563-7',  # CENTRAIS ELÉTRICAS DE RONDÔNIA S/A - CERON
      '0000000095268-1',  # COMPNACIONAL DE ABASTCONAB 1999
      '0000000033376-0',  # COMPANHIA NACIONAL DE ABASTECIMENTO - CONAB 1991
      '0000000002819-3',  # EMPRBRASCORRE TELEGRAFOS (Correios) 1969
      '0000000348915-9',  # ELETROSUL CENTRAIS ELETRICAS S/A 2012
      '0000000394095-1',  # WSP RONDÔNIA SERVIÇOS DE TELECOMUNICAÇÕES LTDA - ME 2013
      '0000000055105-8',  # MECANIZAÇAO RONDONIA LTDA EPP 2010 CANCELADO
    ]
  end

  include_examples "IE basic specs"

  it 'must check if number is legacy' do
    expect(described_class.legacy?("101.62521")).to be_truthy
    expect(described_class.legacy?("0000000062521-3")).to be_falsey
  end

  it 'must allow legacy numbers generation' do
    number = described_class.generate(true, true)

    expect(described_class.legacy?(number)).to be_truthy
    expect(described_class.valid?(number)).to be_truthy
  end

  it 'must allow legacy numbers convertion to new format' do
    doc_number = "101.62521-3"
    expected = "0000000062521-3"

    number = BRDocuments::IE::RO.convert_legacy(doc_number)

    expect(described_class.legacy?(doc_number)).to be_truthy
    expect(described_class.legacy?(number)).to be_falsey
    expect(number).to eq(expected)
  end

  it 'must pick current format for new documents generation' do
    number = described_class.generate
    klass = described_class.class_for_number(number)

    expect(klass).to be(described_class.const_get('Current'))
  end
end