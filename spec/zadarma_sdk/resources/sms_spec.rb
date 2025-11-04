# frozen_string_literal: true

RSpec.describe ZadarmaSdk::Resources::Sms do
  let(:client) { ZadarmaSdk::Client.new(api_key: 'test_key', api_secret: 'test_secret') }
  let(:sms) { described_class.new(client: client) }

  describe '#send_sms' do
    it 'sends an SMS' do
      stub_request(:post, /api.zadarma.com\/v1\/sms\/send\//)
        .to_return(body: { status: 'success' }.to_json)

      response = sms.send_sms(number: '1234567890', message: 'Hello')
      expect(response['status']).to eq('success')
    end
  end
end
