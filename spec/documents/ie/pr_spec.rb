require 'spec_helper'
require_relative 'shared_examples'

describe BRDocuments::IE::PR do

  before :all do

    @format_examples = {
      "4221216097" => "42212160-97"
    }

    @valid_numbers = %w(
      42212160-97
      4221216097
      422.121.60-97
    )

    @invalid_numbers = %w(
      42212160-971
      412212160-97
      4221216-971
    )

    @valid_verify_digits = {
      [9,7] => %w(42212160-97 42212160 4221216097)
    }

    @valid_existent_numbers = [
      '42212160-97', # ITAIPU BINACIONAL
      '90102000-05', # Renault do Brasil S.A
      '90233099-28', # Copel-Telecom - Copel Telecomunicacoes S.A.
      '41806670-97', # COAMO AGROINDUSTRIAL COOPERATIVA
    ]
  end

  include_examples "IE basic specs"
end