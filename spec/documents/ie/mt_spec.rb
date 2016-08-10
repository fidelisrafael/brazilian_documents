require 'spec_helper'

describe BRDocuments::IE::MT do

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
    expect(described_class.pretty("130000019")).to eq("13.000.001-9")
  end

  it 'must prettify IE number including initial fixed numbers' do
    number = described_class.generate

    expect(number).to match(/\A#{described_class.fixed_initial_numbers.join}/)
  end

  it 'remove an IE number formatting' do
    expect(described_class.strip('13.000.001-9')).to eq('130000019')
  end

  it 'must validate correctly valid IE numbers' do
    expect(described_class.valid?('13.000.001-9')).to be_truthy
    expect(described_class.valid?('13000001-9')).to be_truthy
    expect(described_class.valid?('130000019')).to be_truthy
  end

  it 'is invalid with wrong digits number' do
    expect(described_class.invalid?('1300000191')).to be_truthy
    expect(described_class.invalid?('1310000019')).to be_truthy
  end

  it 'must calculate verify digits' do
    expected = [9]

    expect(described_class.calculate_verify_digits("13.000.001-9")).to eq(expected)
    expect(described_class.calculate_verify_digits("13.000.001")).to eq(expected)
    expect(described_class.calculate_verify_digits("13000001")).to eq(expected)
  end

  it 'must validate a list of valid IE' do
    numbers = [
      '13.000.001-9', # Exemplo Sintegra
      '13.324.155-6', # AMAGGI EXPORTAÇÃO E IMPORTAÇÃO LTDA
      '13.020.425-0', # ENERGISA MATO GROSSO - DISTRIBUIDORA DE ENERGIA S. 17/01/2000
      '13.282.948-7', # FIAGRIL LTDA
      '13.067.161-4', # ALL-AMERICA LATINA LOGISTICA MALHA NORTE S/A
      '13.247.769-6', # AGROPECUARIA MAGGI LTDA
      '13.156.709-8', # UNIMED CUIABA COOPERATIVA TRAB MEDICO
      '13.197.865-9', # SUPERMERCADO MODELO LTDA
      '13.379.950-6', # GCLP COMÉRCIO DE ROUPAS EIRELI
      '13.201.070-4', # NABI IMPORT INDUSTRIA E COMERCIO LTDA - EPP
      '13.371.269-9', # BAYER & CIA LTDA ME
    ].each do |number|
      ie_object = described_class.new(number)

      expect(ie_object).to be_valid
      expect(ie_object).to_not be_invalid
      expect(ie_object.pretty).to eq(number)
      expect(ie_object.strip).to eq(described_class.strip(number))
    end
  end
end