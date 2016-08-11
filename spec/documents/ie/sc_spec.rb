require 'spec_helper'
require_relative 'shared_examples'

describe BRDocuments::IE::SC do

  before :all do
    @format_examples = {
      "251040852" => "251.040.852"
    }

    @valid_numbers = %w(
      251.040.852
    )

    @invalid_numbers = %w(
      251.040.8522
      251.040.85
      251.040.1852
      25104852
    )

    @valid_verify_digits = {
      [2] => %w( 251.040.852 25104085-2 251040852 ),
      [1] => %w( 255.926.561 255.926.56 25592656 ),
      [0] => %w( 253.645.700 253.645.70 253645700)
    }

    @valid_existent_numbers = [
      '251.040.852', # Exemplo Sintegra
      '255.926.561', # BRF Brasil Food S/A
      '250.126.494', # WEG SA
      '253.645.700', # ENGIE BRASIL ENERGIA S.A.
      '250.166.321', # Centrais Elétricas de Santa Catarina S. A. - CELESC
      '255.266.626', # Celesc Distribuição S. A.
      '255.267.177', # Celesc Geração S. A.
      '253.028.655', # Companhia de Gás de Santa Catarina S.A. - SCGÁS
    ]
  end

  include_examples "IE basic specs"
end