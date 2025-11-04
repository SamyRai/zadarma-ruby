# frozen_string_literal: true

RSpec.describe ZadarmaSdk::Resources::Info do
  let(:client) { ZadarmaSdk::Client.new(api_key: 'test_key', api_secret: 'test_secret') }
  let(:info) { described_class.new(client: client) }

  describe '#balance' do
    it 'gets the balance' do
      stub_request(:get, /api.zadarma.com\/v1\/info\/balance\//)
        .to_return(body: { status: 'success', balance: 100 }.to_json)

      response = info.balance
      expect(response['status']).to eq('success')
    end
  end

  describe '#price' do
    it 'gets the price' do
      stub_request(:get, /api.zadarma.com\/v1\/info\/price\//)
        .to_return(body: { status: 'success', price: 0.1 }.to_json)

      response = info.price(number: '1234567890')
      expect(response['status']).to eq('success')
    end
  end
end
