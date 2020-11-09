require 'spec_helper'
require_relative 'shared_examples'

describe BRDocuments::IE::DF do

  before :all do

    @format_examples = {
      "0730000100109" => "07.300.001.001-09"
    }

    @valid_numbers = %w(
      07.300.001.001-09
      07.300001001-09
      0730000100109
      0800877000167
    )

    @invalid_numbers = %w(
      07.300.001.001-091
      107.300.001.001-09
      107.300.001.01-09
    )

    @valid_verify_digits = {
      [0, 9] => %w(07.300.001.001-09 07.300.001.00109 0730000100109)
    }

    @valid_existent_numbers = [
      '07.300.001.001-09', # Exemplo Sintegra
      '07.441.356.001-93', # Oi
      '07.326.199.001-83', # CENTRAIS ELETRICAS DO NORTE DO BRASIL S/A
      '07.317.963.001-13', # EMPRESA BRASILEIRA DE INFRA-ESTRUTURA AEROPORTUARIA 1994
      '07.518.585.001-66', # CASA DA MOEDA DO BRASIL
      '07.326.199.001-83', # CENTRAIS ELETRICAS DO NORTE DO BRASIL S/A
      '07.312.777.001-70', # COMPANHIA NACIONAL DE ABASTECIMENTO CONAB,
      '08.008.770.001-67', # JMX IMPORTACAO E COMERCIO DE TELEFONIA LTDA
    ]
  end

  include_examples "IE basic specs"
end