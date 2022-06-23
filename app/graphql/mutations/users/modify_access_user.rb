module Mutations
  module Users
    class ModifyAccessUser < BaseMutation
      include AuthenticableApiUser

      argument :access_attributes, Types::Users::AccessAttributes, required: true

      type Types::Users::ObjectType

      def resolve(**params)
        authenticate_admin!
        update_user(params)
      rescue ActiveRecord::RecordNotFound => e
        execution_error(message: e.message)
      rescue => e
        execution_error(message: e.message)
      end
      
      private

        def authenticate_admin!
          raise execution_error unless context[:current_user].admin?
        end

        def update_user(params)
          user = User.find(params[:access_attributes][:user_id])
          user.update(params[:access_attributes].to_h.except(:user_id))
          user
        end
    end
  end
end