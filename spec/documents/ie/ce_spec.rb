require 'spec_helper'

describe BRDocuments::IE::CE do

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
    expect(described_class.pretty("060000015")).to eq("06.000001-5")
  end

  it 'must prettify IE number including initial fixed numbers' do
    number = described_class.generate

    expect(number).to match(/\A#{described_class.fixed_initial_numbers.join}/)
  end

  it 'remove an IE number formatting' do
    expect(described_class.strip('06000001-5')).to eq('060000015')
  end

  it 'must validate correctly valid IE numbers' do
    expect(described_class.valid?('060000015')).to be_truthy
    expect(described_class.valid?('06.000.001-5')).to be_truthy
    expect(described_class.valid?('06000001-5')).to be_truthy
  end

  it 'is invalid with wrong digits number' do
    expect(described_class.invalid?('0600000151')).to be_truthy
    expect(described_class.invalid?('1060000015')).to be_truthy
  end

  it 'must calculate verify digits' do
    expected = [5]

    expect(described_class.calculate_verify_digits("060000015")).to eq(expected)
    expect(described_class.calculate_verify_digits("06000001")).to eq(expected)
    expect(described_class.calculate_verify_digits("06.000.001")).to eq(expected)
  end

  it 'must validate a list of valid IE' do
    numbers = [
      '06.105848-3', # COMPANHIA ENERGETICA DO CEARA COELCE
      '06.102615-8', # MDIAS BRANCO S A INDUSTRIA E COMERCIO DE ALIMENTOS
      '06.845128-8', # EMPREENDIMENTOS PAGUE MENOS S/A
      '06.204166-5', # J MACEDO S/A
      '06.916113-5', # GRENDENE S A
      '06.105002-4', # VICUNHA TEXTIL S A
      '06.282598-4', # NORSA REFRIGERANTES LTDA
      '06.864509-0', # TRES CORACOES ALIMENTOS S/A
      '06.699030-0', # EIT EMPRESA INDUSTRIAL TECNICA S A EM RECUPERACAO JUDICIAL
      '06.276959-6', # ESMALTEC S A
      '06.666801-8', # CGTF CENTRAL GERADORA TERMELETRICA FORTALEZA S A
      '06.859236-1', # COMPANHIA DE AGUA E ESGOTO DO CEARA CAGECE
    ].each do |number|
      ie_object = described_class.new(number)

      expect(ie_object).to be_valid
      expect(ie_object).to_not be_invalid
      expect(ie_object.pretty).to eq(number)
      expect(ie_object.strip).to eq(described_class.strip(number))
    end
  end
end