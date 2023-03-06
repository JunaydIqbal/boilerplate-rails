module Queries
  module Users
    class FetchUser < Queries::BaseQuery
      include AuthenticableApiUser

      argument :id, ID, required: false

      type Types::Users::ObjectType, null: false

      def resolve(**params)
        params[:id].present? ? User.find(params[:id]) : context[:current_user]
      rescue ActiveRecord::RecordNotFound => e
        execution_error(message: e.message)
      rescue => e
        execution_error(message: e.message)
      end 
    end
  end
end