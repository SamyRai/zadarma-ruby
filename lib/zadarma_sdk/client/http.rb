# frozen_string_literal: true

require 'digest/md5'
require 'openssl'
require 'base64'

module ZadarmaSdk
  class Client
    # A module for handling HTTP requests to the Zadarma API.
    module Http
      private

      def request(method, path, params = {})
        params.merge!(format: 'json')

        response = connection.public_send(method, "/v1#{path}", params) do |request|
          request.headers['Authorization'] = "#{@api_key}:#{signature("/v1#{path}", params)}"
        end

        raise ZadarmaSdk::Error, "API Error: #{response.status} - #{response.body}" unless response.success?

        body = JSON.parse(response.body)
        raise ZadarmaSdk::Error, "API Error: #{body['message']}" if body['status'] == 'error'

        body
      end

      def signature(url, params)
        query = URI.encode_www_form(params.sort)
        sign_str = url + query + Digest::MD5.hexdigest(query)
        Base64.encode64(OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), @api_secret, sign_str)).strip
      end

      def connection
        @connection ||= Faraday.new(url: API_URL) do |faraday|
          faraday.request :url_encoded
          faraday.adapter Faraday.default_adapter
        end
      end
    end
  end
end
