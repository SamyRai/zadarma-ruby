# frozen_string_literal: true

module Zadarma
  module Resources
    class Sms
      def initialize(client:)
        @client = client
      end

      # Send an SMS message
      # @param number [String] The destination phone number
      # @param message [String] The SMS message text
      # @param sender [String] The SMS sender (virtual number or text)
      # @return [Hash]
      def send_sms(number:, message:, sender: nil)
        params = { number: number, message: message }
        params[:sender] = sender if sender
        @client.post('/v1/sms/send/', params)
      end
    end
  end
end
