module Mutations
  module Users
    class DestroyUser < BaseMutation
      include AuthenticableApiUser
      include PermissionAuthenticator

      argument :id, ID, required: true

      type Types::Users::ObjectType

      def resolve(**params)
        authenticate_admin!
        result = destroy_user(params[:id])
        
        result.success? ? result.user : execution_error(message: result.error)
      end

      private

        def destroy_user(id)
          ::Users::Destroy.call(user_id: id)
        end
    end
  end
end