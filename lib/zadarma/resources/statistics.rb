# frozen_string_literal: true

require 'time'

module Zadarma
  module Resources
    class Statistics
      def initialize(client:)
        @client = client
      end

      # Get overall call statistics
      # @param start [String] The start date of the statistics display
      # @param end_date [String] The end date of the statistics display
      # @param sip [String] Filter based on a specific SIP number
      # @param cost_only [String] Display only the amount of funds spent
      # @param type [String] Request type ('overall' or 'toll-free')
      # @param skip [Integer] Number of lines to be skipped in the sample
      # @param limit [Integer] The limit on the number of input lines
      # @return [Hash]
      def statistics(start:, end_date:, sip: nil, cost_only: nil, type: nil, skip: nil, limit: nil)
        params = { start: start, end: end_date }
        params[:sip] = sip if sip
        params[:cost_only] = cost_only if cost_only
        params[:type] = type if type
        params[:skip] = skip if skip
        params[:limit] = limit if limit
        response = @client.get('/v1/statistics/', params)
        if response['stats']
          response['stats'].each do |stat|
            stat['callstart'] = Time.parse(stat['callstart']) if stat['callstart']
          end
        end
        response
      end

      # Get PBX call statistics
      # @param start [String] The start date of the statistics display
      # @param end_date [String] The end date of the statistics display
      # @param version [String] Format of the statistics result ('1' or '2')
      # @param skip [Integer] Number of lines to be skipped in the sample
      # @param limit [Integer] The limit on the number of input lines
      # @param call_type [String] Call destination ('in' or 'out')
      # @return [Hash]
      def pbx_statistics(start:, end_date:, version: nil, skip: nil, limit: nil, call_type: nil)
        params = { start: start, end: end_date }
        params[:version] = version if version
        params[:skip] = skip if skip
        params[:limit] = limit if limit
        params[:call_type] = call_type if call_type
        response = @client.get('/v1/statistics/pbx/', params)
        if response['stats']
          response['stats'].each do |stat|
            stat['callstart'] = Time.parse(stat['callstart']) if stat['callstart']
          end
        end
        response
      end
    end
  end
end
