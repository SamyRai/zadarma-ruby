# frozen_string_literal: true

module Zadarma
  module Resources
    class GroupsOfDocuments
      def initialize(client:)
        @client = client
      end

      # Get the list of files/documents in the group of documents
      # @param group_id [String] The group of documents ID
      # @return [Hash]
      def files(group_id: nil)
        params = {}
        params[:group_id] = group_id if group_id
        @client.get('/v1/documents/files/', params)
      end

      # Get the list of groups of documents
      # @return [Hash]
      def list
        @client.get('/v1/documents/groups/list/')
      end

      # Get information on a certain group
      # @param id [String] The group ID
      # @return [Hash]
      def get(id:)
        @client.get("/v1/documents/groups/get/#{id}/")
      end

      # Create a new group of documents
      # @param params [Hash] The parameters for creating a new group of documents
      # @return [Hash]
      def create(params:)
        @client.post('/v1/documents/groups/create/', params)
      end

      # Update a group of documents
      # @param id [String] The group ID
      # @param params [Hash] The parameters for updating a group of documents
      # @return [Hash]
      def update(id:, params:)
        @client.put("/v1/documents/groups/update/#{id}/", params)
      end
    end
  end
end
