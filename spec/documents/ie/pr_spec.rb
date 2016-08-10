require 'spec_helper'

describe BRDocuments::IE::PR do

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
    expect(described_class.pretty("4221216097")).to eq("42212160-97")
  end

  it 'must prettify IE number including initial fixed numbers' do
    number = described_class.generate

    expect(number).to match(/\A#{described_class.fixed_initial_numbers.join}/)
  end

  it 'remove an IE number formatting' do
    expect(described_class.strip('42212160-97')).to eq('4221216097')
  end

  it 'must validate correctly valid IE numbers' do
    expect(described_class.valid?('42212160-97')).to be_truthy
    expect(described_class.valid?('4221216097')).to be_truthy
    expect(described_class.valid?('422.121.60-97')).to be_truthy
  end

  it 'is invalid with wrong digits number' do
    expect(described_class.invalid?('42212160-971')).to be_truthy
    expect(described_class.invalid?('412212160-97')).to be_truthy
  end

  it 'must calculate verify digits' do
    expected = [9,7]

    expect(described_class.calculate_verify_digits("42212160-97")).to eq(expected)
    expect(described_class.calculate_verify_digits("42212160")).to eq(expected)
    expect(described_class.calculate_verify_digits("4221216097")).to eq(expected)
  end

  it 'must validate a list of valid IE' do
    numbers = [
      '42212160-97', # ITAIPU BINACIONAL
      '90102000-05', # Renault do Brasil S.A
      '90233099-28', # Copel-Telecom - Copel Telecomunicacoes S.A.
      '41806670-97', # COAMO AGROINDUSTRIAL COOPERATIVA
    ].each do |number|
      ie_object = described_class.new(number)

      expect(ie_object).to be_valid
      expect(ie_object).to_not be_invalid
      expect(ie_object.pretty).to eq(number)
      expect(ie_object.strip).to eq(described_class.strip(number))
    end
  end
end