module Queries
  module Users
    class FetchUser < Queries::BaseQuery
      include AuthenticableApiUser

      argument :id, ID, required: true

      type Types::Users::ObjectType, null: false

      def resolve(**params)
        User.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        execution_error(message: e.message)
      rescue => e
        execution_error(message: e.message)
      end 
    end
  end
end