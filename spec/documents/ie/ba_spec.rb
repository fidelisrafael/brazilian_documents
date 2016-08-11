require 'spec_helper'
require_relative 'shared_examples'

describe BRDocuments::IE::BA do

  before :all do

    @format_examples = {
      '001027389' => '001.027.389'
    }

    @valid_numbers = %w(
      001.027.389
      001.027389
      001027389
    )

    @invalid_numbers = %w(
      001.027.3890
      1001.027.389
      001.27.389
    )

    @valid_verify_digits = {
      [8, 9] => %w(001027389 001.027.3 0010273)
    }

    @valid_existent_numbers = [
      '001.027.389', # BRASKEM S/A 01/02/1974
      '026.641.885', # SUZANO PAPEL E CELULOSE S.A. 22/01/1988
      '000.478.696', # COMPANHIA DE ELETRICIDADE DO ESTADO DA BAHIA COELBA 28/03/1960
      '004.539.298', # PIRELLI PNEUS LTDA Feira de Santana 12/02/1969
      '001.764.543', # CARAIBA METAIS S/A  08/05/2013
      '000.608.880', # Vale Manganes - Vale Manganes S.A
      '001.661.097', # LOJAS INSINUANTE S.A. 05/10/1977
      '063.180.808', # COMPANHIA DE GAS DA BAHIA BAHIAGAS 17/04/2008
      '000.665.571', # Embasa - Empresa Baiana de Aguas e Saneamento Sa 31/10/1991
      '030.262.313', # VERACEL CELULOSE S.A.  01/08/1991
      '006.235.527', # BELGO BEKAERT ARAMES LTDA  13/12/2011
      '001.745.616', # DETEN QUIMICA S/A
      '009.871.889', # Monsanto do Brasil 26/08/2011
      '063.595.400', # Gdk - Gdk S.A. Em Recuperacao Judicial 23/04/2004
      '076.813.702', # Brasoil Manati Exploracao Petrolifera S.A. 02/04/2008
      '123.456.63',  # Exemplo Sintegra
      '612.345.57'   # Exemplo Sintegra formato antigo
    ]
  end

  include_examples "IE basic specs"

  it 'must generate root numbers with fixed numbers' do
    klasses = [
      'Digits9::Modulo10',
      'Digits9::Modulo11',
      'Digits8::Modulo10',
      'Digits8::Modulo11'
    ]

    klasses.each do |class_name|
      klass = described_class.const_get(class_name)

      fixed_numbers = klass.const_get('FIXED_INITIAL_NUMBERS').map(&:to_i)
      fixed_position = klass.initial_fix_numbers_position

      100.times {
        numbers = klass.generate_root_numbers
        expect(fixed_numbers).to include(numbers[fixed_position].to_i)
      }
    end
  end

  it 'must allow to generate 4 types of documents' do
    klasses = {
      'Digits9::Modulo10' => [9, 10],
      'Digits9::Modulo11' => [9, 11],
      'Digits8::Modulo10' => [8, 10],
      'Digits8::Modulo11' => [8, 11]
    }

    klasses.each do |class_name, arguments|
      doc_class = described_class.const_get(class_name)

      10.times {
        number = described_class.generate(true, *arguments)
        expect(described_class.valid?(number)).to be_truthy

        klass = described_class.class_for_number(number)
        expect(klass).to be(doc_class)
      }
    end
  end

  it 'must pick 9 digits and use modulo 10 for new generated documents' do
    number = described_class.generate
    klass = described_class.class_for_number(number)

    expect(klass).to be(described_class.const_get('Digits9::Modulo10'))
  end

  it 'must allow random IE format to be generated' do
    10.times {
      number = described_class.rand_generate

      expect(described_class.valid?(number)).to be_truthy
    }
  end
end