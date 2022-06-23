module Mutations
  module Users
    class ResendInvitation < BaseMutation
      include AuthenticableApiUser

      argument :id, ID, required: true
      argument :email, String, required: true, 
        validates: { format: { 
          with: /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/
        }
      }

      type Types::Users::ObjectType, null: false

      def resolve(**params)
        result = resend_invitation_to_user(params)

        result.success? ? result.user : execution_error(message: result.error)
      end

      private

        def resend_invitation_to_user(params)
          raise execution_error(message: "Access Denied") unless context[:current_user].admin?
          ::Users::ResendInvitation.call(user_params: params)
        end
    end
  end
end