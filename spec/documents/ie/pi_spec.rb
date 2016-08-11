require 'spec_helper'
require_relative 'shared_examples'

describe BRDocuments::IE::PI do

  before :all do

    @format_examples = {
      "193013835" => "19301383-5"
    }

    @valid_numbers = %w(
      19301383-5
      19-3013835
      193013835
    )

    @invalid_numbers = %w(
      19301383-51
      19301383-511
      193013-51
    )

    @valid_verify_digits = {
      [5] => %w(19301383-5 19301383)
    }

    @valid_existent_numbers = [
      '19301383-5', # COMPANHIA ENERGETICA DO PIAUI 08/08/1962
      '19301656-7', # AGUAS E ESGOTOS DO PIAUI SA 28/01/1964
      '19448642-7', # CARVALHO E FERNANDES LTDA
      '19400969-6', # CLAUDINO S A LOJAS DE DEPARTAMENTOS
      '19447385-6', # METROP0LITAN HOTEL LTDA
      '19489563-7', # CEV V A P - CERAMICA VEREMLHA DO VALE DO PARNAIBA LTDA
      '19451276-2', # DISTRIBUIDORA YORK LTDA
      '19429717-9', # DISCAR DISTRIBUIDORA DE BEBIDAS CARVALHO LTDA
    ]
  end

  include_examples "IE basic specs"
end