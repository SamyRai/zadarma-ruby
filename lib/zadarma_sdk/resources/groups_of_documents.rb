# frozen_string_literal: true

module ZadarmaSdk
  module Resources
    # The GroupsOfDocuments resource allows you to manage groups of documents.
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
        @client.get('/documents/files/', params)
      end

      # Get the list of groups of documents
      # @return [Hash]
      def list
        @client.get('/documents/groups/list/')
      end

      # Get information on a certain group
      # @param id [String] The group ID
      # @return [Hash]
      def get(id:)
        @client.get("/documents/groups/get/#{id}/")
      end

      # Create a new group of documents
      # @param params [Hash] The parameters for creating a new group of documents
      # @return [Hash]
      def create(params:)
        @client.post('/documents/groups/create/', params)
      end

      # Update a group of documents
      # @param id [String] The group ID
      # @param params [Hash] The parameters for updating a group of documents
      # @return [Hash]
      def update(id:, params:)
        @client.put("/documents/groups/update/#{id}/", params)
      end
    end
  end
end
