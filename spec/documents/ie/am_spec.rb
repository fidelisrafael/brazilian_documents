require 'spec_helper'
require_relative 'shared_examples'

describe BRDocuments::IE::AM do

  before :all do

    @format_examples = {
      '070002207' => '07.000.220-7'
    }

    @valid_numbers = %w(
      07.000.220-7
      07.000.2207
      07.0002207
      070002207
    )

    @invalid_numbers = %w(
      07.000.220-70
      107.000.220-7
    )

    @valid_verify_digits = {
      [7] => %w(07.000.220 07.000.220 07000220)
    }

    @valid_existent_numbers = [
      '07.000.220-7',  # Moto Honda
      '06.200.256-2',  # Moto Honda
      '04.156.817-6',  # Moto Honda
      '04.153.370-4',  # Monto Honda
      '04.135.646-2',  # Nokia
      '06.200.267-8',  # Nokia
      '07.000.848-5',  # Nokia
      '06.300.694-4',  # LG
      '06.200.685-1',  # LG
    ]
  end

  include_examples "IE basic specs"
end