# frozen_string_literal: true

module Zadarma
  module Resources
    # The Request resource allows you to initiate callbacks.
    class Request
      def initialize(client:)
        @client = client
      end

      # Request a callback
      # @param from [String] Your phone/SIP number, the PBX extension or the PBX scenario
      # @param to [String] The phone or SIP number that is being called
      # @param sip [String] The SIP user's number or the PBX extension
      # @param predicted [String] If specified, the request is predicted
      # @return [Hash]
      def callback(from:, to:, sip: nil, predicted: nil)
        params = { from: from, to: to }
        params[:sip] = sip if sip
        params[:predicted] = predicted if predicted
        @client.get('/v1/request/callback/', params)
      end
    end
  end
end
