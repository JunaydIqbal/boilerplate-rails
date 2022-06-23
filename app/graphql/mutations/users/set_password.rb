module Mutations
  module Users
    class SetPassword < BaseMutation
      argument :set_password_attributes, Types::Users::SetPasswordAttributes, required: true

      field :resource, Types::Users::ObjectType, null: false
      field :token, String, null: false

      def resolve(**params)
        result = params[:set_password_attributes][:reset_password] ? 
            reset_resource_password(params) : 
            accept_user_invitation(params)

        result.success? ? result : execution_error(message: result.error)
      end

      private

        def reset_resource_password(params)
          ::DeviseResources::ResetPassword.call(resource_params: params, klass: "User")
        end

        def accept_user_invitation(params)
          ::Users::AcceptInvitation.call(user_params: params)
        end
    end
  end
end