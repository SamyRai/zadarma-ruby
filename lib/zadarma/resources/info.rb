# frozen_string_literal: true

module Zadarma
  module Resources
    class Info
      def initialize(client:)
        @client = client
      end

      # Get the user's balance
      # @return [Hash]
      def balance
        @client.get('/v1/info/balance/')
      end

      # Get the call rate for a given number
      # @param number [String] The phone number
      # @param caller_id [String] The CallerID to be used for the call
      # @return [Hash]
      def price(number:, caller_id: nil)
        params = { number: number }
        params[:caller_id] = caller_id if caller_id
        @client.get('/v1/info/price/', params)
      end
    end
  end
end
