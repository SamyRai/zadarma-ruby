# frozen_string_literal: true

module Zadarma
  module Resources
    class DirectNumbers
      def initialize(client:)
        @client = client
      end

      # Get information about the user's virtual numbers
      # @return [Hash]
      def all
        @client.get('/v1/direct_numbers/')
      end

      # Get a list of countries where numbers can be ordered
      # @param language [String] The language for the country names
      # @return [Hash]
      def countries(language: nil)
        params = {}
        params[:language] = language if language
        @client.get('/v1/direct_numbers/countries/', params)
      end

      # Get a list of destinations in a country where a number can be ordered
      # @param country [String] The ISO country code
      # @param language [String] The language for the destination names
      # @param direction_id [String] The direction ID
      # @return [Hash]
      def country(country:, language: nil, direction_id: nil)
        params = { country: country }
        params[:language] = language if language
        params[:direction_id] = direction_id if direction_id
        @client.get('/v1/direct_numbers/country/', params)
      end

      # Get a list of available numbers for a given direction
      # @param direction_id [String] The direction ID
      # @param mask [String] A mask for searching number matches
      # @return [Hash]
      def available(direction_id:, mask: nil)
        params = {}
        params[:mask] = mask if mask
        @client.get("/v1/direct_numbers/available/#{direction_id}/", params)
      end

      # Order a virtual number
      # @param direction_id [String] The direction/city ID
      # @param number_id [String] The ID of the number to be connected
      # @param documents_group_id [String] The ID of the group of user documents
      # @param purpose [String] A text description of the purpose of number use
      # @param receive_sms [String] '1' to enable SMS reception
      # @param period [String] 'month' or '3month'
      # @param autorenew_period [String] 'year' or 'month'
      # @return [Hash]
      def order(direction_id:, number_id: nil, documents_group_id: nil, purpose: nil, receive_sms: nil, period: nil, autorenew_period: nil)
        params = { direction_id: direction_id }
        params[:number_id] = number_id if number_id
        params[:documents_group_id] = documents_group_id if documents_group_id
        params[:purpose] = purpose if purpose
        params[:receive_sms] = receive_sms if receive_sms
        params[:period] = period if period
        params[:autorenew_period] = autorenew_period if autorenew_period
        @client.post('/v1/direct_numbers/order/', params)
      end

      # Prepay the number for the specified number of months
      # @param number [String] The number to be prolonged
      # @param months [Integer] The number of months
      # @return [Hash]
      def prolong(number:, months:)
        @client.post('/v1/direct_numbers/prolong/', number: number, months: months)
      end
    end
  end
end
