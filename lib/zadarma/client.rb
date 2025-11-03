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

    def initialize(api_key:, api_secret:)
      @api_key = api_key
      @api_secret = api_secret
    end

    def balance
      info.balance
    end

    def price(number:, caller_id: nil)
      info.price(number: number, caller_id: caller_id)
    end

    def internal_numbers
      pbx.internal
    end

    def set_call_recording(id:, status:, email: nil, speech_recognition: nil)
      pbx.set_call_recording(id: id, status: status, email: email, speech_recognition: speech_recognition)
    end

    def pbx_record_request(call_id: nil, pbx_call_id: nil, lifetime: nil)
      pbx.pbx_record_request(call_id: call_id, pbx_call_id: pbx_call_id, lifetime: lifetime)
    end

    def direct_numbers
      direct_numbers_resource.all
    end

    def direct_number_countries(language: nil)
      direct_numbers_resource.countries(language: language)
    end

    def direct_number_country(country:, language: nil, direction_id: nil)
      direct_numbers_resource.country(country: country, language: language, direction_id: direction_id)
    end

    def available_direct_numbers(direction_id:, mask: nil)
      direct_numbers_resource.available(direction_id: direction_id, mask: mask)
    end

    def order_direct_number(params)
      direct_numbers_resource.order(params)
    end

    def prolong_direct_number(number:, months:)
      direct_numbers_resource.prolong(number: number, months: months)
    end

    def callback(from:, to:, sip: nil, predicted: nil)
      request_resource.callback(from: from, to: to, sip: sip, predicted: predicted)
    end

    def sips
      sip.all
    end

    def sip_status(sip:)
      self.sip.status(sip: sip)
    end

    def create_sip(name:, password: nil, callerid: nil, redirect_to_phone: nil)
      sip.create(name: name, password: password, callerid: callerid, redirect_to_phone: redirect_to_phone)
    end

    def set_sip_password(sip:, value:)
      self.sip.password(sip: sip, value: value)
    end

    def set_sip_caller_id(id:, number:)
      sip.set_caller_id(id: id, number: number)
    end

    def redirection(id: nil)
      sip.redirection(id: id)
    end

    def set_redirection(id:, status:, type: nil, number: nil, condition: nil)
      sip.set_redirection(id: id, status: status, type: type, number: number, condition: condition)
    end

    def send_sms(number:, message:, sender: nil)
      sms.send_sms(number: number, message: message, sender: sender)
    end

    def statistics(params)
      statistics_resource.statistics(params)
    end

    def pbx_statistics(params)
      statistics_resource.pbx_statistics(params)
    end

    def get_speech_recognition(call_id:, lang: nil, return_results: nil, alternatives: nil)
      speech_recognition_resource.get(call_id: call_id, lang: lang, return_results: return_results,
                                      alternatives: alternatives)
    end

    def initiate_speech_recognition(call_id:, lang: nil)
      speech_recognition_resource.initiate(call_id: call_id, lang: lang)
    end

    def document_files(group_id: nil)
      groups_of_documents_resource.files(group_id: group_id)
    end

    def document_groups
      groups_of_documents_resource.list
    end

    def get_document_group(id:)
      groups_of_documents_resource.get(id: id)
    end

    def create_document_group(params:)
      groups_of_documents_resource.create(params: params)
    end

    def update_document_group(id:, params:)
      groups_of_documents_resource.update(id: id, params: params)
    end

    def get(path, params = {})
      request(:get, path, params)
    end

    def post(path, params = {})
      request(:post, path, params)
    end

    def put(path, params = {})
      request(:put, path, params)
    end

    def delete(path, params = {})
      request(:delete, path, params)
    end
  end
end
