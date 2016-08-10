require 'spec_helper'

describe BRDocuments::IE::DF do

  it 'must generate root numbers with fixed numbers' do
    number = described_class.generate_root_numbers # without formatting

    initial_pos = described_class.initial_fix_numbers_position
    fixed_numbers = described_class.fixed_initial_numbers

    expect(number.slice(initial_pos, fixed_numbers.size)).to eq(fixed_numbers)
  end

  it 'generate documents must have valid fixed numbers' do
    document = described_class.new(described_class.generate)

    expect(document.valid_fixed_numbers?).to be_truthy
  end

  it 'must generate valid IE' do
    10.times { expect(described_class.valid?(described_class.generate)).to be_truthy }
  end

  it 'pretty formats an IE number' do
    expect(described_class.pretty("0730000100109")).to eq("07.300.001.001-09")
  end

  it 'must prettify IE number including initial fixed numbers' do
    number = described_class.generate

    expect(number).to match(/\A#{described_class.fixed_initial_numbers.join}/)
  end

  it 'remove an IE number formatting' do
    expect(described_class.strip('07.300.001.001-09')).to eq('0730000100109')
  end

  it 'must validate correctly valid IE numbers' do
    expect(described_class.valid?('07.300.001.001-09')).to be_truthy
    expect(described_class.valid?('07.300001001-09')).to be_truthy
    expect(described_class.valid?('0730000100109')).to be_truthy
  end

  it 'is invalid with wrong digits number' do
    expect(described_class.invalid?('07.300.001.001-091')).to be_truthy
    expect(described_class.invalid?('107.300.001.001-09')).to be_truthy
  end

  it 'must calculate verify digits' do
    expected = [0, 9]

    expect(described_class.calculate_verify_digits("07.300.001.001-09")).to eq(expected)
    expect(described_class.calculate_verify_digits("07.300.001.00109")).to eq(expected)
    expect(described_class.calculate_verify_digits("0730000100109")).to eq(expected)
  end

  it 'must validate a list of valid IE' do
    numbers = [
      '07.300.001.001-09',
      '07.441.356.001-93', # Oi
      '07.326.199.001-83', # CENTRAIS ELETRICAS DO NORTE DO BRASIL S/A
      '07.317.963.001-13', # EMPRESA BRASILEIRA DE INFRA-ESTRUTURA AEROPORTUARIA 1994
      '07.518.585.001-66', # CASA DA MOEDA DO BRASIL
      '07.326.199.001-83', # CENTRAIS ELETRICAS DO NORTE DO BRASIL S/A
      '07.312.777.001-70', # COMPANHIA NACIONAL DE ABASTECIMENTO CONAB
    ].each do |number|
      ie_object = described_class.new(number)

      expect(ie_object).to be_valid
      expect(ie_object).to_not be_invalid
      expect(ie_object.pretty).to eq(number)
      expect(ie_object.strip).to eq(described_class.strip(number))
    end
  end
end