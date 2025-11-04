# frozen_string_literal: true

module ZadarmaSdk
  module Resources
    # The DirectNumbers resource allows you to manage virtual numbers.
    class DirectNumbers
      def initialize(client:)
        @client = client
      end

      # Get information about the user's virtual numbers
      # @return [Hash]
      def all
        @client.get('/direct_numbers/')
      end

      # Get a list of countries where numbers can be ordered
      # @param language [String] The language for the country names
      # @return [Hash]
      def countries(language: nil)
        params = {}
        params[:language] = language if language
        @client.get('/direct_numbers/countries/', params)
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
        @client.get('/direct_numbers/country/', params)
      end

      # Get a list of available numbers for a given direction
      # @param direction_id [String] The direction ID
      # @param mask [String] A mask for searching number matches
      # @return [Hash]
      def available(direction_id:, mask: nil)
        params = {}
        params[:mask] = mask if mask
        @client.get("/direct_numbers/available/#{direction_id}/", params)
      end

      # Order a virtual number
      # @param params [Hash] The parameters for ordering a number
      # @option params [String] :direction_id The direction/city ID
      # @option params [String] :number_id The ID of the number to be connected
      # @option params [String] :documents_group_id The ID of the group of user documents
      # @option params [String] :purpose A text description of the purpose of number use
      # @option params [String] :receive_sms '1' to enable SMS reception
      # @option params [String] :period 'month' or '3month'
      # @option params [String] :autorenew_period 'year' or 'month'
      # @return [Hash]
      def order(params)
        @client.post('/direct_numbers/order/', params)
      end

      # Prepay the number for the specified number of months
      # @param number [String] The number to be prolonged
      # @param months [Integer] The number of months
      # @return [Hash]
      def prolong(number:, months:)
        @client.post('/direct_numbers/prolong/', number: number, months: months)
      end
    end
  end
end
