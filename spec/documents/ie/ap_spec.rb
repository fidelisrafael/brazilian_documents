require 'spec_helper'
require_relative 'shared_examples'

describe BRDocuments::IE::AP do

  before :all do

    @format_examples = {
      '030123459' => '03.012345-9'
    }

    @valid_numbers = %w(
      03.012.345-9
      03.012345-9
      03.012.345-9
    )

    @invalid_numbers = %w(
      03.0123.459-0
      03.101.234-59
    )

    @valid_verify_digits = {
      [9] => %w(030123459 03.012.345 03.012-345)
    }

    @valid_existent_numbers = [
      '03.012345-9',  # Exemplo sintegra.gov
      '03.008674-0',  # COMPANHIA DE AGUA E ESGOTOS DO AMAPA - CAESA
      '03.002994-0',  # CEA - Companhia de Eletricidade do Amapá
      '03.049903-8',  # CINEPOLIS OPERADORA DE CINEMAS DO BRASIL LTDA
      '03.009439-4',  # CNA Macapá (NADSON P. P. VALENTE-ME)
      '03.021834-9',  # SOCIEDADE EDUCACIONAL DA AMAZONIA LTDA
      '03.033529-9',  # Hotel Ibis Macapá (BETRAL RENT A CAR LTDA)
    ]
  end

  include_examples "IE basic specs"
end