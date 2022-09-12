require 'spec_helper'
require_relative 'shared_examples'

describe BRDocuments::IE::CE do

  before :all do

    @format_examples = {
      "060000015" => "06.000001-5",
      "070558604" => "07.055860-4"
    }

    @valid_numbers = %w(
      060000015
      06.000.001-5
      06000001-5
      070558604
      07.055.860-4
    )

    @invalid_numbers = %w(
      0600000151
      1060000015
      060000051
      070558601
      0705586041
      1070558604
    )

    @valid_verify_digits = {
      [5] => %w(060000015 06000001 06.000.001)
    }

    @valid_existent_numbers = [
      '06.105848-3', # COMPANHIA ENERGETICA DO CEARA COELCE
      '06.102615-8', # MDIAS BRANCO S A INDUSTRIA E COMERCIO DE ALIMENTOS
      '06.845128-8', # EMPREENDIMENTOS PAGUE MENOS S/A
      '06.204166-5', # J MACEDO S/A
      '06.916113-5', # GRENDENE S A
      '06.105002-4', # VICUNHA TEXTIL S A
      '06.282598-4', # NORSA REFRIGERANTES LTDA
      '06.864509-0', # TRES CORACOES ALIMENTOS S/A
      '06.699030-0', # EIT EMPRESA INDUSTRIAL TECNICA S A EM RECUPERACAO JUDICIAL
      '06.276959-6', # ESMALTEC S A
      '06.666801-8', # CGTF CENTRAL GERADORA TERMELETRICA FORTALEZA S A
      '06.859236-1', # COMPANHIA DE AGUA E ESGOTO DO CEARA CAGECE
      '07.055860-4', # SOME RANDOM NUMBERS STARTED WITH 7
    ]
  end

  include_examples "IE basic specs"
end