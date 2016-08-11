require 'spec_helper'
require_relative 'shared_examples'

describe BRDocuments::IE::RR do

  before :all do
    @format_examples = {
      "240066281" => "24.006628-1"
    }

    @valid_numbers = %w(
      24006628-1
      24001755-6
      24003429-0
      24001360-3
      24008266-8
      24006153-6
      24007356-2
      24005467-4
      24004145-5
      24001340-7
    )

    @invalid_numbers = %w(
      24006628-11
      2400175-6
      2400349-01
      24001303
    )

    @valid_verify_digits = {
      [1] => %w(24006628-1 240066281 24006628),
      [8] => %w(24008266-8 240082668 24008266),
      [5] => %w(24004145-5 240041455 24004145),
      [0] => %w(24003429-0 240034290 24003429)
    }

    @valid_existent_numbers = [
      '24.001489-5', # COMPANHIA ENERGETICA DE RORAIMA
      '24.006114-4', # COMPANHIA DE AGUAS E ESGOTOS DE RORAIMA
      '24.010923-7', # RORAIMA ADVENTURES TURISMO LTDA ME
      '24.017489-3', # RORAIMA TRADING COM DE IMP E EXP LTDA ME 1987
      '24.018796-0', # INSTITUTO BATISTA DE RORAIMA 1986
      '24.014480-6', # UNIVERSIDADE ESTADUAL DE RORAIMA
    ]
  end

  include_examples "IE basic specs"
end