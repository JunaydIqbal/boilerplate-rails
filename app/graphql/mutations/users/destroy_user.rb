module Mutations
  module Users
    class DestroyUser < BaseMutation
      include AuthenticableApiUser

      argument :id, ID, required: true

      type Types::Users::ObjectType

      def resolve(**params)
        result = destroy_user(params[:id])
        
        result.success? ? result.user : execution_error(message: result.error)
      end

      private

        def destroy_user(id)
          raise unauthorized_error unless context[:current_user].admin?
          ::Users::Destroy.call(user_id: id)
        end
    end
  end
end