require 'spec_helper'

describe BRDocuments::IE::PB do

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
    expect(described_class.pretty("160158230")).to eq("16.015.823-0")
  end

  it 'must prettify IE number including initial fixed numbers' do
    number = described_class.generate

    expect(number).to match(/\A#{described_class.fixed_initial_numbers.join}/)
  end

  it 'remove an IE number formatting' do
    expect(described_class.strip('16.015.823-0')).to eq('160158230')
  end

  it 'must validate correctly valid IE numbers' do
    expect(described_class.valid?('16.015.823-0')).to be_truthy
    expect(described_class.valid?('16015823-0')).to be_truthy
    expect(described_class.valid?('160158230')).to be_truthy
  end

  it 'is invalid with wrong digits number' do
    expect(described_class.invalid?('16.015.823-01')).to be_truthy
    expect(described_class.invalid?('1610158230')).to be_truthy
  end

  it 'must calculate verify digits' do
    expected = [0]

    expect(described_class.calculate_verify_digits("16.015.823-0")).to eq(expected)
    expect(described_class.calculate_verify_digits("16015823")).to eq(expected)
    expect(described_class.calculate_verify_digits("16.015.823")).to eq(expected)
  end

  it 'must validate a list of valid IE' do
    numbers = [
      '16.015.823-0', # Energisa
      '16.064.797-5', # Oi
      '16.211.981-0', # Oi Movel
      '16.143.665-0', # Tim
      '16.000.751-8', # Souza Cruz
      '16.218.715-7', # Ambev
      '16.164.850-9', # Claro
      '16.158.896-4', # Carrefour Comercio e Industria Ltda
    ].each do |number|
      ie_object = described_class.new(number)

      expect(ie_object).to be_valid
      expect(ie_object).to_not be_invalid
      expect(ie_object.pretty).to eq(number)
      expect(ie_object.strip).to eq(described_class.strip(number))
    end
  end
end