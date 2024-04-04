module Mutations
  module Users
    class ResendInvitation < BaseMutation
      include AuthenticableApiUser
      include PermissionAuthenticator

      argument :id, ID, required: true
      argument :email, String, required: true, 
        validates: { format: { 
          with: /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/
        }
      }

      type Types::Users::ObjectType, null: false

      def resolve(**params)
        authenticate_admin!
        result = resend_invitation_to_user(params)

        result.success? ? result.user : interactors_execution_error(result: result)
      end

      private

        def resend_invitation_to_user(params)
          ::Users::ResendInvitation.call(user_params: params)
        end
    end
  end
end