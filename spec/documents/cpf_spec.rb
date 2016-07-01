require 'spec_helper'

describe BRDocuments::CPF do
  it 'normalize document number' do
    document_number = '58397453750'
    expected_normalized = [5,8,3,9,7,4,5,3,7,5,0]

    normalized_document_number = BRDocuments::CPF.normalize_document_number(document_number)

    expect(normalized_document_number).to eq(expected_normalized)
    expect(normalized_document_number).to be_a(Array)
  end

  it 'clear the document number formatting' do
    document_number = '583.974.537-50'
    expected_stripped = '58397453750'

    stripped_document_number = BRDocuments::CPF.clear_document_number(document_number)

    expect(stripped_document_number).to eq(expected_stripped)
    expect(stripped_document_number).to be_a(String)
  end

  it 'pretty format the document number' do
    document_number = 58397453750
    expected_formatted = '583.974.537-50'

    formatted_document_number = BRDocuments::CPF.pretty_formatted(document_number)

    expect(formatted_document_number).to eq(expected_formatted)
    expect(formatted_document_number).to match(BRDocuments::CPF.get_valid_format_regexp)
  end

  it 'calculates all verify digits for document' do
    document_number = '583.974.537'

    verify_digits = BRDocuments::CPF.calculate_verify_digits(document_number)

    expect(verify_digits).to be_a(Array)
    expect(verify_digits).to eq([5, 0])
  end

  it 'calculates all verify digits for normalized document' do
    document_number = BRDocuments::CPF.normalize_document_number('583.974.537')

    verify_digits = BRDocuments::CPF.calculate_verify_digits(document_number)

    expect(verify_digits).to be_a(Array)
    expect(verify_digits).to eq([5, 0])
  end

  it 'returns only root of document number' do
    document_number = '583.974.537-50'
    root_document_number = '583974537'
    root_document_number_arry = [5,8,3,9,7,4,5,3,7]

    root_string = BRDocuments::CPF.root_document_number_to_s(document_number)
    root_array = BRDocuments::CPF.root_document_number(document_number)

    expect(root_string).to eq(root_document_number)
    expect(root_string).to be_a(String)
    expect(root_array).to eq(root_document_number_arry)
    expect(root_array).to be_a(Array)
  end

  it 'correctly validate document number' do
    document_number = '583.974.537-50'

    expect(BRDocuments::CPF.valid?(document_number)).to be true
    expect(BRDocuments::CPF.invalid?(document_number)).to be false
  end

  it 'correctly mark document number as invalid' do
    document_number = '583.974.537-40'

    expect(BRDocuments::CPF.valid?(document_number)).to be false
    expect(BRDocuments::CPF.invalid?(document_number)).to be true
  end

  it 'consider nil document_number as invalid document' do
    expect(BRDocuments::CPF.valid?(nil)).to eq(false)
  end

  it 'consider blank document_number as invalid document' do
    expect(BRDocuments::CPF.valid?('')).to eq(false)
  end
end
