# frozen_string_literal: true

RSpec.describe ZadarmaSdk::Resources::GroupsOfDocuments do
  let(:client) { ZadarmaSdk::Client.new(api_key: 'test_key', api_secret: 'test_secret') }
  let(:groups_of_documents) { described_class.new(client: client) }

  describe '#list' do
    it 'gets a list of groups of documents' do
      stub_request(:get, /api.zadarma.com\/v1\/documents\/groups\/list\//)
        .to_return(body: { status: 'success', groups: [] }.to_json)

      response = groups_of_documents.list
      expect(response['status']).to eq('success')
    end
  end
end
