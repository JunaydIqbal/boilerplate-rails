module Mutations
  module Users
    class UpdateUser < BaseMutation
      include AuthenticableApiUser
      
      argument :user_attributes, Types::Users::UpdateAttributes, required: true

      type Types::Users::ObjectType

      def resolve(**params)
        result = update_user(params)

        result.success? ? result.user : interactors_execution_error(result: result)
      end

      private

        def update_user(params)
          ::Users::Update.call(
            user_id: params[:user_attributes][:id], 
            user_params: params.dig(:user_attributes).to_h.except(:id),
            current_user: context[:current_user]
          )
        end
    end
  end
end