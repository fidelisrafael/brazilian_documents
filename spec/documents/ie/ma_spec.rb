require 'spec_helper'
require_relative 'shared_examples'

describe BRDocuments::IE::MA do

  before :all do

    @format_examples = {
      "120000385" => "12.000.038-5"
    }

    @valid_numbers = %w(
      12.000.038-5
      12000038-5
      120000385
    )

    @invalid_numbers = %w(
      12.000.038-51
      12.000.03-51
      121.000.038-5
    )

    @valid_verify_digits = {
      [5] => %w(12.000.038-5 12.000.038 12000038)
    }

    @valid_existent_numbers = [
      '12.085.506-2', # PETROLEO BRASILEIRO S A PETROBRAS
      '12.051.511-3', # COMPANHIA ENERGETICA DO MARANHAO CEMAR
      '12.051.297-1', # PETROBRAS DISTRIBUIDORA S A
      '12.423.718-5', # AMBEV S A
      '12.190.396-6', # TIM CELULAR S A
      '12.398.704-0', # OI MOVEL S.A
      '12.201.918-0', # TELEFONICA BRASIL S A
      '12.243.194-4', # CLARO S A
      '12.298.232-0', # IMIFARMA PRODUTOS FARMACEUTICOS E COSMETICOS SA
    ]
  end

  include_examples "IE basic specs"
end