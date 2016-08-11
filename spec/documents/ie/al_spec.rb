require 'spec_helper'
require_relative 'shared_examples'

describe BRDocuments::IE::AL do

  before :all do

    @format_examples = {
      '240000048' => '24.000004-8'
    }

    @valid_numbers = %w(
      240000048
      24.000.004-8
      24.000004.8
      24000004-8
    )

    @invalid_numbers = %w(
      24.000.004-80
      124.000.004-8
    )

    @valid_verify_digits = {
      [8] => %w(24.000.004 24.000004 24000004)
    }

    @valid_existent_numbers = %w(
       24.810989-8
       24.840219-6
       24.838692-1
       24.885944-7
       24.860732-4
       24.817955-1
       24.577875-6
       24.757527-5
       24.864992-2
    )
  end

  include_examples "IE basic specs"

  it 'must generate a number with valid company type digit' do
    10.times {
      number = described_class.generate

      expect(described_class.company_type(number)).to_not be_nil
    }
  end
end