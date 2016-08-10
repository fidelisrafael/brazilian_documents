require 'spec_helper'

describe BRDocuments::IE::AL do

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
    expect(described_class.pretty("240000048")).to eq("24.000004-8")
  end

  it 'must prettify IE number including initial fixed numbers' do
    number = described_class.generate

    expect(number).to match(/\A#{described_class.fixed_initial_numbers.join}/)
  end

  it 'remove an IE number formatting' do
    expect(described_class.strip('24.000004-8')).to eq('240000048')
  end

  it 'must validate correctly valid IE numbers' do
    expect(described_class.valid?('240000048')).to be_truthy
    expect(described_class.valid?('24.000.004-8')).to be_truthy
    expect(described_class.valid?('24.000004.8')).to be_truthy
    expect(described_class.valid?('24000004-8')).to be_truthy
  end

  it 'is invalid with wrong digits number' do
    expect(described_class.invalid?('24.000.004-80')).to be_truthy
    expect(described_class.invalid?('124.000.004-8')).to be_truthy
    expect(described_class.valid?('24.000.004-80')).to be_falsey
    expect(described_class.valid?('124.000.004-8')).to be_falsey
  end

  it 'must calculate verify digits' do
    expected = [8]

    expect(described_class.calculate_verify_digits("24.000.004")).to eq(expected)
    expect(described_class.calculate_verify_digits("24.000004")).to eq(expected)
    expect(described_class.calculate_verify_digits("24000004")).to eq(expected)
  end

  it 'must validate a list of valid IE' do
    %w(
       24.810989-8
       24.840219-6
       24.838692-1
       24.885944-7
       24.860732-4
       24.817955-1
       24.577875-6
       24.757527-5
       24.864992-2
    ).each do |number|
      ie_object = described_class.new(number)
      expect(ie_object).to be_valid
      expect(ie_object).to_not be_invalid
      expect(ie_object.pretty).to eq(number)
      expect(ie_object.strip).to eq(described_class.strip(number))
    end
  end

  it 'must be invalid if dont starts with fixed initial numbers' do
    expect(described_class.valid?('14.810989-8')).to be_falsey
    expect(described_class.valid?('04.810989-8')).to be_falsey
  end

  it 'must handle companies type methods' do
    expect(described_class.company_type('24.864992-2')).to eq('Micro-Empresa')
    expect(described_class.company_type('24.577875-6')).to eq('Substituta')
    expect(described_class.company_type_digit('24.577875-6')).to eq('5')
    expect(described_class.company_type_digit('24.885944-7')).to eq('8')
  end

  it 'must generate a number with valid company type digit' do
    10.times {
      number = described_class.generate

      expect(described_class.company_type(number)).to_not be_nil
    }
  end
end