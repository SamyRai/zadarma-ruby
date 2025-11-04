# frozen_string_literal: true

require 'spec_helper'
require 'zadarma'

RSpec.describe Zadarma::Resources::Sip do
  subject(:sip) { described_class.new(client: client) }

  let(:client) { Zadarma::Client.new(api_key: 'test_key', api_secret: 'test_secret') }

  describe '#all' do
    it 'returns the list of sips' do
      stub_request(:get, 'https://api.zadarma.com/v1/sip/')
        .to_return(status: 200, body: '{"sips": [{"id": "1234"}]}', headers: {})
      expect(sip.all).to eq('sips' => [{ 'id' => '1234' }])
    end
  end

  describe '#set_caller_id' do
    it 'sets the caller id for a sip' do
      stub_request(:put, 'https://api.zadarma.com/v1/sip/callerid/')
        .to_return(status: 200, body: '{"status": "success"}', headers: {})
      expect(sip.set_caller_id(id: '1234', number: '5678')).to eq('status' => 'success')
    end
  end

  describe '#redirection' do
    it 'returns the redirection status for all sips' do
      stub_request(:get, 'https://api.zadarma.com/v1/sip/redirection/')
        .to_return(status: 200, body: '{"info": "test"}', headers: {})
      expect(sip.redirection).to eq('info' => 'test')
    end

    it 'returns the redirection status for a specific sip' do
      stub_request(:get, 'https://api.zadarma.com/v1/sip/redirection/?id=1234')
        .to_return(status: 200, body: '{"info": "test"}', headers: {})
      expect(sip.redirection(id: '1234')).to eq('info' => 'test')
    end
  end

  describe '#set_redirection' do
    it 'sets the redirection for a sip' do
      stub_request(:put, 'https://api.zadarma.com/v1/sip/redirection/')
        .to_return(status: 200, body: '{"status": "success"}', headers: {})
      expect(sip.set_redirection(id: '1234', status: 'on')).to eq('status' => 'success')
    end
  end

  describe '#status' do
    it 'returns the status of a sip' do
      stub_request(:get, %r{api.zadarma.com/v1/sip/123/status/})
        .to_return(body: { status: 'success', is_online: true }.to_json)

      response = sip.status(sip: '123')
      expect(response).to eq('status' => 'success', 'is_online' => true)
    end
  end

  describe '#create' do
    it 'creates a new sip' do
      stub_request(:post, %r{api.zadarma.com/v1/sip/create/})
        .to_return(body: { status: 'success', sip: '12345' }.to_json)

      response = sip.create(name: 'New SIP')
      expect(response).to eq('status' => 'success', 'sip' => '12345')
    end
  end

  describe '#password' do
    it 'sets the password for a sip' do
      stub_request(:put, %r{api.zadarma.com/v1/sip/123/password/})
        .to_return(body: { status: 'success' }.to_json)

      response = sip.password(sip: '123', value: 'new_password')
      expect(response['status']).to eq('success')
    end
  end
end
