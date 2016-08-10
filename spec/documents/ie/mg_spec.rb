require 'spec_helper'

describe BRDocuments::IE::MG do

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
    50.times {
      expect(described_class.valid?(described_class.generate)).to be_truthy
    }
  end

  it 'pretty formats an IE number' do
    expect(described_class.pretty("0623079040081")).to eq("062307904.00-81")
  end

  it 'must prettify IE number including initial fixed numbers' do
    number = described_class.generate

    expect(number).to match(/\A#{described_class.fixed_initial_numbers.join}/)
  end

  it 'remove an IE number formatting' do
    expect(described_class.strip('062.307.904/0081')).to eq('0623079040081')
  end

  it 'must validate correctly valid IE numbers' do
    expect(described_class.valid?('062.307.904/0081')).to be_truthy
    expect(described_class.valid?('062.307.904/0081')).to be_truthy
    expect(described_class.valid?('0623079040081')).to be_truthy
  end

  it 'is invalid with wrong digits number' do
    expect(described_class.invalid?('062.307.904/00811')).to be_truthy
    expect(described_class.invalid?('1062.307.904/0081')).to be_truthy
  end

  it 'must calculate verify digits' do
    expected = [8,1]

    expect(described_class.calculate_verify_digits("062.307.904/0081")).to eq(expected)
    expect(described_class.calculate_verify_digits("062.307.904/00")).to eq(expected)
    expect(described_class.calculate_verify_digits("06230790400")).to eq(expected)
  end

  it 'must validate a list of valid IE' do
    numbers = [
      '062307904.00-81', # Exemplo sintegra
      '702386594.00-73', # ALGAR AVIATION TAXI AEREO S/A
      '001094739.00-90', # MINAS GERAIS EDUCACAO SA
      '062013766.01-45', # BANCO MERCANTIL DO BRASIL S A
      '062013766.00-64', # BANCO MERCANTIL DO BRASIL S A (baixado)
      '062001540.00-92', # CIA DE FIACAO E TECIDOS CEDRO E CACHOEIRA 10/05/1927
    ].each do |number|
      ie_object = described_class.new(number)

      expect(ie_object).to be_valid
      expect(ie_object).to_not be_invalid
      expect(ie_object.pretty).to eq(number)
      expect(ie_object.strip).to eq(described_class.strip(number))
    end
  end
end