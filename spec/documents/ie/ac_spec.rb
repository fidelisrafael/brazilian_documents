require 'spec_helper'

describe BRDocuments::IE::AC do

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
    expect(described_class.pretty("0100482300112")).to eq("01.004.823/001-12")
  end

  it 'must prettify IE number including initial fixed numbers' do
    number = described_class.generate

    expect(number).to match(/\A#{described_class.fixed_initial_numbers.join}/)
  end

  it 'remove an IE number formatting' do
    expect(described_class.strip('01.004.823/001-12')).to eq('0100482300112')
  end

  it 'must validate correctly valid IE numbers' do
    expect(described_class.valid?('01.004.823/001-12')).to be_truthy
    expect(described_class.valid?('01004823/001-12')).to be_truthy
    expect(described_class.valid?('01004823001-12')).to be_truthy
    expect(described_class.valid?('0100482300112')).to be_truthy
  end

  it 'is invalid with wrong digits number' do
    expect(described_class.invalid?('01.004.823/001-122')).to be_truthy
    expect(described_class.invalid?('01.004.823/001-122')).to be_truthy
    expect(described_class.valid?('01.004.823/001-122')).to be_falsey
    expect(described_class.valid?('101.004.823/001-12')).to be_falsey
  end

  it 'must calculate verify digits' do
    expected = [1,2]

    expect(described_class.calculate_verify_digits("01.004.823/001-12")).to eq(expected)
    expect(described_class.calculate_verify_digits("01.004.823/001")).to eq(expected)
    expect(described_class.calculate_verify_digits("01004823001")).to eq(expected)
  end

  it 'must validate a list of valid IE' do
    %w(
       01.966.402/850-16
       01.661.230/759-62
       01.512.383/878-70
       01.044.877/188-51
       01.420.462/883-00
       01.209.489/734-80
       01.153.113/681-28
       01.791.547/394-65
       01.075.519/201-77
    ).each do |number|
      ie_object = described_class.new(number)
      expect(ie_object).to be_valid
      expect(ie_object).to_not be_invalid
      expect(ie_object.pretty).to eq(number)
      expect(ie_object.strip).to eq(described_class.strip(number))
    end
  end

  it 'must be invalid if dont starts with fixed initial numbers' do
    expect(described_class.valid?('02.966.402/850-16')).to be_falsey
    expect(described_class.valid?('04.966.402/850-16')).to be_falsey
  end
end