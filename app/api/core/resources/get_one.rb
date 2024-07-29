# frozen_string_literal: true

# Description: Gets a resource with the specified ID and doesn't return one if it is deleted
# Request URI: GET https://api.simcoesignout.com/api/core/resources?id=:id
module Core
  module Resources
    class GetOne < Grape::API
      params do
        requires :id, type: Integer
      end

      get ':id' do
        resource = Resource.find_by_id(params[:id])
        error!({ error: 'Resource not found' }, 404) if resource.nil?

        error!({ error: "Resource is either deleted or you don't have access to it" }, 403) if resource.deleted

        present(resource)
      end
    end
  end
end
