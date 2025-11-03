# frozen_string_literal: true

module Zadarma
  module Resources
    class Sip
      def initialize(client:)
        @client = client
      end

      # Get the list of user's SIP-numbers
      # @return [Hash]
      def all
        @client.get('/v1/sip/')
      end

      # Set the CallerID for a SIP number
      # @param id [String] The SIP ID
      # @param number [String] The new CallerID
      # @return [Hash]
      def set_caller_id(id:, number:)
        @client.put('/v1/sip/callerid/', id: id, number: number)
      end

      # Get call forwarding information for a SIP number
      # @param id [String] The SIP ID
      # @return [Hash]
      def redirection(id: nil)
        params = {}
        params[:id] = id if id
        @client.get('/v1/sip/redirection/', params)
      end

      # Set call forwarding for a SIP number
      # @param id [String] The SIP ID
      # @param status [String] The call forwarding status ('on' or 'off')
      # @param type [String] The call forwarding type ('phone', 'voicemail', etc.)
      # @param number [String] The destination number for call forwarding
      # @param condition [String] The call forwarding condition ('always', 'noanswer', etc.)
      # @return [Hash]
      def set_redirection(id:, status:, type: nil, number: nil, condition: nil)
        params = { id: id, status: status }
        params[:type] = type if type
        params[:number] = number if number
        params[:condition] = condition if condition
        @client.put('/v1/sip/redirection/', params)
      end

      # Get the online status of a SIP number
      # @param sip [String] The SIP number
      # @return [Hash]
      def status(sip:)
        @client.get("/v1/sip/#{sip}/status/")
      end

      # Create a new SIP number
      # @param name [String] The displayed name for the new SIP number
      # @param password [String] The password for the new SIP number
      # @param callerid [String] The CallerID for the new SIP number
      # @param redirect_to_phone [String] The phone number to redirect calls to
      # @return [Hash]
      def create(name:, password: nil, callerid: nil, redirect_to_phone: nil)
        params = { name: name }
        params[:password] = password if password
        params[:callerid] = callerid if callerid
        params[:redirect_to_phone] = redirect_to_phone if redirect_to_phone
        @client.post('/v1/sip/create/', params)
      end

      # Change the password for a SIP number
      # @param sip [String] The SIP number
      # @param value [String] The new password
      # @return [Hash]
      def password(sip:, value:)
        @client.put("/v1/sip/#{sip}/password/", value: value)
      end
    end
  end
end
