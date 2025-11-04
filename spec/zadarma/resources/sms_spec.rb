# frozen_string_literal: true

require 'spec_helper'
require 'zadarma'

RSpec.describe Zadarma::Resources::Sms do
  subject(:sms) { described_class.new(client: client) }

  let(:client) { Zadarma::Client.new(api_key: 'test_key', api_secret: 'test_secret') }

  describe '#send_sms' do
    it 'sends an sms' do
      stub_request(:post, 'https://api.zadarma.com/v1/sms/send/')
        .to_return(status: 200, body: '{"status": "success"}', headers: {})
      expect(sms.send_sms(number: '1234567890', message: 'test message')).to eq('status' => 'success')
    end
  end
end
