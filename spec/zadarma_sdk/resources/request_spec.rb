# frozen_string_literal: true

RSpec.describe ZadarmaSdk::Resources::Request do
  let(:client) { ZadarmaSdk::Client.new(api_key: 'test_key', api_secret: 'test_secret') }
  let(:request) { described_class.new(client: client) }

  describe '#callback' do
    it 'requests a callback' do
      stub_request(:get, /api.zadarma.com\/v1\/request\/callback\//)
        .to_return(body: { status: 'success' }.to_json)

      response = request.callback(from: '123', to: '456')
      expect(response['status']).to eq('success')
    end
  end
end
