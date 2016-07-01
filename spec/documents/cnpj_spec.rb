require 'spec_helper'

describe BRDocuments::CNPJ do
  it 'normalize document number' do
    document_number = '09037584000144'
    expected_normalized = [0,9,0,3,7,5,8,4,0,0,0,1,4,4]

    normalized_document_number = BRDocuments::CNPJ.normalize_document_number(document_number)

    expect(normalized_document_number).to eq(expected_normalized)
    expect(normalized_document_number).to be_a(Array)
  end

  it 'clear the document number formatting' do
    document_number = '57.451.163/0001-08'
    expected_stripped = '57451163000108'

    stripped_document_number = BRDocuments::CNPJ.clear_document_number(document_number)

    expect(stripped_document_number).to eq(expected_stripped)
    expect(stripped_document_number).to be_a(String)
  end

  it 'pretty format the document number' do
    document_number = 57451163000108
    expected_formatted = '57.451.163/0001-08'

    formatted_document_number = BRDocuments::CNPJ.pretty_formatted(document_number)

    expect(formatted_document_number).to eq(expected_formatted)
    expect(formatted_document_number).to match(BRDocuments::CNPJ.get_valid_format_regexp)
  end

  it 'calculates all verify digits for document' do
    document_number = '57.451.163/0001'

    verify_digits = BRDocuments::CNPJ.calculate_verify_digits(document_number)

    expect(verify_digits).to be_a(Array)
    expect(verify_digits).to eq([0, 8])
  end

  it 'calculates all verify digits for normalized document' do
    document_number = BRDocuments::CNPJ.normalize_document_number('57.451.163/0001')

    verify_digits = BRDocuments::CNPJ.calculate_verify_digits(document_number)

    expect(verify_digits).to be_a(Array)
    expect(verify_digits).to eq([0, 8])
  end

  it 'returns only root of document number' do
    document_number = '57.451.163/0001-08'
    root_document_number = '574511630001'
    root_document_number_arry = [5,7,4,5,1,1,6,3,0,0,0,1]

    root_string = BRDocuments::CNPJ.root_document_number_to_s(document_number)
    root_array = BRDocuments::CNPJ.root_document_number(document_number)

    expect(root_string).to eq(root_document_number)
    expect(root_string).to be_a(String)
    expect(root_array).to eq(root_document_number_arry)
    expect(root_array).to be_a(Array)
  end

  it 'correctly validate document number' do
    document_number = '57.451.163/0001-08'

    expect(BRDocuments::CNPJ.valid?(document_number)).to be true
    expect(BRDocuments::CNPJ.invalid?(document_number)).to be false
  end

  it 'correctly mark document number as invalid' do
    document_number = '57.451.163/0001-10'

    expect(BRDocuments::CNPJ.valid?(document_number)).to be false
    expect(BRDocuments::CNPJ.invalid?(document_number)).to be true
  end

  it 'consider nil document_number as invalid document' do
    expect(BRDocuments::CNPJ.valid?(nil)).to eq(false)
  end

  it 'consider blank document_number as invalid document' do
    expect(BRDocuments::CNPJ.valid?('')).to eq(false)
  end
end
