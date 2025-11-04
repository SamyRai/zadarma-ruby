# frozen_string_literal: true

module Zadarma
  class Client
    # A module for accessing the various resources of the Zadarma API.
    module Resources
      private

      # @!group Resources
      # @!macro [attach] zadarma.resource
      #   @return [Zadarma::Resources::$1] the $1 resource

      def info
        ::Zadarma::Resources::Info.new(client: self)
      end

      def pbx
        ::Zadarma::Resources::Pbx.new(client: self)
      end

      def direct_numbers_resource
        ::Zadarma::Resources::DirectNumbers.new(client: self)
      end

      def request_resource
        ::Zadarma::Resources::Request.new(client: self)
      end

      def sip
        ::Zadarma::Resources::Sip.new(client: self)
      end

      def sms
        ::Zadarma::Resources::Sms.new(client: self)
      end

      def statistics_resource
        ::Zadarma::Resources::Statistics.new(client: self)
      end

      def speech_recognition_resource
        ::Zadarma::Resources::SpeechRecognition.new(client: self)
      end

      def groups_of_documents_resource
        ::Zadarma::Resources::GroupsOfDocuments.new(client: self)
      end
    end
  end
end
