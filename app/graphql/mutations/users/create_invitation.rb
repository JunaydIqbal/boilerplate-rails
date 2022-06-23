module Mutations
  module Users
    class CreateInvitation < BaseMutation
      include AuthenticableApiUser

      argument :email, String, required: true, 
        validates: { format: { 
          with: /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/
        }
      }

      type Types::Users::ObjectType, null: false

      def resolve(**params)
        result = invite_user(params)

        result.success? ? result.user : execution_error(message: result.error)
      end

      private

        def invite_user(params)
          raise execution_error(message: "Access Denied") unless context[:current_user].admin?
          ::Users::ForwardInvitation.call(user_params: params)
        end
    end
  end
end