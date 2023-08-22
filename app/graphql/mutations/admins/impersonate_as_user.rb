module Mutations
  module Admins
    class ImpersonateAsUser < BaseMutation
      include AuthenticableApiUser
      include AuthenticateAdmin

      argument :user_id, ID, required: true

      field :impersonated_token, String, null: false
      field :user, Types::Users::ObjectType, null: false

      def resolve(**params)
        authenticate_admin!

        result = login_user(params)

        result.success? ? result : execution_error(message: result.error)
      end

      private

      def login_user(params)
        ::Admins::Impersonate.call(user_id: params[:user_id])
      end
    end
  end
end