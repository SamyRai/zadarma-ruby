# frozen_string_literal: true

module ZadarmaSdk
  class Client
    # A module for accessing the various resources of the Zadarma API.
    module Resources
      # Define methods for accessing each resource.
      #
      # @!method info
      #   @return [ZadarmaSdk::Resources::Info] the Info resource
      # @!method pbx
      #   @return [ZadarmaSdk::Resources::Pbx] the Pbx resource
      # @!method direct_numbers_resource
      #   @return [ZadarmaSdk::Resources::DirectNumbers] the DirectNumbers resource
      # @!method request_resource
      #   @return [ZadarmaSdk::Resources::Request] the Request resource
      # @!method sip
      #   @return [ZadarmaSdk::Resources::Sip] the Sip resource
      # @!method sms
      #   @return [ZadarmaSdk::Resources::Sms] the Sms resource
      # @!method statistics_resource
      #   @return [ZadarmaSdk::Resources::Statistics] the Statistics resource
      # @!method speech_recognition_resource
      #   @return [ZadarmaSdk::Resources::SpeechRecognition] the SpeechRecognition resource
      # @!method groups_of_documents_resource
      #   @return [ZadarmaSdk::Resources::GroupsOfDocuments] the GroupsOfDocuments resource
      %i[
        info
        pbx
        direct_numbers_resource
        request_resource
        sip
        sms
        statistics_resource
        speech_recognition_resource
        groups_of_documents_resource
      ].each do |resource|
        define_method(resource) do
          instance_variable_get("@#{resource}") ||
            instance_variable_set(
              "@#{resource}",
              case resource
              when :info
                ::ZadarmaSdk::Resources::Info.new(client: self)
              when :pbx
                ::ZadarmaSdk::Resources::Pbx.new(client: self)
              when :direct_numbers_resource
                ::ZadarmaSdk::Resources::DirectNumbers.new(client: self)
              when :request_resource
                ::ZadarmaSdk::Resources::Request.new(client: self)
              when :sip
                ::ZadarmaSdk::Resources::Sip.new(client: self)
              when :sms
                ::ZadarmaSdk::Resources::Sms.new(client: self)
              when :statistics_resource
                ::ZadarmaSdk::Resources::Statistics.new(client: self)
              when :speech_recognition_resource
                ::ZadarmaSdk::Resources::SpeechRecognition.new(client: self)
              when :groups_of_documents_resource
                ::ZadarmaSdk::Resources::GroupsOfDocuments.new(client: self)
              end
            )
        end
      end
    end
  end
end
