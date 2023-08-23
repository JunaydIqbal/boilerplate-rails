module Mutations
  module Admins
    class ModifyAccessUser < BaseMutation
      include AuthenticableApiUser
      include AuthenticateAdmin

      argument :access_attributes, Types::Users::AccessAttributes, required: true

      type Types::Users::ObjectType

      def resolve(**params)
        authenticate_admin!

        update_user(params)
      rescue ActiveRecord::RecordNotFound,
             StandardError => e
        execution_error(message: e.message)
      end
      
      private

        def update_user(params)
          user = User.find(params[:access_attributes][:user_id])
          user.update(params[:access_attributes].to_h.except(:user_id))
          user
        end
    end
  end
end