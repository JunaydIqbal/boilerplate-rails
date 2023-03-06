module Queries
  module Users
    class FetchUser < Queries::BaseQuery
      include AuthenticableApiUser

      argument :id, ID, required: false

      type Types::Users::ObjectType, null: false

      def resolve(**params)
        unless params[:id]
          context[:current_user]
        else
          User.find(params[:id])
        end
      rescue ActiveRecord::RecordNotFound => e
        execution_error(message: e.message)
      rescue => e
        execution_error(message: e.message)
      end 
    end
  end
end