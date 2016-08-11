require 'spec_helper'
require_relative 'shared_examples'

describe BRDocuments::IE::PB do

  before :all do

    @format_examples = {
      "160158230" => "16.015.823-0"
    }

    @valid_numbers = %w(
      16.015.823-0
      16015823-0
      160158230
    )

    @invalid_numbers = %w(
      16.015.823-01
      1610158230
      161018230
    )

    @valid_verify_digits = {
      [0] => %w(16.015.823-0 16015823 16.015.823)
    }

    @valid_existent_numbers = [
      '16.015.823-0', # Energisa
      '16.064.797-5', # Oi
      '16.211.981-0', # Oi Movel
      '16.143.665-0', # Tim
      '16.000.751-8', # Souza Cruz
      '16.218.715-7', # Ambev
      '16.164.850-9', # Claro
      '16.158.896-4', # Carrefour Comercio e Industria Ltda
    ]
  end

  include_examples "IE basic specs"
end