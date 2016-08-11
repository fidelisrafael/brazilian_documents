require 'spec_helper'
require_relative 'shared_examples'

describe BRDocuments::IE::MT do

  before :all do

    @format_examples = {
      "130000019" => "13.000.001-9"
    }

    @valid_numbers = %w(
      13.000.001-9
      13000001-9
      130000019
    )

    @invalid_numbers = %w(
      1300000191
      1310000019
      13000019
    )

    @valid_verify_digits = {
      [9] => %w(13.000.001-9 13.000.001 13000001)
    }

    @valid_existent_numbers = [
      '13.000.001-9', # Exemplo Sintegra
      '13.324.155-6', # AMAGGI EXPORTAÇÃO E IMPORTAÇÃO LTDA
      '13.020.425-0', # ENERGISA MATO GROSSO - DISTRIBUIDORA DE ENERGIA S. 17/01/2000
      '13.282.948-7', # FIAGRIL LTDA
      '13.067.161-4', # ALL-AMERICA LATINA LOGISTICA MALHA NORTE S/A
      '13.247.769-6', # AGROPECUARIA MAGGI LTDA
      '13.156.709-8', # UNIMED CUIABA COOPERATIVA TRAB MEDICO
      '13.197.865-9', # SUPERMERCADO MODELO LTDA
      '13.379.950-6', # GCLP COMÉRCIO DE ROUPAS EIRELI
      '13.201.070-4', # NABI IMPORT INDUSTRIA E COMERCIO LTDA - EPP
      '13.371.269-9', # BAYER & CIA LTDA ME
    ]
  end

  include_examples "IE basic specs"
end