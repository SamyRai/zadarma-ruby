# frozen_string_literal: true

RSpec.describe ZadarmaSdk::Resources::Statistics do
  let(:client) { ZadarmaSdk::Client.new(api_key: 'test_key', api_secret: 'test_secret') }
  let(:statistics) { described_class.new(client: client) }

  describe '#statistics' do
    it 'gets statistics' do
      stub_request(:get, /api.zadarma.com\/v1\/statistics\//)
        .to_return(body: { status: 'success', stats: [] }.to_json)

      response = statistics.statistics(start: '2023-01-01', end_date: '2023-01-31')
      expect(response['status']).to eq('success')
    end
  end

  describe '#pbx_statistics' do
    it 'gets pbx statistics' do
      stub_request(:get, /api.zadarma.com\/v1\/statistics\/pbx\//)
        .to_return(body: { status: 'success', stats: [] }.to_json)

      response = statistics.pbx_statistics(start: '2023-01-01', end_date: '2023-01-31')
      expect(response['status']).to eq('success')
    end
  end
end
