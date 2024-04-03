module Mutations
  module Admins
    class ModifyAccessUser < BaseMutation
      include AuthenticableApiUser
      include PermissionAuthenticator

      argument :access_attributes, Types::Users::AccessAttributes, required: true

      type Types::Users::ObjectType, null: false

      def resolve(access_attributes:)
        authenticate_admin!

        update_user(access_attributes)
      rescue ActiveRecord::RecordNotFound,
             StandardError => e
        execution_error(message: e.message)
      end
      
      private

        def update_user(access_attributes)
          user = User.find(access_attributes[:user_id])
          update_params = access_attributes.instance_variable_get(:@ruby_style_hash).except(:user_id)

          user.update(update_params)
          user
        end
    end
  end
end