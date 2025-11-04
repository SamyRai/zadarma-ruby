# frozen_string_literal: true

RSpec.describe ZadarmaSdk::Client do
  let(:client) { described_class.new(api_key: 'test_key', api_secret: 'test_secret') }

  describe '#initialize' do
    it 'creates a new client' do
      expect(client).to be_a(described_class)
    end
  end
end
