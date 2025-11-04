# frozen_string_literal: true

module Zadarma
  class Client
    # A module for handling HTTP requests to the Zadarma API.
    module Http
      private

      def request(method, path, params)
        raise 'No API key or secret provided' unless @api_key && @api_secret

        sorted_params = params.sort.to_h
        query_string = to_query(sorted_params)
        signature = generate_signature(path, query_string)

        response = execute_request(method, path, sorted_params, signature)

        handle_response(response)
      end

      def execute_request(method, path, params, signature)
        connection.send(method) do |req|
          req.url path
          req.headers['Authorization'] = "#{@api_key}:#{signature}"
          if %i[post put].include?(method)
            req.body = params
          else
            req.params = params
          end
        end
      end

      def connection
        @connection ||= Faraday.new(url: API_URL) do |faraday|
          faraday.request :url_encoded
          faraday.adapter Faraday.default_adapter
        end
      end

      def generate_signature(path, query_string)
        string_to_sign = path + query_string + Digest::MD5.hexdigest(query_string)
        hmac = OpenSSL::HMAC.hexdigest('sha1', @api_secret, string_to_sign)
        Base64.strict_encode64(hmac)
      end

      def to_query(hash)
        hash.map { |k, v| "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}" }.join('&')
      end

      def handle_response(response)
        raise Zadarma::Error, "API Error: #{response.status} - #{response.body}" unless response.success?

        body = JSON.parse(response.body)
        raise Zadarma::Error, "API Error: #{body['message']}" if body['status'] == 'error'

        body
      end
    end
  end
end
