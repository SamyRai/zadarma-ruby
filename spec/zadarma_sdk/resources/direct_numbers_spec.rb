# frozen_string_literal: true

RSpec.describe ZadarmaSdk::Resources::DirectNumbers do
  let(:client) { ZadarmaSdk::Client.new(api_key: 'test_key', api_secret: 'test_secret') }
  let(:direct_numbers) { described_class.new(client: client) }

  describe '#all' do
    it 'gets all direct numbers' do
      stub_request(:get, /api.zadarma.com\/v1\/direct_numbers\//)
        .to_return(body: { status: 'success', numbers: [] }.to_json)

      response = direct_numbers.all
      expect(response['status']).to eq('success')
    end
  end
end
