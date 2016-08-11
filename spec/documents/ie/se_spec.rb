require 'spec_helper'
require_relative 'shared_examples'

describe BRDocuments::IE::SE do

  before :all do
    @format_examples = {
      '271234563' => '27.123.456-3'
    }

    @valid_numbers = %w(
      27.123.456-3
      27.123.4563
      27123456-3
    )

    @invalid_numbers = %w(
      27.123.456-31
      27.123.453
      27.1123.456-3
    )

    @valid_verify_digits = {
      [3] => %w(27.123.456-3 27123456-3 27123456 271234563)
      [0] => %w(27.000.251-0 27.000.251 27000251)
    }

    @valid_existent_numbers = [
      '27.123.456-3', # Exemplo Sintegra
      '27.076.743-6', # ENERGISA SERGIPE - DISTRIBUIDORA DE ENERGIA S.A. 1966
      '27.105.210-4', # CENCOSUD BRASIL COMERCIAL LTDA G Barbosa
      '27.051.036-2', # COMPANHIA DE SANEAMENTO DE SERGIPE - DESO
      '27.000.251-0', # SERGIPE INDUSTRIAL TEXTIL LTDA
      '27.003.407-2', # CIA SUL SERGIPANA DE ELETRICIDADE
      '27.072.532-6', # CERAMICA SERGIPE INDUSTRIA E COMERCIO LTDA
    ]
  end

  include_examples "IE basic specs"
end