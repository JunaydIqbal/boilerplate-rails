module Mutations
  module Users
    class UpdateUser < BaseMutation
      include AuthenticableApiUser
      
      argument :profile_attributes, Types::Users::ProfileAttributes, required: true

      type Types::Users::ObjectType

      def resolve(**params)
        result = update_user(params)

        result.success? ? result.user : execution_error(message: result.error)
      end

      private

        def update_user(params)
          ::Users::Update.call(
            user_id: params[:profile_attributes][:id], 
            user_params: params.dig(:profile_attributes).to_h.except(:id)
          )
        end
    end
  end
end