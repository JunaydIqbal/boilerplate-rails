module Mutations
  module Users
    class SendResetPasswordInstructions < BaseMutation
      argument :email, String, required: true

      type Types::Users::ObjectType, null: true

      def resolve(**params)
        result = grab_resource_and_send_instructions(params)

        result.success? ? result.resource : execution_error(message: result.error)
      end

      private

        def grab_resource_and_send_instructions(params)
          ::DeviseResources::SendResetPasswordInstructions.call(email: params[:email], klass: "User")
        end
    end
  end
end