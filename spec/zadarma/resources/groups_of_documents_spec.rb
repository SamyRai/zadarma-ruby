# frozen_string_literal: true

require 'zadarma/client'
require 'webmock/rspec'

RSpec.describe Zadarma::Resources::GroupsOfDocuments do
  let(:client) { Zadarma::Client.new(api_key: 'test_key', api_secret: 'test_secret') }

  describe '#files' do
    it 'retrieves the list of files in a group of documents' do
      stub_request(:get, /api.zadarma.com\/v1\/documents\/files\//)
        .to_return(body: { status: 'success' }.to_json)

      response = client.document_files
      expect(response['status']).to eq('success')
    end
  end

  describe '#list' do
    it 'retrieves the list of groups of documents' do
      stub_request(:get, /api.zadarma.com\/v1\/documents\/groups\/list\//)
        .to_return(body: { status: 'success' }.to_json)

      response = client.document_groups
      expect(response['status']).to eq('success')
    end
  end

  describe '#get' do
    it 'retrieves a group of documents' do
      stub_request(:get, /api.zadarma.com\/v1\/documents\/groups\/get\/123\//)
        .to_return(body: { status: 'success' }.to_json)

      response = client.get_document_group(id: '123')
      expect(response['status']).to eq('success')
    end
  end

  describe '#create' do
    it 'creates a new group of documents' do
      stub_request(:post, /api.zadarma.com\/v1\/documents\/groups\/create\//)
        .to_return(body: { status: 'success' }.to_json)

      response = client.create_document_group(params: { first_name: 'John', last_name: 'Doe' })
      expect(response['status']).to eq('success')
    end
  end

  describe '#update' do
    it 'updates a group of documents' do
      stub_request(:put, /api.zadarma.com\/v1\/documents\/groups\/update\/123\//)
        .to_return(body: { status: 'success' }.to_json)

      response = client.update_document_group(id: '123', params: { first_name: 'Jane' })
      expect(response['status']).to eq('success')
    end
  end
end
