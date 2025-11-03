# frozen_string_literal: true

require 'spec_helper'
require 'zadarma'

RSpec.describe Zadarma::Resources::Pbx do
  let(:client) { Zadarma::Client.new(api_key: 'test_key', api_secret: 'test_secret') }
  subject { described_class.new(client: client) }

  describe '#internal' do
    it 'returns the list of internal numbers' do
      stub_request(:get, 'https://api.zadarma.com/v1/pbx/internal/')
        .to_return(status: 200, body: '{"numbers": ["100", "101"]}', headers: {})
      expect(subject.internal).to eq('numbers' => ['100', '101'])
    end
  end

  describe '#set_call_recording' do
    it 'sets the call recording for a pbx' do
      stub_request(:put, "https://api.zadarma.com/v1/pbx/internal/recording/")
        .to_return(status: 200, body: '{"status": "success"}', headers: {})
      expect(subject.set_call_recording(id: '1234', status: 'on')).to eq('status' => 'success')
    end
  end

  describe '#pbx_record_request' do
    it 'requests a call recording' do
      stub_request(:get, /api.zadarma.com\/v1\/pbx\/record\/request\//)
        .to_return(body: { status: 'success', link: 'http://example.com/record.mp3' }.to_json)

      response = client.pbx_record_request(call_id: '12345')
      expect(response['status']).to eq('success')
      expect(response['link']).to eq('http://example.com/record.mp3')
    end
  end
end
