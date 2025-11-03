# frozen_string_literal: true

require 'zadarma/client'
require 'webmock/rspec'

RSpec.describe Zadarma::Resources::Statistics do
  let(:client) { Zadarma::Client.new(api_key: 'test_key', api_secret: 'test_secret') }

  describe '#statistics' do
    it 'retrieves statistics' do
      stub_request(:get, %r{api.zadarma.com/v1/statistics/})
        .to_return(body: { status: 'success', stats: [] }.to_json)

      response = client.statistics(start: '2023-01-01', end: '2023-01-31')
      expect(response['status']).to eq('success')
    end
  end

  describe '#pbx_statistics' do
    it 'retrieves pbx statistics' do
      stub_request(:get, %r{api.zadarma.com/v1/statistics/pbx/})
        .to_return(body: { status: 'success', stats: [] }.to_json)

      response = client.pbx_statistics(start: '2023-01-01', end: '2023-01-31')
      expect(response['status']).to eq('success')
    end
  end
end
