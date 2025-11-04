# frozen_string_literal: true

require 'json'
require 'faraday'
require 'openssl'
require 'base64'
require 'digest/md5'
require 'cgi'

require_relative 'resources/info'
require_relative 'resources/pbx'
require_relative 'resources/direct_numbers'
require_relative 'resources/request'
require_relative 'resources/sip'
require_relative 'resources/sms'
require_relative 'resources/statistics'
require_relative 'resources/speech_recognition'
require_relative 'resources/groups_of_documents'
require_relative 'client/resources'
require_relative 'client/http'

module Zadarma
  # The Client class is the main entry point for interacting with the Zadarma API.
  class Client
    include Resources
    include Http

    API_URL = 'https://api.zadarma.com'

    # Initializes a new Client object.
    #
    # @param api_key [String] The Zadarma API key.
    # @param api_secret [String] The Zadarma API secret.
    def initialize(api_key:, api_secret:)
      @api_key = api_key
      @api_secret = api_secret
    end

    # Get the current account balance.
    #
    # @return [Hash] The API response.
    # @see https://zadarma.com/en/support/api/#api_balance
    def balance
      info.balance
    end

    # Get the price for a call to a specific number.
    #
    # @param number [String] The destination number.
    # @param caller_id [String] The caller ID.
    # @return [Hash] The API response.
    # @see https://zadarma.com/en/support/api/#api_price
    def price(number:, caller_id: nil)
      info.price(number: number, caller_id: caller_id)
    end

    # Get a list of internal PBX numbers.
    #
    # @return [Hash] The API response.
    # @see https://zadarma.com/en/support/api/#api_pbx_internal
    def internal_numbers
      pbx.internal
    end

    # Enable or disable call recording for a PBX extension.
    #
    # @param id [String] The PBX extension ID.
    # @param status [String] The recording status.
    # @param email [String] The email address to send the recording to.
    # @param speech_recognition [String] The speech recognition status.
    # @return [Hash] The API response.
    # @see https://zadarma.com/en/support/api/#api_pbx_record
    def set_call_recording(id:, status:, email: nil, speech_recognition: nil)
      pbx.set_call_recording(id: id, status: status, email: email, speech_recognition: speech_recognition)
    end

    # Request a call recording from the PBX.
    #
    # @param call_id [String] The call ID.
    # @param pbx_call_id [String] The PBX call ID.
    # @param lifetime [String] The lifetime of the recording.
    # @return [Hash] The API response.
    # @see https://zadarma.com/en/support/api/#api_pbx_record_request
    def pbx_record_request(call_id: nil, pbx_call_id: nil, lifetime: nil)
      pbx.pbx_record_request(call_id: call_id, pbx_call_id: pbx_call_id, lifetime: lifetime)
    end

    # Get a list of direct numbers.
    #
    # @return [Hash] The API response.
    # @see https://zadarma.com/en/support/api/#api_direct_numbers
    def direct_numbers
      direct_numbers_resource.all
    end

    # Get a list of countries for direct numbers.
    #
    # @param language [String] The language of the response.
    # @return [Hash] The API response.
    # @see https://zadarma.com/en/support/api/#api_direct_number_countries
    def direct_number_countries(language: nil)
      direct_numbers_resource.countries(language: language)
    end

    # Get a list of direct numbers for a specific country.
    #
    # @param country [String] The country code.
    # @param language [String] The language of the response.
    # @param direction_id [String] The direction ID.
    # @return [Hash] The API response.
    # @see https://zadarma.com/en/support/api/#api_direct_number_country
    def direct_number_country(country:, language: nil, direction_id: nil)
      direct_numbers_resource.country(country: country, language: language, direction_id: direction_id)
    end

    # Get a list of available direct numbers.
    #
    # @param direction_id [String] The direction ID.
    # @param mask [String] The number mask.
    # @return [Hash] The API response.
    # @see https://zadarma.com/en/support/api/#api_available_direct_numbers
    def available_direct_numbers(direction_id:, mask: nil)
      direct_numbers_resource.available(direction_id: direction_id, mask: mask)
    end

    # Order a direct number.
    #
    # @param params [Hash] The order parameters.
    # @return [Hash] The API response.
    # @see https://zadarma.com/en/support/api/#api_order_direct_number
    def order_direct_number(params)
      direct_numbers_resource.order(params)
    end

    # Prolong a direct number.
    #
    # @param number [String] The direct number.
    # @param months [String] The number of months to prolong the number for.
    # @return [Hash] The API response.
    # @see https://zadarma.com/en/support/api/#api_prolong_direct_number
    def prolong_direct_number(number:, months:)
      direct_numbers_resource.prolong(number: number, months: months)
    end

    # Initiate a callback between two numbers.
    #
    # @param from [String] The source number.
    # @param to [String] The destination number.
    # @param sip [String] The SIP number.
    # @param predicted [String] The predicted status.
    # @return [Hash] The API response.
    # @see https://zadarma.com/en/support/api/#api_callback
    def callback(from:, to:, sip: nil, predicted: nil)
      request_resource.callback(from: from, to: to, sip: sip, predicted: predicted)
    end

    # Get a list of SIP numbers.
    #
    # @return [Hash] The API response.
    # @see https://zadarma.com/en/support/api/#api_sips
    def sips
      sip.all
    end

    # Get the status of a SIP number.
    #
    # @param sip [String] The SIP number.
    # @return [Hash] The API response.
    # @see https://zadarma.com/en/support/api/#api_sip_status
    def sip_status(sip:)
      self.sip.status(sip: sip)
    end

    # Create a SIP number.
    #
    # @param name [String] The SIP number name.
    # @param password [String] The SIP number password.
    # @param callerid [String] The SIP number caller ID.
    # @param redirect_to_phone [String] The phone number to redirect to.
    # @return [Hash] The API response.
    # @see https://zadarma.com/en/support/api/#api_create_sip
    def create_sip(name:, password: nil, callerid: nil, redirect_to_phone: nil)
      sip.create(name: name, password: password, callerid: callerid, redirect_to_phone: redirect_to_phone)
    end

    # Set the password for a SIP number.
    #
    # @param sip [String] The SIP number.
    # @param value [String] The new password.
    # @return [Hash] The API response.
    # @see https://zadarma.com/en/support/api/#api_set_sip_password
    def set_sip_password(sip:, value:)
      self.sip.password(sip: sip, value: value)
    end

    # Set the caller ID for a SIP number.
    #
    # @param id [String] The SIP number ID.
    # @param number [String] The new caller ID.
    # @return [Hash] The API response.
    # @see https://zadarma.com/en/support/api/#api_set_sip_caller_id
    def set_sip_caller_id(id:, number:)
      sip.set_caller_id(id: id, number: number)
    end

    # Get call forwarding information for a SIP number.
    #
    # @param id [String] The SIP number ID.
    # @return [Hash] The API response.
    # @see https://zadarma.com/en/support/api/#api_redirection
    def redirection(id: nil)
      sip.redirection(id: id)
    end

    # Set call forwarding for a SIP number.
    #
    # @param id [String] The SIP number ID.
    # @param status [String] The forwarding status.
    # @param type [String] The forwarding type.
    # @param number [String] The forwarding number.
    # @param condition [String] The forwarding condition.
    # @return [Hash] The API response.
    # @see https://zadarma.com/en/support/api/#api_set_redirection
    def set_redirection(id:, status:, type: nil, number: nil, condition: nil)
      sip.set_redirection(id: id, status: status, type: type, number: number, condition: condition)
    end

    # Send an SMS message.
    #
    # @param number [String] The destination number.
    # @param message [String] The message text.
    # @param sender [String] The sender ID.
    # @return [Hash] The API response.
    # @see https://zadarma.com/en/support/api/#api_send_sms
    def send_sms(number:, message:, sender: nil)
      sms.send_sms(number: number, message: message, sender: sender)
    end

    # Get overall call statistics.
    #
    # @param params [Hash] The statistics parameters.
    # @return [Hash] The API response.
    # @see https://zadarma.com/en/support/api/#api_statistics
    def statistics(params)
      statistics_resource.statistics(params)
    end

    # Get PBX call statistics.
    #
    # @param params [Hash] The statistics parameters.
    # @return [Hash] The API response.
    # @see https://zadarma.com/en/support/api/#api_pbx_statistics
    def pbx_statistics(params)
      statistics_resource.pbx_statistics(params)
    end

    # Get speech recognition results.
    #
    # @param call_id [String] The call ID.
    # @param lang [String] The language of the speech.
    # @param return_results [String] Whether to return the results.
    # @param alternatives [String] Whether to return alternative results.
    # @return [Hash] The API response.
    # @see https://zadarma.com/en/support/api/#api_get_speech_recognition
    def get_speech_recognition(call_id:, lang: nil, return_results: nil, alternatives: nil)
      speech_recognition_resource.get(call_id: call_id, lang: lang, return_results: return_results,
                                      alternatives: alternatives)
    end

    # Initiate speech recognition.
    #
    # @param call_id [String] The call ID.
    # @param lang [String] The language of the speech.
    # @return [Hash] The API response.
    # @see https://zadarma.com/en/support/api/#api_initiate_speech_recognition
    def initiate_speech_recognition(call_id:, lang: nil)
      speech_recognition_resource.initiate(call_id: call_id, lang: lang)
    end

    # Get a list of document files.
    #
    # @param group_id [String] The group ID.
    # @return [Hash] The API response.
    # @see https://zadarma.com/en/support/api/#api_document_files
    def document_files(group_id: nil)
      groups_of_documents_resource.files(group_id: group_id)
    end

    # Get a list of document groups.
    #
    # @return [Hash] The API response.
    # @see https://zadarma.com/en/support/api/#api_document_groups
    def document_groups
      groups_of_documents_resource.list
    end

    # Get a document group.
    #
    # @param id [String] The group ID.
    # @return [Hash] The API response.
    # @see https://zadarma.com/en/support/api/#api_get_document_group
    def get_document_group(id:)
      groups_of_documents_resource.get(id: id)
    end

    # Create a document group.
    #
    # @param params [Hash] The group parameters.
    # @return [Hash] The API response.
    # @see https://zadarma.com/en/support/api/#api_create_document_group
    def create_document_group(params:)
      groups_of_documents_resource.create(params: params)
    end

    # Update a document group.
    #
    # @param id [String] The group ID.
    # @param params [Hash] The group parameters.
    # @return [Hash] The API response.
    # @see https://zadarma.com/en/support/api/#api_update_document_group
    def update_document_group(id:, params:)
      groups_of_documents_resource.update(id: id, params: params)
    end

    # Make a GET request to the Zadarma API.
    #
    # @param path [String] The API endpoint path.
    # @param params [Hash] The request parameters.
    # @return [Hash] The API response.
    def get(path, params = {})
      request(:get, path, params)
    end

    # Make a POST request to the Zadarma API.
    #
    # @param path [String] The API endpoint path.
    # @param params [Hash] The request parameters.
    # @return [Hash] The API response.
    def post(path, params = {})
      request(:post, path, params)
    end

    # Make a PUT request to the Zadarma API.
    #
    # @param path [String] The API endpoint path.
    # @param params [Hash] The request parameters.
    # @return [Hash] The API response.
    def put(path, params = {})
      request(:put, path, params)
    end

    # Make a DELETE request to the Zadarma API.
    #
    # @param path [String] The API endpoint path.
    # @param params [Hash] The request parameters.
    # @return [Hash] The API response.
    def delete(path, params = {})
      request(:delete, path, params)
    end
  end
end
