# frozen_string_literal: true

RSpec.describe ZadarmaSdk::Resources::SpeechRecognition do
  let(:client) { ZadarmaSdk::Client.new(api_key: 'test_key', api_secret: 'test_secret') }
  let(:speech_recognition) { described_class.new(client: client) }

  describe '#get' do
    it 'gets speech recognition' do
      stub_request(:get, /api.zadarma.com\/v1\/speech_recognition\//)
        .to_return(body: { status: 'success' }.to_json)

      response = speech_recognition.get(call_id: '123')
      expect(response['status']).to eq('success')
    end
  end

  describe '#initiate' do
    it 'initiates speech recognition' do
      stub_request(:put, /api.zadarma.com\/v1\/speech_recognition\//)
        .to_return(body: { status: 'success' }.to_json)

      response = speech_recognition.initiate(call_id: '123')
      expect(response['status']).to eq('success')
    end
  end
end
