module Mutations
  module Users
    class UpdatePassword < BaseMutation
      include AuthenticableApiUser
      
      argument :current_password, String, required: true
      argument :password, String, required: true
      argument :password_confirmation, String, required: true

      field :response, Boolean, null: false

      def resolve(**params)
        result = update_password(params)

        result.success? ? result : execution_error(message: result.error)
      end

      private

        def update_password(params)
          ::Users::UpdatePassword.call(
            current_user: context[:current_user],
            user_params: params
          )
        end
    end    
  end  
end