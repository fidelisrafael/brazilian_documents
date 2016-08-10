require 'spec_helper'

describe BRDocuments::CPF do
  it 'normalize document number' do
    document_number = '58397453750'
    expected_normalized = [5,8,3,9,7,4,5,3,7,5,0]

    normalized_document_number = described_class.normalize(document_number)

    expect(normalized_document_number).to eq(expected_normalized)
    expect(normalized_document_number).to be_a(Array)
  end

  it 'clear the document number formatting' do
    document_number = '583.974.537-50'
    expected_stripped = '58397453750'

    stripped_document_number = described_class.strip(document_number)

    expect(stripped_document_number).to eq(expected_stripped)
    expect(stripped_document_number).to be_a(String)
  end

  it 'pretty format the document number' do
    document_number = 58397453750
    expected_formatted = '583.974.537-50'

    formatted_document_number = described_class.pretty(document_number)

    expect(formatted_document_number).to eq(expected_formatted)
    expect(formatted_document_number).to match(described_class.get_format_regexp)
  end

  it 'calculates all verify digits for document' do
    document_number = '583.974.537'

    verify_digits = described_class.calculate_verify_digits(document_number)

    expect(verify_digits).to be_a(Array)
    expect(verify_digits).to eq([5, 0])
  end

  it 'calculates all verify digits for normalized document' do
    document_number = described_class.normalize('583.974.537')

    verify_digits = described_class.calculate_verify_digits(document_number)

    expect(verify_digits).to be_a(Array)
    expect(verify_digits).to eq([5, 0])
  end

  it 'returns only root of document number' do
    document_number = '583.974.537-50'
    root_document_number = '583974537'
    root_document_number_arry = [5,8,3,9,7,4,5,3,7]

    root_string = described_class.root_number_to_s(document_number)
    root_array = described_class.root_number(document_number)

    expect(root_string).to eq(root_document_number)
    expect(root_string).to be_a(String)
    expect(root_array).to eq(root_document_number_arry)
    expect(root_array).to be_a(Array)
  end

  it 'correctly validate document number' do
    document_number = '583.974.537-50'

    expect(described_class.valid?(document_number)).to be true
    expect(described_class.invalid?(document_number)).to be false
  end

  it 'correctly mark document number as invalid' do
    document_number = '583.974.537-40'

    expect(described_class.valid?(document_number)).to be false
    expect(described_class.invalid?(document_number)).to be true
  end

  it 'consider nil document_number as invalid document' do
    expect(described_class.valid?(nil)).to eq(false)
  end

  it 'consider blank document_number as invalid document' do
    expect(described_class.valid?('')).to eq(false)
  end

  it 'generate valid documents numbers' do
    10.times do
      generated_doc = described_class.generate

      expect(described_class.valid?(generated_doc)).to eq(true)
    end
  end
end
