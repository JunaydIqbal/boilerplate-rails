module Mutations
  module Users
    class CreateInvitation < BaseMutation
      include AuthenticableApiUser
      include PermissionAuthenticator

      argument :base_attributes, Types::Users::BaseAttributes, required: true

      type Types::Users::ObjectType, null: false

      def resolve(**params)
        authenticate_admin!
        result = invite_user(params)

        result.success? ? result.user : execution_error(message: result.error)
      end

      private

        def invite_user(params)
          ::Users::ForwardInvitation.call(user_params: params[:base_attributes], current_user: context[:current_user])
        end
    end
  end
end