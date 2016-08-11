require 'spec_helper'
require_relative 'shared_examples'

describe BRDocuments::IE::RS do

  before :all do
    @format_examples = {
      "1320117934" => "132/0117934"
    }

    @valid_numbers = %w(
      132/0117934
    )

    @invalid_numbers = %w(
      132/01179341
    )

    @valid_verify_digits = {
      [4] => %w( 132/0117934 1320117934),
    }

    @valid_existent_numbers = [
      '224/3658792', # Exemplo Sintegra
      '132/0117934', # GERDAU ACOS LONGOS S/A 2005
      '008/0181198', # IPIRANGA PRODUTOS DE PETROLEO S/A 2009
      '120/0082831', # COPESUL COMERCIO DE MATERIAL DE CONSTRUCAO LTDA
      '024/0311698', # ALBERTO PASQUALINI REFAP S/A
      '096/2536253', # BANCO DO ESTADO DO RIO GRANDE DO SUL S/A BANRISUL 1996
      '029/0487447', # RIO GRANDE ENERGIA S/A RGE
    ]
  end

  include_examples "IE basic specs"
end