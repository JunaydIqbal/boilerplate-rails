module Mutations
  module Admins
    class ImpersonateAsUser < BaseMutation
      include AuthenticableApiUser
      include PermissionAuthenticator

      argument :user_id, ID, required: true

      field :impersonated_token, String, null: false
      field :user, Types::Users::ObjectType, null: false

      def resolve(user_id:)
        authenticate_admin!

        result = login_user(user_id)

        result.success? ? result : execution_error(message: result.error)
      end

      private

      def login_user(user_id)
        ::Admins::Impersonate.call(user_id: user_id)
      end
    end
  end
end