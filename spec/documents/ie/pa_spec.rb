require 'spec_helper'

describe BRDocuments::IE::PA do

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
    expect(described_class.pretty("150696655")).to eq("15.069.665-5")
  end

  it 'must prettify IE number including initial fixed numbers' do
    number = described_class.generate

    expect(number).to match(/\A#{described_class.fixed_initial_numbers.join}/)
  end

  it 'remove an IE number formatting' do
    expect(described_class.strip('15.069.665-5')).to eq('150696655')
  end

  it 'must validate correctly valid IE numbers' do
    expect(described_class.valid?('15.069.665-5')).to be_truthy
    expect(described_class.valid?('15069665-5')).to be_truthy
    expect(described_class.valid?('150696655')).to be_truthy
  end

  it 'is invalid with wrong digits number' do
    expect(described_class.invalid?('1506966551')).to be_truthy
    expect(described_class.invalid?('1510696655')).to be_truthy
  end

  it 'must calculate verify digits' do
    expected = [5]

    expect(described_class.calculate_verify_digits("15.069.665-5")).to eq(expected)
    expect(described_class.calculate_verify_digits("15.069.665")).to eq(expected)
    expect(described_class.calculate_verify_digits("15069665")).to eq(expected)
  end

  it 'must validate a list of valid IE' do
    numbers = [
      '15.999.999-5', # Exemplo Sintegra
      '15.000.614-4', # Y Yamada Sa Comercio e Industria
      '15.069.665-5', # ALBRAS ALUMINIO BRASILEIRO S.A
      '15.074.998-8', # COMPANHIA DE SANEAMENTO DO PARA
      '15.286.652-3', # Companhia Docas do Para
      '15.050.675-9', # Banpara - Banco do Estado do Para S A 26/10/1961
    ].each do |number|
      ie_object = described_class.new(number)

      expect(ie_object).to be_valid
      expect(ie_object).to_not be_invalid
      expect(ie_object.pretty).to eq(number)
      expect(ie_object.strip).to eq(described_class.strip(number))
    end
  end
end