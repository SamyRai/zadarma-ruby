# frozen_string_literal: true

require 'spec_helper'
require 'zadarma'

RSpec.describe Zadarma::Resources::Info do
  let(:client) { Zadarma::Client.new(api_key: 'test_key', api_secret: 'test_secret') }
  subject { described_class.new(client: client) }

  describe '#balance' do
    it 'returns the current balance' do
      stub_request(:get, 'https://api.zadarma.com/v1/info/balance/')
        .to_return(status: 200, body: '{"balance": 100.0}', headers: {})
      expect(subject.balance).to eq('balance' => 100.0)
    end
  end

  describe '#price' do
    it 'returns the price for a given number' do
      stub_request(:get, "https://api.zadarma.com/v1/info/price/?number=1234567890")
        .to_return(status: 200, body: '{"price": 0.01}', headers: {})
      expect(subject.price(number: '1234567890')).to eq('price' => 0.01)
    end

    it 'returns the price for a given number and caller_id' do
      stub_request(:get, "https://api.zadarma.com/v1/info/price/?caller_id=0987654321&number=1234567890")
        .to_return(status: 200, body: '{"price": 0.02}', headers: {})
      expect(subject.price(number: '1234567890', caller_id: '0987654321')).to eq('price' => 0.02)
    end
  end
end
