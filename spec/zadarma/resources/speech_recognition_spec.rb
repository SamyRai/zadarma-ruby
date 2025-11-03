# frozen_string_literal: true

require 'zadarma/client'
require 'webmock/rspec'

RSpec.describe Zadarma::Resources::SpeechRecognition do
  let(:client) { Zadarma::Client.new(api_key: 'test_key', api_secret: 'test_secret') }

  describe '#get' do
    it 'retrieves speech recognition results' do
      stub_request(:get, %r{api.zadarma.com/v1/speech_recognition/})
        .to_return(body: { status: 'success' }.to_json)

      response = client.get_speech_recognition(call_id: '12345')
      expect(response['status']).to eq('success')
    end
  end

  describe '#initiate' do
    it 'initiates speech recognition' do
      stub_request(:put, %r{api.zadarma.com/v1/speech_recognition/})
        .to_return(body: { status: 'success' }.to_json)

      response = client.initiate_speech_recognition(call_id: '12345')
      expect(response['status']).to eq('success')
    end
  end
end
