require "spec_helper"
require "zadarma"

RSpec.describe Zadarma::Client do
  let(:api_key) { "test_key" }
  let(:api_secret) { "test_secret" }
  let(:client) { described_class.new(api_key: api_key, api_secret: api_secret) }

  describe "#initialize" do
    it "initializes with an api_key and api_secret" do
      expect(client).to be_a(Zadarma::Client)
    end
  end

  describe "#get" do
    it "makes a GET request to the specified path" do
      stub_request(:get, "https://api.zadarma.com/v1/test_path?param=value").
        to_return(status: 200, body: '{"status":"success"}', headers: {})

      client.get("/v1/test_path", param: "value")

      expect(WebMock).to have_requested(:get, "https://api.zadarma.com/v1/test_path?param=value").
        with(headers: {"Authorization" => /test_key:.*/}).once
    end
  end
end
