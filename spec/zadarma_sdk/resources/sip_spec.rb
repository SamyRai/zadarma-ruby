# frozen_string_literal: true

RSpec.describe ZadarmaSdk::Resources::Sip do
  let(:client) { ZadarmaSdk::Client.new(api_key: 'test_key', api_secret: 'test_secret') }
  let(:sip) { described_class.new(client: client) }

  describe '#all' do
    it 'gets all sips' do
      stub_request(:get, /api.zadarma.com\/v1\/sip\//)
        .to_return(body: { status: 'success', sips: [] }.to_json)

      response = sip.all
      expect(response['status']).to eq('success')
    end
  end
end
