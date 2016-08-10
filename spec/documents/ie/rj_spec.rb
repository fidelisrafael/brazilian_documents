require 'spec_helper'

describe BRDocuments::IE::RJ do

  it 'must generate root numbers with fixed numbers' do
    fixed_numbers = described_class.const_get('FIXED_INITIAL_NUMBERS').map(&:to_s)
    fixed_position = described_class.initial_fix_numbers_position

    10.times {
      numbers = described_class.generate_root_numbers
      expect(fixed_numbers).to include(numbers[fixed_position..1].join)
    }
  end

  it 'generate documents must have valid fixed numbers' do
    document = described_class.new(described_class.generate)

    expect(document.valid_fixed_numbers?).to be_truthy
  end

  it 'must generate valid IE' do
    10.times {
      expect(described_class.valid?(described_class.generate)).to be_truthy
    }
  end

  it 'pretty formats an IE number' do
    expect(described_class.pretty("81293279")).to eq("81.293.279")
  end

  it 'must prettify IE number including initial fixed numbers' do
    number = described_class.generate

    regexp = %r{\A#{described_class.const_get('FIXED_INITIAL_NUMBERS').join('|')}}

    expect(number).to match(regexp)
  end

  it 'remove an IE number formatting' do
    expect(described_class.strip('8129327-9')).to eq('81293279')
  end

  it 'must validate correctly valid IE numbers' do
    expect(described_class.valid?('8129327-9')).to be_truthy
    expect(described_class.valid?('812.932.79')).to be_truthy
    expect(described_class.valid?('81293279')).to be_truthy
  end

  it 'is invalid with wrong digits number' do
    expect(described_class.invalid?('8129327-91')).to be_truthy
  end

  it 'must calculate verify digits' do
    expected = [9]

    expect(described_class.calculate_verify_digits("8129327-9")).to eq(expected)
    expect(described_class.calculate_verify_digits("8129327")).to eq(expected)
    expect(described_class.calculate_verify_digits("81293279")).to eq(expected)
  end

  it 'must validate a list of valid IE' do
    numbers = [
      '81.293.279', # PETROBRAS DISTRIBUIDORA SA
      '80.495.072', # Vale 1986
      '81.306.141', # RAIZEN COMBUSTIVEIS S A 17/11/1977
      '81.680.469', # TELEMAR NORTE LESTE S/A 1978
      '81.281.777', # COMPANHIA SIDERURGICA NACIONAL 1977
      '81.380.023', # LIGHT SERVICOS DE ELETRICIDADE S A
      '84.780.707', # COMPANHIA ESTADUAL DE AGUAS E ESGOTOS - CEDAE
    ].each do |number|
      ie_object = described_class.new(number)

      expect(ie_object).to be_valid
      expect(ie_object).to_not be_invalid
      expect(ie_object.pretty).to eq(number)
      expect(ie_object.strip).to eq(described_class.strip(number))
    end
  end
end