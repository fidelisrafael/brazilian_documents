require 'spec_helper'

describe BRDocuments::IE::PE do

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
    expect(described_class.pretty("032141840")).to eq("0321418-40")
  end

  it 'must prettify IE number including initial fixed numbers' do
    number = described_class.generate

    expect(number).to match(/\A#{described_class.fixed_initial_numbers.join}/)
  end

  it 'remove an IE number formatting' do
    expect(described_class.strip('0321418-40')).to eq('032141840')
  end

  it 'must validate correctly valid IE numbers' do
    expect(described_class.valid?('0321418-40')).to be_truthy
    expect(described_class.valid?('03.214.18-40')).to be_truthy
    expect(described_class.valid?('032141840')).to be_truthy
  end

  it 'is invalid with wrong digits number' do
    expect(described_class.invalid?('0321418-401')).to be_truthy
    expect(described_class.invalid?('03121418-40')).to be_truthy
  end

  it 'must calculate verify digits' do
    expected = [4,0]

    expect(described_class.calculate_verify_digits("0321418-40")).to eq(expected)
    expect(described_class.calculate_verify_digits("0321418")).to eq(expected)
    expect(described_class.calculate_verify_digits("03.21418")).to eq(expected)
    expect(described_class.calculate_verify_digits("18.1.001.0000004-9")).to eq([9])
    expect(described_class.calculate_verify_digits("18.1.001.0000004")).to eq([9])
  end

  it 'must validate a list of valid IE' do
    numbers = [
      '0321418-40', # Exemplo sintegra,
      '18.1.001.0000004-9', # Exemplo Sintegra (Legado)
    ].each do |number|
      ie_object = described_class.new(number)

      expect(ie_object).to be_valid
      expect(ie_object).to_not be_invalid
      expect(ie_object.pretty).to eq(number)
      expect(ie_object.strip).to eq(described_class.strip(number))
    end
  end

  it 'must check if number is legacy' do
    expect(described_class.legacy?("18.1.001.0000004-9")).to be_truthy
    expect(described_class.legacy?("0321418-40")).to be_falsey
  end

  it 'must allow legacy numbers generation' do
    number = described_class.generate(true, true)

    expect(described_class.legacy?(number)).to be_truthy
    expect(described_class.valid?(number)).to be_truthy
  end
end