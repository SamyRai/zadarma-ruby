# frozen_string_literal: true

require 'spec_helper'
require 'zadarma'

RSpec.describe Zadarma::Resources::DirectNumbers do
  subject(:direct_numbers) { described_class.new(client: client) }

  let(:client) { Zadarma::Client.new(api_key: 'test_key', api_secret: 'test_secret') }

  describe '#all' do
    it 'returns the list of direct numbers' do
      stub_request(:get, 'https://api.zadarma.com/v1/direct_numbers/')
        .to_return(status: 200, body: '{"info": [{"number": "1234567890"}]}', headers: {})
      expect(direct_numbers.all).to eq('info' => [{ 'number' => '1234567890' }])
    end
  end

  describe '#countries' do
    it 'returns the list of countries' do
      stub_request(:get, %r{api.zadarma.com/v1/direct_numbers/countries/})
        .to_return(body: { status: 'success', info: [] }.to_json)

      response = direct_numbers.countries
      expect(response['status']).to eq('success')
    end
  end

  describe '#country' do
    it 'returns the list of destinations in a country' do
      stub_request(:get, %r{api.zadarma.com/v1/direct_numbers/country/})
        .to_return(body: { status: 'success', info: [] }.to_json)

      response = direct_numbers.country(country: 'US')
      expect(response['status']).to eq('success')
    end
  end

  describe '#available' do
    it 'returns the list of available numbers' do
      stub_request(:get, %r{api.zadarma.com/v1/direct_numbers/available/123/})
        .to_return(body: { status: 'success', numbers: [] }.to_json)

      response = direct_numbers.available(direction_id: '123')
      expect(response['status']).to eq('success')
    end
  end

  describe '#order' do
    it 'orders a new direct number' do
      stub_request(:post, %r{api.zadarma.com/v1/direct_numbers/order/})
        .to_return(body: { status: 'success', number: '1234567890' }.to_json)

      response = direct_numbers.order(direction_id: '123')
      expect(response).to eq('status' => 'success', 'number' => '1234567890')
    end
  end

  describe '#prolong' do
    it 'prolongs a direct number' do
      stub_request(:post, %r{api.zadarma.com/v1/direct_numbers/prolong/})
        .to_return(body: { status: 'success' }.to_json)

      response = direct_numbers.prolong(number: '1234567890', months: 1)
      expect(response['status']).to eq('success')
    end
  end
end
