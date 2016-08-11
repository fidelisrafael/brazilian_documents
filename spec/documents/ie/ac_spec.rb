require 'spec_helper'
require_relative 'shared_examples'

describe BRDocuments::IE::AC do

  before :all do

    @format_examples = {
      "0100482300112" => "01.004.823/001-12"
    }

    @valid_numbers = %w(
      01.004.823/001-12
      01004823/001-12
      01004823001-12
      0100482300112
      01.661.230/759-62
      01.512.383/878-70
      01.044.877/188-51
      01.420.462/883-00
      01.209.489/734-80
      01.153.113/681-28
      01.791.547/394-65
      01.075.519/201-77
    )

    @invalid_numbers = %w(
      01.004.823/001-122
      101.004.823/001-12
    )

    @valid_verify_digits = {
      [1,2] => %w(01.004.823/001-12 01.004.823/001 01004823001)
    }

    @valid_existent_numbers = [
      '01.966.402/850-16', # Exemplo Sintegra
      '01.004.141/001-46', # COMPANHIA DE ELETRICIDADE DO ACRE
      '01.007.923/001-37', # COMPANHIA DE SANEAMENTO DO ESTADO DO ACRE
      '01.021.182/001-38', # COOP DE TRANSPORTES DE CARGAS RIO BRANCO
      '01.018.483/001-78', # VIVO S/A
    ]
  end

  include_examples "IE basic specs"
end