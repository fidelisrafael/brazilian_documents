require 'spec_helper'
require_relative 'shared_examples'

describe BRDocuments::IE::RN do

  before :all do
    @format_examples = {
      "203024508" => "20.302.450-8"
    }

    @valid_numbers = %w(20.302.450-8 20302450-8 203024508)

    @invalid_numbers = %w(20.302.450-81 20.1302.450-8)

    @valid_verify_digits = {
      [8] => %w(20.302.450-8 20.302.450 20302450)
    }

    @valid_existent_numbers = [
      '20.302.450-8', # PETROLEO BRASILEIRO S A PETROBRAS
      '20.055.199-0', # COMPANHIA ENERGETICA DO RIO GRANDE DO NORTE COSERN
      '20.054.091-2', # TELEMAR NORTE LESTE S/A
      '20.001.611-3', # GUARARAPES CONFECCOES S/A
      '20.302.178-9', # TNL PCS SA
      '20.003.548-7', # SOUZA CRUZ S/A
      '20.001.816-7', # SUPERMERCADO NORDESTAO LTDA
      '20.300.487-6', # AMBEV BRASIL BEBIDAS S.A.
      '20.088.161-2', # BOMPRECO SUPERMERCADOS DO NORDESTE LTDA
    ]
  end

  include_examples "IE basic specs"
end