require 'spec_helper'
require_relative 'shared_examples'

describe BRDocuments::IE::PE do
  before :all do

    @format_examples = {
      "032141840" => "0321418-40"
    }

    @valid_numbers = %w(
      0321418-40
      03.214.18-40
      032141840
    )

    @invalid_numbers = %w(
      0321418-401
      03121418-40
      0312141-40
    )

    @valid_verify_digits = {
      [4, 0] => %w(0321418-40 0321418 03.21418),
      [9]    => %w(18.1.001.0000004-9 18.1.001.0000004)
    }

    @valid_existent_numbers = [
      '0321418-40', # Exemplo sintegra,
      '18.1.001.0000004-9', # Exemplo Sintegra (Legado)
      '0005943-93', # COMPANHIA ENERGETICA DE PERNAMBUCO
      '0014398-71', # COMPANHIA PERNAMBUCANA DE SANEAMENTO
      '0607699-80', # VOTORANTIM CIMENTOS N/NE S/A
      '0318537-06', # M&G POLIMEROS BRASIL S.A.
      '0327800-01', # REFRESCOS GUARARAPES LTDA COCA COLA
      '0342771-45', # ESTALEIRO ATLANTICO SUL S/A
      '0290946-40', # ELLO-PUMA DISTRIBUIDORA DE COMBUSTIVEIS S/A
      '0125831-11', # FEDEX BRASIL LOGISTICA E TRANSPORTE S.A.
      '0287455-58', # CONSORCIO OP TERMOPE
      '0148778-72', # WHITE MARTINS GASES INDUSTRIAIS DO NORDESTE LTDA.
      '0008854-44', # ACUMULADORES MOURA S/A  Baterias Moura
      '18.1.080.0279713-1', # M&G FIBRAS BRASIL LTDA. (Antiga)
      '0279713-50', # M&G FIBRAS BRASIL LTDA.
    ]
  end

  include_examples "IE basic specs"

  it 'must check if number is legacy' do
    expect(described_class.legacy?("18.1.001.0000004-9")).to be_truthy
    expect(described_class.legacy?("0321418-40")).to be_falsey
  end

  it 'must allow legacy numbers generation' do
    number = described_class.generate(true, true)

    expect(described_class.legacy?(number)).to be_truthy
    expect(described_class.valid?(number)).to be_truthy
  end
end