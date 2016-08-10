require 'spec_helper'

describe BRDocuments::IE::GO do

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
    expect(described_class.pretty("101399693")).to eq("10.139.969-3")
  end

  it 'must prettify IE number including initial fixed numbers' do
    number = described_class.generate

    expect(number).to match(/\A#{described_class.fixed_initial_numbers.join}/)
  end

  it 'remove an IE number formatting' do
    expect(described_class.strip('10.139.969-3')).to eq('101399693')
  end

  it 'must validate correctly valid IE numbers' do
    expect(described_class.valid?('10.139.969-3')).to be_truthy
    expect(described_class.valid?('10139969-3')).to be_truthy
    expect(described_class.valid?('101399693')).to be_truthy
  end

  it 'is invalid with wrong digits number' do
    expect(described_class.invalid?('10.139.969-31')).to be_truthy
    expect(described_class.invalid?('110.139.969-3')).to be_truthy
  end

  it 'must calculate verify digits' do
    expected = [3]

    expect(described_class.calculate_verify_digits("10.139.969-3")).to eq(expected)
    expect(described_class.calculate_verify_digits("10.139.969")).to eq(expected)
    expect(described_class.calculate_verify_digits("10139969")).to eq(expected)
  end

  it 'must validate a list of valid IE' do
    numbers = [
      '10.139.969-3', # PANPHARMA DISTRIBUIDORA DE MEDICAMENTOS LTDA. 1990
      '10.013.357-6', # SANEAMENTO DE GOIAS S/A 09/07/1984
      '10.054.942-0', # CELG DISTRIBUICAO S.A. - CELG D 13/03/1989
      '10.398.152-7', # HOTELARIA ACCOR BRASIL S/A 21/03/2006
      '10.394.194-0', # WAL - MART BRASIL LTDA 09/11/2005
      '10.580.075-9', # Ambev GO
      '10.368.446-8', # PRODUTOS ROCHE QUIMICOS E FARMACEUTICOS S A
      '10.166.488-5', # REFRESCOS BANDEIRANTES INDUSTRIA E COMERCIO LTDA
      '10.349.118-0', # CENCOSUD BRASIL COMERCIAL LTDA - Bretas 2002
      '10.297.851-4', # CENCOSUD BRASIL COMERCIAL LTDA - Bretas 1997
      '10.506.343-6', # CENCOSUD BRASIL COMERCIAL LTDA - Bretas 2011
      '10.005.565-6', # PRODUTOS ALIMENTICIOS ORLANDIA  1986
      '10.314.113-8', # SAUDE INDUSTRIA E COMERCIO DE AGUA MINERALE SERVIÇOS LTDA 1999
      '10.446.955-2', # 2009
    ].each do |number|
      ie_object = described_class.new(number)

      expect(ie_object).to be_valid
      expect(ie_object).to_not be_invalid
      expect(ie_object.pretty).to eq(number)
      expect(ie_object.strip).to eq(described_class.strip(number))
    end
  end
end