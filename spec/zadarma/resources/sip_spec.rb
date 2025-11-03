# frozen_string_literal: true

require 'spec_helper'
require 'zadarma'

RSpec.describe Zadarma::Resources::Sip do
  let(:client) { Zadarma::Client.new(api_key: 'test_key', api_secret: 'test_secret') }
  subject { described_class.new(client: client) }

  describe '#all' do
    it 'returns the list of sips' do
      stub_request(:get, 'https://api.zadarma.com/v1/sip/')
        .to_return(status: 200, body: '{"sips": [{"id": "1234"}]}', headers: {})
      expect(subject.all).to eq('sips' => [{'id' => '1234'}])
    end
  end

  describe '#set_caller_id' do
    it 'sets the caller id for a sip' do
      stub_request(:put, "https://api.zadarma.com/v1/sip/callerid/")
        .to_return(status: 200, body: '{"status": "success"}', headers: {})
      expect(subject.set_caller_id(id: '1234', number: '5678')).to eq('status' => 'success')
    end
  end

  describe '#redirection' do
    it 'returns the redirection status for all sips' do
      stub_request(:get, 'https://api.zadarma.com/v1/sip/redirection/')
        .to_return(status: 200, body: '{"info": "test"}', headers: {})
      expect(subject.redirection).to eq('info' => 'test')
    end

    it 'returns the redirection status for a specific sip' do
      stub_request(:get, 'https://api.zadarma.com/v1/sip/redirection/?id=1234')
        .to_return(status: 200, body: '{"info": "test"}', headers: {})
      expect(subject.redirection(id: '1234')).to eq('info' => 'test')
    end
  end

  describe '#set_redirection' do
    it 'sets the redirection for a sip' do
      stub_request(:put, "https://api.zadarma.com/v1/sip/redirection/")
        .to_return(status: 200, body: '{"status": "success"}', headers: {})
      expect(subject.set_redirection(id: '1234', status: 'on')).to eq('status' => 'success')
    end
  end

  describe '#status' do
    it 'returns the status of a sip' do
      stub_request(:get, /api.zadarma.com\/v1\/sip\/123\/status\//)
        .to_return(body: { status: 'success', is_online: true }.to_json)

      response = client.sip_status(sip: '123')
      expect(response['status']).to eq('success')
      expect(response['is_online']).to eq(true)
    end
  end

  describe '#create' do
    it 'creates a new sip' do
      stub_request(:post, /api.zadarma.com\/v1\/sip\/create\//)
        .to_return(body: { status: 'success', sip: '12345' }.to_json)

      response = client.create_sip(name: 'New SIP')
      expect(response['status']).to eq('success')
      expect(response['sip']).to eq('12345')
    end
  end

  describe '#password' do
    it 'sets the password for a sip' do
      stub_request(:put, /api.zadarma.com\/v1\/sip\/123\/password\//)
        .to_return(body: { status: 'success' }.to_json)

      response = client.set_sip_password(sip: '123', value: 'new_password')
      expect(response['status']).to eq('success')
    end
  end
end
