# frozen_string_literal: true

RSpec.describe ZadarmaSdk::Resources::Pbx do
  let(:client) { ZadarmaSdk::Client.new(api_key: 'test_key', api_secret: 'test_secret') }
  let(:pbx) { described_class.new(client: client) }

  describe '#internal' do
    it 'gets internal numbers' do
      stub_request(:get, /api.zadarma.com\/v1\/pbx\/internal\//)
        .to_return(body: { status: 'success', numbers: [] }.to_json)

      response = pbx.internal
      expect(response['status']).to eq('success')
    end
  end
end
