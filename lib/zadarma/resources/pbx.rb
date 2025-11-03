# frozen_string_literal: true

module Zadarma
  module Resources
    class Pbx
      def initialize(client:)
        @client = client
      end

      # Get the list of PBX internal numbers
      # @return [Hash]
      def internal
        @client.get('/v1/pbx/internal/')
      end

      # Set the call recording for a PBX extension
      # @param id [String] The PBX extension ID
      # @param status [String] The call recording status ('on', 'off', etc.)
      # @param email [String] The email address to send recordings to
      # @param speech_recognition [String] The speech recognition settings
      # @return [Hash]
      def set_call_recording(id:, status:, email: nil, speech_recognition: nil)
        params = { id: id, status: status }
        params[:email] = email if email
        params[:speech_recognition] = speech_recognition if speech_recognition
        @client.put('/v1/pbx/internal/recording/', params)
      end

      # Request a call recording file
      # @param call_id [String] The unique call ID
      # @param pbx_call_id [String] The permanent ID of the external call to the PBX
      # @param lifetime [Integer] The link's lifetime in seconds
      # @return [Hash]
      def pbx_record_request(call_id: nil, pbx_call_id: nil, lifetime: nil)
        params = {}
        params[:call_id] = call_id if call_id
        params[:pbx_call_id] = pbx_call_id if pbx_call_id
        params[:lifetime] = lifetime if lifetime
        @client.get('/v1/pbx/record/request/', params)
      end
    end
  end
end
