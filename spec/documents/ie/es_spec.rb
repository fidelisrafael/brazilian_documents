require 'spec_helper'

describe BRDocuments::IE::ES do

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
    expect(described_class.pretty("080624685")).to eq("080.624.68-5")
  end

  it 'must prettify IE number including initial fixed numbers' do
    number = described_class.generate

    expect(number).to match(/\A#{described_class.fixed_initial_numbers.join}/)
  end

  it 'remove an IE number formatting' do
    expect(described_class.strip('080.624.68-5')).to eq('080624685')
  end

  it 'must validate correctly valid IE numbers' do
    expect(described_class.valid?('080.624.68-5')).to be_truthy
    expect(described_class.valid?('08062468-5')).to be_truthy
    expect(described_class.valid?('080.624.68-5')).to be_truthy
  end

  it 'is invalid with wrong digits number' do
    expect(described_class.invalid?('080.624.68-51')).to be_truthy
    expect(described_class.invalid?('1080.624.68-5')).to be_truthy
  end

  it 'must calculate verify digits' do
    expected = [5]

    expect(described_class.calculate_verify_digits("080.624.68-5")).to eq(expected)
    expect(described_class.calculate_verify_digits("080.624.68")).to eq(expected)
    expect(described_class.calculate_verify_digits("08062468")).to eq(expected)
  end

  it 'must validate a list of valid IE' do
    numbers = [
      '080.624.68-5', # A GAZETA DO ESPIRITO SANTO RADIO E TV LTDA
      '081.989.93-8', # ABAV - ABATEDOURO ATILIO VIVACQUA LTDA
      '080.507.33-6', # ACTA ENGENHARIA LTDA
      '080.835.35-0', # ALCON COMPANHIA DE ALCOOL CONC DA BARRA
      '080.885.69-1', # ARGALIT INDUSTRIA DE REVESTIMENTOS LTDA
      '082.004.16-1', # COLUMBIA TRADING S.A.
      '080.081.90-8', # METALOSA INDUSTRIA METALURGICA S.A
      '080.805.30-2', # TRIESTE VEICULOS LTDA
      '082.156.62-0', # COSENTINO LATINA LTDA
    ].each do |number|
      ie_object = described_class.new(number)

      expect(ie_object).to be_valid
      expect(ie_object).to_not be_invalid
      expect(ie_object.pretty).to eq(number)
      expect(ie_object.strip).to eq(described_class.strip(number))
    end
  end
end