require 'spec_helper'

describe BRDocuments::IE::AM do

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
    expect(described_class.pretty("070002207")).to eq("07.000.220-7")
  end

  it 'must prettify IE number including initial fixed numbers' do
    number = described_class.generate

    expect(number).to match(/\A#{described_class.fixed_initial_numbers.join}/)
  end

  it 'remove an IE number formatting' do
    expect(described_class.strip('07.000.220-7')).to eq('070002207')
  end

  it 'must validate correctly valid IE numbers' do
    expect(described_class.valid?('07.000.220-7')).to be_truthy
    expect(described_class.valid?('07.000.2207')).to be_truthy
    expect(described_class.valid?('07.0002207')).to be_truthy
    expect(described_class.valid?('070002207')).to be_truthy
  end

  it 'is invalid with wrong digits number' do
    expect(described_class.invalid?('07.000.220-70')).to be_truthy
    expect(described_class.invalid?('107.000.220-7')).to be_truthy
  end

  it 'must calculate verify digits' do
    expected = [7]

    expect(described_class.calculate_verify_digits("07.000.220")).to eq(expected)
    expect(described_class.calculate_verify_digits("07.000.220")).to eq(expected)
    expect(described_class.calculate_verify_digits("07000220")).to eq(expected)
  end

  it 'must validate a list of valid IE' do
    numbers = [
      '07.000.220-7',  # Moto Honda
      '06.200.256-2',  # Moto Honda
      '04.156.817-6',  # Moto Honda
      '04.153.370-4',  # Monto Honda
      '04.135.646-2',  # Nokia
      '06.200.267-8',  # Nokia
      '07.000.848-5',  # Nokia
      '06.300.694-4',  # LG
      '06.200.685-1',  # LG
    ].each do |number|
      ie_object = described_class.new(number)
      expect(ie_object).to be_valid
      expect(ie_object).to_not be_invalid
      expect(ie_object.pretty).to eq(number)
      expect(ie_object.strip).to eq(described_class.strip(number))
    end
  end
end