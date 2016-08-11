require 'spec_helper'
require_relative 'shared_examples'

describe BRDocuments::IE::ES do

  before :all do

    @format_examples = {
      "080624685" => "080.624.68-5"
    }

    @valid_numbers = %w(
      080.624.68-5
      08062468-5
      080.624.68-5
    )

    @invalid_numbers = %w(
      080.624.68-51
      080.624.168-5
      080.624.8-5
    )

    @valid_verify_digits = {
      [5] => %w(080.624.68-5 080.624.68 08062468)
    }

    @valid_existent_numbers = [
      '080.624.68-5', # A GAZETA DO ESPIRITO SANTO RADIO E TV LTDA
      '081.989.93-8', # ABAV - ABATEDOURO ATILIO VIVACQUA LTDA
      '080.507.33-6', # ACTA ENGENHARIA LTDA
      '080.835.35-0', # ALCON COMPANHIA DE ALCOOL CONC DA BARRA
      '080.885.69-1', # ARGALIT INDUSTRIA DE REVESTIMENTOS LTDA
      '082.004.16-1', # COLUMBIA TRADING S.A.
      '080.081.90-8', # METALOSA INDUSTRIA METALURGICA S.A
      '080.805.30-2', # TRIESTE VEICULOS LTDA
      '082.156.62-0', # COSENTINO LATINA LTDA
    ]
  end

  include_examples "IE basic specs"
end