require 'spec_helper'
require_relative 'shared_examples'

describe BRDocuments::IE::PA do

  before :all do

    @format_examples = {
      "150696655" => "15.069.665-5"
    }

    @valid_numbers = %w(
      15.069.665-5
      15069665-5
      150696655
    )

    @invalid_numbers = %w(
      1506966551
      150696651
      1510696655
    )

    @valid_verify_digits = {
      [5] => %w(15.069.665-5 15.069.665 15069665)
    }

    @valid_existent_numbers = [
      '15.999.999-5', # Exemplo Sintegra
      '15.000.614-4', # Y Yamada Sa Comercio e Industria
      '15.069.665-5', # ALBRAS ALUMINIO BRASILEIRO S.A
      '15.074.998-8', # COMPANHIA DE SANEAMENTO DO PARA
      '15.286.652-3', # Companhia Docas do Para
      '15.050.675-9', # Banpara - Banco do Estado do Para S A 26/10/1961
    ]
  end

  include_examples "IE basic specs"
end