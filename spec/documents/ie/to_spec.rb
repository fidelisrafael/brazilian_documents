require 'spec_helper'
require_relative 'shared_examples'

describe BRDocuments::IE::TO do

  before :all do
    @format_examples = {
      "290319986" => "29.031.998-6"
    }

    @valid_numbers = %w(
      29.031.998-6
      29.031.9986
      290319986
    )

    @invalid_numbers = %w(
      29.031.998-61
      29.031.996
      29.031.9961
    )

    @valid_verify_digits = {
      [0] => %w(29.430.513-0 29.430.513 29430513 294305130),
      [6] => %w(29.031.998-6 29.031.998 29031998 29.022.783-6 29.022.783)
    }

    @valid_existent_numbers = [
      '29.022.783-6', # Exemplo Sintegra
      '29.031.998-6', # ENERGISA TOCANTINS DISTRIBUIDORA DE ENERGIA S/A
      '29.031.448-8', # COMPANHIA DE SANEAMENTO DO TOCANTINS-SANEATINS
      '29.068.567-2', # MINASCOM COMERCIAL LTDA
      '29.451.487-2', # TIM CELULAR S.A
      '29.430.513-0', # CINEMARK BRASIL S A
      '29.414.603-2', # Palmas Cell
    ]
  end

  include_examples "IE basic specs"
end