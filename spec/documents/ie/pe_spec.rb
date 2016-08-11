require 'spec_helper'
require_relative 'shared_examples'

describe BRDocuments::IE::PE do
  before :all do

    @format_examples = {
      "032141840" => "0321418-40"
    }

    @valid_numbers = %w(
      0321418-40
      03.214.18-40
      032141840
    )

    @invalid_numbers = %w(
      0321418-401
      03121418-40
      0312141-40
    )

    @valid_verify_digits = {
      [4, 0] => %w(0321418-40 0321418 03.21418),
      [9]    => %w(18.1.001.0000004-9 18.1.001.0000004)
    }

    @valid_existent_numbers = [
      '0321418-40', # Exemplo sintegra,
      '18.1.001.0000004-9', # Exemplo Sintegra (Legado)
    ]
  end

  include_examples "IE basic specs"

  it 'must check if number is legacy' do
    expect(described_class.legacy?("18.1.001.0000004-9")).to be_truthy
    expect(described_class.legacy?("0321418-40")).to be_falsey
  end

  it 'must allow legacy numbers generation' do
    number = described_class.generate(true, true)

    expect(described_class.legacy?(number)).to be_truthy
    expect(described_class.valid?(number)).to be_truthy
  end
end