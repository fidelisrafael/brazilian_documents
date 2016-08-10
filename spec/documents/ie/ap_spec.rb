require 'spec_helper'

describe BRDocuments::IE::AP do

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
    expect(described_class.pretty("030123459")).to eq("03.012345-9")
  end

  it 'must prettify IE number including initial fixed numbers' do
    number = described_class.generate

    expect(number).to match(/\A#{described_class.fixed_initial_numbers.join}/)
  end

  it 'remove an IE number formatting' do
    expect(described_class.strip('03.012.345-9')).to eq('030123459')
  end

  it 'must validate correctly valid IE numbers' do
    expect(described_class.valid?('03.012.345-9')).to be_truthy
    expect(described_class.valid?('03.012345-9')).to be_truthy
    expect(described_class.valid?('03.012.345-9')).to be_truthy
  end

  it 'is invalid with wrong digits number' do
    expect(described_class.invalid?('03.0123.459-0')).to be_truthy
    expect(described_class.invalid?('03.101.234-59')).to be_truthy
  end

  it 'must calculate verify digits' do
    expected = [9]

    expect(described_class.calculate_verify_digits("030123459")).to eq(expected)
    expect(described_class.calculate_verify_digits("03.012.345")).to eq(expected)
    expect(described_class.calculate_verify_digits("03.012-345")).to eq(expected)
  end

  it 'must validate a list of valid IE' do
    numbers = [
      '03.012345-9',  # Exemplo sintegra.gov
      '03.008674-0',  # COMPANHIA DE AGUA E ESGOTOS DO AMAPA - CAESA
      '03.002994-0',  # CEA - Companhia de Eletricidade do Amapá
      '03.049903-8',  # CINEPOLIS OPERADORA DE CINEMAS DO BRASIL LTDA
      '03.009439-4',  # CNA Macapá (NADSON P. P. VALENTE-ME)
      '03.021834-9',  # SOCIEDADE EDUCACIONAL DA AMAZONIA LTDA
      '03.033529-9',  # Hotel Ibis Macapá (BETRAL RENT A CAR LTDA)
    ].each do |number|
      ie_object = described_class.new(number)

      expect(ie_object).to be_valid
      expect(ie_object).to_not be_invalid
      expect(ie_object.pretty).to eq(number)
      expect(ie_object.strip).to eq(described_class.strip(number))
    end
  end
end