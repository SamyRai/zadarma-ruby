# frozen_string_literal: true

module Zadarma
  module Resources
    # The SpeechRecognition resource allows you to manage speech recognition.
    class SpeechRecognition
      def initialize(client:)
        @client = client
      end

      # Get recognition results
      # @param call_id [String] The unique call ID
      # @param lang [String] The recognition language
      # @param return_results [String] The returned result ('words' or 'phrases')
      # @param alternatives [String] Return alternative results ('0' or '1')
      # @return [Hash]
      def get(call_id:, lang: nil, return_results: nil, alternatives: nil)
        params = { call_id: call_id }
        params[:lang] = lang if lang
        params[:return] = return_results if return_results
        params[:alternatives] = alternatives if alternatives
        @client.get('/v1/speech_recognition/', params)
      end

      # Initiate call recognition
      # @param call_id [String] The unique call ID
      # @param lang [String] The recognition language
      # @return [Hash]
      def initiate(call_id:, lang: nil)
        params = { call_id: call_id }
        params[:lang] = lang if lang
        @client.put('/v1/speech_recognition/', params)
      end
    end
  end
end
