require 'spec_helper'

describe BRDocuments::IE::MA do

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
    expect(described_class.pretty("120000385")).to eq("12.000.038-5")
  end

  it 'must prettify IE number including initial fixed numbers' do
    number = described_class.generate

    expect(number).to match(/\A#{described_class.fixed_initial_numbers.join}/)
  end

  it 'remove an IE number formatting' do
    expect(described_class.strip('12.000.038-5')).to eq('120000385')
  end

  it 'must validate correctly valid IE numbers' do
    expect(described_class.valid?('12.000.038-5')).to be_truthy
    expect(described_class.valid?('12000038-5')).to be_truthy
    expect(described_class.valid?('120000385')).to be_truthy
  end

  it 'is invalid with wrong digits number' do
    expect(described_class.invalid?('12.000.038-51')).to be_truthy
    expect(described_class.invalid?('121.000.038-5')).to be_truthy
  end

  it 'must calculate verify digits' do
    expected = [5]

    expect(described_class.calculate_verify_digits("12.000.038-5")).to eq(expected)
    expect(described_class.calculate_verify_digits("12.000.038")).to eq(expected)
    expect(described_class.calculate_verify_digits("12000038")).to eq(expected)
  end

  it 'must validate a list of valid IE' do
    numbers = [
      '12.085.506-2', # PETROLEO BRASILEIRO S A PETROBRAS
      '12.051.511-3', # COMPANHIA ENERGETICA DO MARANHAO CEMAR
      '12.051.297-1', # PETROBRAS DISTRIBUIDORA S A
      '12.423.718-5', # AMBEV S A
      '12.190.396-6', # TIM CELULAR S A
      '12.398.704-0', # OI MOVEL S.A
      '12.201.918-0', # TELEFONICA BRASIL S A
      '12.243.194-4', # CLARO S A
      '12.298.232-0', # IMIFARMA PRODUTOS FARMACEUTICOS E COSMETICOS SA
    ].each do |number|
      ie_object = described_class.new(number)

      expect(ie_object).to be_valid
      expect(ie_object).to_not be_invalid
      expect(ie_object.pretty).to eq(number)
      expect(ie_object.strip).to eq(described_class.strip(number))
    end
  end
end