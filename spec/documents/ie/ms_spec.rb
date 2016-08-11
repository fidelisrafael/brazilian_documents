require 'spec_helper'
require_relative 'shared_examples'

describe BRDocuments::IE::MS do

  before :all do

    @format_examples = {
      "280084617" => "28.008.461-7"
    }

    @valid_numbers = %w(
      28.008.461-7
      28.008461-7
      280084617
    )

    @invalid_numbers = %w(
      28.008.461-71
      28.1008.461-7
      28.108.46-7
    )

    @valid_verify_digits = {
      [7] => %w(28.008.461-7 28.008.461 280084617)
    }

    @valid_existent_numbers = [
      '28.008.461-7', # COPAGAZ
      '28.090.459-2', # Rede Matogrossense de Televisao
      '28.267.793-3', # Nucleo da Pgpm Mato Grosso do Sul
      '28.302.733-9', # Unidade Mercado de Opcoes Mato Grosso do Sul
      '28.105.553-0', # Energisa - Energisa Mato Grosso do Sul - Distribuidora de Energia S.A.
      '28.310.991-2', # Energisa - Energisa Mato Grosso do Sul - Distribuidora de Energia S.A.
      '28.204.297-0', # Empresa Funeraria Mato Grosso do Sul Ltda - ME
      '28.222.911-6', # Correio do Estado Sa
    ]
  end

  include_examples "IE basic specs"
end