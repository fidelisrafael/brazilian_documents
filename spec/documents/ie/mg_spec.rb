require 'spec_helper'
require_relative 'shared_examples'

describe BRDocuments::IE::MG do

  before :all do

    @format_examples = {
      "0623079040081" => "062307904.00-81"
    }

    @valid_numbers = %w(
      062.307.904/0081
      062.307.904/0081
      0623079040081
    )

    @invalid_numbers = %w(
      062.307.904/00811
      1062.307.904/0081
    )

    @valid_verify_digits = {
      [8,1] => %w(062.307.904/0081 062.307.904/00 06230790400)
    }

    @valid_existent_numbers = [
      '062307904.00-81', # Exemplo sintegra
      '702386594.00-73', # ALGAR AVIATION TAXI AEREO S/A
      '001094739.00-90', # MINAS GERAIS EDUCACAO SA
      '062013766.01-45', # BANCO MERCANTIL DO BRASIL S A
      '062013766.00-64', # BANCO MERCANTIL DO BRASIL S A (baixado)
      '062001540.00-92', # CIA DE FIACAO E TECIDOS CEDRO E CACHOEIRA 10/05/1927
      '001082350.00-98', # M&G FIbras
    ]
  end

  include_examples "IE basic specs"
end