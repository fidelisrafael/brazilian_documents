require 'spec_helper'
require_relative 'shared_examples'

describe BRDocuments::IE::SP do

  before :all do
    @format_examples = {
      '110042490114' => '110.042.490.114',
      # number => [pretty, stripped]
      'P011004243002' => ['P-01100424.3/002', '011004243002']
    }

    @valid_numbers = %w(
      110.042.490.114
      110042490114
      P-01100424.3/002
      P-011004243002
      P011004243002
    )

    @invalid_numbers = %w(
      110.042.490.113
      110.042.491.114
      110.042.49.114
      110.042.490.11
    )

    @valid_verify_digits = {
      [0, 4] => %w(110.042.490.114 110.042.49.11 1100424911),
      [3] => %w(P011004243002 P01100424002 P-011.004.243.002)
    }

    @valid_existent_numbers = [
      '102.614.327.119', # COMPANHIA ULTRAGAZ S/A
      '104.871.489.118', # CARGILL AGRICOLA S A 1965
      '104.120.688.115', # COMPANHIA BRASILEIRA DE DISTRIBUICAO | Pão de açucar
      '109.184.763.118', # COMPANHIA BRASILEIRA DE DISTRIBUICAO | Pão de açucar
      '116.167.080.117', # COMPANHIA BRASILEIRA DE DISTRIBUICAO | Pão de açucar
      '116.804.053.119', # COMPANHIA BRASILEIRA DE DISTRIBUICAO | Pão de açucar
      '103.874.615.112', # COMPANHIA BRASILEIRA DE DISTRIBUICAO | Pão de açucar
      '105.475.569.116', # COMPANHIA BRASILEIRA DE DISTRIBUICAO | Pão de açucar
      '104.157.953.116', # COMPANHIA BRASILEIRA DE DISTRIBUICAO | Pão de açucar
      '145.848.640.117', # COMPANHIA BRASILEIRA DE DISTRIBUICAO | Pão de açucar
      '636.192.740.114', # COMPANHIA BRASILEIRA DE DISTRIBUICAO | Pão de açucar
      '623.097.238.116', # COMPANHIA BRASILEIRA DE DISTRIBUICAO | Pão de açucar
      '111.123.980.116', # LOUIS DREYFUS COMPANY BRASIL S.A.
    ]
  end

  include_examples "IE basic specs"
end