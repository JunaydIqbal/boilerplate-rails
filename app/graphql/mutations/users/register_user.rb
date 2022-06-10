module Mutations
  module Users
    class RegisterUser < BaseMutation
      argument :register_attributes, Types::Users::RegisterAttributes, required: true

      type Types::Payloads::UserPayload

      def resolve(**params)
        result = register_user(params)

        result.success? ? result : execution_error(message: result.error)
      end
      
      private

        def register_user(params)
          ::DeviseResources::Register.call(
            resource_params: params[:register_attributes].to_h, 
            klass: 'User'
          )
        end
    end
  end
end