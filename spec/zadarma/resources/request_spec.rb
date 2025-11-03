# frozen_string_literal: true

require 'spec_helper'
require 'zadarma'

RSpec.describe Zadarma::Resources::Request do
  let(:client) { Zadarma::Client.new(api_key: 'test_key', api_secret: 'test_secret') }
  subject { described_class.new(client: client) }

  describe '#callback' do
    it 'requests a callback' do
      stub_request(:get, "https://api.zadarma.com/v1/request/callback/?from=1234567890&to=0987654321")
        .to_return(status: 200, body: '{"status": "success"}', headers: {})
      expect(subject.callback(from: '1234567890', to: '0987654321')).to eq('status' => 'success')
    end
  end
end
