# frozen_string_literal: true

require 'time'

module ZadarmaSdk
  module Resources
    # The Statistics resource provides access to call statistics.
    class Statistics
      def initialize(client:)
        @client = client
      end

      # Get overall call statistics
      # @param params [Hash] The parameters for the statistics request
      # @option params [String] :start The start date of the statistics display
      # @option params [String] :end The end date of the statistics display
      # @option params [String] :sip Filter based on a specific SIP number
      # @option params [String] :cost_only Display only the amount of funds spent
      # @option params [String] :type Request type ('overall' or 'toll-free')
      # @option params [Integer] :skip Number of lines to be skipped in the sample
      # @option params [Integer] :limit The limit on the number of input lines
      # @return [Hash]
      def statistics(params)
        response = @client.get('/statistics/', params)
        response['stats']&.each do |stat|
          stat['callstart'] = Time.parse(stat['callstart']) if stat['callstart']
        end
        response
      end

      # Get PBX call statistics
      # @param params [Hash] The parameters for the PBX statistics request
      # @option params [String] :start The start date of the statistics display
      # @option params [String] :end The end date of the statistics display
      # @option params [String] :version Format of the statistics result ('1' or '2')
      # @option params [Integer] :skip Number of lines to be skipped in the sample
      # @option params [Integer] :limit The limit on the number of input lines
      # @option params [String] :call_type Call destination ('in' or 'out')
      # @return [Hash]
      def pbx_statistics(params)
        response = @client.get('/statistics/pbx/', params)
        response['stats']&.each do |stat|
          stat['callstart'] = Time.parse(stat['callstart']) if stat['callstart']
        end
        response
      end
    end
  end
end
